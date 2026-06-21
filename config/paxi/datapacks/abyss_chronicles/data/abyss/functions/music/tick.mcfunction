# Дирижёр боевой музыки: играет эпичную тему, пока рядом босс
execute as @a[scores={abyss.bossmus=1..}] run scoreboard players remove @s abyss.bossmus 1
execute as @a[scores={abyss.bossmus=0}] at @s if entity @e[type=#abyss:bosses,distance=..50,limit=1] run function abyss:music/start
