import glob, json, os, re, sys

ERR = []
OK = []
def err(m): ERR.append(m)
def ok(m): OK.append(m)

DP = 'config/paxi/datapacks/abyss_chronicles'

# ---------- 1. JSON parse all datapack json ----------
jsons = glob.glob(DP + '/**/*.json', recursive=True) + [DP + '/pack.mcmeta']
parsed = {}
for f in jsons:
    try:
        parsed[f] = json.load(open(f, encoding='utf-8'))
    except Exception as e:
        err('JSON parse FAIL %s :: %s' % (os.path.relpath(f), e))
ok('parsed %d datapack json files' % len(parsed))

# ---------- helpers to resolve ids ----------
def fn_path(fid):  # abyss:player/welcome -> data/abyss/functions/player/welcome.mcfunction
    ns, p = fid.split(':')
    return '%s/data/%s/functions/%s.mcfunction' % (DP, ns, p)
def adv_path(aid):
    ns, p = aid.split(':')
    return '%s/data/%s/advancements/%s.json' % (DP, ns, p)

# ---------- 2. function tags ----------
for tag, expect in [('minecraft/tags/functions/load.json','abyss:init'),
                    ('minecraft/tags/functions/tick.json','abyss:tick')]:
    p = DP + '/data/' + tag
    d = json.load(open(p, encoding='utf-8')) if os.path.exists(p) else None
    if not d: err('missing tag '+tag); continue
    for v in d['values']:
        if not os.path.exists(fn_path(v)): err('tag %s -> missing function %s' % (tag, v))
        else: ok('tag %s -> %s OK' % (tag, v))

# ---------- 3. advancements: parents + reward functions ----------
advs = glob.glob(DP + '/data/abyss/advancements/**/*.json', recursive=True)
adv_ids = set()
for f in advs:
    rel = os.path.relpath(f, DP + '/data/abyss/advancements').replace('\\','/')[:-5]
    adv_ids.add('abyss:' + rel)
for f in advs:
    d = json.load(open(f, encoding='utf-8'))
    aid = 'abyss:' + os.path.relpath(f, DP+'/data/abyss/advancements').replace('\\','/')[:-5]
    par = d.get('parent')
    if par and par not in adv_ids:
        err('%s: parent %s does not exist' % (aid, par))
    rf = d.get('rewards', {}).get('function')
    if rf and not os.path.exists(fn_path(rf)):
        err('%s: reward function %s missing' % (aid, rf))
    # display sanity
    if 'criteria' not in d: err('%s: no criteria' % aid)
ok('advancements: %d found, ids=%s' % (len(advs), sorted(x.split('/')[-1] for x in adv_ids)))

# ---------- 4. mcfunction cross-refs ----------
fns = glob.glob(DP + '/data/abyss/functions/**/*.mcfunction', recursive=True)
ref_fn = re.compile(r'\bfunction\s+(abyss:[\w/]+)')
ref_adv = re.compile(r'advancement\s+\w+\s+@\w+\s+\w+\s+(abyss:[\w/]+)')
for f in fns:
    txt = open(f, encoding='utf-8').read()
    if '�' in txt: err('mojibake in '+f)
    for m in ref_fn.findall(txt):
        if not os.path.exists(fn_path(m)): err('%s refs missing function %s' % (os.path.basename(f), m))
    for m in ref_adv.findall(txt):
        if m not in adv_ids: err('%s grants missing advancement %s' % (os.path.basename(f), m))
ok('functions: %d, cross-refs checked' % len(fns))

# ---------- 5. patchouli (book.json in datapack, content in resourcepack) ----------
RP = 'config/paxi/resourcepacks/abyss_chronicles_rp'
book = DP + '/data/abyss/patchouli_books/chronicles/book.json'
if os.path.exists(book):
    bj = json.load(open(book, encoding='utf-8'))
    if bj.get('use_resource_pack') is True: ok('patchouli book.json present, use_resource_pack=true')
    else: err('patchouli book.json use_resource_pack must be true for 1.20.1 (got %r)' % bj.get('use_resource_pack'))
else: err('patchouli book.json MISSING')
if not os.path.exists(RP + '/pack.mcmeta'): err('resourcepack pack.mcmeta MISSING')
else:
    json.load(open(RP + '/pack.mcmeta', encoding='utf-8')); ok('resourcepack pack.mcmeta valid')
PB = RP + '/assets/abyss/patchouli_books/chronicles'
cats = glob.glob(PB + '/*/categories/*.json')
cat_ids = set('abyss:' + os.path.basename(c)[:-5] for c in cats)
ents = glob.glob(PB + '/*/entries/*.json')
for e in ents:
    d = json.load(open(e, encoding='utf-8'))
    if d.get('category') not in cat_ids:
        err('entry %s category %s not in %s' % (os.path.basename(e), d.get('category'), cat_ids))
    if not d.get('pages'): err('entry %s has no pages' % os.path.basename(e))
if not cats: err('no patchouli categories found in resourcepack')
if len(ents) < 6: err('expected >=6 patchouli entries, found %d' % len(ents))
ok('patchouli(RP): %d categories %s, %d entries' % (len(cats), sorted(cat_ids), len(ents)))
# paintings + new datapack files
for png in ['void.png', 'pointer.png', 'wanderer.png']:
    p = RP + '/assets/minecraft/textures/painting/' + png
    if os.path.exists(p): ok('painting present: ' + png)
    else: err('painting MISSING: ' + png)
for jf in [DP + '/data/abyss/predicates/sneaking.json', DP + '/data/abyss/tags/entity_types/bosses.json']:
    if os.path.exists(jf):
        json.load(open(jf, encoding='utf-8')); ok('valid json: ' + os.path.basename(jf))
    else: err('MISSING: ' + jf)

# ---------- 6. SNBT quests: utf-8 clean + new chapter integrity ----------
def moji(t): return any(''<=c<='' for c in t) or ('Ð' in t) or ('Ñ' in t)
for f in glob.glob('config/ftbquests/quests/**/*.snbt', recursive=True):
    raw = open(f,'rb').read()
    try: t = raw.decode('utf-8')
    except Exception as e: err('snbt not utf-8: %s (%s)'%(f,e)); continue
    if '�' in t: err('replacement char in '+f)
    if moji(t): err('MOJIBAKE remains in '+f)
    if t.count('{') != t.count('}'): err('brace imbalance in '+f)
ok('all snbt quest files utf-8 clean + braces balanced')

# new chapter id integrity
ch = open('config/ftbquests/quests/chapters/abyss_signs.snbt', encoding='utf-8').read()
ids = re.findall(r'id:\s*"([0-9A-Fa-f]{16})"', ch)
dup = set(x for x in ids if ids.count(x) > 1)
if dup: err('duplicate ids in abyss_signs: %s' % dup)
else: ok('abyss_signs: %d unique ids' % len(ids))
quest_ids = re.findall(r'id:\s*"(80A[0-9A-Fa-f]{13})"\n', ch)
deps = re.findall(r'dependencies:\s*\[([^\]]*)\]', ch)
dep_ids = set(re.findall(r'"([0-9A-Fa-f]{16})"', ' '.join(deps)))
qset = set(re.findall(r'\t\t\tid:\s*"([0-9A-Fa-f]{16})"', ch))
for d in dep_ids:
    if d not in qset: err('abyss_signs dependency %s has no matching quest' % d)
ok('abyss_signs: dependencies resolve (%d deps)' % len(dep_ids))
# advancement tasks reference existing datapack advancements
for a in re.findall(r'advancement:\s*"(abyss:[\w/]+)"', ch):
    if a not in adv_ids: err('abyss_signs task refs missing advancement %s' % a)
ok('abyss_signs: advancement tasks reference valid datapack advancements')

# ---------- 7. FancyMenu ----------
fm = 'config/fancymenu/customization/main1413413.txt'
t = open(fm, encoding='utf-8').read()
if t.count('{') != t.count('}'): err('FancyMenu brace imbalance: %d vs %d' % (t.count('{'), t.count('}')))
else: ok('FancyMenu braces balanced')
for src in re.findall(r'source = \[source:local\](config/fancymenu/assets/abyss_[\w.]+)', t):
    if not os.path.exists(src): err('FancyMenu refs missing asset '+src)
    else: ok('FancyMenu asset present: '+src)

# ---------- report ----------
print('=== OK (%d) ===' % len(OK))
for m in OK: print('  +', m)
print('\n=== ERRORS (%d) ===' % len(ERR))
for m in ERR: print('  !', m)
sys.exit(1 if ERR else 0)
