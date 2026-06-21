# Веха: вход в Глубокую Тьму
scoreboard players set @s abyss.stage 2
title @s times 10 70 20
title @s subtitle {"text":"Нисхождение","color":"dark_aqua","italic":true}
playsound minecraft:entity.warden.heartbeat master @s ~ ~ ~ 1 0.7
tellraw @s ["",{"text":"Глубокая Тьма смыкается над тобой. Здесь Бездна ближе всего к поверхности — и она уже чувствует твой шаг.","color":"dark_aqua","italic":true}]
