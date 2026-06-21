# ФИНАЛ — Лилит повержена. Концовка зависит от выбора игрока (abyss.path)
scoreboard players set @s abyss.stage 8
execute if score @s abyss.path matches 2 run function abyss:beat/ending_herald
execute unless score @s abyss.path matches 2 run function abyss:beat/ending_keeper
