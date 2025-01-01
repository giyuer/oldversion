
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