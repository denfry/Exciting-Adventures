# Веха: убит Хранитель
title @s times 10 70 20
title @s subtitle {"text":"Сердце Хранителя","color":"dark_aqua","italic":true}
playsound minecraft:entity.warden.death master @s ~ ~ ~ 1 1
tellraw @s ["",{"text":"Ты сразил Хранителя глубин. Немногие слышали стук его сердца — и ещё меньше осталось жить, чтобы рассказать.","color":"dark_aqua","italic":true}]
