script_key = "DBVHszBoTSbvzQTfWiJpijjGSNlKFXfs" -- cf by mrbear
getgenv().Team = "Pirates" -- Pirates,Marines

getgenv().WeaponsSetting = {
    ["Melee"] = {
        ["Enable"] = true,
        ["Delay"] = 2,
        ["SwitchNextWeaponIfCooldown"] = true,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["NoPredict"] = true, -- For Dragon Tailon, Disable it 
                ["HoldTime"] = 0.6,
                ["TimeToNextSkill"] = 0.3, -- cf by mrbear
            },
        [ "X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.2,
                ["TimeToNextSkill"] = 0.3, -- cf by mrbear
            },

            ["C"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.1,
                ["TimeToNextSkill"] = 0.3, -- cf by mrbear
            },
        },
    },
    ["Blox Fruit"] = {
        ["Enable"] = false,
        ["Delay"] = 0,
        ["SwitchNextWeaponIfCooldown"] = true,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
            ["X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },

            ["C"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
            ["V"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
            ["F"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
        },
    },
    ["Sword"] = {
        ["Enable"] = true,
        ["Delay"] = 1,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["HoldTime"] = 1,
                ["TimeToNextSkill"] = 0, -- cf by mrbear
            },
            ["X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0.1,
                ["TimeToNextSkill"] = 0, -- cf by mrbear
            },
        },
    },
    ["Gun"] = {
        ["Enable"] = false,
        ["Delay"] = 0,
        ["Skills"] = {
            ["Z"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
            ["X"] = {
                ["Enable"] = true,
                ["HoldTime"] = 0,
                ["TimeToNextSkill"] = 0,
            },
        },
    },
}
getgenv().Theme = { -- getgenv().Theme = false if you want to disable
    OldTheme = false,
    Name="MrBear", --"Raiden","Ayaka","Hutao","Yelan","Miko","Nahida","Ganyu","Keqing","Nilou","Barbara","Zhongli","Layla"
    Custom={
            ["Enable"] = true,
            ['char_size'] = UDim2.new(0.668, 0, 1.158, 0),
            ['char_pos'] = UDim2.new(0.463, 0, -0.105, 0),
            ['title_color'] = Color3.fromRGB(0, 0, 0, 1),
            ['titleback_color'] = Color3.fromRGB(0, 0, 0, 1), -- color black
            ['list_color'] = Color3.fromRGB(0, 0, 0, 1),
            ['liststroke_color'] = Color3.fromRGB(0, 0, 0, 1), -- color black
            ['button_color'] = Color3.fromRGB(0, 0, 0, 1)
       }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b6d24ef1f7dab9c7b22f259a3db6c47e.lua"))()
