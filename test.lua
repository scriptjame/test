local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa gui cũ nếu có
local oldGui = playerGui:FindFirstChild("rutoairas")
if oldGui then oldGui:Destroy() end

-- GUI chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "rutoairas"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Viền ngoài
local outerFrame = Instance.new("Frame")
outerFrame.Size = UDim2.new(0, 420, 0, 400) -- Tăng chiều cao để chứa thông báo
outerFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
outerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
outerFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
outerFrame.BorderSizePixel = 2
outerFrame.Parent = screenGui

local outerCorner = Instance.new("UICorner", outerFrame)
outerCorner.CornerRadius = UDim.new(0, 15)

-- Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, -20, 1, -20)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = outerFrame

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

-- Tiêu đề
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "rutoairas"
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

-- Nút đóng
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame
closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Nút Hide/Show
local toggleGuiButton = Instance.new("TextButton")
toggleGuiButton.Size = UDim2.new(0, 50, 0, 30)
toggleGuiButton.Position = UDim2.new(0, 5, 0, 5)
toggleGuiButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
toggleGuiButton.Text = "Hide"
toggleGuiButton.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleGuiButton.Font = Enum.Font.GothamBold
toggleGuiButton.TextSize = 18
toggleGuiButton.Parent = screenGui

local guiVisible = true
toggleGuiButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    outerFrame.Visible = guiVisible
    toggleGuiButton.Text = guiVisible and "Hide" or "Show"
end)

-- Menu bên trái
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 100, 1, -30)
menuFrame.Position = UDim2.new(0, 0, 0, 30)
menuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = mainFrame

local function createMenuButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.Parent = menuFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local mainBtn = createMenuButton("Main", 0)
local playerBtn = createMenuButton("Player", 40)
local autoBuyBtn = createMenuButton("Auto Buy", 80)
local settingsBtn = createMenuButton("Settings", 120)

-- Nội dung chính
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, -80)
contentFrame.Position = UDim2.new(0, 100, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Tiêu đề tab
local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.BackgroundTransparency = 1
tabTitle.Text = "Main"
tabTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 24
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Parent = contentFrame

-- Dòng thông báo tối ưu hóa
local optimizeLabel = Instance.new("TextLabel")
optimizeLabel.Size = UDim2.new(1, -20, 0, 30)
optimizeLabel.Position = UDim2.new(0, 10, 1, -35)
optimizeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
optimizeLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
optimizeLabel.Font = Enum.Font.GothamBold
optimizeLabel.TextSize = 16
optimizeLabel.Text = "⏳ The system is optimizing for the best experience. Please wait: 200 seconds."
optimizeLabel.Parent = mainFrame
Instance.new("UICorner", optimizeLabel).CornerRadius = UDim.new(0, 6)

-- Đếm ngược
local secondsLeft = 200
task.spawn(function()
    while secondsLeft > 0 do
        optimizeLabel.Text = "⏳ The system is optimizing for the best experience. Please wait: " .. secondsLeft .. " seconds."
        secondsLeft -= 1
        wait(1)
    end
    optimizeLabel.Text = "✅ Optimization completed. Ready to use!"
end)

-- Tạo toggle
local toggles = {}
local function createToggleButton(text, posY, parent, fakeNote)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, fakeNote and 60 or 40)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    if fakeNote then
        local note = Instance.new("TextLabel")
        note.Size = UDim2.new(1, -60, 0, 20)
        note.Position = UDim2.new(0, 0, 0, 22)
        note.BackgroundTransparency = 1
        note.Text = "Chỉ là ảo"
        note.TextColor3 = Color3.fromRGB(255, 50, 50)
        note.Font = Enum.Font.GothamItalic
        note.TextSize = 14
        note.TextXAlignment = Enum.TextXAlignment.Left
        note.Parent = container
    end

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0, 10)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    toggle.Parent = container
    toggle.ClipsDescendants = true
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 18, 0, 18)
    toggleCircle.Position = UDim2.new(0, 1, 0, 1)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggle
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)

    toggles[text] = false
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.Parent = toggle
    toggleBtn.MouseButton1Click:Connect(function()
        toggles[text] = not toggles[text]
        if toggles[text] then
            toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            toggleCircle:TweenPosition(UDim2.new(0.5, 20, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            toggleCircle:TweenPosition(UDim2.new(0, 1, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        end
    end)
end

-- Tạo các tab
local mainToggles = { "Spam Click V2", "Spam Click Mobile", "Auto Spam Bata", "AutoParry" }
local playerToggles = { "ESP PLAYER", "ESP BALL", "SPEED", "JUMP" }

local function clearContent()
    for _, child in pairs(contentFrame:GetChildren()) do
        if child ~= tabTitle then child:Destroy() end
    end
end

local function loadMainTab()
    tabTitle.Text = "Main"
    clearContent()
    local y = 50
    for _, name in ipairs(mainToggles) do
        createToggleButton(name, y, contentFrame, false)
        y += 50
    end
end

local function loadPlayerTab()
    tabTitle.Text = "Player"
    clearContent()
    local y = 50
    for _, name in ipairs(playerToggles) do
        createToggleButton(name, y, contentFrame, true)
        y += 70
    end
end

mainBtn.MouseButton1Click:Connect(loadMainTab)
playerBtn.MouseButton1Click:Connect(loadPlayerTab)
autoBuyBtn.MouseButton1Click:Connect(function()
    tabTitle.Text = "Auto Buy"
    clearContent()
end)
settingsBtn.MouseButton1Click:Connect(function()
    tabTitle.Text = "Settings"
    clearContent()
end)

-- Mặc định load Main
loadMainTab()
