# -*- coding: utf-8 -*-
# Генератор главы FTBQuests "Хроники — Пролог: Пробуждение" (abyss_signs.snbt).
# Большой пролог-questline Части I: иконка на каждом квесте, рамка "это только начало".
# Печатает SNBT в точном таб-формате FTBQuests (id квеста на 3 таба, id задач/наград на 4-5).
import io
import re

CHAPTER_ID = "0672353E319EE94F"   # сохраняем id главы (та же вкладка, order_index 0)

# в FTBQuests-описаниях пак использует чистый текст без кодов форматирования —
# вычищаем любые § -последовательности, чтобы не показывать «§9» дословно.
def clean(s):
    return re.sub(r'§.', '', s)

# id-схема: квест 7A51.., задача 7A52.., награда(и) 7A54.. — уникальные 16-hex, prefix 7A5
def qid(i):  return "7A51%010X%02X" % (0, i)
def tid(i):  return "7A52%010X%02X" % (0, i)
def rid(i, j=0): return "7A5%X%010X%02X" % (4 + j, 0, i)

# ---- квесты: (key, title, icon, x, y, deps[keys], task, rewards[list], flags{}) ----
# task: ('adv', 'abyss:story/x') | ('item', 'minecraft:x', count) | ('check', 'подпись')
# reward: ('xp', N) | ('lvl', N) | ('item', 'minecraft:x', count)
Q = []
def add(key, title, icon, x, y, deps, task, rewards, desc, **flags):
    Q.append(dict(key=key, title=title, icon=icon, x=x, y=y, deps=deps,
                  task=task, rewards=rewards, desc=desc, flags=flags))

add("prologue", "Пролог: Холодный берег", "minecraft:heart_of_the_sea", 0.0, 0.0, [],
    ('adv', 'abyss:story/prologue'), [('xp', 50)],
    ["Хроники Бездны. §9Часть I — Пробуждение.§r",
     "Ты очнулся на чужом берегу без памяти, с письмом и книгой в руке. Море не помнит твоего имени. Бездна — помнит.",
     "Открой выданный кодекс «Хроники Бездны». Всё, что здесь начнётся, — лишь первая глава долгой борьбы."],
    shape="hexagon")

add("codex", "Слова на полях", "minecraft:writable_book", 0.0, -1.5, ["prologue"],
    ('check', 'Прочесть кодекс «Хроники Бездны»'), [('xp', 30)],
    ["Раскрой кодекс из инвентаря и прочти первые страницы.",
     "Семь испытаний отделяют тебя от Неё. Но и за ними борьба не кончится — запомни это."])

add("hermit", "Отшельник берега", "minecraft:campfire", 0.0, 1.5, ["prologue"],
    ('adv', 'abyss:story/met_hermit'), [('item', 'minecraft:torch', 8)],
    ["Подойди к §3Отшельнику берега§r вплотную (или присядь рядом) и выслушай его.",
     "Он вытащил тебя из прибоя — и единственный здесь, кто ещё помнит, каким был мир до Бездны."])

add("sculk", "Эхо под камнем", "minecraft:sculk", 1.5, 0.0, ["prologue"],
    ('item', 'minecraft:sculk', 4), [('xp', 60)],
    ["Бездна прорастает в камне чёрным мхом. Добудь скалк — её первый след на поверхности."])

add("gifts", "Дары берега", "minecraft:cooked_beef", 1.5, 1.5, ["hermit"],
    ('item', 'minecraft:cooked_beef', 6), [('xp', 40)],
    ["Отшельник делится последним. Собери припасы на первую ночь — Бездна не любит сытых и согретых.",
     "§8Необязательная тропа.§r"],
    optional=True)

add("nether_gate", "Врата Нижнего мира", "minecraft:obsidian", 1.5, -1.5, ["prologue"],
    ('adv', 'abyss:story/into_the_dark'), [('xp', 100)],
    ["Шагни в Незер — там Бездна вьёт свои огненные корни.",
     "Здесь добывается то, без чего не вспыхнет даже первая печать."])

add("blaze", "Огненные корни", "minecraft:blaze_rod", 3.0, -1.5, ["nether_gate"],
    ('item', 'minecraft:blaze_rod', 4), [('xp', 80)],
    ["Вырви у Незера его жар. Стержни ифритов горят даже во льдах берега."])

add("descent", "Нисхождение", "minecraft:sculk_shrieker", 3.0, 0.0, ["sculk"],
    ('adv', 'abyss:story/descent'), [('xp', 100)],
    ["Спустись в §3Глубокую Тьму§r — туда, где Бездна ближе всего к поверхности.",
     "Войди в биом Deep Dark. Голос отзовётся, и мир отметит твой шаг."])

add("warden", "Сердце Хранителя", "minecraft:soul_lantern", 3.0, 1.5, ["descent"],
    ('adv', 'abyss:story/warden'), [('item', 'minecraft:netherite_scrap', 2)],
    ["Скрытое испытание для дерзких: услышать стук сердца §1Хранителя глубин§r — и пережить встречу.",
     "Немногие возвращались."],
    optional=True, hide=True)

add("star", "Звезда мрака", "minecraft:wither_skeleton_skull", 4.5, -1.5, ["blaze"],
    ('adv', 'abyss:story/storm'), [('lvl', 5)],
    ["Призови и сокруши §8Иссушителя§r. Из его смерти родится звезда — первый ключ к печати Бездны."])

add("whisper", "Зов глубин", "minecraft:echo_shard", 4.5, 0.0, ["descent"],
    ('adv', 'abyss:story/the_whisper'), [('lvl', 3)],
    ["Добудь осколок эха из Древнего города. С ним Бездна услышит тебя — и запомнит твоё имя."])

add("catalyst", "Слушающий камень", "minecraft:sculk_catalyst", 4.5, 1.5, ["descent"],
    ('item', 'minecraft:sculk_catalyst', 1), [('xp', 90)],
    ["Сердце скалка слышит каждую смерть. Вырежи катализатор из Древнего города — он ещё пригодится."])

add("compass", "Голос, что помнит имя", "minecraft:recovery_compass", 6.0, 0.0, ["whisper"],
    ('item', 'minecraft:recovery_compass', 1), [('xp', 120)],
    ["Собери компас возвращения из осколков эха. Он указывает туда, где ты пал, — а Бездна любит такие места."])

add("marks", "Метки Бездны", "minecraft:sculk_sensor", 6.0, -1.5, ["whisper"],
    ('item', 'minecraft:echo_shard', 3), [('xp', 80)],
    ["Чем больше осколков эха ты несёшь, тем громче зовёт глубина. Собери ещё три.",
     "§8Необязательно — но Бездна ценит упорство.§r"],
    optional=True)

add("edge", "Край мира", "minecraft:ender_eye", 6.0, 1.5, ["whisper"],
    ('adv', 'abyss:story/the_edge'), [('xp', 150)],
    ["Достигни §5Края§r — пустоты между звёздами, что старше самой Бездны."])

add("herald", "Вестница Бездны", "minecraft:wither_rose", 7.5, 1.5, ["edge"],
    ('adv', 'abyss:story/met_herald'), [('lvl', 4)],
    ["В пустоте Края тебя встретит §5Вестница Бездны§r. Выслушай её и сделай первый выбор: запечатать или принять.",
     "Этот выбор ещё не окончателен — борьба только начинается."])

add("dragon", "Крылатая погибель", "minecraft:dragon_head", 7.5, 0.0, ["edge"],
    ('adv', 'abyss:story/winged_doom'), [('lvl', 5)],
    ["Сорви власть §5Дракона Края§r — древнего стража, которого Бездна обратила себе на службу."])

add("seal", "Первая печать", "minecraft:nether_star", 9.0, 0.0, ["star", "dragon"],
    ('adv', 'abyss:story/the_seal'),
    [('item', 'minecraft:netherite_ingot', 2), ('xp', 1000)],
    ["Вырви три ключа, начерти круг на льду и низвергни §4Лилит§r — голос, что звал тебя всё это время.",
     "Когда это свершится, на разлом ляжет §6первая§r печать. Последний рывок описан в главе «§6Часть I — Первая Печать§r».",
     "Но печать — не победа. Это лишь первый камень в стене против тьмы."],
    shape="gear", size=1.5)

add("epilogue", "…это только начало", "minecraft:end_crystal", 10.5, 0.0, ["seal"],
    ('check', 'Принять: борьба с Бездной только началась'),
    [('item', 'minecraft:experience_bottle', 16)],
    ["Лёд стихает. Голос умолкает. Но под печатью всё ещё бьётся древнее сердце — медленно, терпеливо.",
     "Ты запечатал §bпервый§r разлом. Их больше. Бездна лишь приоткрыла глаз и снова уснула, запоминая твоё лицо.",
     "§5Часть II§r ждёт. Расправь крылья, переведи дух — и готовься: настоящая война впереди."])

# ---------- сериализатор ----------
key2qid = {q['key']: qid(i + 1) for i, q in enumerate(Q)}

def esc(s):
    s = clean(s)
    return s.replace('\\', '\\\\').replace('"', '\\"')

def task_obj(t, i):
    if t[0] == 'adv':
        return ['advancement: "%s"' % t[1], 'criterion: ""', 'id: "%s"' % tid(i), 'type: "advancement"']
    if t[0] == 'item':
        lines = []
        if t[2] != 1:
            lines.append('count: %dL' % t[2])
        lines += ['id: "%s"' % tid(i), 'item: "%s"' % t[1], 'type: "item"']
        return lines
    if t[0] == 'check':
        return ['id: "%s"' % tid(i), 'title: "%s"' % esc(t[1]), 'type: "checkmark"']
    raise ValueError(t)

def reward_obj(r, i, j):
    if r[0] == 'xp':
        return ['id: "%s"' % rid(i, j), 'type: "xp"', 'xp: %d' % r[1]]
    if r[0] == 'lvl':
        return ['id: "%s"' % rid(i, j), 'type: "xp_levels"', 'xp_levels: %d' % r[1]]
    if r[0] == 'item':
        lines = []
        if r[2] != 1:
            lines.append('count: %d' % r[2])
        lines += ['id: "%s"' % rid(i, j), 'item: "%s"' % r[1], 'type: "item"']
        return lines
    raise ValueError(r)

def block(lst, indent, open_pfx, close):
    # одиночный объект -> компактный [{ ... }]; несколько -> многострочный
    T = '\t'
    out = []
    if len(lst) == 1:
        out.append('%s%s[{' % (T * indent, open_pfx))
        for ln in lst[0]:
            out.append('%s%s' % (T * (indent + 1), ln))
        out.append('%s}]' % (T * indent))
    else:
        out.append('%s%s[' % (T * indent, open_pfx))
        for obj in lst:
            out.append('%s{' % (T * (indent + 1)))
            for ln in obj:
                out.append('%s%s' % (T * (indent + 2), ln))
            out.append('%s}' % (T * (indent + 1)))
        out.append('%s]' % (T * indent))
    return out

def fmtnum(v):
    return ('%.1fd' % v)

out = io.StringIO()
w = out.write
w('{\n')
w('\tdefault_hide_dependency_lines: false\n')
w('\tdefault_quest_shape: ""\n')
w('\tfilename: "abyss_signs"\n')
w('\tgroup: ""\n')
w('\ticon: "minecraft:heart_of_the_sea"\n')
w('\tid: "%s"\n' % CHAPTER_ID)
w('\torder_index: 0\n')
w('\tquest_links: [ ]\n')
w('\tquests: [\n')

for i, q in enumerate(Q, start=1):
    T = '\t'
    w('%s{\n' % (T * 2))
    fields = []
    # dependencies
    if q['deps']:
        deps = ', '.join('"%s"' % key2qid[k] for k in q['deps'])
        fields.append(['dependencies: [%s]' % deps])
    # description
    dl = ['%s"%s"' % (T * 4, esc(d)) for d in q['desc']]
    desc_block = ['%sdescription: [' % (T * 3)] + dl + ['%s]' % (T * 3)]
    # build full quest in alphabetical-ish order matching FTBQuests
    lines = []
    if q['deps']:
        deps = ', '.join('"%s"' % key2qid[k] for k in q['deps'])
        lines.append('%sdependencies: [%s]' % (T * 3, deps))
    lines += desc_block
    if q['flags'].get('hide'):
        lines.append('%shide_until_deps_visible: true' % (T * 3))
    lines.append('%sicon: "%s"' % (T * 3, q['icon']))
    lines.append('%sid: "%s"' % (T * 3, key2qid[q['key']]))
    if q['flags'].get('optional'):
        lines.append('%soptional: true' % (T * 3))
    # rewards
    robjs = [reward_obj(r, i, j) for j, r in enumerate(q['rewards'])]
    lines += block(robjs, 3, 'rewards: ', None)
    if q['flags'].get('shape'):
        lines.append('%sshape: "%s"' % (T * 3, q['flags']['shape']))
    if q['flags'].get('size'):
        lines.append('%ssize: %s' % (T * 3, fmtnum(q['flags']['size'])))
    # tasks
    tobjs = [task_obj(q['task'], i)]
    lines += block(tobjs, 3, 'tasks: ', None)
    lines.append('%stitle: "%s"' % (T * 3, esc(q['title'])))
    lines.append('%sx: %s' % (T * 3, fmtnum(q['x'])))
    lines.append('%sy: %s' % (T * 3, fmtnum(q['y'])))
    w('\n'.join(lines) + '\n')
    w('%s}\n' % (T * 2))

w('\t]\n')
w('\ttitle: "Хроники — Пролог: Пробуждение"\n')
w('}\n')

data = out.getvalue()
with open('config/ftbquests/quests/chapters/abyss_signs.snbt', 'w', encoding='utf-8') as f:
    f.write(data)

# быстрая самопроверка
ids = [l for l in data.splitlines()]
print("quests:", len(Q))
print("braces:", data.count('{'), data.count('}'))
print("OK ->", 'abyss_signs.snbt')
