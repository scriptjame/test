-- Nếu đã tồn tại GUI cũ, xóa đi
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("rutoairas")
if old then old:Destroy() end

-- GUI chính
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "rutoairas"

local outer = Instance.new("Frame", screenGui)
outer.Size = UDim2.new(0, 420, 0, 450)
outer.Position = UDim2.new(0.5, -210, 0.5, -225)
outer.BackgroundColor3 = Color3.new(0, 0, 0)
outer.BorderSizePixel = 2
outer.BorderColor3 = Color3.new(1, 0, 0)
Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 15)

local main = Instance.new("Frame", outer)
main.Size = UDim2.new(1, -20, 1, -20)
main.Position = UDim2.new(0, 10, 0, 10)
main.BackgroundColor3 = Color3.new(0, 0, 0)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "rutoairas"
title.TextColor3 = Color3.new(1, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Nút đóng GUI
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 0, 0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BackgroundColor3 = Color3.new(0.16, 0, 0)
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Nút Hide/Show GUI
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 30)
toggleBtn.Position = UDim2.new(0, 5, 0, 5)
toggleBtn.Text = "Hide"
toggleBtn.TextColor3 = Color3.new(1, 0, 0)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.BackgroundColor3 = Color3.new(0.16, 0, 0)

local guiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    outer.Visible = guiVisible
    toggleBtn.Text = guiVisible and "Hide" or "Show"
end)

-- Sidebar menu
local menu = Instance.new("Frame", main)
menu.Size = UDim2.new(0, 100, 1, -30)
menu.Position = UDim2.new(0, 0, 0, 30)
menu.BackgroundColor3 = Color3.new(0.06, 0.06, 0.06)

local function makeMenuBtn(txt, y)
    local btn = Instance.new("TextButton", menu)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.Text = txt
    btn.TextColor3 = Color3.new(1, 0, 0)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.new(0.1, 0, 0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local btnMain = makeMenuBtn("Main", 0)
local btnPlayer = makeMenuBtn("Player", 40)
local btnDupe = makeMenuBtn("Dupe", 80)
local btnChanger = makeMenuBtn("Skin", 120)
local btnRank = makeMenuBtn("Rank", 160)

-- Content frame
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -100, 1, -60)
content.Position = UDim2.new(0, 100, 0, 30)
content.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)

local tabTitle = Instance.new("TextLabel", content)
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.Position = UDim2.new(0, 0, 0, 0)
tabTitle.BackgroundTransparency = 1
tabTitle.TextColor3 = Color3.new(1, 0, 0)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 24
tabTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle UI line
local function createToggle(text, y, fakeNote)
    local frame = Instance.new("Frame", content)
    frame.Size = UDim2.new(1, -20, 0, fakeNote and 60 or 40)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -60, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left

    if fakeNote then
        local note = Instance.new("TextLabel", frame)
        note.Size = UDim2.new(1, -60, 0, 20)
        note.Position = UDim2.new(0, 0, 0, 22)
        note.BackgroundTransparency = 1
        note.Text = "Chỉ là ảo"
        note.TextColor3 = Color3.new(1, 0.2, 0.2)
        note.Font = Enum.Font.GothamItalic
        note.TextSize = 14
        note.TextXAlignment = Enum.TextXAlignment.Left
    end

    local toggle = Instance.new("Frame", frame)
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0, 10)
    toggle.BackgroundColor3 = Color3.new(0.31, 0, 0)
    toggle.ClipsDescendants = true
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    local circ = Instance.new("Frame", toggle)
    circ.Size = UDim2.new(0, 18, 0, 18)
    circ.Position = UDim2.new(0, 1, 0, 1)
    circ.BackgroundColor3 = Color3.new(0, 0, 0)
    Instance.new("UICorner", circ).CornerRadius = UDim.new(1, 0)

    local enabled = false
    local btn = Instance.new("TextButton", toggle)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        toggle.BackgroundColor3 = enabled and Color3.new(1, 0, 0) or Color3.new(0.31, 0, 0)
        circ:TweenPosition(enabled and UDim2.new(0.5, 20, 0, 1) or UDim2.new(0, 1, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
    end)
end

-- Load nội dung tab
local function clearContent()
    for _, c in ipairs(content:GetChildren()) do
        if c ~= tabTitle then c:Destroy() end
    end
end

local function loadMain()
    tabTitle.Text = "Main"
    clearContent()
    local y = 50
    createToggle("Auto Parry", y, false)
    y += 50
    createToggle("AI Play", y, false)
end

local function loadPlayer()
    tabTitle.Text = "Player"
    clearContent()
    local y = 50
    for _, v in ipairs({"ESP PLAYER", "ESP BALL", "SPEED", "JUMP"}) do
        createToggle(v, y, true)
        y += 70
    end
end

local function loadDupe()
    tabTitle.Text = "Dupe"
    clearContent()
    createToggle("Auto Dupe", 50, false)
end

local function loadChanger()
    tabTitle.Text = "Changer Skin"
    clearContent()
    createToggle("Auto Skin Change", 50, false)
end

local function loadRank()
    tabTitle.Text = "Auto Rank"
    clearContent()
    createToggle("Rank Up Bot", 50, false)
end

-- Liên kết nút
btnMain.MouseButton1Click:Connect(loadMain)
btnPlayer.MouseButton1Click:Connect(loadPlayer)
btnDupe.MouseButton1Click:Connect(loadDupe)
btnChanger.MouseButton1Click:Connect(loadChanger)
btnRank.MouseButton1Click:Connect(loadRank)
loadMain()

-- Countdown
local notify = Instance.new("TextLabel", outer)
notify.Size = UDim2.new(1, -20, 0, 30)
notify.Position = UDim2.new(0, 10, 1, -35)
notify.BackgroundTransparency = 0.5
notify.BackgroundColor3 = Color3.new(0, 0, 0)
notify.TextColor3 = Color3.new(1, 0, 0)
notify.Font = Enum.Font.GothamBold
notify.TextSize = 16
Instance.new("UICorner", notify).CornerRadius = UDim.new(0, 6)

local countdown = 170
spawn(function()
    while countdown >= 0 do
        notify.Text = countdown > 0 and ("⏳ Please wait: " .. countdown .. "s") or "✅ Ready!"
        countdown -= 1
        wait(1)
    end
end)

-- Load script từ URL gốc của bạn
spawn(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
    end)
    if not ok then
        notify.Text = "⚠ Failed to load main script!"
        warn("Error loading main script:", err)
    end
end)
