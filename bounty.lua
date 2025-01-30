wait(10)
script_key = "AwNCIhwxJSyjfeZOIatRtjpGibcznGAt"
getgenv().Team = "Pirates"
getgenv().WebhookSetting = {
    Enable = false,
    Url = "1",
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
    SmartUseRaceV3 = true,
    DashIfV4 = true,
    Dash = false,
    IgnoreInCombat = true, --Turn This Off When Reseting Or Hop You Lost Bounty (Rare, Happens On Some Accounts) cf by eric
    ChatKillEnable = false,
    Chat = {"gg"},
    IgnoreFriends = true, --true neu muon co ban be vao no hop sv
}
getgenv().AttackSetting = {
    ForceMelee = true,
    ForceMeleeTime = 3.5,
    StopAttack = true, --When Meet Below Condition
    StopAttackAtHealth = 50,--%
    FastAttack= true, -- Toggle Fast Attack
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

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/248f97d7a28a4d09c641d8279a935333.lua"))()
