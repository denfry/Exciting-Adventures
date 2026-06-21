# Отшельник берега — приветствие
scoreboard players set @s abyss.talk 10
scoreboard players set @s abyss.met_hermit 1
scoreboard players set @s abyss.npccd 80
advancement grant @s only abyss:story/met_hermit
playsound minecraft:entity.villager.ambient master @s ~ ~ ~ 0.7 0.9
tellraw @s ["",{"text":"Отшельник берега","color":"dark_aqua","bold":true},{"text":": ","color":"dark_aqua"},{"text":"Очнулся? Я вытащил тебя из прибоя. Во сне ты звал кого-то — голосом, что был не твой.","color":"white"}]
tellraw @s ["",{"text":"   ▶ ","color":"dark_gray"},{"text":"Что это за место?","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/trigger abyss.dlg set 1"},"hoverEvent":{"action":"show_text","contents":{"text":"Спросить о Бездне","color":"gray"}}}]
tellraw @s ["",{"text":"   ▶ ","color":"dark_gray"},{"text":"Кто я такой?","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/trigger abyss.dlg set 2"},"hoverEvent":{"action":"show_text","contents":{"text":"Спросить о себе","color":"gray"}}}]
scoreboard players enable @s abyss.dlg
