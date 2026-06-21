# Маршрутизатор кликабельных ответов (запускается, когда abyss.dlg >= 1)
execute if score @s abyss.talk matches 10 if score @s abyss.dlg matches 1 run function abyss:npc/hermit/about_abyss
execute if score @s abyss.talk matches 10 if score @s abyss.dlg matches 2 run function abyss:npc/hermit/about_self
execute if score @s abyss.talk matches 20 if score @s abyss.dlg matches 1 run function abyss:npc/herald/choose_keeper
execute if score @s abyss.talk matches 20 if score @s abyss.dlg matches 2 run function abyss:npc/herald/choose_herald
scoreboard players set @s abyss.dlg 0
scoreboard players enable @s abyss.dlg
