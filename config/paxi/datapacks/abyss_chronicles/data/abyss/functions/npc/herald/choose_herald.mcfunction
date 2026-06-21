# Выбран Путь Вестника (тёмный финал)
scoreboard players set @s abyss.path 2
scoreboard players set @s abyss.talk 0
title @s times 8 50 15
title @s subtitle {"text":"Путь Вестника избран","color":"light_purple","italic":true}
playsound minecraft:entity.elder_guardian.curse master @s ~ ~ ~ 1 0.7
tellraw @s ["",{"text":"Вестница Бездны","color":"dark_purple","bold":true},{"text":": ","color":"dark_purple"},{"text":"Мудро. Зачем запирать то, чем можно стать? Лилит научит тебя — а ты займёшь её место у разлома.","color":"white"}]
