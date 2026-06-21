# Выбран Путь Хранителя (светлый финал)
scoreboard players set @s abyss.path 1
scoreboard players set @s abyss.talk 0
title @s times 8 50 15
title @s subtitle {"text":"Путь Хранителя избран","color":"aqua","italic":true}
tellraw @s ["",{"text":"Вестница Бездны","color":"dark_purple","bold":true},{"text":": ","color":"dark_purple"},{"text":"Гордо. Глупо. Пусть так — Бездна примет твой вызов.","color":"white"}]
