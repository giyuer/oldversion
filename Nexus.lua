if Nexus then Nexus:Stop() end

if not game:IsLoaded() then
    task.delay(60, function()
        if NoShutdown then return end

        if not game:IsLoaded() then
            return game:Shutdown()
        end

        local Code = game:GetService'GuiService':GetErrorCode().Value

        if Code >= Enum.ConnectionError.DisconnectErrors.Value then
            return game:Shutdown()
        end
    end)

    game.Loaded:Wait()
end

local Nexus = {}
local WSConnect = syn and syn.websocket.connect or
    (Krnl and (function() repeat task.wait() until Krnl.WebSocket and Krnl.WebSocket.connect return Krnl.WebSocket.connect end)()) or
    WebSocket and WebSocket.connect

if not WSConnect then
    if messagebox then
        messagebox(('Nexus encountered an error while launching!\n\n%s'):format('Your exploit (' .. (identifyexecutor and identifyexecutor() or 'UNKNOWN') .. ') is not supported'), 'Roblox Account Manager', 0)
    end

    return
end

-- Wait and check until WebSocket is available
local WSAvailable = false
local WaitStart = os.clock()

repeat
    WSAvailable = pcall(function() return WSConnect("ws://localhost:5242") end)
    if not WSAvailable then task.wait(0.5) end
until WSAvailable or os.clock() - WaitStart >= 60

if not WSAvailable then
    if messagebox then
        messagebox('WebSocket initialization timed out after 60 seconds. Ensure WebSocket is enabled and supported.', 'Error', 0)
    end
    return
end

local TeleportService = game:GetService'TeleportService'
local InputService = game:GetService'UserInputService'
local HttpService = game:GetService'HttpService'
local RunService = game:GetService'RunService'
local GuiService = game:GetService'GuiService'
local Players = game:GetService'Players'
local LocalPlayer = Players.LocalPlayer if not LocalPlayer then repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer end task.wait(0.5)

local UGS = UserSettings():GetService'UserGameSettings'
local OldVolume = UGS.MasterVolume

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started and Nexus.IsConnected then
        Nexus:Stop() -- Disconnect WebSocket on teleport
    end
end)

local Signal = {} do
    Signal.__index = Signal

    function Signal.new()
        local self = setmetatable({ _BindableEvent = Instance.new'BindableEvent' }, Signal)
        return self
    end

    function Signal:Connect(Callback)
        assert(typeof(Callback) == 'function', 'function expected, got ' .. typeof(Callback))
        return self._BindableEvent.Event:Connect(Callback)
    end

    function Signal:Fire(...)
        self._BindableEvent:Fire(...)
    end

    function Signal:Wait()
        return self._BindableEvent.Event:Wait()
    end

    function Signal:Disconnect()
        if self._BindableEvent then
            self._BindableEvent:Destroy()
        end
    end
end

do -- Nexus
    local BTN_CLICK = 'ButtonClicked:'

    Nexus.Connected = Signal.new()
    Nexus.Disconnected = Signal.new()
    Nexus.MessageReceived = Signal.new()

    Nexus.Commands = {}
    Nexus.Connections = {}

    Nexus.ShutdownTime = 45
    Nexus.ShutdownOnTeleportError = true

    function Nexus:Send(Command, Payload)
        assert(self.Socket ~= nil, 'websocket is nil')
        assert(self.IsConnected, 'websocket not connected')
        assert(typeof(Command) == 'string', 'Command must be a string, got ' .. typeof(Command))

        if Payload then
            assert(typeof(Payload) == 'table', 'Payload must be a table, got ' .. typeof(Payload))
        end

        local Message = HttpService:JSONEncode {
            Name = Command,
            Payload = Payload
        }

        self.Socket:Send(Message)
    end

    function Nexus:SetAutoRelaunch(Enabled)
        self:Send('SetAutoRelaunch', { Content = Enabled and 'true' or 'false' })
    end

    function Nexus:SetPlaceId(PlaceId)
        self:Send('SetPlaceId', { Content = PlaceId })
    end

    function Nexus:SetJobId(JobId)
        self:Send('SetJobId', { Content = JobId })
    end

    function Nexus:Echo(Message)
        self:Send('Echo', { Content = Message })
    end

    function Nexus:Log(...)
        local T = {}
        for _, Value in pairs({ ... }) do
            table.insert(T, tostring(Value))
        end
        self:Send('Log', { Content = table.concat(T, ' ') })
    end

    function Nexus:CreateElement(ElementType, Name, Content, Size, Margins, Table)
        assert(typeof(Name) == 'string', 'string expected on argument #1, got ' .. typeof(Name))
        assert(typeof(Content) == 'string', 'string expected on argument #2, got ' .. typeof(Content))
        assert(Name:find'%W' == nil, 'argument #1 cannot contain whitespace')

        if Size then assert(typeof(Size) == 'table' and #Size == 2, 'table with 2 arguments expected on argument #3, got ' .. typeof(Size)) end
        if Margins then assert(typeof(Margins) == 'table' and #Margins == 4, 'table with 4 arguments expected on argument #4, got ' .. typeof(Margins)) end

        local Payload = {
            Name = Name,
            Content = Content,
            Size = Size and table.concat(Size, ','),
            Margin = Margins and table.concat(Margins, ',')
        }

        if Table then
            for Index, Value in pairs(Table) do
                Payload[Index] = Value
            end
        end

        self:Send(ElementType, Payload)
    end

    function Nexus:CreateButton(...)
        return self:CreateElement('CreateButton', ...)
    end

    function Nexus:CreateLabel(...)
        return self:CreateElement('CreateLabel', ...)
    end

    Nexus.MessageReceived:Connect(function(Message)
        local S = Message:find(' ')
        local Command = S and Message:sub(1, S - 1):lower() or Message:lower()

        if Nexus.Commands[Command] then
            local Success, Error = pcall(Nexus.Commands[Command], Message:sub(S + 1))
            if not Success then Nexus:Log('Error executing command:', Error) end
        end
    end)
end

do -- Default Commands
    Nexus:AddCommand('rejoin', function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)

    Nexus:AddCommand('mute', function()
        OldVolume = UGS.MasterVolume
        UGS.MasterVolume = 0
    end)

    Nexus:AddCommand('unmute', function()
        UGS.MasterVolume = OldVolume
    end)

    Nexus:AddCommand('teleport', function(Message)
        local S = Message:find(' ')
        local PlaceId, JobId = S and Message:sub(1, S - 1) or Message, S and Message:sub(S + 1)
        TeleportService:TeleportToPlaceInstance(tonumber(PlaceId), JobId)
    end)
end

do -- Connections
    GuiService.ErrorMessageChanged:Connect(function()
        if NoShutdown then return end

        local Code = GuiService:GetErrorCode().Value
        if Code >= Enum.ConnectionError.DisconnectErrors.Value then
            if not Nexus.ShutdownOnTeleportError and Code > Enum.ConnectionError.PlacelaunchOtherError.Value then
                return
            end
            task.delay(Nexus.ShutdownTime, game.Shutdown, game)
        end
    end)
end

local GEnv = getgenv()
GEnv.Nexus = Nexus

if not Nexus_Version then
    Nexus:Connect()
end
