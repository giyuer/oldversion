script_key = "AwNCIhwxJSyjfeZOIatRtjpGibcznGAt"
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
    IgnoreInCombat = true, --Turn This Off When Reseting Or Hop You Lost Bounty (Rare, Happens On Some Accounts) cf by eric
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

wait(5)

repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local GuiService = game:GetService("GuiService")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Variables for the timer
local TimerDuration = 300 -- 5 minutes in seconds
local TimeLeft = TimerDuration
local TimerRunning = false

-- Create a simple GUI for the countdown
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

local CountdownText = Instance.new("TextLabel")
CountdownText.Size = UDim2.new(0, 200, 0, 50)
CountdownText.Position = UDim2.new(0.5, -100, 0, 50)
CountdownText.BackgroundTransparency = 0.5
CountdownText.TextSize = 30
CountdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
CountdownText.Text = "Time left: " .. TimeLeft .. "s"
CountdownText.Parent = ScreenGui

-- Function to check for friends in the game
local function checkForFriends()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player:IsFriendsWith(LocalPlayer.UserId) then
            print("Friend found: " .. player.Name)
            -- Execute the server hop script if a friend is found
            loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/AutoServerHop.lua"))()
            return -- Exit the function after finding and executing
        end
    end
    print("No friends found.")
end

-- Function to update the countdown and execute after 5 minutes
local function updateTimer()
    while TimerRunning do
        wait(1) -- Decrease time by 1 second
        TimeLeft = TimeLeft - 1
        CountdownText.Text = "Time left: " .. TimeLeft .. "s"

        -- If the timer hits 0, execute the server hop script
        if TimeLeft <= 0 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/AutoServerHop.lua"))()
            print("5 minutes passed, server hop executed!")
            break -- Exit after executing the script
        end
    end
end

-- Initial check for friends
checkForFriends()

-- Start the 5-minute countdown if no friends are found
if not TimerRunning then
    TimerRunning = true
    task.spawn(updateTimer)
end

-- Check when a new player joins
Players.PlayerAdded:Connect(function(player)
    if player:IsFriendsWith(LocalPlayer.UserId) then
        print("Friend found: " .. player.Name)
        -- Execute the server hop script if a friend joins
        loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/AutoServerHop.lua"))()
    end
end)

-- Periodic checks for friends
task.spawn(function()
    while wait(10) do -- Check every 10 seconds
        checkForFriends()
    end
end)

