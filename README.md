# Core-Forge Drug Empire

A full criminal economy system for FiveM — from sourcing raw precursors, through lab synthesis or street-level crafting, to running the streets and building your rep.

## Table of Contents

- [About](#about)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Features](#features)
- [Included Drugs](#included-drugs)
- [Support](#support)

---

## About

Core-Forge Drug Empire is a config-driven multi-drug economy framework built for QBCore, ESX, and QBox. It combines a precursor supply chain, multi-step lab synthesis, street-level crafting, plant gathering, and a full rep/XP progression system into a single resource.

Add a completely new drug with unique steps, locations, animations, and props in 30 minutes or less — no scripting required.

---

## Requirements

- [ox_inventory](https://github.com/overextended/ox_inventory)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)
- QBCore / ESX / QBox

---

## Installation

1. Download from your cfx portal and place inside your `resources` folder 

2. Download [glitch-minigames](https://github.com/Gl1tchStudios/glitch-minigames) and place inside your `resources` folder

3. Import the SQL file into your database

```bash
mysql -u root -p your_database < core_drugs.sql
```

4. Add the resource to your `server.cfg`

```
ensure glitch-minigames
ensure core-drugs
```

5. Configure the resource to match your server — see [Configuration](#configuration)

6. Restart your server or run `refresh` then `ensure glitch-minigames` `ensure core-drugs` in the console

---

## Configuration

All configuration lives in `config/`. No scripting required to add or modify drugs.

### Adding a New Drug

Define a new entry in `Config.ProcessingSteps` or `Config.LabTargets` depending on the drug type:

```lua
Config.ProcessingSteps = {
    YourDrug = {
        [1] = {
            Zones = { vec3(0.0, 0.0, 0.0) },
            Ingredients = { your_item = 2 },
            OutputItem = 'your_output_item',
            OutputAmount = 1,
            Duration = 10000,
            Anim = { dict = 'your_dict', name = 'your_clip' },
            progressText = "Processing..."
        }
    }
}
```

### Lab Fail Settings

```lua
Config.LabFail = {
    Explosion = true,
    ExplosionChance = 40,
    ExplosionDamage = { min = 40, max = 190 },
    RagdollTime = 6000,
    LabFailCooldown = 10000
}
```

### Lab Minigame Settings
Lab minigames are optional and can be turned off or use any minigame pack for fivem.
Script is preconfigured to use glitch-minigames https://github.com/Gl1tchStudios/glitch-minigames
```lua
--/editable/client/minigames.lua
-- This is what it's already preconfigured to use.
--minigamePrecursor
RegisterNetEvent("rs-drugs:client:minigamePrecursor", function(drugName, stepIndex)
    local success = exports['glitch-minigames']:StartAimTestGame(15000, 5, 1500, 60, true, 2, 0)
    -- Parameters: timeLimit, targetsToHit, targetLifetime, targetSize, shrinkTarget, maxMisses, timePenalty
    -- Defaults: 30000, 10, 1500, 60, true, 5, 0
    if success then
        notifySuccess()
        TriggerEvent("rs-drugs:client:minigamePrecursorPart2", drugName, stepIndex)
    else
        notifyFail()
        if Config.LabFail.Explosion == true then
            TriggerServerEvent("rs-drugs:server:resolveLabFail", drugName, stepIndex)
        end
    end
end)
RegisterNetEvent("rs-drugs:client:minigamePrecursorPart2", function(drugName, stepIndex)
    Wait(100)
    local success = exports['glitch-minigames']:StartBalanceGame(10000, 8, 12, 18, 20, 2, 1000)
    -- Parameters: timeLimit, driftSpeed, sensitivity, greenZoneWidth, yellowZoneWidth, driftRandomness, maxDangerTime
    -- Defaults: 10000, 3, 8, 30, 25, 2, 1000
    if success then
        notifySuccess()
        TriggerServerEvent("rs-drugs:server:attemptLabStep", drugName, stepIndex)
    else
        notifyFail()
        if Config.LabFail.Explosion == true then
            TriggerServerEvent("rs-drugs:server:resolveLabFail", drugName, stepIndex)
        end
    end
end)
```

### Precursor Settings

```lua
Config.Precursor.Cost = 5000        -- Cost per shipment
Config.Precursor.Cooldown = 40      -- Minutes between requests
Config.Precursor.Amount = 50        -- Items per shipment
```

---

## Features

### Lab & Synthesis

- Multi-step lab synthesis with zone-based progression
- Unique lab locations per drug, per step
- Lab teleport system
- Hand props and world props per step
- Blotter select UI for tab-select drugs
- Lab fail system — explosion chance, damage range, ragdoll
- Reusable item support

### Crafting & Processing

- Simple crafting for street-level drugs
- Simple processing for raw material conversion
- Mix and match lab vs crafting per drug

### Gathering & Plants

- Simple item gathering zones
- Seed-based plant spawning — set a center zone and a seed, done
- Procedurally generated positions — same layout every restart
- All clients see identical plant positions

### Precursor System

- NPC brokers at unique map locations
- Hot item flagging for precursor chemicals
- Cooldown between shipment requests
- Randomized drop locations per request

### Street Economy & Rep

- Reputation tracked per drug per player
- XP earned per sale — XP is your rep
- Level progression stored in SQL
- Lifetime earnings tracked per player
- Fully persistent across restarts

### Consumeable Framework

- Item-based consumeable effects
- Configurable health, armor, and buff effects per item
- Props and animations per consumeable

---

## Included Drugs

| Drug | Type | Steps |
| ------ | ------ | ------- |
| Cocaine | Processing | 3 |
| Heroin | Processing | 2 |
| Fentanyl | Lab Synthesis | 4 |
| PCP | Lab Synthesis | 4 |
| LSD | Lab Synthesis (Tab Select) | 4 |
| 2CB | Lab Synthesis (Tab Select) | 4 |
| Ketamine | Processing | 2 |
| DMT | Processing | 2 |
| Mushroom | Processing | 1 |
| Peyote | Processing | 1 |
| Moonshine | Processing | 1 |

---

## Support

- 💬 Discord: [discord.gg/TBb4QKHQtm](https://discord.gg/TBb4QKHQtm)
- 🛒 Tebex: [core-forge.tebex.io](https://core-forge.tebex.io/package/7497769)
- 📺 YouTube: [youtube.com/@CoreForgeFivem](https://youtube.com/@CoreForgeFivem)
- 📁 GitHub: [github.com/Core-Forge-5](https://github.com/Core-Forge-5)