# Веха: добыт осколок эха
title @s times 10 60 20
title @s subtitle {"text":"Бездна услышала тебя","color":"dark_purple","italic":true}
playsound minecraft:block.sculk_shrieker.shriek master @s ~ ~ ~ 1 0.8
tellraw @s ["",{"text":"Эхо шепчет именами тех, кого поглотила глубина. Теперь оно знает и твоё.","color":"dark_purple","italic":true}]
