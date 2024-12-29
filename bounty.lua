getgenv().BountyFarm = {
    ["Script"] = {
        ["Black Screen"] = true,
        ["Team"] = "Pirates", -- Pirates/Marines
        ["Panic % Health"] = 40, -- Teleport to Safe Zone if player below x % HP
        ["Skip Timer"] = 60, -- Skip if took more than x seconds to kill
        ["M1 Health"] = 70, -- Attack M1 if target health above x % HP
        ["Ignore User"] = {"Portal-Portal"}, -- Ignore user with the ate Blox Fruit
        ["Ignore Bounty"] = 5000000, -- Ignore user with higher than x bounty than you
    },
    ["Hop Server"] = {
        ["Delay"] = 10, -- Delay before Hop Server
        ["Below Ping"] = 100, -- Hop to Server below x ping
        ["Hop Ping"] = 1000, -- Hop if current server ping is higher than x 
    },
    ["Skill"] = {
        ["Use Type"] = 1,
        ["Prioritize"] = {"Melee", "Sword", "Blox Fruit", "Gun"}, -- Use skill Left to right (first to last)
        -- ["Skill"] = {Enable, Predict, Hold, Delay Next Skill}
        ["Melee"] = {
            ["Z"] = {true, false, 0.6, 0.3},
            ["X"] = {true, true, 0.3, 0.3},
            ["C"] = {true, true, 0.1, 0.3},
        },
        ["Blox Fruit"] = {
            ["Z"] = {false, true, 0, 1},
            ["X"] = {false, true, 0, 1},
            ["C"] = {false, true, 0, 1},
            ["V"] = {false, true, 0, 1},
            ["F"] = {false, true, 0, 1},
        },
        ["Sword"] = {
            ["Z"] = {true, true, 0.3, 1},
            ["X"] = {true, true, 0.4, 1},
        },
        ["Gun"] = {
            ["Z"] = {false, true, 0, 1},
            ["X"] = {false, true, 0, 1},
        },
    },
}

getgenv().Setup = {
    ["Melee"]  = "Electric Claw",
    ["Sword"] = "Cursed Dual Katana",
    ["Gun"] = "",
    ["Accessory"] = "Lei",
    ["Stat"] = {
        ["Melee"] = 2600,
        ["Defense"] = 2600,
        ["Sword"] = 2600,
        ["Gun"] = 0,
        ["Blox Fruit"] = 0,
    }
}

getgenv().Key = "k7f3eae6864b3b08a076187e"
loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()
