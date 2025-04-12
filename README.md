# Papyrus-to-Lua Quest and Dialog System

This project implements a flexible and moddable quest and dialog system for the Godot game engine using Lua as the scripting language. It provides a modern alternative to Bethesda's Papyrus scripting language, with a planned converter for existing `.psc` files and a powerful Lua-based runtime that supports quests, branching dialogs, and in-game consequences.

---

## ⚠️ Preamble

This project and its core concept are released freely to the community in the spirit of open source. Due to physical limitations caused by a progressive disability (MDA), I am unable to actively lead or maintain this project. However, I strongly encourage developers, designers, and enthusiasts to take these ideas further, adapt them, and share improvements — as long as the results remain open source and accessible to others.

No attribution is required, but contributions that stay true to the original goal of empowering narrative and quest-driven experiences through modular, interpretable scripting are deeply appreciated.

---

## ✨ Motivation

Bethesda's Papyrus scripting language powers iconic RPGs like Skyrim and Fallout. However, it is tightly coupled to the Creation Engine. This project aims to:

- Recreate Papyrus-style scripting in Lua
- Enable easy quest logic and dialog design
- Support decision-based gameplay mechanics
- Run entirely inside the Godot Engine
- **Go beyond the limitations of traditional Papyrus AI scripting** by introducing behavioral reasoning and mood-driven responses instead of rigid kill-centric quests.

### Rethinking NPC Behavior

Many quests in modern RPGs rely on scripted behavior and combat-driven objectives. This project aims to encourage more nuanced and emergent gameplay by:

- Defining **actor moods and internal states**
- Allowing NPCs to respond dynamically to situations, not just scripted triggers
- Enabling **non-violent resolutions** and quest branches
- Modeling behaviors like fear, suspicion, trust, or motivation in lightweight systems
- Moving from scripted outcomes to behavior-based goals

This enables quest writers to design missions where empathy, intimidation, persuasion, or deception are valid approaches — not just combat.

---

## 📝 Overview

The system has three major parts:

1. **Papyrus-to-Lua Translator**  
   Parses Papyrus `.psc` files and outputs equivalent Lua scripts.

2. **Lua Quest Runtime**  
   Provides quest management, branching logic, objectives, and rewards.

3. **Lua Dialog System**  
   Enables dynamic conversations with NPCs, including player choices and consequences.

---

## ⚖️ Quest System Example: "The Lost Ring"

```lua
LostRingQuest = Quest:extend()

function LostRingQuest:OnInit()
    Debug.Trace("Quest 'The Lost Ring' started")
    self.name = "The Lost Ring"
    self:AddObjective("Find Bob's lost ring.")
    self:SetStage(10)
end

function LostRingQuest:OnStage(stage)
    local player = Game.GetPlayer()
    local bob = Game.GetActor("Bob")

    if stage == 10 then
        bob:Say("I lost my ring in the forest. Can you help me?")
    elseif stage == 20 then
        bob:Say("You found it! Thank you!")
        self:GiveReward(player)
        self:Complete()
    end
end

function LostRingQuest:GiveReward(player)
    player:AddGold(100)
    player:Say("You receive 100 gold.")
end
```

---

## 🚪 Dialog System Example: "Elora's Recipe"

```lua
local tree = DialogTree:new()

local n1 = DialogNode:new("greeting", "Elora", "Did you find my recipe?")
n1:addOption(DialogOption:new("Yes, here it is.", "thankyou", function()
    StolenRecipeQuest:SetStage(30)
end))
n1:addOption(DialogOption:new("I think I'll keep it...", "betray", function()
    StolenRecipeQuest:SetStage(40)
end))

local n2 = DialogNode:new("thankyou", "Elora", "Thank you so much!")
local n3 = DialogNode:new("betray", "Elora", "How dare you...")

tree:addNode(n1)
tree:addNode(n2)
tree:addNode(n3)

dialog = DialogManager:new(tree)
dialog:present()
```

This dialog system supports:
- Branching player choices
- Callbacks for each response
- Integration with quest stages and game state

---

## 📊 Architecture

```text
+------------------+      +--------------------+      +---------------------+
| .psc Script File | -->  | Papyrus-to-Lua     | -->  | Lua Script Runtime  |
| (Papyrus Source) |      | Translator         |      | (in Godot)          |
+------------------+      +--------------------+      +---------------------+
                                                       ↙
                +------------------------+           ↙
                | Quest/Dialog API Layer | <---------+-- Game Objects (NPCs, Triggers)
                +------------------------+
```

---

## 💡 Features

- Easy-to-write Lua quests and dialogs
- Papyrus-style class and event handling
- Branching story logic with consequences
- Extendable with custom game logic
- Behavior-driven design potential (actor states, motives, emergent outcomes)
- Can load from Lua or external formats (JSON planned)

---

## 🔧 Planned Features

- Papyrus `.psc` parser and transpiler to Lua
- Save/load quest and dialog states
- Graph-based dialog editor (future)
- Condition-based dialog options
- Visual quest debugger
- Actor behavior and state system (mood, traits, attitude)

---

## ⚖️ License

MIT License

---

## 🚀 Contributions Welcome

If you're interested in:
- Translating `.psc` files
- Improving Lua runtime architecture
- UI systems in Godot
- Building behavior-rich NPC interactions
- Creating non-violent and multi-path quests

Feel free to fork, contribute or open issues!


