-- Nếu GUI cũ tồn tại thì xóa
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("rutoairas")
if old then old:Destroy() end

-- Tạo ScreenGui mới
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "rutoairas"
screenGui.ResetOnSpawn = false

-- GUI Loading chung
local loadingFrame = Instance.new("Frame", screenGui)
loadingFrame.Size = UDim2.new(0, 250, 0, 120)
loadingFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
loadingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
loadingFrame.BorderSizePixel = 2
loadingFrame.BorderColor3 = Color3.new(1, 0, 0)
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)
loadingFrame.Visible = false

local loadingTitle = Instance.new("TextLabel", loadingFrame)
loadingTitle.Size = UDim2.new(1, 0, 0, 30)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Loading..."
loadingTitle.TextColor3 = Color3.new(1, 0, 0)
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.TextSize = 20

local progressLabel = Instance.new("TextLabel", loadingFrame)
progressLabel.Size = UDim2.new(1, 0, 0, 50)
progressLabel.Position = UDim2.new(0, 0, 0, 40)
progressLabel.BackgroundTransparency = 1
progressLabel.Text = "0%"
progressLabel.TextColor3 = Color3.new(1, 0, 0)
progressLabel.Font = Enum.Font.GothamBold
progressLabel.TextSize = 28

-- Hàm chạy loading
local function showLoading(callback)
    loadingFrame.Visible = true
    progressLabel.Text = "0%"
    for i = 1, 100 do
        progressLabel.Text = i.."%"
        task.wait(0.02) -- tốc độ loading (2s sẽ xong)
    end
    loadingFrame.Visible = false
    if callback then callback() end
end

-- Khung outer chứa UI
local outer = Instance.new("Frame", screenGui)
outer.Size = UDim2.new(0, 420, 0, 450)
outer.Position = UDim2.new(0.5, -210, 0.5, -225)
outer.BackgroundColor3 = Color3.new(0, 0, 0)
outer.BorderSizePixel = 2
outer.BorderColor3 = Color3.new(1, 0, 0)
Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 15)

-- Frame nội dung bên trong
local main = Instance.new("Frame", outer)
main.Size = UDim2.new(1, -20, 1, -20)
main.Position = UDim2.new(0, 10, 0, 10)
main.BackgroundColor3 = Color3.new(0, 0, 0)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Tiêu đề GUI
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
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

-- Frame chứa nội dung tab
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -100, 1, -60)
content.Position = UDim2.new(0, 100, 0, 30)
content.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)

local tabTitle = Instance.new("TextLabel", content)
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.BackgroundTransparency = 1
tabTitle.TextColor3 = Color3.new(1, 0, 0)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 24
tabTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Hàm tạo toggle có loading
local function createToggle(text, y)
    local frame = Instance.new("Frame", content)
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -60, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("Frame", frame)
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0, 10)
    toggle.BackgroundColor3 = Color3.new(0.31, 0, 0)
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
    btn.Text = ""

    btn.MouseButton1Click:Connect(function()
        if enabled then
            -- Tắt ngay lập tức
            enabled = false
            toggle.BackgroundColor3 = Color3.new(0.31, 0, 0)
            circ:TweenPosition(UDim2.new(0, 1, 0, 1))
        else
            -- Chạy loading
            enabled = false
            toggle.BackgroundColor3 = Color3.new(0.31, 0, 0)
            circ:TweenPosition(UDim2.new(0, 1, 0, 1))
            showLoading(function()
                enabled = true
                toggle.BackgroundColor3 = Color3.new(1, 0, 0)
                circ:TweenPosition(UDim2.new(0.5, 20, 0, 1))
            end)
        end
    end)
end

-- Hàm tạo input box
local function createInput(text, y)
    local frame = Instance.new("Frame", content)
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0, 120, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0, 120, 0, 30)
    box.Position = UDim2.new(0, 150, 0, 5)
    box.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 16
    box.PlaceholderText = "Enter value"
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

    return box
end

-- Hàm xóa nội dung
local function clearContent()
    for _, c in ipairs(content:GetChildren()) do
        if c ~= tabTitle then
            c:Destroy()
        end
    end
end

-- Tab Main
local function loadMain()
    tabTitle.Text = "Main"
    clearContent()
    local y = 50
    createToggle("Auto Parry", y)
    y = y + 50
    createToggle("AI Play", y)
    y = y + 50
    createInput("SPEED", y)
    y = y + 50
    createInput("JUMP", y)
end

-- Tab Player
local function loadPlayer()
    tabTitle.Text = "Player"
    clearContent()
    local y = 50
    createToggle("ESP PLAYER", y)
    y = y + 50
    createToggle("ESP BALL", y)
end

-- Tab Dupe
local function loadDupe()
    tabTitle.Text = "Dupe"
    clearContent()
    local y = 50
    createToggle("Auto Dupe", y)
    y = y + 50
    createInput("Dupe Token", y)
    y = y + 50
    createInput("Dupe Sword", y)
end

-- Tab Changer Skin
local function loadChanger()
    tabTitle.Text = "Changer Skin"
    clearContent()
    local y = 50
    createToggle("Auto Skin Change", y)
    y = y + 50
    createInput("Change Skin", y)
end

-- Tab Auto Rank
local function loadRank()
    tabTitle.Text = "Auto Rank"
    clearContent()
    local y = 50
    createToggle("Rank Up Bot", y)
end

-- Kết nối menu
btnMain.MouseButton1Click:Connect(loadMain)
btnPlayer.MouseButton1Click:Connect(loadPlayer)
btnDupe.MouseButton1Click:Connect(loadDupe)
btnChanger.MouseButton1Click:Connect(loadChanger)
btnRank.MouseButton1Click:Connect(loadRank)

-- Load mặc định tab Main
loadMain()

-- Load script chính
spawn(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
    end)
    if not ok then
        warn("⚠ Failed to load main script:", err)
    end
end)
