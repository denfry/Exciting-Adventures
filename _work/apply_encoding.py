import glob, os, shutil, sys
from fix_encoding import fix

QDIR = 'config/ftbquests/quests'
BACKUP = '../backups/2026-06-21_pre_worldstory/quests'


def main():
    # 1) backup
    if not os.path.exists(BACKUP):
        shutil.copytree(QDIR, BACKUP)
        print('backup ->', os.path.abspath(BACKUP))
    else:
        print('backup already exists, skipping:', os.path.abspath(BACKUP))

    # 2) apply fix in place for changed files
    files = sorted(glob.glob(QDIR + '/**/*.snbt', recursive=True))
    for f in files:
        fixed, method = fix(f)
        if method in ('demojibake', 'cp1251-single'):
            data = fixed.encode('utf-8')
            # sanity: must round-trip and contain no replacement char
            assert '�' not in fixed, f
            with open(f, 'wb') as fh:
                fh.write(data)
            print('FIXED   [%s] %s' % (method, os.path.relpath(f)))
        else:
            print('skip    [%s] %s' % (method, os.path.relpath(f)))


if __name__ == '__main__':
    os.chdir(os.path.join(os.path.dirname(__file__)))
    os.chdir('..')  # back to minecraft/
    main()
