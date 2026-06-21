# Вестница Бездны — ВЫБОР, определяющий финал
scoreboard players set @s abyss.talk 20
scoreboard players set @s abyss.met_herald 1
scoreboard players set @s abyss.npccd 80
advancement grant @s only abyss:story/met_herald
playsound minecraft:block.sculk_sensor.clicking master @s ~ ~ ~ 1 0.6
tellraw @s ["",{"text":"Вестница Бездны","color":"dark_purple","bold":true},{"text":": ","color":"dark_purple"},{"text":"Ты зашёл далеко, безымянный. Лилит ждёт тебя у разлома. Но прежде реши, кем ты придёшь к ней — этот выбор решит, чем закончатся Хроники.","color":"white"}]
tellraw @s ["",{"text":"   ✦ ","color":"dark_gray"},{"text":"Я запечатаю Бездну и спасу мир.","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/trigger abyss.dlg set 1"},"hoverEvent":{"action":"show_text","contents":{"text":"Путь Хранителя — светлый финал","color":"aqua"}}}]
tellraw @s ["",{"text":"   ✦ ","color":"dark_gray"},{"text":"Я приму силу Бездны как свою.","color":"light_purple","underlined":true,"clickEvent":{"action":"run_command","value":"/trigger abyss.dlg set 2"},"hoverEvent":{"action":"show_text","contents":{"text":"Путь Вестника — тёмный финал","color":"dark_purple"}}}]
tellraw @s ["",{"text":"   (выбор можно изменить, пока Лилит жива — поговори со мной снова, присев рядом)","color":"dark_gray","italic":true}]
scoreboard players enable @s abyss.dlg
