# NPC: взаимодействие по близости (первый подход) и по Shift (повторно)
execute as @a[scores={abyss.npccd=1..}] run scoreboard players remove @s abyss.npccd 1
# Отшельник берега
execute as @a[scores={abyss.met_hermit=0,abyss.npccd=0}] at @s if entity @e[tag=npc_hermit,distance=..3,limit=1] run function abyss:npc/hermit/greet
execute as @a[scores={abyss.met_hermit=1..,abyss.npccd=0}] at @s if entity @e[tag=npc_hermit,distance=..4,limit=1] if predicate abyss:sneaking run function abyss:npc/hermit/greet
# Вестница Бездны
execute as @a[scores={abyss.met_herald=0,abyss.npccd=0}] at @s if entity @e[tag=npc_herald,distance=..3,limit=1] run function abyss:npc/herald/greet
execute as @a[scores={abyss.met_herald=1..,abyss.npccd=0}] at @s if entity @e[tag=npc_herald,distance=..4,limit=1] if predicate abyss:sneaking run function abyss:npc/herald/greet
