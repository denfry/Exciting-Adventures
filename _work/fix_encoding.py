import glob, os, re

CTRL = re.compile('[-]')

def fix(path):
    b = open(path, 'rb').read()
    try:
        M = b.decode('utf-8')
    except UnicodeDecodeError:
        # raw single-byte cp1251
        return b.decode('cp1251'), 'cp1251-single'
    looks_moji = bool(CTRL.search(M)) or ('Р' in M and any(s in M for s in ('Ре', 'Ра', 'РІ', 'РЅ')))
    if not looks_moji:
        return M, 'clean'
    out = bytearray()
    ok = True
    for ch in M:
        try:
            out += ch.encode('cp1251')
        except Exception:
            o = ord(ch)
            if o <= 0xFF:
                out.append(o)
            else:
                ok = False
                break
    if ok:
        try:
            cand = out.decode('utf-8')
            if '�' not in cand:
                return cand, 'demojibake'
        except Exception:
            pass
    return M, 'unchanged(failsafe)'


def main():
    outdir = '_work/demoji'
    os.makedirs(outdir, exist_ok=True)
    files = sorted(glob.glob('config/ftbquests/quests/**/*.snbt', recursive=True))
    lines = []
    for f in files:
        fixed, method = fix(f)
        cyr = sum(1 for c in fixed if 'Ѐ' <= c <= 'ӿ')
        rel = os.path.relpath(f)
        name = rel.replace(os.sep, '__')
        op = os.path.join(outdir, name)
        with open(op, 'w', encoding='utf-8', newline='\n') as fh:
            fh.write(fixed)
        ffd = '�' in fixed
        lines.append('%-20s cyr=%4d ffd=%s  %s' % (method, cyr, ffd, rel))
    print('\n'.join(lines))


if __name__ == '__main__':
    main()
