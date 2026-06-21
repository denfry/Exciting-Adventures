# Концовка Части I «Вестник» — ты принял силу Бездны (тёмный итог, но НЕ финал)
title @s times 20 160 40
title @s subtitle {"text":"Бездна обрела новый голос","color":"light_purple","italic":true}
title @s title {"text":"ПЕРВЫЙ ИЗ ГОЛОСОВ","color":"dark_red","bold":true}
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 1 0.7
tellraw @a ["",{"text":"Лилит повержена — но Бездна не запечатана. ","color":"dark_purple","bold":true},{"text":"Её сила перетекает в ","color":"light_purple"},{"selector":"@s"},{"text":". Берег умолкает. Первый из голосов глубины — теперь ты.","color":"light_purple"}]
tellraw @s ["",{"text":"Ты услышал отголосок имени — слишком древнего, чтобы произнести. И это лишь начало пути. Часть II ждёт.","color":"dark_purple","italic":true}]
give @s minecraft:elytra
give @s minecraft:nether_star 3
give @s minecraft:netherite_ingot 2
give @s minecraft:wither_skeleton_skull{display:{Name:'[{"text":"Венец Бездны","color":"dark_purple","italic":false}]',Lore:['[{"text":"Корона того, кто стал голосом глубины.","color":"dark_gray","italic":true}]']}}
