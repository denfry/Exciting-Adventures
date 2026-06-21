import zipfile, json, os, shutil

SRC = 'mods/seasonhud-fabric-1.20.1-1.9.8.jar'
BACKUP_DIR = '../backups/2026-06-21_pre_worldstory/disabled-incompatible-mods'
TMP = '_work/seasonhud_patched.jar'
CFG = 'seasonhud.fabric.mixins.json'
DROP = 'ftbchunks.FTBChunksClientMixin'

os.makedirs(BACKUP_DIR, exist_ok=True)
# 1) back up original (once)
bkp = os.path.join(BACKUP_DIR, os.path.basename(SRC) + '.orig')
if not os.path.exists(bkp):
    shutil.copy2(SRC, bkp)
    print('backed up original ->', bkp)

zin = zipfile.ZipFile(SRC, 'r')
cfg = json.loads(zin.read(CFG).decode('utf-8'))
before = list(cfg.get('client', []))
cfg['client'] = [m for m in cfg.get('client', []) if m != DROP]
print('client mixins before:', before)
print('client mixins after :', cfg['client'])
assert DROP not in cfg['client'], 'drop failed'
assert any('Xaero' in m for m in cfg['client']), 'xaero integration unexpectedly gone'
new_cfg = json.dumps(cfg, indent=2, ensure_ascii=False).encode('utf-8')

# 2) rewrite jar, replacing only the one config; drop the now-unused mixin class too
DROP_CLASS = 'club/iananderson/seasonhud/mixin/ftbchunks/FTBChunksClientMixin.class'
with zipfile.ZipFile(TMP, 'w', zipfile.ZIP_DEFLATED) as zout:
    for item in zin.infolist():
        if item.filename == DROP_CLASS:
            continue  # remove orphaned broken mixin class
        data = zin.read(item.filename)
        if item.filename == CFG:
            data = new_cfg
        zout.writestr(item, data)
zin.close()

# 3) validate the patched jar
zt = zipfile.ZipFile(TMP)
bad = zt.testzip()
assert bad is None, 'corrupt zip entry: %s' % bad
fm = json.loads(zt.read('fabric.mod.json').decode('utf-8'))
cfg2 = json.loads(zt.read(CFG).decode('utf-8'))
assert fm.get('id') == 'seasonhud'
assert DROP not in cfg2['client']
assert DROP_CLASS not in zt.namelist()
print('PATCHED OK: id=%s ver=%s, client=%s, classes=%d' % (
    fm['id'], fm.get('version'), cfg2['client'], len([n for n in zt.namelist() if n.endswith('.class')])))
zt.close()

# 4) replace original
shutil.move(TMP, SRC)
print('replaced', SRC)
