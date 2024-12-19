-- Function to create the FPS control GUI
local function createFPSControlGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Create and configure the GUI
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    Frame.Parent = ScreenGui
    Frame.Position = UDim2.new(0, 10, 0, 10) -- Top-left corner with padding
    Frame.Size = UDim2.new(0, 150, 0, 100)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Frame.BorderSizePixel = 0

    UIListLayout.Parent = Frame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    -- Function to create a button
    local function createButton(text, fpsValue)
        local Button = Instance.new("TextButton")
        Button.Parent = Frame
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Text = text
        Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 14

        -- Set FPS cap on click
        Button.MouseButton1Click:Connect(function()
            setfpscap(fpsValue)
            print("FPS cap set to " .. fpsValue)
        end)
    end

    -- Add buttons
    createButton("5 FPS", 5)
    createButton("15 FPS", 15)
    createButton("30 FPS", 30)
end

-- Create the FPS control GUI
createFPSControlGUI()
