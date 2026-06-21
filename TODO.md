# TODO — «Хроники Бездны» (Exciting Adventures): что осталось

Статус на момент написания: фазы **A, B, C, D + A2/A3/A4**, гейт полёта, мост-рецепты и
тех-моды — **сделаны и провалидированы** (`python _work/validate.py` → 0 ошибок; мод
`abysscore-0.1.0.jar` собирается и установлен в `mods/`). Ниже — то, что осталось.

---

## 1. Проверка в игре (на стороне пользователя)

Запустить инстанс PrismLauncher и проверить:

- [ ] `logs/latest.log` без `Mixin apply failed` / missing-deps; есть строки:
  - `[abysscore] Ядро «Хроник Бездны» инициализировано.`
  - `[abysscore] Загружено диалогов: N` (hermit/herald из jar + wanderer/oracle из датапака)
  - `[abysscore] Загружено загадок: M` (после первого старта мира)
- [ ] `logs/crafttweaker.log` — `scripts/abyss_progression.zs` загрузился без ошибок рецептов.
- [ ] NPC: ПКМ по виллагеру-отшельнику открывает **GUI-меню** (не чат).
- [ ] Загадки: `/abyss puzzle open intro` → открывается браузер; решил → `/abyss puzzle solve ABYSS-7314` → прогресс.
- [ ] Пьедестал: скрафтить `Загадочный камень`, поставить, ПКМ → браузер; `/abyss pedestal set cipher` привязывает другую загадку.
- [ ] **Гейт полёта**: до убийства Лилит элитры/полёт не работают; после `abyss:story/the_seal` — работают.
- [ ] Структуры: в **новых** чанках тайги генерится `hermit_hut`, в Краю — `edge_shrine` (worldgen не трогает старые чанки).

## 2. GitHub Pages (браузерные загадки)

- [ ] Включить Pages: **Settings → Pages → Deploy from branch → `master` / папка `/docs`**.
- [ ] Репозиторий называется **`denfry/Exciting-Adventures`** (с заглавными!). URL Pages
      регистрозависим: `https://denfry.github.io/Exciting-Adventures/`. Поле `base_url` в
      `config/abysscore/puzzles.json` должно совпадать **в точности** (исправлено на
      `…/Exciting-Adventures/puzzles/`).
- [ ] Проверить, что страницы открываются и коды совпадают с `puzzles.json`
      (intro=`ABYSS-7314`, cipher=`ABYSS-5290`, grid=`ABYSS-8861`).

## 3. Выделенный сервер (когда понадобится)

- [ ] Собрать/положить `fabric-server-launch.jar` (MC 1.20.1 / Loader 0.16.14) в `server/`.
- [ ] `server/split_mods.sh ../mods ./mods` — разнести клиентские моды.
- [ ] Скопировать `config/`, `defaultconfigs/`, `scripts/` рядом; принять EULA; запустить `start.sh`.
- [ ] FTBQuests при первом старте — в `world/serverconfig/ftbquests/`.

## 4. Решения по дизайну (дефолты выставлены, можно поменять)

- [ ] **Кооп FTBQuests**: сейчас **пер-игрок** (`default_reward_team:false`, `progression_mode:"linear"`).
      FTB Teams (2001.3.2) в паке есть — при желании переключить на командный прогресс в `data.snbt`.
- [ ] **Элитры**: гейт полёта уже делает их бесполезными до Лилит. Если хочется, чтобы элитра
      была **эксклюзивом босса** — отдельно убрать её из лута Энд-Сити (это hardcoded item frame
      в генерации End-корабля, не loot table → потребуется мод/мишин или замена структуры).

## 5. Расширения (по желанию)

- [ ] **Связь модов/рецептов**: `scripts/abyss_progression.zs` — это безопасный фундамент с
      примерами. Дополнить **выверенными** id из SimplySwords / Spectrum / Bewitchment / BetterEnd
      (проверять `logs/crafttweaker.log`). Полную «связь всех модов» вслепую не делал — риск баланса.
- [ ] **Аудит финала Части I**: убедиться, что квест «Ритуал призыва» в `finale.snbt` даёт
      корректный рецепт ритуала Bewitchment для `bewitchment:lilith` (иначе босс недостижим).
      Цепочка эндинга (`the_seal` → `beat/lilith` → keeper/herald) уже связана.
- [ ] **Больше NPC/структур**: добавить новые `.nbt` (`_work/gen_structures.py`) + диалоги
      (`data/abysscore/dialogues/*.json`, без пересборки jar).
- [ ] **Депрекейт-чистка**: старые tellraw-функции датапака (`npc/hermit/*`, `npc/herald/*`,
      `npc/dlg_handle`) оставлены как фолбэк — можно удалить, если мод подтверждён рабочим.

## 6. Пересборка мода (если правишь Java)

```bash
cd abyssmod
# на обычной машине достаточно:
gradle wrapper --gradle-version 8.7 && ./gradlew build
cp build/libs/abysscore-0.1.0.jar ../mods/
```

> ⚠️ В этой среде сеть рвёт TLS к `libraries.minecraft.net`. Обходы (НЕ нужны на нормальной машине):
> TLS 1.2 уже в `gradle.properties`; MC-библиотеки бьётся из локального зеркала через
> `--init-script` (см. `abyssmod/README.md` → «Сетевые нюансы сборки»).

---

## Карта проекта (где что лежит)

| Что | Где |
|-----|-----|
| Мод (исходники) | `abyssmod/` (jar → `mods/`, gitignored) |
| Браузерные загадки | `docs/` (GitHub Pages) |
| Конфиг загадок | `config/abysscore/puzzles.json` |
| Сюжетный датапак | `config/paxi/datapacks/abyss_chronicles/` |
| Структуры / worldgen / диалоги NPC | `…/data/abyss/structures/`, `…/data/abyss/worldgen/`, `…/data/abysscore/dialogues/` |
| FTBQuests | `config/ftbquests/quests/chapters/` (генераторы в `_work/`) |
| CraftTweaker | `scripts/*.zs` |
| Профиль сервера | `server/` |
| Валидатор | `python _work/validate.py` |
