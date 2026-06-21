# Веха: первый вход в Край — здесь же является Вестница Бездны с выбором финала
tellraw @s ["",{"text":"Край мира. Пустота между звёздами. Бездна была здесь задолго до тебя.","color":"light_purple","italic":true}]
function abyss:npc/spawn_herald
tellraw @s ["",{"text":"Из пустоты выступает фигура в покрове тьмы. ","color":"gray","italic":true},{"text":"Вестница Бездны","color":"dark_purple","italic":true},{"text":" ждёт твоего слова. (подойди к ней)","color":"gray","italic":true}]
