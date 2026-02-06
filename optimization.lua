--================ FPS =================
setfpscap(15)

--================ SERVICES =================
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Settings = settings()
local player = Players.LocalPlayer

--================ RENDER SETTINGS =================
pcall(function()
    Settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
    Settings.Rendering.EagerBulkExecution = false
end)

pcall(function()
    Workspace.ClientAnimatorThrottling = Enum.ClientAnimatorThrottlingMode.Enabled
    Workspace.InterpolationThrottling = Enum.InterpolationThrottlingMode.Enabled
    Workspace.LevelOfDetail = Enum.ModelLevelOfDetail.Disabled
end)

--================ LIGHTING =================
pcall(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
    Lighting.Ambient = Color3.new(0,0,0)
end)

for _,v in ipairs(Lighting:GetChildren()) do
    if v:IsA("Sky")
    or v:IsA("BloomEffect")
    or v:IsA("BlurEffect")
    or v:IsA("ColorCorrectionEffect")
    or v:IsA("SunRaysEffect")
    or v:IsA("DepthOfFieldEffect") then
        v:Destroy()
    end
end

Lighting.ChildAdded:Connect(function(v)
    if v:IsA("BloomEffect")
    or v:IsA("BlurEffect")
    or v:IsA("ColorCorrectionEffect")
    or v:IsA("SunRaysEffect")
    or v:IsA("DepthOfFieldEffect") then
        v:Destroy()
    end
end)

--================ TERRAIN =================
pcall(function()
    if Terrain then
        Terrain.WaterTransparency = 1
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
    end
end)

--================ SAFETY FILTERS =================
local function isCharacter(inst)
    local p = inst
    while p do
        if p:FindFirstChildOfClass("Humanoid") then
            return true
        end
        if p:IsA("Tool") or p:IsA("Accessory") then
            return true
        end
        p = p.Parent
    end
    return false
end

--================ OPTIMIZER =================
local function optimize(v)
    if isCharacter(v) then return end

    if v:IsA("Part") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
        v.Transparency = math.clamp(v.Transparency,0,0.35)

    elseif v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1

    elseif v:IsA("ParticleEmitter") then
        v.Enabled = false
        v.Rate = 0

    elseif v:IsA("Trail") or v:IsA("Beam") then
        v.Enabled = false

    elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false

    elseif v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
        v.Enabled = false

    elseif v:IsA("Sound") then
        v.Volume = 0
    end
end

for _,v in ipairs(Workspace:GetDescendants()) do
    optimize(v)
end

Workspace.DescendantAdded:Connect(optimize)

--================ USERNAME DISPLAY =================
local pg = player:WaitForChild("PlayerGui")

if pg:FindFirstChild("UsernameDisplay") then
    pg.UsernameDisplay:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "UsernameDisplay"
gui.ResetOnSpawn = false
gui.Parent = pg

local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(0.6,0,0.1,0)
label.Position = UDim2.new(0.5,0,0.5,0)
label.AnchorPoint = Vector2.new(0.5,0.5)
label.BackgroundTransparency = 1
label.Text = player.Name
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.new(1,1,1)
label.TextStrokeTransparency = 0.3
label.TextStrokeColor3 = Color3.new(0,0,0)

player.CharacterAdded:Connect(function()
    label.Text = player.Name
end)

--================ MEMORY CLEAN =================
collectgarbage("collect")

-- ================= USERNAME DISPLAY =================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "UsernameDisplay"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Create text label
local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(0.6, 0, 0.1, 0)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.AnchorPoint = Vector2.new(0.5, 0.5)

label.BackgroundTransparency = 1
label.Text = player.Name
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextStrokeTransparency = 0.3
label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Optional: keep it always correct on rejoin / respawn
player.CharacterAdded:Connect(function()
    label.Text = player.Name
end)
