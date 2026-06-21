# Хроники Бездны — инициализация (срабатывает при загрузке мира)
scoreboard objectives add abyss.stage dummy {"text":"Хроники Бездны"}
scoreboard objectives add abyss.beats dummy {"text":"Сюжетные вехи"}
# путь игрока: 0 — не выбран, 1 — Хранитель (запечатать), 2 — Вестник (принять)
scoreboard objectives add abyss.path dummy {"text":"Путь Бездны"}
# диалоговый триггер (кликабельные ответы) и контекст разговора
scoreboard objectives add abyss.dlg trigger
scoreboard objectives add abyss.talk dummy
scoreboard objectives add abyss.npccd dummy
scoreboard objectives add abyss.met_hermit dummy
scoreboard objectives add abyss.met_herald dummy
# таймер боевой музыки
scoreboard objectives add abyss.bossmus dummy
