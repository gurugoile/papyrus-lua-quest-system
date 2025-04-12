
-- Behavior.lua
-- Basic actor behavior, disposition, and negotiation module

local Behavior = {}

-- Actor states (could be per actor instance)
Behavior.states = {
    mood = "neutral",           -- e.g. hostile, cautious, cooperative
    disposition = {},           -- table of actor: value pairs
    loyalty = 1.0,              -- 0.0 (disloyal) to 1.0 (devoted)
    values = { gold = 1.0 },    -- subjective value weighting
    isLeader = false,
    influenceRadius = 0
}

function Behavior:SetMood(mood)
    self.states.mood = mood
end

function Behavior:GetMood()
    return self.states.mood
end

function Behavior:SetDisposition(target, value)
    self.states.disposition[target] = value
end

function Behavior:GetDisposition(target)
    return self.states.disposition[target] or 0
end

function Behavior:EvaluateOffer(offer)
    local value = 0
    if offer.gold then
        value = value + (offer.gold * (self.states.values.gold or 1.0))
    end
    -- Add more factors like fear, risk, item value, etc.
    return value
end

function Behavior:IsLeader()
    return self.states.isLeader
end

function Behavior:SetLeaderState(enabled, radius)
    self.states.isLeader = enabled
    self.states.influenceRadius = radius or 0
end

function Behavior:ApplyLeaderDecision(action)
    -- This would propagate action to all actors in range (handled by game engine)
    print("[LeaderDecision] Action applied to followers: " .. action)
end

return Behavior
