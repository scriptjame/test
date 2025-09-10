-- Tạo ScreenGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "rutoairas"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Khung chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Tên GUI header
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

-- Nút ẩn/hiện GUI (góc trên bên trái)
local toggleGuiButton = Instance.new("TextButton")
toggleGuiButton.Size = UDim2.new(0, 40, 0, 30)
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
    mainFrame.Visible = guiVisible
    if guiVisible then
        toggleGuiButton.Text = "Hide"
        externalLabel.Visible = false
    else
        toggleGuiButton.Text = "Show"
        -- Khi ẩn GUI, vẫn hiện external label nếu có toggle bật
        local anyEnabled = false
        for _, state in pairs(toggles) do
            if state then
                anyEnabled = true
                break
            end
        end
        externalLabel.Visible = anyEnabled
    end
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

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)

    return btn
end

local mainBtn = createMenuButton("Main", 0)
local playerBtn = createMenuButton("Player", 40)
local autoBuyBtn = createMenuButton("Auto Buy", 80)
local settingsBtn = createMenuButton("Settings", 120)

-- Nội dung chính
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, -30)
contentFrame.Position = UDim2.new(0, 100, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Tiêu đề Main
local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.BackgroundTransparency = 1
tabTitle.Text = "Main"
tabTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 24
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Parent = contentFrame

-- Auto Spam ngoài GUI
local externalLabel = Instance.new("TextLabel")
externalLabel.Size = UDim2.new(0, 140, 0, 30)
externalLabel.Position = UDim2.new(0.5, -70, 0, -50)
externalLabel.AnchorPoint = Vector2.new(0.5, 0)
externalLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
externalLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
externalLabel.Text = "Auto Spam"
externalLabel.Font = Enum.Font.GothamBold
externalLabel.TextSize = 20
externalLabel.Visible = false
externalLabel.Parent = screenGui

local extCorner = Instance.new("UICorner", externalLabel)
extCorner.CornerRadius = UDim.new(0, 8)

-- Quản lý toggle bật
local toggles = {}

local function updateExternalLabel()
    local anyEnabled = false
    for _, state in pairs(toggles) do
        if state then
            anyEnabled = true
            break
        end
    end
    externalLabel.Visible = anyEnabled and not guiVisible
end

-- Tạo toggle
local function createToggleButton(text, posY)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 40)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = contentFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0, 10)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    toggle.Parent = container
    toggle.ClipsDescendants = true

    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(1, 0)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 18, 0, 18)
    toggleCircle.Position = UDim2.new(0, 1, 0, 1)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggle

    local circleCorner = Instance.new("UICorner", toggleCircle)
    circleCorner.CornerRadius = UDim.new(1, 0)

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
        updateExternalLabel()
    end)

    return container
end

-- Tạo các toggle
createToggleButton("Spam Click V2", 50)
createToggleButton("Spam Click Mobile", 100)
createToggleButton("Auto Spam Bata", 150)
createToggleButton("AutoParry", 200)

-- Nếu muốn thêm phím tắt ẩn/hiện (nhưng mobile không dùng được):
-- local UserInputService = game:GetService("UserInputService")
-- UserInputService.InputBegan:Connect(function(input, gameProcessed)
--     if not gameProcessed then
--         if input.KeyCode == Enum.KeyCode.H then
--             guiVisible = not guiVisible
--             mainFrame.Visible = guiVisible
--             if guiVisible then
--                 toggleGuiButton.Text = "Hide"
--                 externalLabel.Visible = false
--             else
--                 toggleGuiButton.Text = "Show"
--                 updateExternalLabel()
--             end
--         end
--     end
-- end)
