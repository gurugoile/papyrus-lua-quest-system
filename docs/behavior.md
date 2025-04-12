
# Behavior and Influence Model

This document expands on the README's concept of a modular behavior and faction system with leader-based influence.

## Goals

- Move away from scripted sequences toward emergent NPC reactions
- Create flexible systems where decisions and mood affect outcomes
- Allow factions to act as dynamic entities influenced by internal and external triggers

## Core Concepts

### 1. Actor Disposition

Each actor maintains a set of dynamic state variables:

- `mood`: hostile, cautious, cooperative, fearful, etc.
- `disposition`: numeric scale representing general attitude toward the player
- `loyalty`: strength of commitment to their faction or leader
- `values`: what they care about (gold, power, honor, etc.)

### 2. Faction Hierarchy and Authority

- Factions can be structured hierarchically
- Leaders have `influence_radius` — an area where their decisions apply
- Followers check if a local decision was made by a peer or a leader

### 3. Negotiation Dynamics

- Deals can be offered to any member of a group
- If a **follower** accepts, the result is local and temporary
- If the **leader** accepts, the deal becomes authoritative and applies to the entire group

### Example: Bandit Surrender

| Scenario                          | Outcome                                              |
|----------------------------------|------------------------------------------------------|
| Player surrenders to a lone bandit  | Bandit may accept — but others might still attack   |
| Player negotiates with bandit leader | Entire group stands down if within influence range  |

### 4. Value-Based Decisions

NPCs make decisions by weighing perceived value:
- What are they protecting?
- What are they risking?
- What do they gain by fighting or cooperating?

This supports:

- Non-combat paths
- Bribery, intimidation, persuasion systems
- Dynamic group behavior based on authority and context

## API Ideas

```lua
actor:SetMood("cautious")
actor:SetDisposition(player, -15)
actor:EvaluateOffer(Deal:new({gold = 200, threat = false}))
faction:GetLeader():ApplyDecision("ceasefire")
```

## Future Directions

- Influence decay over time or distance
- Leader replacement / mutiny scenarios
- Trait-based behavior weights (e.g. greedy, prideful)
