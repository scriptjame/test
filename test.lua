local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa gui cũ nếu có
local oldGui = playerGui:FindFirstChild("rutoairas")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "rutoairas"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Viền ngoài lớn bọc toàn bộ GUI
local outerFrame = Instance.new("Frame")
outerFrame.Size = UDim2.new(0, 420, 0, 370)
outerFrame.Position = UDim2.new(0.5, -210, 0.5, -185)
outerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
outerFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
outerFrame.BorderSizePixel = 2
outerFrame.Parent = screenGui

local outerCorner = Instance.new("UICorner")
outerCorner.CornerRadius = UDim.new(0, 15)
outerCorner.Parent = outerFrame

-- Khung chính bên trong (chừa viền)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, -20, 1, -20)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = outerFrame

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

local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.BackgroundTransparency = 1
tabTitle.Text = "Main"
tabTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 24
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Parent = contentFrame

-- Xóa nội dung cũ
local function clearContent()
    for _, child in pairs(contentFrame:GetChildren()) do
        if child ~= tabTitle then
            child:Destroy()
        end
    end
end

-- Tạo toggle đơn giản
local function createToggle(text, y, parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 40)
    container.Position = UDim2.new(0, 10, 0, y)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 40, 0, 20)
    toggleFrame.Position = UDim2.new(1, -50, 0, 10)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    toggleFrame.Parent = container
    toggleFrame.ClipsDescendants = true

    local toggleCorner = Instance.new("UICorner", toggleFrame)
    toggleCorner.CornerRadius = UDim.new(1, 0)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 18, 0, 18)
    toggleCircle.Position = UDim2.new(0, 1, 0, 1)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleFrame

    local circleCorner = Instance.new("UICorner", toggleCircle)
    circleCorner.CornerRadius = UDim.new(1, 0)

    local enabled = false

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame

    toggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            toggleCircle:TweenPosition(UDim2.new(0.5, 20, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        else
            toggleFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            toggleCircle:TweenPosition(UDim2.new(0, 1, 0, 1), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        end
    end)

    return {
        frame = container,
        isEnabled = function() return enabled end,
        setEnabled = function(state)
            enabled = state
            if enabled then
                toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                toggleCircle.Position = UDim2.new(0.5, 20, 0, 1)
            else
                toggleFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
                toggleCircle.Position = UDim2.new(0, 1, 0, 1)
            end
        end
    }
end

-- Tạo slider đơn giản
local function createSlider(text, y, parent, minVal, maxVal, defaultVal)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 50)
    container.Position = UDim2.new(0, 10, 0, y)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(defaultVal)
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -60, 0, 20)
    sliderFrame.Position = UDim2.new(0, 0, 0, 25)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    sliderFrame.Parent = container
    sliderFrame.ClipsDescendants = true

    local sliderCorner = Instance.new("UICorner", sliderFrame)
    sliderCorner.CornerRadius = UDim.new(0, 6)

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    sliderBar.Parent = sliderFrame

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 18, 0, 20)
    sliderButton.Position = UDim2.new(sliderBar.Size.X.Scale, 0, 0, 0)
    sliderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sliderButton.BorderSizePixel = 0
    sliderButton.Parent = sliderFrame

    local buttonCorner = Instance.new("UICorner", sliderButton)
    buttonCorner.CornerRadius = UDim.new(1, 0)

    local dragging = false

    local function updateSlider(inputPosX)
        local relativePos = math.clamp(inputPosX - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
        local scale = relativePos / sliderFrame.AbsoluteSize.X
        sliderBar.Size = UDim2.new(scale, 0, 1, 0)
        sliderButton.Position = UDim2.new(scale, 0, 0, 0)

        local value = math.floor(minVal + scale * (maxVal - minVal))
        label.Text = text .. ": " .. tostring(value)
    end

    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderFrame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)

    return container
end

-- Xây dựng nội dung từng tab
local function showMainTab()
    clearContent()
    tabTitle.Text = "Main"

    local autoParryToggle = createToggle("AutoParry", 10, contentFrame)
    autoParryToggle.frame.Parent = contentFrame

    -- Ví dụ thêm toggle khác
    local autoClickToggle = createToggle("AutoClick (Fake)", 60, contentFrame)
    autoClickToggle.frame.Parent = contentFrame
end

local function showPlayerTab()
    clearContent()
    tabTitle.Text = "Player"

    local flyToggle = createToggle("Fly (Fake)", 10, contentFrame)
    flyToggle.frame.Parent = contentFrame

    local speedSlider = createSlider("Speed", 60, contentFrame, 16, 500, 16)
    speedSlider.Parent = contentFrame
end

-- Gán sự kiện chuyển tab
mainBtn.MouseButton1Click:Connect(function()
    showMainTab()
end)

playerBtn.MouseButton1Click:Connect(function()
    showPlayerTab()
end)

autoBuyBtn.MouseButton1Click:Connect(function()
    clearContent()
    tabTitle.Text = "Auto Buy"
    -- Thêm code Auto Buy tại đây
end)

settingsBtn.MouseButton1Click:Connect(function()
    clearContent()
    tabTitle.Text = "Settings"
    -- Thêm code Settings tại đây
end)

-- Mặc định hiển thị Main tab
showMainTab()
