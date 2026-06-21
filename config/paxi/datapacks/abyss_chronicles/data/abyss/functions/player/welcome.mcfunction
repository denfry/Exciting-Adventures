# Первая встреча игрока с Бездной — выдаётся один раз
tag @s add abyss.welcomed
scoreboard players set @s abyss.stage 1
# гарантируем стартовые значения диалоговых скорбордов (иначе NPC не отзовутся)
scoreboard players set @s abyss.met_hermit 0
scoreboard players set @s abyss.met_herald 0
scoreboard players set @s abyss.npccd 0
scoreboard players set @s abyss.talk 0
scoreboard players set @s abyss.path 0
advancement grant @s only abyss:story/root
advancement grant @s only abyss:story/prologue
function abyss:player/give_codex
function abyss:npc/spawn_hermit
title @s times 12 90 25
title @s subtitle {"text":"Пролог — Холодный берег","color":"dark_aqua","italic":true}
title @s title {"text":"ХРОНИКИ БЕЗДНЫ","color":"dark_purple","bold":true}
playsound minecraft:ambient.cave master @s ~ ~ ~ 1 0.6
tellraw @s ["",{"text":"Ты приходишь в себя на чужом берегу. Памяти нет — только холод, ветер и стылая вода.","color":"gray","italic":true}]
tellraw @s ["",{"text":"…  ","color":"dark_purple"},{"text":"Голос зовёт тебя по имени, которого ты не помнишь.","color":"dark_purple","italic":true}]
tellraw @s ["",{"text":"В руке — потёртое письмо и книга в кожаном переплёте. ","color":"gray","italic":true},{"text":"[Хроники Бездны]","color":"dark_purple","italic":true,"hoverEvent":{"action":"show_text","contents":{"text":"Открой книгу из инвентаря, чтобы начать","color":"gray"}}}]
