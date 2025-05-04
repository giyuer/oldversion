if Nexus then Nexus:Stop() end

if not game:IsLoaded() then
    task.delay(60, function()
        if NoShutdown then return end
        if not game:IsLoaded() then return end
        local Code = game:GetService("GuiService"):GetErrorCode().Value
        if Code >= Enum.ConnectionError.DisconnectErrors.Value then return end
    end)
    game.Loaded:Wait()
end

-- Optimized string operations
local lower = string.lower
local find = string.find
local sub = string.sub
local format = string.format

local Nexus = {}
local WSConnect = syn and syn.websocket.connect or
    (Krnl and (function() repeat task.wait() until Krnl.WebSocket and Krnl.WebSocket.connect return Krnl.WebSocket.connect end)()) or
    WebSocket and WebSocket.connect

if not WSConnect then
    if messagebox then
        messagebox(format('Nexus encountered an error while launching!\n\nYour exploit (%s) is not supported',
            identifyexecutor and identifyexecutor() or 'UNKNOWN'), 'Roblox Account Manager', 0)
    end
    return
end

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
task.wait(0.5)

local UGS = UserSettings():GetService("UserGameSettings")
local OldVolume = UGS.MasterVolume

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started and Nexus.IsConnected then
        Nexus:Stop()
    end
end)

local Signal = {} do
    Signal.__index = Signal
    function Signal.new()
        return setmetatable({ _BindableEvent = Instance.new("BindableEvent") }, Signal)
    end
    function Signal:Connect(Callback)
        return self._BindableEvent.Event:Connect(Callback)
    end
    function Signal:Fire(...) self._BindableEvent:Fire(...) end
    function Signal:Wait() return self._BindableEvent.Event:Wait() end
    function Signal:Disconnect()
        if self._BindableEvent then self._BindableEvent:Destroy() end
    end
end

do -- Nexus definition
    Nexus.Connected = Signal.new()
    Nexus.Disconnected = Signal.new()
    Nexus.MessageReceived = Signal.new()

    Nexus.Commands = {}
    Nexus.Connections = {}

    function Nexus:Send(Command, Payload)
        assert(self.Socket and self.IsConnected, "WebSocket not connected")
        self.Socket:Send(HttpService:JSONEncode({ Name = Command, Payload = Payload }))
    end

    function Nexus:Log(...) 
        local count = select("#", ...)
        local T = table.create(count)
        for i = 1, count do
            T[i] = tostring(select(i, ...))
        end
        self:Send("Log", { Content = table.concat(T, " ") })
    end

    function Nexus:Connect(Host, Bypass)
        if not Bypass and self.IsConnected then return end
        
        local retryDelay = 5
        local maxRetryDelay = 60
        
        while not self.Terminated do
            -- Cleanup existing connections
            for _, conn in ipairs(self.Connections) do conn:Disconnect() end
            table.clear(self.Connections)

            if self.IsConnected then
                self.IsConnected = false
                self.Socket = nil
                self.Disconnected:Fire()
            end

            -- Attempt connection
            Host = Host or "localhost:5242"
            local success, socket = pcall(WSConnect, format("ws://%s/Nexus?name=%s&id=%s&jobId=%s",
                Host, LocalPlayer.Name, LocalPlayer.UserId, game.JobId))
            
            if not success then 
                task.wait(retryDelay)
                retryDelay = math.min(retryDelay * 2, maxRetryDelay)
                continue 
            end
            
            -- Connection successful
            retryDelay = 5 -- Reset delay
            self.Socket = socket
            self.IsConnected = true

            -- Set up message handler
            table.insert(self.Connections, socket.OnMessage:Connect(function(msg)
                self.MessageReceived:Fire(msg)
            end))

            -- Set up close handler
            table.insert(self.Connections, socket.OnClose:Connect(function()
                self.IsConnected = false
                self.Disconnected:Fire()
            end))

            self.Connected:Fire()

            -- Ping loop
            while self.IsConnected and not self.Terminated do
                local ok = pcall(self.Send, self, "ping")
                if not ok then break end
                task.wait(30) -- Keep this long interval
            end
        end
    end

    function Nexus:Stop()
        self.IsConnected = false
        self.Terminated = true
        self.Disconnected:Fire()
        if self.Socket then pcall(function() self.Socket:Close() end) end
    end

    function Nexus:Cleanup()
        self:Stop()
        if self.Connected then self.Connected:Disconnect() end
        if self.Disconnected then self.Disconnected:Disconnect() end
        if self.MessageReceived then self.MessageReceived:Disconnect() end
        table.clear(self.Commands)
        table.clear(self.Connections)
    end
end

-- Message queue system
local messageQueue = {}
local processing = false
local processRate = 0.05 -- seconds between processing messages

Nexus.MessageReceived:Connect(function(msg)
    table.insert(messageQueue, msg)
    if not processing then
        processing = true
        while #messageQueue > 0 do
            local msg = table.remove(messageQueue, 1)
            local s = find(msg, " ", 1, true) -- plain search
            local command, content = s and sub(msg, 1, s - 1), s and sub(msg, s + 1)
            command = command and lower(command)
            local callback = Nexus.Commands[command or msg]
            if callback then
                local ok, err = pcall(callback, content or msg)
                if not ok then 
                    Nexus:Log(format("Error with command `%s`: %s", command or msg, err))
                end
            end
            task.wait(processRate)
        end
        processing = false
    end
end)

do -- Default Commands
    Nexus:AddCommand("execute", function(code)
        local func, err = loadstring(code)
        if func then
            local env = getfenv(func)
            env.Player = LocalPlayer
            env.print = function(...) Nexus:Log(...) end
            if newcclosure then env.print = newcclosure(env.print) end
            local ok, result = pcall(func)
            if not ok then Nexus:Log(result) end
        else
            Nexus:Log(err)
        end
    end)

    Nexus:AddCommand("teleport", function(msg)
        local s = find(msg, " ", 1, true)
        local pid, jid = s and sub(msg, 1, s - 1) or msg, s and sub(msg, s + 1)
        if jid then
            TeleportService:TeleportToPlaceInstance(tonumber(pid), jid)
        else
            TeleportService:Teleport(tonumber(pid))
        end
    end)

    Nexus:AddCommand("rejoin", function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)

    Nexus:AddCommand("mute", function()
        if (UGS.MasterVolume - OldVolume) > 0.01 then
            OldVolume = UGS.MasterVolume
        end
        UGS.MasterVolume = 0
    end)

    Nexus:AddCommand("unmute", function()
        UGS.MasterVolume = OldVolume
    end)
end

local GEnv = getgenv()
GEnv.Nexus = Nexus

-- Safe connection handler
local function safeConnect()
    local ok, err = pcall(function()
        if not Nexus_Version then
            Nexus:Connect()
        end
    end)
    if not ok then
        warn("Nexus connection failed: " .. tostring(err))
        task.wait(30)
        safeConnect() -- Attempt to reconnect
    end
end

safeConnect()

-- Cleanup on player leaving
Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        Nexus:Cleanup()
    end
end)
