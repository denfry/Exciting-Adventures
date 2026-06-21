# Хроники Бездны — основной такт.
# 0) инициализация per-player скорбордов. dummy-скоры НЕ существуют у игрока, пока не
#    заданы явно; без этого селекторы вида scores={abyss.met_hermit=0,abyss.npccd=0}
#    не находят никого — поэтому NPC молчали, а боевая музыка не запускалась.
#    "add ... 0" создаёт скор со значением 0, если его нет, и не трогает существующий.
scoreboard players add @a abyss.npccd 0
scoreboard players add @a abyss.met_hermit 0
scoreboard players add @a abyss.met_herald 0
scoreboard players add @a abyss.talk 0
scoreboard players add @a abyss.bossmus 0
scoreboard players add @a abyss.path 0
# 1) первая встреча игрока с Бездной
execute as @a[tag=!abyss.welcomed] at @s run function abyss:player/welcome
# 2) диалоги с NPC (подход/Shift рядом с персонажем)
function abyss:npc/tick
# 3) маршрутизатор кликабельных ответов
execute as @a[scores={abyss.dlg=1..}] at @s run function abyss:npc/dlg_handle
# 4) дирижёр боевой музыки
function abyss:music/tick
