getgenv().key = "sZ1MvWfj8uAZOGPCTbIJNSyN4"
getgenv().config = {
    ["Use Race"] = {
        ["V4"] = true,
        ["V3"] = true,
    },
    ["BypassTp"] = false,
    ["Info Screen"] = true,
    ["SafeHealth"] = 4000,
    ["Webhooks"] = {
        ["Toggle Webhook"] = true,
        ["Link Webhook"] = "",
    },
    ["White Screen"] = false,
    ["SkipFruit"] = {
        "Portal-Portal",
    },
    ["Skip Race V4 User"] = false,
    ["Team"] = "Pirates",
    ["MaxBountyHunt"] = 30000000,
    ["MinBountyHunt"] = 0,
    ["MainSkillToggle"] = {
        ["Sword"] = {
            ["Enable"] = true,
            ["Skills"] = {
                ["X"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0.2,
                },
                ["Z"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0.2,
                },
            },
            ["Delay"] = 1,
        },
        ["Blox Fruit"] = {
            ["Enable"] = false,
            ["Skills"] = {
                ["X"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 2,
                },
                ["C"] = {
                    ["Enable"] = false,
                    ["HoldTime"] = 0,
                },
                ["Z"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0,
                },
                ["F"] = {
                    ["Enable"] = false,
                    ["HoldTime"] = 0,
                },
                ["V"] = {
                    ["Enable"] = false,
                    ["HoldTime"] = 0,
                },
            },
            ["Delay"] = 2,
        },
        ["Melee"] = {
            ["Enable"] = true,
            ["Skills"] = {
                ["X"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0,
                },
                ["C"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0,
                },
                ["Z"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 2.5,
                },
            },
            ["Delay"] = 1.75,
        },
        ["Gun"] = {
            ["Enable"] = false,
            ["Skills"] = {
                ["X"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0,
                },
                ["Z"] = {
                    ["Enable"] = true,
                    ["HoldTime"] = 0,
                },
            },
            ["Delay"] = 1,
        },
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/LumosSera/Serra/refs/heads/main/Bounty.lua"))()
