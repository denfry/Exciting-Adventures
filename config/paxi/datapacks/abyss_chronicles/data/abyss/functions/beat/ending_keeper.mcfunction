# Концовка Части I «Хранитель» — первая печать легла (светлый итог, но НЕ финал)
title @s times 20 140 40
title @s subtitle {"text":"Первая печать легла","color":"dark_aqua","italic":true}
title @s title {"text":"ПЕРВАЯ ПОБЕДА","color":"gold","bold":true}
playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
playsound minecraft:entity.ender_dragon.death master @a ~ ~ ~ 1 0.6
tellraw @a ["",{"text":"Лилит повержена. ","color":"gold","bold":true},{"text":"Лёд стихает, первый разлом закрыт — и ","color":"yellow"},{"selector":"@s"},{"text":" наконец слышит своё имя. Хранитель.","color":"yellow"}]
tellraw @s ["",{"text":"Расправь крылья — но не убирай меч. Это была лишь первая битва: Бездна отступила, не умерев. Часть II ждёт.","color":"gold","italic":true}]
give @s minecraft:elytra
