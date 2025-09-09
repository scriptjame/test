-- Tạo ScreenGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "rutoairas"
screenGui.Parent = playerGui

-- Khung chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Tên GUI header
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "rutoairas"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

-- Nút thu nhỏ và đóng
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Menu bên trái
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 100, 1, -30)
menuFrame.Position = UDim2.new(0, 0, 0, 30)
menuFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = mainFrame

local function createMenuButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.Parent = menuFrame
    return btn
end

local mainBtn = createMenuButton("Main", 0)
local playerBtn = createMenuButton("Player", 40)
local autoBuyBtn = createMenuButton("Auto Buy", 80)
local settingsBtn = createMenuButton("Settings", 120)

-- Khu vực nội dung bên phải
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, -30)
contentFrame.Position = UDim2.new(0, 100, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Tiêu đề tab Main
local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.BackgroundTransparency = 1
tabTitle.Text = "Main"
tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 24
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Parent = contentFrame

-- Tạo một nút toggle theo mẫu trong ảnh
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
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0, 10)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    toggle.Parent = container
    toggle.ClipsDescendants = true
    toggle.AnchorPoint = Vector2.new(0, 0)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 18, 0, 18)
    toggleCircle.Position = UDim2.new(0, 1, 0, 1)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggle
    toggleCircle.AnchorPoint = Vector2.new(0, 0)
    toggleCircle.Name = "ToggleCircle"
    toggleCircle.ZIndex = 2
    toggleCircle.BackgroundTransparency = 0.1
    toggleCircle.BorderColor3 = Color3.new(0,0,0)

    -- Bật tắt toggle
    local toggled = false
    local function toggleSwitch()
        toggled = not toggled
        if toggled then
            toggle.BackgroundColor3 = Color3.fromRGB(0, 162, 255) -- xanh dương bật
            toggleCircle:TweenPosition(UDim2.new(0.5, 20, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- xám tắt
            toggleCircle:TweenPosition(UDim2.new(0, 1, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        end
    end

    toggle.MouseButton1Click = toggleSwitch -- toggle là frame nên không có sự kiện này, cần thay bằng nút bấm

    -- Thay frame toggle thành nút bấm
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.Parent = toggle

    toggleBtn.MouseButton1Click:Connect(toggleSwitch)

    return container
end

-- Thêm các toggle buttons theo ảnh
createToggleButton("Spam Click V2", 50)
createToggleButton("Spam Click Mobile", 100)
createToggleButton("Auto Spam Bata", 150)

-- Tạo toggle FFA phía dưới cùng
local ffaLabel = Instance.new("TextLabel")
ffaLabel.Size = UDim2.new(1, -20, 0, 40)
ffaLabel.Position = UDim2.new(0, 10, 0, 220)
ffaLabel.BackgroundTransparency = 1
ffaLabel.Text = "Auto Vote"
ffaLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ffaLabel.Font = Enum.Font.GothamSemibold
ffaLabel.TextSize = 18
ffaLabel.TextXAlignment = Enum.TextXAlignment.Left
ffaLabel.Parent = contentFrame

local ffaToggle = Instance.new("Frame")
ffaToggle.Size = UDim2.new(0, 40, 0, 20)
ffaToggle.Position = UDim2.new(1, -50, 0, 220 + 10)
ffaToggle.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
ffaToggle.Parent = contentFrame
ffaToggle.ClipsDescendants = true

local ffaCircle = Instance.new("Frame")
ffaCircle.Size = UDim2.new(0, 18, 0, 18)
ffaCircle.Position = UDim2.new(0.5, 20, 0, 1)
ffaCircle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ffaCircle.BorderSizePixel = 0
ffaCircle.Parent = ffaToggle

-- Toggle FFA logic
local ffaOn = true
local function toggleFFA()
    ffaOn = not ffaOn
    if ffaOn then
        ffaToggle.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        ffaCircle:TweenPosition(UDim2.new(0.5, 20, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
    else
        ffaToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        ffaCircle:TweenPosition(UDim2.new(0, 1, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
    end
end

ffaToggle.MouseButton1Click = nil -- Frame không có sự kiện bấm
local ffaToggleBtn = Instance.new("TextButton")
ffaToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ffaToggleBtn.BackgroundTransparency = 1
ffaToggleBtn.Text = ""
ffaToggleBtn.Parent = ffaToggle
ffaToggleBtn.MouseButton1Click:Connect(toggleFFA)
