script_key = "DBVHszBoTSbvzQTfWiJpijjGSNlKFXfs"
getgenv().Team = "Pirates"
getgenv().WebhookSetting = {
    Enable = true,
    Url = "",
    Embed = true,
    StoredFruit = true,
    ImageEmbed = true,
    CustomImage = true,
    CustomImageUrl = "https://i.imgur.com/wWxwPWE.png", --cf by eric
    OnServerHop = false,
    BountyChanged = true,
}
getgenv().PlayerSetting = {
    SafeMode = true,
    SafeModeHealth = {4300,40},--Number And %, Start Safe Mode And Stop Safe Mode
    UseRaceV3 = true,
    SmartUseRaceV3= true,
    DashIfV4 = true,
    Dash= false,
    IgnoreInCombat = false, --Turn This Off When Reseting Or Hop You Lost Bounty (Rare, Happens On Some Accounts) cf by eric
    ChatKillEnable = false,
    Chat = {"gg"},
    IgnoreFriends = false, --true neu muon co ban be vao no hop sv
}
getgenv().AttackSetting = {
    ForceMelee = true,
    ForceMeleeTime = 3.5,
    StopAttack =true, --When Meet Below Condition
    StopAttackAtHealth = 50,--%
    FastAttack=true, -- Toggle Fast Attack
}
getgenv().UseSkillSetting = {
    -- Three Methods: "Normal", "Fast", "Spam", "SpamAll"
    MethodIfTargetOnV4 = "Fast",
    MethodIfPlayerOnV4 = "SpamAll",
    MethodIfTargetUseFruit = {Fruits={buddha},Method="Spam"},
    NormalMethod = "Fast",
    LowHealthPlayerCondition = { --Player Can Attack Us, No Need For Slow Attack
        Enable = true,
        Health = 70,--%Health That Are Low
        Method = "Fast",
    },
    LowHealthTargetCondition = {
        Enable = true,
        Health = 20,--%Health That Are Low
        DelayFirstTime = {true,2}, --1 Is Enable, 2 Is Second To Delay Before Attack Again
        Method = "Fast",
        WaitTime = 0.5,-- If Normal Method, Wait Every Skill If It Hits Target
    }
}
getgenv().WeaponsSetting = {
    ["Melee"] = {
        ["Enable"] = true,
        ["Delay"] = 1, 
        ["SwitchNextWeaponIfCooldown"] = true,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["NoPredict"] = true, -- For Dragon Tailon, Disable it 
                ["HoldTime"] = 1.2,
                ["TimeToNextSkill"] = 0, -- cf by eric
            },
        [ "X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.14,
                ["TimeToNextSkill"] = 0,
            },

            ["C"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.4,
                ["TimeToNextSkill"] = 0,
            },
        },
    },
    ["Blox Fruit"] = {
        ["Enable"] = false,
        ["Delay"] = 1,
        ["SwitchNextWeaponIfCooldown"] = true,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["HoldTime"] = 2,
                ["TimeToNextSkill"] = 0,
            },
            ["X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.2,
                ["TimeToNextSkill"] = 0,
            },

            ["C"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.3,
                ["TimeToNextSkill"] = 0,
            },
            ["V"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.2,
                ["TimeToNextSkill"] = 0,
            },
            ["F"] = {
                ["Enable"] = false,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
        },
    },
    ["Sword"] = {
        ["Enable"] = true,
        ["Delay"] = 1.3,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["HoldTime"] = 1.2,
                ["TimeToNextSkill"] = 0,
            },
            ["X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.5,
                ["TimeToNextSkill"] = 0,
            },
        },
    },
    ["Gun"] = {
        ["Enable"] = false,
        ["Delay"] = 0.5,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = false,
                ["HoldTime"] = 0.1,
                ["TimeToNextSkill"] = 0,
            },
            ["X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.1,
                ["TimeToNextSkill"] = 0,
            },
        },
    },
}
getgenv().Theme = { -- getgenv().Theme = false if you want to disable
    OldTheme = false,
    Name="Hutao", --"Raiden","Ayaka","Hutao","Yelan","Miko","Nahida","Ganyu","Keqing","Nilou","Barbara","Zhongli","Layla"
    Custom={
            ["Enable"] = false,
            ['char_size'] = UDim2.new(0.668, 0, 1.158, 0),
            ['char_pos'] = UDim2.new(0.463, 0, -0.105, 0),
            ['title_color'] = Color3.fromRGB(255, 221, 252),
            ['titleback_color'] = Color3.fromRGB(169, 20, 255),
            ['list_color'] = Color3.fromRGB(255, 221, 252),
            ['liststroke_color'] = Color3.fromRGB(151, 123, 207),
            ['button_color'] = Color3.fromRGB(255, 221, 252)
       }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/248f97d7a28a4d09c641d8279a935333.lua"))()

wait(1)

repeat wait() until game:IsLoaded()

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local TIME_ZONE = 1
local WEBHOOK_URL = "https://discord.com/api/webhooks/XXXXXX/YYYYYY" -- Replace with your webhook URL
local AUTO_HOP_ENABLED = true
local timeBeforeHop = 120 -- Configurable time in seconds before auto-hop as a failsafe

local function getCurrentTimestamp()
    local date = os.date("!*t")
    local hour = (date.hour + TIME_ZONE) % 24
    local ampm = hour < 12 and "AM" or "PM"
    return string.format("%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, ampm)
end

local function sendWebhookNotification(message, playerName)
    local embed = {
        title = "Username: ||" .. playerName .. "||",
        description = "**Current Time: **" .. getCurrentTimestamp(),
        type = "rich",
        color = tonumber(0xffffff),
        fields = {{
            name = "Stats",
            value = message,
            inline = true
        }}
    }
    syn.request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode({ content = "", embeds = { embed } })
    })
end

local function findNewServer()
    local gameId = game.PlaceId
    local currentJobId = game.JobId
    local apiEndpoint = "https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Desc&limit=100"

    local function fetchServers(cursor)
        local url = apiEndpoint .. (cursor and "&cursor=" .. cursor or "")
        local response = game:HttpGet(url)
        return HttpService:JSONDecode(response)
    end

    local nextCursor
    repeat
        local serverData = fetchServers(nextCursor)
        for _, server in ipairs(serverData.data) do
            if server.playing < server.maxPlayers and server.id ~= currentJobId then
                local success = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, gameId, server.id, Players.LocalPlayer)
                if success then return end
            end
        end
        nextCursor = serverData.nextPageCursor
        wait(5)
    until not nextCursor
end

local function handleFriendInServer()
    if not AUTO_HOP_ENABLED then return end

    local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    local message = string.format("**Game: ** %s\n**Friend Joined Your Game**\n*Hopping Servers Now*", gameName)
    sendWebhookNotification(message, Players.LocalPlayer.Name)
    findNewServer()
end

local function checkForFriends()
    for _, player in ipairs(Players:GetPlayers()) do
        if player:IsFriendsWith(Players.LocalPlayer.UserId) then
            handleFriendInServer()
            break
        end
    end
end

-- GUI Creation for Failsafe Countdown
local ScreenGui = Instance.new("ScreenGui")
local CountdownLabel = Instance.new("TextLabel")

-- Parent GUI to the Player's PlayerGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "HopCountdownGUI"

-- Configure the Countdown Label
CountdownLabel.Parent = ScreenGui
CountdownLabel.Size = UDim2.new(0, 300, 0, 50)
CountdownLabel.Position = UDim2.new(0.5, -150, 0.1, 0) -- Centered at the top
CountdownLabel.BackgroundColor3 = Color3.new(0, 0, 0)
CountdownLabel.BackgroundTransparency = 0.5
CountdownLabel.TextColor3 = Color3.new(1, 1, 1)
CountdownLabel.Font = Enum.Font.SourceSansBold
CountdownLabel.TextSize = 24

-- Failsafe Countdown Logic
local function startFailsafeCountdown()
    for i = timeBeforeHop, 0, -1 do
        CountdownLabel.Text = "Time before auto-hop: " .. i .. " seconds"
        wait(1)
    end
    -- Auto-hop after countdown
    local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    local message = string.format("**Game: ** %s\n**Failsafe Activated**\n*Hopping Servers Now*", gameName)
    sendWebhookNotification(message, Players.LocalPlayer.Name)
    findNewServer()
end

task.spawn(startFailsafeCountdown)

-- Check when a new player joins
Players.PlayerAdded:Connect(function(player)
    if player:IsFriendsWith(Players.LocalPlayer.UserId) then
        handleFriendInServer()
    end
end)

-- Periodically check for friends in the server
task.spawn(function()
    while wait(10) do
        checkForFriends()
    end
end)
