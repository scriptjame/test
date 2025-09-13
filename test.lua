-- Full refreshed GUI script for Blade Ball (copy & paste)
-- Author: ChatGPT (customized for your requests)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old gui if present
local existing = playerGui:FindFirstChild("rutoairas")
if existing then
    existing:Destroy()
end

-- Helper to create instance and set parent at end
local function new(class, props, parent)
    local obj = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            obj[k] = v
        end
    end
    if parent then
        obj.Parent = parent
    end
    return obj
end

-- Root ScreenGui
local screenGui = new("ScreenGui", {Name = "rutoairas", ResetOnSpawn = false}, playerGui)

-- Outer frame (main window)
local outer = new("Frame", {
    Size = UDim2.new(0, 460, 0, 480),
    Position = UDim2.new(0.5, -230, 0.5, -240),
    BackgroundColor3 = Color3.fromRGB(18,18,18),
    BorderSizePixel = 0,
    ZIndex = 2
}, screenGui)
new("UICorner", {CornerRadius = UDim.new(0, 14)}, outer)
local outerStroke = new("UIStroke", {
    Color = Color3.fromRGB(200, 30, 30),
    Thickness = 1,
    Transparency = 0.2
}, outer)
local outerGrad = new("UIGradient", {
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22,22,22)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(32,8,12))
    },
    Rotation = 90
}, outer)

-- Inner content frame
local main = new("Frame", {
    Size = UDim2.new(1, -24, 1, -28),
    Position = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 0,
    BackgroundColor3 = Color3.fromRGB(10,10,10),
    BorderSizePixel = 0
}, outer)
new("UICorner", {CornerRadius = UDim.new(0, 12)}, main)

-- Title bar
local titleBar = new("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1
}, main)
local title = new("TextLabel", {
    Size = UDim2.new(1, -80, 1, 0),
    Position = UDim2.new(0, 12, 0, 0),
    BackgroundTransparency = 1,
    Text = "rutoairas",
    TextColor3 = Color3.fromRGB(220,40,40),
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextXAlignment = Enum.TextXAlignment.Left
}, titleBar)
-- title outline/glow
new("UIStroke", {Color = Color3.fromRGB(150,20,20), Thickness = 1, Transparency = 0.6}, title)

-- Close button (X)
local closeBtn = new("TextButton", {
    Size = UDim2.new(0, 36, 0, 28),
    Position = UDim2.new(1, -44, 0, 6),
    BackgroundColor3 = Color3.fromRGB(30, 0, 0),
    Text = "X",
    TextColor3 = Color3.fromRGB(255,80,80),
    Font = Enum.Font.GothamBold,
    TextSize = 18
}, titleBar)
new("UICorner", {CornerRadius = UDim.new(0,6)}, closeBtn)
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Hide (small) button changed to R with hover & pulse
local hideBtn = new("TextButton", {
    Name = "HideBtn",
    Size = UDim2.new(0, 40, 0, 40),
    Position = UDim2.new(0, 8, 0, 8),
    BackgroundColor3 = Color3.fromRGB(24,8,8),
    Text = "R",
    TextColor3 = Color3.fromRGB(255, 60, 60),
    Font = Enum.Font.GothamBlack,
    TextSize = 20,
    ZIndex = 3
}, screenGui)
new("UICorner", {CornerRadius = UDim.new(1,8)}, hideBtn)
local hideStroke = new("UIStroke", {Color = Color3.fromRGB(150,20,20), Thickness = 1, Transparency = 0.35}, hideBtn)

-- Hover effect (tween)
local hoverInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
hideBtn.MouseEnter:Connect(function()
    TweenService:Create(hideBtn, hoverInfo, {BackgroundColor3 = Color3.fromRGB(40,10,10)}):Play()
    TweenService:Create(hideBtn, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {Rotation = 2}):Play()
end)
hideBtn.MouseLeave:Connect(function()
    TweenService:Create(hideBtn, hoverInfo, {BackgroundColor3 = Color3.fromRGB(24,8,8), Rotation = 0}):Play()
end)

local guiVisible = true
hideBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    outer.Visible = guiVisible
    -- small visual feedback
    TweenService:Create(hideBtn, TweenInfo.new(0.12), {BackgroundColor3 = guiVisible and Color3.fromRGB(24,8,8) or Color3.fromRGB(50,12,12)}):Play()
end)

-- Sidebar menu (left)
local menu = new("Frame", {
    Size = UDim2.new(0, 112, 1, -54),
    Position = UDim2.new(0, 0, 0, 44),
    BackgroundColor3 = Color3.fromRGB(12,12,12),
    BorderSizePixel = 0
}, main)
new("UICorner", {CornerRadius = UDim.new(0,8)}, menu)
local menuGrad = new("UIGradient", {
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,18)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12,8,8))
    }
}, menu)

local function makeMenuBtn(txt, y)
    local btn = new("TextButton", {
        Size = UDim2.new(1, -12, 0, 44),
        Position = UDim2.new(0, 6, 0, y),
        BackgroundColor3 = Color3.fromRGB(20,6,6),
        Text = txt,
        TextColor3 = Color3.fromRGB(220,40,40),
        Font = Enum.Font.GothamSemibold,
        TextSize = 18
    }, menu)
    new("UICorner", {CornerRadius = UDim.new(0,8)}, btn)
    local stroke = new("UIStroke", {Color = Color3.fromRGB(120,20,20), Thickness = 1, Transparency = 0.7}, btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(36,6,6)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(20,6,6)}):Play()
    end)
    return btn
end

local btnMain = makeMenuBtn("Main", 12)
local btnPlayer = makeMenuBtn("Player", 70)
local btnDupe = makeMenuBtn("Dupe", 128)
local btnSkin = makeMenuBtn("Skin", 186)
local btnRank = makeMenuBtn("Rank", 244)

-- Content area (right)
local content = new("Frame", {
    Size = UDim2.new(1, -120, 1, -70),
    Position = UDim2.new(0, 120, 0, 44),
    BackgroundColor3 = Color3.fromRGB(8,8,8),
    BorderSizePixel = 0
}, main)
new("UICorner", {CornerRadius = UDim.new(0,10)}, content)

local tabTitle = new("TextLabel", {
    Size = UDim2.new(1, -24, 0, 36),
    Position = UDim2.new(0, 12, 0, 6),
    BackgroundTransparency = 1,
    Text = "Main",
    TextColor3 = Color3.fromRGB(230,50,50),
    Font = Enum.Font.GothamBold,
    TextSize = 24,
    TextXAlignment = Enum.TextXAlignment.Left
}, content)

-- Loading overlay (centered)
local loadingFrame = new("Frame", {
    Size = UDim2.new(0, 380, 0, 130),
    Position = UDim2.new(0.5, -190, 0.5, -60),
    BackgroundColor3 = Color3.fromRGB(22,22,22),
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 5
}, screenGui)
new("UICorner", {CornerRadius = UDim.new(0,12)}, loadingFrame)
new("UIStroke", {Color = Color3.fromRGB(80,20,20), Thickness = 1, Transparency = 0.6}, loadingFrame)
new("UIGradient", {
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,18)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28,6,6))
    }
}, loadingFrame)

-- Top reason title (fixed first line)
local reasonTitle = new("TextLabel", {
    Size = UDim2.new(1, -24, 0, 28),
    Position = UDim2.new(0, 12, 0, 8),
    BackgroundTransparency = 1,
    Text = "Why you need to wait",
    TextColor3 = Color3.fromRGB(235,235,235),
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Center
}, loadingFrame)

-- Status message (below reasonTitle) - will fade between messages
local reasonText = new("TextLabel", {
    Size = UDim2.new(1, -40, 0, 28),
    Position = UDim2.new(0, 20, 0, 36),
    BackgroundTransparency = 1,
    Text = "Fetching Blade Ball configs...",
    TextColor3 = Color3.fromRGB(220,220,220),
    Font = Enum.Font.Gotham,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextTransparency = 0
}, loadingFrame)
-- small subtle stroke to pop text
new("UIStroke", {Color = Color3.fromRGB(30,30,30), Thickness = 1, Transparency = 0.7}, reasonText)

-- Loading percent text
local loadingText = new("TextLabel", {
    Size = UDim2.new(1, -24, 0, 28),
    Position = UDim2.new(0, 12, 0, 70),
    BackgroundTransparency = 1,
    Text = "Loading 0%",
    TextColor3 = Color3.fromRGB(240,240,240),
    Font = Enum.Font.GothamSemibold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Center
}, loadingFrame)

-- Progress bar background + bar
local progressBack = new("Frame", {
    Size = UDim2.new(0.88, 0, 0, 18),
    Position = UDim2.new(0.06, 0, 0, 100),
    BackgroundColor3 = Color3.fromRGB(50,50,50),
    BorderSizePixel = 0
}, loadingFrame)
new("UICorner", {CornerRadius = UDim.new(1,8)}, progressBack)
local progressBar = new("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = Color3.fromRGB(255,170,20)
}, progressBack)
new("UICorner", {CornerRadius = UDim.new(1,8)}, progressBar)
-- subtle glow using UIStroke (not too strong)
new("UIStroke", {Color = Color3.fromRGB(255,200,60), Thickness = 1, Transparency = 0.6}, progressBar)

-- Messages tailored for Blade Ball (first displayed after the fixed "Why..." title)
local messages = {
    "Fetching Blade Ball configs...",
    "Calibrating parry system...",
    "Optimizing reaction speed...",
    "Loading skill modules...",
    "Almost ready to play!"
}

-- Cycle & fade messages (respect "Why you need to wait" stay on top; reasonText cycles)
local function cycleMessages(stopCondition)
    -- We show the first message after the fixed title for a short delay, then cycle
    spawn(function()
        local idx = 1
        task.wait(2.6) -- allow first fixed title to be read
        while loadingFrame.Visible and not (stopCondition and stopCondition()) do
            local msg = messages[idx]
            -- fade out
            TweenService:Create(reasonText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
            task.wait(0.65)
            reasonText.Text = msg
            -- fade in
            TweenService:Create(reasonText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            -- display time (not too quick, not too slow)
            task.wait(3.2)
            idx = idx + 1
            if idx > #messages then idx = 1 end
        end
        -- ensure visible when finished
        TweenService:Create(reasonText, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
    end)
end

-- startLoading with smooth tweens and message cycling
local function startLoading(totalDuration, callback)
    totalDuration = totalDuration or 170
    loadingFrame.Visible = true
    -- initialize
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    loadingText.Text = "Loading 0%"
    reasonText.Text = messages[1]
    reasonText.TextTransparency = 0
    -- start message cycle
    cycleMessages(function() return not loadingFrame.Visible end)

    -- We'll tween progress in increments so it's smooth and update percent label in RunService
    local startTime = tick()
    local endTime = startTime + totalDuration

    -- We'll run a loop that tweens progressBar to the next target percent every 1 second (smooth)
    local lastPercent = 0
    local updateConn
    updateConn = RunService.Heartbeat:Connect(function(dt)
        local now = tick()
        local alpha = math.clamp((now - startTime) / totalDuration, 0, 1)
        local percent = math.floor(alpha * 100 + 0.5)
        if percent ~= lastPercent then
            loadingText.Text = "Loading " .. tostring(percent) .. "%"
            lastPercent = percent
        end
        -- Tween bar width to current alpha smoothly
        local target = UDim2.new(alpha, 0, 1, 0)
        -- Instead of creating a new tween every frame, let's set size directly but smooth using Lerp
        progressBar.Size = progressBar.Size:Lerp(target, math.clamp(8 * dt, 0, 1))
        if alpha >= 1 then
            updateConn:Disconnect()
            -- small finish animation
            TweenService:Create(progressBar, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(1,0,1,0)}):Play()
            task.delay(0.25, function()
                -- hide frame and callback
                loadingFrame.Visible = false
                if callback then
                    pcall(callback)
                end
            end)
        end
    end)
end

----------------------------------------------------------------
-- UI builder functions for toggles & inputs (kept from previous logic but improved visuals)
----------------------------------------------------------------
local function createToggle(text, y)
    local frame = new("Frame", {
        Size = UDim2.new(1, -32, 0, 44),
        Position = UDim2.new(0, 12, 0, y),
        BackgroundTransparency = 1
    }, content)

    local label = new("TextLabel", {
        Size = UDim2.new(1, -110, 1, 0),
        Position = UDim2.new(0, 6, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(220,60,60),
        Font = Enum.Font.GothamSemibold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    }, frame)

    local toggleBg = new("Frame", {
        Size = UDim2.new(0, 54, 0, 28),
        Position = UDim2.new(1, -72, 0.5, -14),
        BackgroundColor3 = Color3.fromRGB(36,6,6),
        ClipsDescendants = true
    }, frame)
    new("UICorner", {CornerRadius = UDim.new(1, 8)}, toggleBg)
    local circ = new("Frame", {
        Size = UDim2.new(0, 22, 0, 22),
        Position = UDim2.new(0, 4, 0, 3),
        BackgroundColor3 = Color3.fromRGB(10,10,10)
    }, toggleBg)
    new("UICorner", {CornerRadius = UDim.new(1, 10)}, circ)

    local enabled = false
    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = ""
    }, toggleBg)
    btn.MouseButton1Click:Connect(function()
        if not enabled then
            -- simulate small loading with our loading GUI
            startLoading(6, function()
                enabled = true
                TweenService:Create(toggleBg, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(200,30,30)}):Play()
                TweenService:Create(circ, TweenInfo.new(0.18), {Position = UDim2.new(1, -26, 0, 3)}):Play()
            end)
        else
            enabled = false
            TweenService:Create(toggleBg, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(36,6,6)}):Play()
            TweenService:Create(circ, TweenInfo.new(0.18), {Position = UDim2.new(0, 4, 0, 3)}):Play()
        end
    end)
end

local function createInput(text, y)
    local frame = new("Frame", {
        Size = UDim2.new(1, -32, 0, 44),
        Position = UDim2.new(0, 12, 0, y),
        BackgroundTransparency = 1
    }, content)

    local label = new("TextLabel", {
        Size = UDim2.new(0, 140, 1, 0),
        Position = UDim2.new(0, 6, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(220,60,60),
        Font = Enum.Font.GothamSemibold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    }, frame)

    local box = new("TextBox", {
        Size = UDim2.new(0, 160, 0, 30),
        Position = UDim2.new(0, 150, 0, 7),
        BackgroundColor3 = Color3.fromRGB(28,28,28),
        TextColor3 = Color3.fromRGB(240,240,240),
        Font = Enum.Font.Gotham,
        TextSize = 16,
        PlaceholderText = "Enter value"
    }, frame)
    new("UICorner", {CornerRadius = UDim.new(0,8)}, box)
    return box
end

local function clearContent()
    for _, c in ipairs(content:GetChildren()) do
        if c ~= tabTitle then
            c:Destroy()
        end
    end
end

-- Tabs content loaders
local function loadMain()
    tabTitle.Text = "Main"
    clearContent()
    local y = 52
    createToggle("Auto Parry", y); y = y + 54
    createToggle("AI Play", y); y = y + 54
    createInput("SPEED", y); y = y + 54
    createInput("JUMP", y); y = y + 54
end

local function loadPlayer()
    tabTitle.Text = "Player"
    clearContent()
    local y = 52
    createToggle("ESP PLAYER", y); y = y + 54
    createToggle("ESP BALL", y); y = y + 54
end

local function loadDupe()
    tabTitle.Text = "Dupe"
    clearContent()
    local y = 52
    createToggle("Auto Dupe", y); y = y + 54
    createInput("Dupe Token", y); y = y + 54
    createInput("Dupe Sword", y); y = y + 54
end

local function loadSkin()
    tabTitle.Text = "Skin Changer"
    clearContent()
    local y = 52
    createToggle("Auto Skin Change", y); y = y + 54
    createInput("Change Skin", y); y = y + 54
end

local function loadRank()
    tabTitle.Text = "Auto Rank"
    clearContent()
    local y = 52
    createToggle("Rank Up Bot", y); y = y + 54
end

-- Bind menu buttons
btnMain.MouseButton1Click:Connect(loadMain)
btnPlayer.MouseButton1Click:Connect(loadPlayer)
btnDupe.MouseButton1Click:Connect(loadDupe)
btnSkin.MouseButton1Click:Connect(loadSkin)
btnRank.MouseButton1Click:Connect(loadRank)

-- Default
loadMain()

-- Example: hook starting loading when the GUI is created (optional)
-- You can remove this if you only want loading triggered by specific actions
task.delay(0.25, function()
    startLoading(170, function()
        -- finished loading, nothing extra
    end)
end)

-- Load the main script as before (kept from your original)
spawn(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
    end)
    if not ok then
        warn("⚠ Failed to load main script:", err)
    end
end)
