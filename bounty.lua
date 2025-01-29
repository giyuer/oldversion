-- Nếu nó là false có nghĩa là đang tắt, còn nếu là true thì đang bật
-- Hãy bật tắt bằng cách điền true / false
-- Mỗi một chiều thức ví dụ Z, X, C, V của từng vũ khí như Súng, Kiếm, Võ, Trái ác quỷ

--[[
Enable = true / false bật tắt chức năng mong muốn
Number = 1 là chiêu sẽ được ưu tiên sử dụng trước, số càng thấp thì càng được ưu tiên
HoldTime = 0.1 là giữ chiêu thức của vũ khí đó trong 0.1s
]]

repeat task.wait(1) until game and game.Players.LocalPlayer and game:IsLoaded()

getgenv().Key = "973b7ad09735267c1b56227b" -- Nhập key của bạn vô đây

_G.Configs = {
    Performance = {
        WhiteScreen = false, -- Chỉnh màn hình trắng
        BlackScreen = {
            Enabled = false, -- chỉnh bảng trạng thái săn
            Font = Enum.Font.FredokaOne, -- Chỉnh kiểu chữ
            Transparency = 0.5, -- Chỉnh độ trong suốt
        },
    },
    allowed_actions = {
        AutoBounty = true,
        Team = "Pirates", -- Chỉnh đội để săn ví dụ: Pirates / Marines
        Continue = 5, -- Nếu người chơi không trong combat trong 5 giây thì bỏ qua
        Dodge = true, -- Né tránh đòn tấn công từ đối phương
        Ken = true, -- Tự động bật ken
        Random = false, -- Tự động dùng bất kì chiêu thức nào có thể gây sát thương
        Weapons = {
            Sword = {
                Enable = true,
                Skills = {
                    X = {
                        Enable = true,
                        Number = 3,
                        HoldTime = 0.1,
                    },
                    Z = {
                        Enable = true,
                        Number = 2,
                        HoldTime = 0.2,
                    },
                },
            },
            ['Blox Fruit'] = {
                Enable = false,
                Skills = {
                    X = {
                        Enable = true,
                        Number = 1,
                        HoldTime = 0.1,
                    },
                    C = {
                        Enable = false,
                        Number = 4.5,
                        HoldTime = 0.2,
                    },
                    Z = {
                        Enable = false,
                        Number = 4,
                        HoldTime = 0.1,
                    },
                    F = {
                        Enable = false,
                        Number = 8,
                        HoldTime = 0.1,
                    },
                    V = {
                        Enable = false,
                        Number = 7,
                        HoldTime = 0.1,
                    },
                },
            },
            Melee = {
                Enable = true,
                Skills = {
                    X = {
                        Enable = true,
                        Number = 5.5,
                        HoldTime = 0.1,
                    },
                    C = {
                        Enable = true,
                        Number = 5,
                        HoldTime = 0.3,
                    },
                    Z = {
                        Enable = true,
                        Number = 4,
                        HoldTime = 0.1,
                    },
                },
            },
            Gun = {
                Enable = false,
                Skills = {
                    X = {
                        Enable = true,
                        Number = 1,
                        HoldTime = 0.16,
                    },
                    Z = {
                        Enable = true,
                        Number = 5,
                        HoldTime = 0.15,
                    },
                },
            },
        },
        AutoView = false, -- Tự động quan sát người bị săn
        SafeZone = {
            Enabled = true,
            Max = 40000, -- Độ cao sẽ bỏ chạy và đến, khi bị đánh như 1 con chó
            ProtectCD = true,
            HighestHealth = 50, -- Khi lượng máu được hồi phục tầm 50% sẽ quay lại chiến tiếp
            LowestHealth = 40, -- Máu thấp nhất sẽ bắt đầu chạy như 1 con chó
        },
        Webhook = {
            Enabled = true,
            Logs = {
                Console = false, -- Hiển thị file lỗi khi đang săn, hỗ trợ dev fix bugs
                PlayerStatus = true, -- Hiển thị thông tin khi săn
            },
            URL = "https://discord.com/api/webhooks/1334070883626778667/hVIJKVzRJotz4-lAULCS1oP6To-oQww_YpTkF7QX-EqjAh2XQIqMYfqmBKgdrnVjslUU",
        },
        RandomATK = 35,
        Limited = 45, -- Giới hạn thời gian săn 1 người là 45 giây
        MethodClicks = {
            Melee = true, -- Vũ khí sẽ được chọn để click
            CanM1At = 9000, -- Có thể bắt đầu click khi người bị săn còn 9000 máu
            Count = 6, -- Chiêu thức được tung ra đủ 6 lần sẽ bắt đầu click
            Gun = false, -- Vũ khí sẽ được chọn để click
            Delay = 0.15, -- Độ trễ khi click
            Sword = false, -- Vũ khí sẽ được chọn để click
        },
        IgnoreFruits = {
        }, -- Bỏ qua những thằng ăn trái ác quỷ
        Race = {
            V4 = {
                Enabled = true, -- Tự động dùng V4
                UseAt = 14000, -- Dùng khi 14000 máu
            },
            V3 = {
                Enabled = true, -- Tự động dùng V3
                Settings = {
                    Shark = {
                        Stun = 2, -- Tự động tộc cá nếu bị choáng quá 2 giây
                    },
                    Human = 8500, -- Tự động dùng tộc human khi máu còn 8500
                },
            },
        },
    },
}

_G.FX_Options = {
        Enabled = false, -- Bật tắt chỉnh sửa đồ hoạ
        Textures = true, -- Xoá kết cấu, hiệu ứng
        VisualEffects = true, -- Xoá hiệu ứng
        Invisible = false, -- Ẩn các khối
        Parts = false, -- Bật / tắt ẩn các khối phải kết hợp với "Invisible
        Particles = true,  -- Xoá hiệu ứng
        Sky = false, --> Xoá trời
        FullBright = true -- Chỉnh sáng
};

-- Kịch bản sẽ được thực hiện:
loadstring(game:HttpGet('https://raw.githubusercontent.com/RedGamer12/TNNP-SYSTEM/refs/heads/main/client/BloxFruit/BountyLoader-obfuscated.lua'))(); 
