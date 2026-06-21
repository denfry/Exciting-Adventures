#START

#Add_Scores

execute unless entity @e[tag=clock] run scoreboard objectives remove dwc.clockTime
execute if entity @e[tag=clock] run scoreboard objectives add dwc.clockTime dummy
# scoreboard objectives setdisplay sidebar dwc.clockTime

scoreboard objectives add dwc.CONST dummy
# scoreboard objectives setdisplay sidebar dwc.CONST
scoreboard players set *-1 dwc.CONST -1
scoreboard players set *10 dwc.CONST 10
scoreboard players set *100 dwc.CONST 100
scoreboard players set *1000 dwc.CONST 1000

#Add_Names

# scoreboard players reset *M1 dwc.clockTime
# scoreboard players reset *M2 dwc.clockTime
# scoreboard players reset *M3 dwc.clockTime

scoreboard players reset *a dwc.clockTime
scoreboard players reset *b dwc.clockTime
scoreboard players reset *c dwc.clockTime
scoreboard players reset *d dwc.clockTime

scoreboard players reset *colon dwc.clockTime

scoreboard players reset *moon_phase.count dwc.clockTime
scoreboard players reset *moon_phase.current dwc.clockTime

scoreboard players reset *sleep dwc.clockTime
scoreboard players reset *weather dwc.clockTime
scoreboard players reset *villager dwc.clockTime

scoreboard players reset *light dwc.clockTime

# scoreboard players reset *signal.temp dwc.clockTime
# scoreboard players reset *signal.delay dwc.clockTime
# scoreboard players reset *signal.count dwc.clockTime
# scoreboard players reset *signal.trigger dwc.clockTime

#Get_Daytime

execute store result score *time dwc.clockTime run time query daytime

#Get_Light_levels

execute positioned ~ 319 ~ if predicate minecraft:light_level_00 run scoreboard players set *light dwc.clockTime 00
execute positioned ~ 319 ~ if predicate minecraft:light_level_01 run scoreboard players set *light dwc.clockTime 01
execute positioned ~ 319 ~ if predicate minecraft:light_level_02 run scoreboard players set *light dwc.clockTime 02
execute positioned ~ 319 ~ if predicate minecraft:light_level_03 run scoreboard players set *light dwc.clockTime 03
execute positioned ~ 319 ~ if predicate minecraft:light_level_04 run scoreboard players set *light dwc.clockTime 04
execute positioned ~ 319 ~ if predicate minecraft:light_level_05 run scoreboard players set *light dwc.clockTime 05
execute positioned ~ 319 ~ if predicate minecraft:light_level_06 run scoreboard players set *light dwc.clockTime 06
execute positioned ~ 319 ~ if predicate minecraft:light_level_07 run scoreboard players set *light dwc.clockTime 07
execute positioned ~ 319 ~ if predicate minecraft:light_level_08 run scoreboard players set *light dwc.clockTime 08
execute positioned ~ 319 ~ if predicate minecraft:light_level_09 run scoreboard players set *light dwc.clockTime 09
execute positioned ~ 319 ~ if predicate minecraft:light_level_10 run scoreboard players set *light dwc.clockTime 10
execute positioned ~ 319 ~ if predicate minecraft:light_level_11 run scoreboard players set *light dwc.clockTime 11
execute positioned ~ 319 ~ if predicate minecraft:light_level_12 run scoreboard players set *light dwc.clockTime 12
execute positioned ~ 319 ~ if predicate minecraft:light_level_13 run scoreboard players set *light dwc.clockTime 13
execute positioned ~ 319 ~ if predicate minecraft:light_level_14 run scoreboard players set *light dwc.clockTime 14
execute positioned ~ 319 ~ if predicate minecraft:light_level_15 run scoreboard players set *light dwc.clockTime 15

#Get_Villager_Work

execute if predicate minecraft:villager_work run scoreboard players add *villager dwc.clockTime 1

#Get_Unlocked_Bed

execute if predicate minecraft:sleep_time run scoreboard players add *sleep dwc.clockTime 1
execute if predicate minecraft:weather_thunder run scoreboard players add *sleep dwc.clockTime 1

#Get_Moon_Phases

scoreboard players set *moon_phase.count dwc.clockTime 8

execute store result score *moon_phase.current dwc.clockTime run time query day
scoreboard players operation *moon_phase.current dwc.clockTime %= *moon_phase.count dwc.clockTime

#Moon_Phases_Rotate_Flip_Over

execute unless score *moon_phase.current dwc.clockTime matches 0 unless score *moon_phase.current dwc.clockTime matches 4 if score *time dwc.clockTime matches 12544..17999 run scoreboard players operation *moon_phase.current dwc.clockTime -= *moon_phase.count dwc.clockTime
execute unless score *moon_phase.current dwc.clockTime matches 0 unless score *moon_phase.current dwc.clockTime matches 4 if score *time dwc.clockTime matches 12544..17999 if score *moon_phase.current dwc.clockTime matches ..0 run scoreboard players operation *moon_phase.current dwc.clockTime *= *-1 dwc.CONST

#Get_Weather

execute if predicate minecraft:weather_clear run scoreboard players set *weather dwc.clockTime 0
execute if predicate minecraft:weather_rain run scoreboard players set *weather dwc.clockTime 1
execute if predicate minecraft:weather_thunder run scoreboard players set *weather dwc.clockTime 2

#Get_Dusk_And_Dawn

execute if score *weather dwc.clockTime matches 0 if score *time dwc.clockTime matches 12000..13000 run scoreboard players remove *weather dwc.clockTime 1
execute if score *weather dwc.clockTime matches 0 if score *time dwc.clockTime matches 23000..24000 run scoreboard players remove *weather dwc.clockTime 2

#Set_Moon_Phase

execute unless score *time dwc.clockTime matches 12544..23461 run scoreboard players add *weather dwc.clockTime 10
execute if score *time dwc.clockTime matches 12544..23461 unless score *weather dwc.clockTime matches 0 run scoreboard players add *weather dwc.clockTime 10

execute if score *time dwc.clockTime matches 12544..23461 if score *weather dwc.clockTime matches 0 run scoreboard players operation *weather dwc.clockTime = *moon_phase.current dwc.clockTime

#Сalculate_MinecraftTime_In_RealTime

scoreboard players add *time dwc.clockTime 6000
execute if score *time dwc.clockTime matches 24000.. run scoreboard players remove *time dwc.clockTime 24000

execute store result storage minecraft:dwc time float 0.06 run scoreboard players get *time dwc.clockTime
execute store result score *time dwc.clockTime run data get storage minecraft:dwc time

execute if score *time dwc.clockTime matches 60.. run scoreboard players add *time dwc.clockTime 40

execute if score *time dwc.clockTime matches 160.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 260.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 360.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 460.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 560.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 660.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 760.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 860.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 960.. run scoreboard players add *time dwc.clockTime 40

execute if score *time dwc.clockTime matches 1060.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1160.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1260.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1360.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1460.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1560.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1660.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1760.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1860.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 1960.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 2060.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 2160.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 2260.. run scoreboard players add *time dwc.clockTime 40
execute if score *time dwc.clockTime matches 2360.. run scoreboard players add *time dwc.clockTime 40

execute if score *time dwc.clockTime matches 1.. run scoreboard players operation *d dwc.clockTime = *time dwc.clockTime

execute if score *time dwc.clockTime matches 10.. run scoreboard players operation *c dwc.clockTime = *time dwc.clockTime
execute if score *time dwc.clockTime matches 10.. run scoreboard players operation *c dwc.clockTime /= *10 dwc.CONST
execute if score *time dwc.clockTime matches 10.. run scoreboard players operation *c dwc.clockTime *= *10 dwc.CONST
execute if score *time dwc.clockTime matches 10.. run scoreboard players operation *d dwc.clockTime = *time dwc.clockTime
execute if score *time dwc.clockTime matches 10.. run scoreboard players operation *d dwc.clockTime -= *c dwc.clockTime
execute if score *time dwc.clockTime matches 10.. run scoreboard players operation *c dwc.clockTime /= *10 dwc.CONST

execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *b dwc.clockTime = *time dwc.clockTime
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *b dwc.clockTime /= *100 dwc.CONST
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *b dwc.clockTime *= *100 dwc.CONST
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *c dwc.clockTime = *time dwc.clockTime
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *c dwc.clockTime -= *b dwc.clockTime
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *b dwc.clockTime /= *100 dwc.CONST
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *d dwc.clockTime = *c dwc.clockTime
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *c dwc.clockTime /= *10 dwc.CONST
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *c dwc.clockTime *= *10 dwc.CONST
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *d dwc.clockTime -= *c dwc.clockTime
execute if score *time dwc.clockTime matches 100.. run scoreboard players operation *c dwc.clockTime /= *10 dwc.CONST

execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *a dwc.clockTime = *time dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *a dwc.clockTime /= *1000 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *a dwc.clockTime *= *1000 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *b dwc.clockTime = *time dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *b dwc.clockTime -= *a dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *a dwc.clockTime /= *1000 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *c dwc.clockTime = *b dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *b dwc.clockTime /= *100 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *b dwc.clockTime *= *100 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *c dwc.clockTime -= *b dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *b dwc.clockTime /= *100 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *d dwc.clockTime = *c dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *c dwc.clockTime /= *10 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *c dwc.clockTime *= *10 dwc.CONST
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *d dwc.clockTime -= *c dwc.clockTime
execute if score *time dwc.clockTime matches 1000.. run scoreboard players operation *c dwc.clockTime /= *10 dwc.CONST

#Tact

scoreboard players operation *M1 dwc.clockTime = *time dwc.clockTime
execute unless score *M1 dwc.clockTime = *M2 dwc.clockTime run scoreboard players add *M3 dwc.clockTime 1

#Tact_Colon_Tick

execute if score *M3 dwc.clockTime matches 1.. run scoreboard players operation *colon dwc.clockTime = *M3 dwc.clockTime
execute if score *M3 dwc.clockTime matches 2.. run scoreboard players operation *colon dwc.clockTime -= *colon dwc.clockTime
execute if score *M3 dwc.clockTime matches 2.. run scoreboard players reset *M3 dwc.clockTime

#Assign_Base_Numbers_To_Names

scoreboard players add *a dwc.clockTime 100
scoreboard players add *b dwc.clockTime 200
scoreboard players add *c dwc.clockTime 300
scoreboard players add *d dwc.clockTime 400

scoreboard players add *colon dwc.clockTime 10

scoreboard players add *sleep dwc.clockTime 20
scoreboard players add *villager dwc.clockTime 50
scoreboard players add *light dwc.clockTime 500
scoreboard players add *weather dwc.clockTime 600

#Summon_Clock

execute as @e[tag=clock] at @s[tag=base,tag=!clock_added] align xyz positioned ~0.5 ~0.5 ~0.5 run summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["clock","starter"],Passengers:[{id:"minecraft:item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","front"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","back"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","display"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","a"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","b"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","c"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","d"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","colon"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","sleep"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","light"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","weather"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b},{id:"minecraft:glow_item_frame",Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:70}},Tags:["clock","villager"],Invisible:1b,Invulnerable:1b,Fixed:1b,Silent:1b}]}

execute as @e[tag=clock] at @s[tag=!base] run data modify entity @s[tag=!clock_added] Facing set from entity @e[tag=clock,tag=base,tag=!clock_added,sort=nearest,limit=1] Facing
execute as @e[tag=clock] at @s[tag=!base] run data modify entity @s[tag=starter] Rotation set from entity @e[tag=clock,tag=base,tag=!clock_added,limit=1] Rotation

execute as @e[tag=clock] at @s[tag=starter,x_rotation=90] align xyz positioned ~0.5 ~0.93699 ~0.5 run summon minecraft:interaction ^ ^ ^ {width:0.75f,height:0.06251f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^-0.343805 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^-0.281295 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^-0.218785 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^-0.156275 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^-0.093765 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^-0.031255 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^0.031255 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^0.093765 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^0.156275 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^0.218785 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^0.281295 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=0] align xyz positioned ~0.5 ~0.125 ~0.5 run summon minecraft:interaction ^0.343805 ^ ^-0.4675 {width:0.06251f,height:0.75f,Tags:["clock","click"]}
execute as @e[tag=clock] at @s[tag=starter,x_rotation=270] align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:interaction ^ ^ ^ {width:0.75f,height:0.06251f,Tags:["clock","click"]}

execute as @e[tag=clock] at @s[tag=!base] run data modify entity @s[tag=!clock_added] Rotation set from entity @e[tag=clock,tag=base,tag=!clock_added,limit=1] Rotation

execute as @e[tag=clock] at @s[tag=front] run data modify entity @s[tag=!clock_added] Item.tag.CustomModelData set value 61
execute as @e[tag=clock] at @s[tag=back] run data modify entity @s[tag=!clock_added] Item.tag.CustomModelData set value 62
execute as @e[tag=clock] at @s[tag=display] run data modify entity @s[tag=!clock_added] Item.tag.CustomModelData set value 63

execute as @e[tag=clock] at @s[tag=!front] run kill @s[tag=base]

execute as @e[tag=clock] at @s[tag=front] run tag @s[tag=!clock_added] add clock_added
execute as @e[tag=clock] at @s[tag=!front] run tag @s[tag=!clock_added] add clock_added

execute as @e[tag=clock] at @s[tag=front] unless entity @s[nbt={Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:61}}}] run data merge entity @s[tag=clock_added] {Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:61}}}

execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 unless block ^ ^ ^-0.75 #minecraft:air run data modify entity @s[nbt={Fixed:0b}] Fixed set value 1b
execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 unless block ^ ^ ^-0.75 #minecraft:pass run data modify entity @s[nbt={Fixed:0b}] Fixed set value 1b

#The_Time_Signal

execute unless score *M1 dwc.clockTime = *M2 dwc.clockTime unless score *time dwc.clockTime matches 1..559 unless score *time dwc.clockTime matches 601..1159 unless score *time dwc.clockTime matches 1201..1759 unless score *time dwc.clockTime matches 1801..2359 run scoreboard players set *signal.count dwc.clockTime 2

execute if score *signal.count dwc.clockTime matches 1.. run scoreboard players set *signal.delay dwc.clockTime 5
execute unless score *signal.temp dwc.clockTime matches 1.. if score *signal.delay dwc.clockTime matches 0.. run scoreboard players operation *signal.temp dwc.clockTime = *signal.delay dwc.clockTime

execute if score *signal.temp dwc.clockTime = *signal.delay dwc.clockTime run scoreboard players set *signal.trigger dwc.clockTime 1
execute if score *signal.temp dwc.clockTime matches 1.. if score *signal.count dwc.clockTime matches 1.. run scoreboard players remove *signal.temp dwc.clockTime 1

execute if score *signal.temp dwc.clockTime matches ..0 run scoreboard players remove *signal.count dwc.clockTime 1

execute as @e[tag=clock] at @s[tag=front] if score *signal.trigger dwc.clockTime matches 1.. if score *time dwc.clockTime matches 600..1159 run playsound minecraft:item.clock.signal block @a ~ ~ ~ 0.25
execute as @e[tag=clock] at @s[tag=front] if score *signal.trigger dwc.clockTime matches 1.. if score *time dwc.clockTime matches 1200..1759 run playsound minecraft:item.clock.signal block @a ~ ~ ~ 0.25 .95
execute as @e[tag=clock] at @s[tag=front] if score *signal.trigger dwc.clockTime matches 1.. if score *time dwc.clockTime matches 1800..2359 run playsound minecraft:item.clock.signal block @a ~ ~ ~ 0.25 .9
execute as @e[tag=clock] at @s[tag=front] if score *signal.trigger dwc.clockTime matches 1.. if score *time dwc.clockTime matches 0..559 run playsound minecraft:item.clock.signal block @a ~ ~ ~ 0.25 .85

execute if score *signal.trigger dwc.clockTime matches 1.. run scoreboard players reset *signal.trigger dwc.clockTime
execute if score *signal.count dwc.clockTime matches ..0 run scoreboard players reset *signal.count dwc.clockTime
execute if score *signal.temp dwc.clockTime matches ..0 run scoreboard players reset *signal.delay dwc.clockTime
execute if score *signal.temp dwc.clockTime matches ..0 run scoreboard players reset *signal.temp dwc.clockTime

#Assign_CustomModelData_From_The_Names_From_Score_To_Objects

execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=a] Item.tag.CustomModelData int 1 run scoreboard players get *a dwc.clockTime
execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=b] Item.tag.CustomModelData int 1 run scoreboard players get *b dwc.clockTime
execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=c] Item.tag.CustomModelData int 1 run scoreboard players get *c dwc.clockTime
execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=d] Item.tag.CustomModelData int 1 run scoreboard players get *d dwc.clockTime

execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=colon] Item.tag.CustomModelData int 1 run scoreboard players get *colon dwc.clockTime

execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=sleep] Item.tag.CustomModelData int 1 run scoreboard players get *sleep dwc.clockTime
execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=weather] Item.tag.CustomModelData int 1 run scoreboard players get *weather dwc.clockTime
execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=villager] Item.tag.CustomModelData int 1 run scoreboard players get *villager dwc.clockTime

execute as @e[tag=clock] at @s[tag=!front] store result entity @s[tag=light] Item.tag.CustomModelData int 1 run scoreboard players get *light dwc.clockTime

#Break_Clock

execute as @e[tag=clock] at @s[tag=click] on attacker if entity @s[gamemode=!creative,gamemode=!spectator] align xyz positioned ~0.5 ~0.5 ~0.5 positioned ^ ^ ^-0.4 run tag @e[tag=clock,tag=front,distance=..0.1,sort=nearest] add summoner

execute as @e[tag=clock] at @s[tag=click] on attacker if entity @s[gamemode=!creative,gamemode=!spectator] run playsound minecraft:entity.item_frame.remove_item master @a
execute as @e[tag=clock] at @s[tag=click] on attacker run playsound minecraft:entity.item_frame.break master @a

execute as @e[tag=clock] at @s[tag=click] on attacker unless entity @s[gamemode=!creative,gamemode=!spectator] align xyz positioned ~0.5 ~0.5 ~0.5 positioned ^ ^ ^-0.4 run kill @e[tag=clock,tag=front,distance=..0.1,sort=nearest,limit=1]

execute as @e[tag=clock] at @s[tag=click] run data remove entity @s attack

#Rotate_Clock

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] on target run scoreboard objectives add dwc.ItemRotation dummy

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] on target run playsound minecraft:entity.item_frame.rotate_item master @a

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] on target align xyz positioned ~0.5 ~0.5 ~0.5 positioned ^ ^ ^-0.4 as @e[tag=clock,distance=..0.1,sort=nearest] at @s[tag=!click] store result score @s dwc.ItemRotation run data get entity @s ItemRotation

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] on target align xyz positioned ~0.5 ~0.5 ~0.5 positioned ^ ^ ^-0.4 as @e[tag=clock,distance=..0.1,sort=nearest] at @s[tag=!click] run scoreboard players add @s dwc.ItemRotation 1

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] on target align xyz positioned ~0.5 ~0.5 ~0.5 positioned ^ ^ ^-0.4 as @e[tag=clock,distance=..0.1,sort=nearest] at @s[tag=!click] store result entity @s ItemRotation int 1 run scoreboard players get @s dwc.ItemRotation

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] on target run scoreboard objectives remove dwc.ItemRotation

execute as @e[tag=clock] at @s[tag=click] unless entity @s[x_rotation=0] run data remove entity @s interaction

#Destroy_The_Clock_If_It_Is_Hanging_In_The_Air

execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if block ^ ^ ^-0.51 #minecraft:air run tag @s add summoner
execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if block ^ ^ ^-0.51 #minecraft:air run playsound minecraft:entity.item_frame.remove_item master @a
execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if block ^ ^ ^-0.51 #minecraft:air run playsound minecraft:entity.item_frame.break master @a

execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if block ^ ^ ^-0.51 #minecraft:pass run tag @s add summoner
execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if block ^ ^ ^-0.51 #minecraft:pass run playsound minecraft:entity.item_frame.remove_item master @a
execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if block ^ ^ ^-0.51 #minecraft:pass run playsound minecraft:entity.item_frame.break master @a

#Drop_Clock

execute as @e[tag=clock] at @s[tag=front] align xyz positioned ~0.5 ~0.5 ~0.5 if entity @s[tag=summoner] run summon minecraft:item ^ ^ ^-0.25 {Motion:[0.05d,0.25d,0.05d],Item:{id:"minecraft:item_frame",Count:1b,tag:{CustomModelData:60,display:{Name:'[{"translate":"item.minecraft.digital_wall_clock","italic":false}]'},EntityTag:{Tags:["clock","base"],Invisible:1b,Item:{id:"minecraft:knowledge_book",Count:1b,tag:{CustomModelData:60}}}}}}
execute as @e[tag=clock] at @s[tag=front] run kill @s[tag=summoner]

#Kill_!Front_Clock_If_Unless_Front

execute as @e[tag=clock] at @s[tag=!front] align xyz positioned ~0.5 ~0.5 ~0.5 positioned ^ ^ ^-0.4 unless entity @e[tag=clock,tag=front,distance=..0.1] run kill @s

#Equalize_Names

scoreboard players operation *M2 dwc.clockTime = *M1 dwc.clockTime

#Craft_Clock

recipe take @a[advancements={dwc:recipes/tools/digital_wall_clock=true}] dwc:digital_wall_clock
clear @a[advancements={dwc:recipes/tools/digital_wall_clock=true}] minecraft:knowledge_book 1
execute as @a at @s[advancements={dwc:recipes/tools/digital_wall_clock=true}] run function dwc:give
advancement revoke @a[advancements={dwc:recipes/tools/digital_wall_clock=true}] only dwc:recipes/tools/digital_wall_clock

#Remove_Data_And_Score

data remove storage minecraft:dwc time
scoreboard objectives remove dwc.CONST

#END