# Отшельник — о Бездне (+ одноразовый подарок)
tellraw @s ["",{"text":"Отшельник берега","color":"dark_aqua","bold":true},{"text":": ","color":"dark_aqua"},{"text":"Холодный берег на самом краю мира. Подо льдом спит Бездна — голод старше всего сущего. Она просыпается и зовёт таких, как ты. Не каждый возвращается с её зова.","color":"white"}]
execute unless entity @s[tag=abyss.hermit_gift] run tellraw @s ["",{"text":"Возьми. На первую ночь хватит.","color":"gray","italic":true}]
execute unless entity @s[tag=abyss.hermit_gift] run give @s minecraft:torch 16
execute unless entity @s[tag=abyss.hermit_gift] run give @s minecraft:cooked_beef 6
execute unless entity @s[tag=abyss.hermit_gift] run give @s minecraft:bread 4
tag @s add abyss.hermit_gift
scoreboard players set @s abyss.talk 0
