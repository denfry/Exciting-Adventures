# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is **not a software project** — it is the `minecraft/` game directory of a
PrismLauncher instance running the CurseForge modpack **"Exciting Adventures"**.
There is no source code to build, no test suite, and no CI. Work here means
**configuring mods, writing scripts, editing resources, and diagnosing crashes**.

Pinned versions (do not change casually — mods are compiled against them):

- Minecraft `1.20.1`
- Mod loader: **Fabric Loader** `0.16.2` (this is a Fabric pack, *not* Forge/NeoForge)
- Java `17` (Microsoft runtime, path in `../instance.cfg` → `JavaPath`)
- ~458 mods in `mods/`

Instance metadata lives one level up (outside this dir):
- `../instance.cfg` — launcher settings (Java path, JVM args, window, etc.)
- `../mmc-pack.json` — exact loader/MC/LWJGL component versions

## Critical: this is a managed pack

`../instance.cfg` has `ManagedPack=true` (`ManagedPackType=flame`, CurseForge
project `601606`, currently version `2.0.6`). **Updating the pack via the launcher
can overwrite `mods/`, `config/`, and other tracked files.** When making lasting
customizations, prefer the override-safe locations below and warn the user that a
pack update may revert in-place edits to managed files.

## Where to make changes

| Goal | Location | Notes |
|------|----------|-------|
| Change a mod's behavior | `config/` (371 entries) | Per-mod files: `.toml`, `.json`, `.json5`, `.properties`, subfolders. Format varies per mod. |
| Default config for fresh worlds | `defaultconfigs/` | Copied into a new world's `serverconfig` on first load (e.g. `ftbchunks`, `ftblibrary`). |
| Recipe / loot / tag tweaks via script | `scripts/` → `.zs` files | **CraftTweaker** (`CraftTweaker-fabric-1.20.1-14.0.43.jar`). Currently empty. This pack has **no KubeJS** — use ZenScript, not JS. |
| Add/remove a mod | `mods/` | Must be a Fabric `1.20.1` jar with compatible deps. Check `latest.log` after. |
| Textures / models | `resourcepacks/`, `texturepacks/` | Activate order is in `options.txt` (`resourcePacks=`). |
| Shaders (Iris) | `shaderpacks/` | `irisUpdateInfo.json` tracks shader update state. |
| Client options / keybinds | `options.txt` | Standard MC options file. |
| GUI / menu customization | `fancymenu_data/` | FancyMenu mod data. |
| Per-world saves | `saves/` | Currently empty. |

## Diagnosing problems (read logs first)

- `logs/latest.log` — main game/mod-loader log. **First stop for crashes,
  missing-dependency errors, and mod load failures.** Look for `Caused by`,
  `Mixin apply failed`, and missing-mod / version-mismatch lines.
- `logs/crafttweaker.log` — output of CraftTweaker script execution and recipe
  dumps. Check here after editing anything in `scripts/`.
- `.mixin.out/` — exported transformed classes; only relevant for deep mixin
  conflict debugging.
- `crash-reports/` will appear here if the game hard-crashes.

## Working conventions

- **Match each mod's existing config format.** A change in `config/` must use that
  file's own syntax (TOML vs JSON5 vs properties) — there is no single schema.
- **Don't invent mod IDs or config keys.** Verify against the actual file in
  `config/` or the jar name in `mods/` before editing; with ~458 mods, guessing
  produces silently-ignored settings.
- **CraftTweaker scripts** go in `scripts/` as `.zs`, are loaded at game start, and
  are validated via `logs/crafttweaker.log` — there is no offline compile step.
- After any change that affects loading, the only "test" is **launching the
  instance** (via PrismLauncher) and reading `logs/latest.log`.

## Notable mod ecosystems present (for context when configuring)

- **Performance/rendering:** DistantHorizons, Iris (shaders), Sodium-family configs.
- **FTB suite:** FTB Chunks / Library (see `defaultconfigs/`, `config/`).
- **Worldgen/structure mods:** many `better*` structure configs in `config/`
  (BetterDungeons, BetterFortresses, BetterEnd, etc.) — `*-fabric-1_20.toml`.
- **Scripting/compat:** CraftTweaker (ZenScript), Cardinal Components API.
- **Map:** Xaero's World Map (`XaeroWorldMap/`, `xaero/`).
