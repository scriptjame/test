-- LocalScript: Auto-parry helper + scanner
-- Dán nguyên file này vào StarterPlayerScripts để test/khám phá remotes + bật auto parry

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa gui cũ (nếu có)
local old = playerGui:FindFirstChild("rutoairas_auto_parry")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "rutoairas_auto_parry"
screenGui.ResetOnSpawn = false

-- Main window
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 700, 0, 380)
frame.Position = UDim2.new(0.5, -350, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,36)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.Text = "rutoairas - Auto Parry Helper"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Center

-- Left: controls
local left = Instance.new("Frame", frame)
left.Size = UDim2.new(0, 230, 1, -36)
left.Position = UDim2.new(0, 0, 0, 36)
left.BackgroundTransparency = 1

local function makeButton(parent, text, posY)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -20, 0, 34)
    b.Position = UDim2.new(0, 10, 0, posY)
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 16
    b.BackgroundColor3 = Color3.fromRGB(70,70,70)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    return b
end

local scanRemotesBtn = makeButton(left, "Scan Remotes (ReplicatedStorage)", 8)
local scanAllRemotesBtn = makeButton(left, "Scan Remotes (Whole Game)", 52)
local scanPartsBtn = makeButton(left, "Scan Candidate Parts (Workspace)", 96)
local rescanBtn = makeButton(left, "Rescan All", 140)

local radiusLabel = Instance.new("TextLabel", left)
radiusLabel.Size = UDim2.new(1, -20, 0, 22)
radiusLabel.Position = UDim2.new(0, 10, 0, 184)
radiusLabel.BackgroundTransparency = 1
radiusLabel.Text = "Parry radius (studs):"
radiusLabel.TextColor3 = Color3.fromRGB(255,255,255)
radiusLabel.Font = Enum.Font.GothamSemibold
radiusLabel.TextSize = 14
radiusLabel.TextXAlignment = Enum.TextXAlignment.Left

local radiusBox = Instance.new("TextBox", left)
radiusBox.Size = UDim2.new(1, -20, 0, 28)
radiusBox.Position = UDim2.new(0, 10, 0, 206)
radiusBox.PlaceholderText = "20"
radiusBox.Text = "20"
radiusBox.ClearTextOnFocus = false
radiusBox.Font = Enum.Font.GothamSemibold
radiusBox.TextSize = 16
radiusBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
radiusBox.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", radiusBox).CornerRadius = UDim.new(0,6)

local cooldownLabel = Instance.new("TextLabel", left)
cooldownLabel.Size = UDim2.new(1, -20, 0, 22)
cooldownLabel.Position = UDim2.new(0, 10, 0, 240)
cooldownLabel.BackgroundTransparency = 1
cooldownLabel.Text = "Cooldown per part (s):"
cooldownLabel.TextColor3 = Color3.fromRGB(255,255,255)
cooldownLabel.Font = Enum.Font.GothamSemibold
cooldownLabel.TextSize = 14
cooldownLabel.TextXAlignment = Enum.TextXAlignment.Left

local cooldownBox = Instance.new("TextBox", left)
cooldownBox.Size = UDim2.new(1, -20, 0, 28)
cooldownBox.Position = UDim2.new(0, 10, 0, 262)
cooldownBox.PlaceholderText = "1"
cooldownBox.Text = "1"
cooldownBox.ClearTextOnFocus = false
cooldownBox.Font = Enum.Font.GothamSemibold
cooldownBox.TextSize = 16
cooldownBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
cooldownBox.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", cooldownBox).CornerRadius = UDim.new(0,6)

local deselectBtn = makeButton(left, "Deselect Remote/Parts", 300)

-- Right: remotes list and parts list
local right = Instance.new("Frame", frame)
right.Size = UDim2.new(1, -240, 1, -36)
right.Position = UDim2.new(0, 240, 0, 36)
right.BackgroundTransparency = 1

local remotesLabel = Instance.new("TextLabel", right)
remotesLabel.Size = UDim2.new(0.5, -6, 0, 22)
remotesLabel.Position = UDim2.new(0, 0, 0, 6)
remotesLabel.BackgroundTransparency = 1
remotesLabel.Text = "Found Remotes"
remotesLabel.TextColor3 = Color3.fromRGB(255,255,255)
remotesLabel.Font = Enum.Font.GothamBold
remotesLabel.TextSize = 14
remotesLabel.TextXAlignment = Enum.TextXAlignment.Left

local partsLabel = Instance.new("TextLabel", right)
partsLabel.Size = UDim2.new(0.5, -6, 0, 22)
partsLabel.Position = UDim2.new(0.5, 6, 0, 6)
partsLabel.BackgroundTransparency = 1
partsLabel.Text = "Found Parts (candidates)"
partsLabel.TextColor3 = Color3.fromRGB(255,255,255)
partsLabel.Font = Enum.Font.GothamBold
partsLabel.TextSize = 14
partsLabel.TextXAlignment = Enum.TextXAlignment.Left

local remotesScroll = Instance.new("ScrollingFrame", right)
remotesScroll.Size = UDim2.new(0.5, -6, 1, -40)
remotesScroll.Position = UDim2.new(0, 0, 0, 34)
remotesScroll.CanvasSize = UDim2.new(0,0,0,0)
remotesScroll.ScrollBarThickness = 6
remotesScroll.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", remotesScroll).CornerRadius = UDim.new(0,6)

local partsScroll = Instance.new("ScrollingFrame", right)
partsScroll.Size = UDim2.new(0.5, -6, 1, -40)
partsScroll.Position = UDim2.new(0.5, 6, 0, 34)
partsScroll.CanvasSize = UDim2.new(0,0,0,0)
partsScroll.ScrollBarThickness = 6
partsScroll.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", partsScroll).CornerRadius = UDim.new(0,6)

-- Bottom log area
local logLabel = Instance.new("TextLabel", frame)
logLabel.Size = UDim2.new(1, -20, 0, 28)
logLabel.Position = UDim2.new(0, 10, 1, -38)
logLabel.BackgroundTransparency = 1
logLabel.Text = "Status: ready"
logLabel.TextColor3 = Color3.fromRGB(200,200,200)
logLabel.Font = Enum.Font.Gotham
logLabel.TextSize = 14
logLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Auto Parry button
local toggleParryBtn = Instance.new("TextButton", left)
toggleParryBtn.Size = UDim2.new(1, -20, 0, 34)
toggleParryBtn.Position = UDim2.new(0, 10, 0, 340)
toggleParryBtn.Text = "Auto Parry [OFF]"
toggleParryBtn.Font = Enum.Font.GothamSemibold
toggleParryBtn.TextSize = 16
toggleParryBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
toggleParryBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", toggleParryBtn).CornerRadius = UDim.new(0,6)

-- Data
local remotesList = {}     -- { {inst=Instance, path=string} ... }
local partsList = {}       -- {Instance, ...}
local selectedRemote = nil -- Instance
local selectedPart = nil   -- Instance (optional)
local autoParryEnabled = false

-- Helpers
local function safeGetFullName(obj)
    local ok, res = pcall(function() return obj:GetFullName() end)
    if ok then return res else return tostring(obj) end
end

local function clearFrameChildren(f)
    for _, c in ipairs(f:GetChildren()) do
        c:Destroy()
    end
end

local function addLog(txt)
    logLabel.Text = "Status: " .. tostring(txt)
    print("[AutoParryHelper] "..tostring(txt))
end

-- Scan functions
local function scanRemotesInContainer(container, out)
    for _, v in ipairs(container:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local path = safeGetFullName(v)
            out[path] = v
        end
    end
end

local function scanRemotes(recurseWholeGame)
    remotesList = {}
    local found = {}
    -- ReplicatedStorage first
    if ReplicatedStorage then
        scanRemotesInContainer(ReplicatedStorage, found)
    end
    -- optionally whole game
    if recurseWholeGame then
        scanRemotesInContainer(game, found)
    end
    -- convert to list
    for path, inst in pairs(found) do
        table.insert(remotesList, {inst = inst, path = path})
    end
    table.sort(remotesList, function(a,b) return a.path < b.path end)
    addLog("Found " .. tostring(#remotesList) .. " remote(s)")
end

local candidatePatterns = {"ball","projectile","orb","bullet","attack","throw","dodge","soccer","football","ballpart","ball_","ball-"}

local function isCandidatePartName(name)
    if not name then return false end
    local lname = string.lower(name)
    for _, p in ipairs(candidatePatterns) do
        if lname:find(p) then return true end
    end
    return false
end

local function scanParts()
    partsList = {}
    -- first check common containers
    local tryContainers = {workspace}
    for _, cont in ipairs(tryContainers) do
        for _, obj in ipairs(cont:GetDescendants()) do
            if obj:IsA("BasePart") then
                if isCandidatePartName(obj.Name) then
                    table.insert(partsList, obj)
                end
            end
        end
    end
    -- also try top-level named "Ball" or "Balls"
    local b = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("ball")
    if b and b:IsA("BasePart") then table.insert(partsList, b) end
    local balls = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("balls")
    if balls then
        for _, v in ipairs(balls:GetDescendants()) do
            if v:IsA("BasePart") then table.insert(partsList, v) end
        end
    end
    -- unique
    local seen = {}
    local uniq = {}
    for _, p in ipairs(partsList) do
        if not seen[p] then
            seen[p] = true
            table.insert(uniq, p)
        end
    end
    partsList = uniq
    addLog("Found " .. tostring(#partsList) .. " candidate parts")
end

-- UI render functions
local function renderRemotes()
    clearFrameChildren(remotesScroll)
    local y = 6
    for i, info in ipairs(remotesList) do
        local b = Instance.new("TextButton", remotesScroll)
        b.Size = UDim2.new(1, -12, 0, 28)
        b.Position = UDim2.new(0, 6, 0, y)
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Text = info.path
        b.BackgroundColor3 = (selectedRemote == info.inst) and Color3.fromRGB(90, 150, 90) or Color3.fromRGB(60,60,60)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Font = Enum.Font.Gotham
        b.TextSize = 14
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
        b.MouseButton1Click:Connect(function()
            selectedRemote = info.inst
            addLog("Selected remote: " .. info.path)
            renderRemotes()
        end)
        y = y + 34
    end
    remotesScroll.CanvasSize = UDim2.new(0,0,0,y)
end

local function renderParts()
    clearFrameChildren(partsScroll)
    local y = 6
    for i, p in ipairs(partsList) do
        local label = Instance.new("TextButton", partsScroll)
        label.Size = UDim2.new(1, -12, 0, 28)
        label.Position = UDim2.new(0, 6, 0, y)
        label.TextXAlignment = Enum.TextXAlignment.Left
        local path = safeGetFullName(p)
        label.Text = path .. " [" .. tostring(math.floor((p.Position and p.Position.Magnitude) or 0)) .. "]"
        label.BackgroundColor3 = (selectedPart == p) and Color3.fromRGB(100,120,160) or Color3.fromRGB(60,60,60)
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        Instance.new("UICorner", label).CornerRadius = UDim.new(0,6)
        label.MouseButton1Click:Connect(function()
            selectedPart = p
            addLog("Selected part: " .. safeGetFullName(p))
            renderParts()
        end)
        y = y + 34
    end
    partsScroll.CanvasSize = UDim2.new(0,0,0,y)
end

-- initial scans
scanRemotes(false)
scanParts()
renderRemotes()
renderParts()

-- Buttons behavior
scanRemotesBtn.MouseButton1Click:Connect(function()
    scanRemotes(false)
    renderRemotes()
end)
scanAllRemotesBtn.MouseButton1Click:Connect(function()
    scanRemotes(true)
    renderRemotes()
end)
scanPartsBtn.MouseButton1Click:Connect(function()
    scanParts()
    renderParts()
end)
rescanBtn.MouseButton1Click:Connect(function()
    scanRemotes(false)
    scanParts()
    renderRemotes()
    renderParts()
end)
deselectBtn.MouseButton1Click:Connect(function()
    selectedRemote = nil
    selectedPart = nil
    addLog("Deselected remote and parts")
    renderRemotes()
    renderParts()
end)

-- Auto parry logic
local lastParryAt = {} -- map part -> time
local function attemptParryForPart(part)
    -- debounce
    local now = os.clock()
    local cooldown = tonumber(cooldownBox.Text) or 1
    if lastParryAt[part] and now - lastParryAt[part] < cooldown then
        return
    end
    lastParryAt[part] = now

    -- call selected remote if any
    if selectedRemote and (selectedRemote.Parent ~= nil) then
        pcall(function()
            if selectedRemote:IsA("RemoteEvent") then
                selectedRemote:FireServer()
            elseif selectedRemote:IsA("RemoteFunction") then
                selectedRemote:InvokeServer()
            end
        end)
        addLog("Fired selected remote for part: "..tostring(part.Name))
        return
    end

    -- otherwise auto-try candidate remotes that look like parry/block
    local tried = 0
    local remotesToTry = {}
    -- first look into ReplicatedStorage.Remotes container if exists
    local remCont = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("remotes")
    if remCont then
        for _, v in ipairs(remCont:GetChildren()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                table.insert(remotesToTry, v)
            end
        end
    end
    -- fallback: all remotesList
    for _, info in ipairs(remotesList) do
        table.insert(remotesToTry, info.inst)
    end

    for _, r in ipairs(remotesToTry) do
        if r and (r.Parent ~= nil) and (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) then
            local lower = string.lower(r.Name or "")
            if lower:find("parry") or lower:find("block") or lower:find("deflect") or lower:find("parrybutton") or lower:find("button") then
                pcall(function()
                    if r:IsA("RemoteEvent") then r:FireServer() end
                    if r:IsA("RemoteFunction") then r:InvokeServer() end
                end)
                addLog("Auto-fired candidate remote: "..tostring(r.Name))
                tried = tried + 1
                break
            end
        end
    end

    if tried == 0 then
        addLog("No suitable remote auto-found - choose remote manually from list")
    end
end

-- helper to get current character hrp safely
local function getHRP()
    local ch = player.Character
    if ch then
        return ch:FindFirstChild("HumanoidRootPart") or ch:FindFirstChild("Torso") or ch:FindFirstChild("UpperTorso")
    end
    return nil
end

-- main loop
local checking = false
toggleParryBtn.MouseButton1Click:Connect(function()
    autoParryEnabled = not autoParryEnabled
    toggleParryBtn.Text = "Auto Parry [" .. (autoParryEnabled and "ON" or "OFF") .. "]"
    toggleParryBtn.BackgroundColor3 = autoParryEnabled and Color3.fromRGB(60,140,60) or Color3.fromRGB(180,40,40)
    if autoParryEnabled and not checking then
        checking = true
        addLog("Auto Parry enabled")
        -- spawn background loop
        task.spawn(function()
            while autoParryEnabled do
                task.wait(0.08) -- check ~12.5 times per second
                local hrp = getHRP()
                if not hrp then
                    -- wait until character exists
                    task.wait(0.5)
                else
                    local radius = tonumber(radiusBox.Text) or 20
                    -- choose parts to check
                    local toCheck = {}
                    if selectedPart and selectedPart.Parent then
                        table.insert(toCheck, selectedPart)
                    elseif #partsList > 0 then
                        for _, p in ipairs(partsList) do
                            if p and p.Parent then table.insert(toCheck, p) end
                        end
                    else
                        -- fallback: dynamic search of workspace for candidate names nearby
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and isCandidatePartName(obj.Name) then
                                table.insert(toCheck, obj)
                            end
                        end
                    end

                    for _, part in ipairs(toCheck) do
                        if part and part.Parent and part:IsA("BasePart") then
                            local ok, d = pcall(function()
                                return (part.Position - hrp.Position).Magnitude
                            end)
                            if ok and d and d <= radius then
                                -- optionally check velocity to detect incoming - many games attach velocity
                                local incoming = true
                                -- try to read velocity: if velocity exists and is moving toward player
                                local velOk, vel = pcall(function() return part.Velocity end)
                                if velOk and vel then
                                    -- direction vector from part to player
                                    local dirToPlayer = (hrp.Position - part.Position).Unit
                                    local speedTowards = vel:Dot(dirToPlayer)
                                    -- if speedTowards small negative, maybe it's receding; use threshold
                                    if speedTowards < 1 then
                                        -- not strongly incoming, but still allow
                                        -- keep incoming true
                                    end
                                end
                                if incoming then
                                    attemptParryForPart(part)
                                end
                            end
                        end
                    end
                end
            end
            checking = false
            addLog("Auto Parry disabled")
        end)
    else
        addLog("Auto Parry disabled")
    end
end)

-- initial helpful message
addLog("Ready. Scan remotes & parts, select remote (if known), then enable Auto Parry.")

-- End of script
