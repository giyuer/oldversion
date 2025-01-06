-- Execute primary script
script_key = "QUGfbiXZYeoJpnDThgKgJBwSWtgaCmZa"
loadstring(game:HttpGet("https://raw.githubusercontent.com/buang5516/buanghub/main/PremiumBuangHub.lua"))()
wait(10)

-- Settings 1: Display location
local settings1 = false
if settings1 then
    -- Remove snow parts in the map
    for _, child in ipairs(workspace._map:GetChildren()) do
        if child:FindFirstChild("snow") then
            child.snow:Destroy()
        end
    end

    -- Remove Beacon if it exists
    if workspace._map.player:FindFirstChild("Beacon") then
        workspace._map.player.Beacon:Destroy()
    end

    -- Modify area properties
    local area = workspace._map.player:FindFirstChild("area")
    if area then
        area.BrickColor = BrickColor.new("Lime green")
        area.Color = Color3.fromRGB(0, 255, 0)
        area.Size = Vector3.new(0.3, 15, 15)
        area.Shape = Enum.PartType.Block

        local attachment = area:FindFirstChild("Attachment")
        if attachment then
            attachment:Destroy()
        end
    end
end

-- Settings 2: Card picker
local settings2 = false
if settings2 then
    getgenv().FocusWave = 20 -- Priority limit wave
    getgenv().PriorityCards = { -- Priority tags when wave = FocusWave
        "+ Range I",
        "- Cooldown I",
        "+ Attack I",
        "+ Gain 2 Random Effects Tier 1",
        "- Cooldown II",
        "+ Range II",
        "+ Attack II",
        "+ Gain 2 Random Effects Tier 2",
        "- Cooldown III",
        "+ Range III",
        "+ Attack III",
        "+ Gain 2 Random Effects Tier 3"
    }
    getgenv().Cards = { -- All cards after FocusWave wave ends
        "+ Explosive Deaths I",
        "+ Explosive Deaths II",
        "+ Explosive Deaths III",
        "+ Gain 2 Random Curses Tier 3",
        "+ Gain 2 Random Curses Tier 2",
        "+ Gain 2 Random Curses Tier 1",
        "+ Enemy Speed III",
        "+ Enemy Speed II",
        "+ Enemy Speed I",
        "+ Enemy Regen I",
        "+ Enemy Regen II",
        "+ Enemy Regen III",
        "+ Yen I",
        "+ Yen II",
        "+ Yen III",
        "+ Boss Damage I",
        "+ Boss Damage II",
        "+ Boss Damage III",
        "+ Range I",
        "- Cooldown I",
        "+ Attack I",
        "+ Gain 2 Random Effects Tier 1",
        "- Cooldown II",
        "+ Range II",
        "+ Attack II",
        "+ Gain 2 Random Effects Tier 2",
        "- Cooldown III",
        "+ Range III",
        "+ Attack III",
        "+ Gain 2 Random Effects Tier 3",
        "+ Enemy Health I",
        "+ Enemy Health II",
        "+ Enemy Health III",
        "+ Enemy Shield I",
        "+ Enemy Shield II",
        "+ Enemy Shield III",
        "+ New Path"
    }
    -- Load card picker script
    loadstring(game:HttpGet("https://raw.githubusercontent.com/junggamyeon/MyScript/refs/heads/main/pickcard.lua"))()
end
