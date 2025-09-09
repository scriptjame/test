local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BladeBallGUI"
ScreenGui.Parent = playerGui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 320)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "rutoairas"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Left menu frame
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 130, 1, -30)
menuFrame.Position = UDim2.new(0, 0, 0, 30)
menuFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = mainFrame

-- Menu label "Blade Ball"
local bladeBallBtn = Instance.new("TextButton")
bladeBallBtn.Size = UDim2.new(1, -20, 0, 40)
bladeBallBtn.Position = UDim2.new(0, 10, 0, 10)
bladeBallBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
bladeBallBtn.Text = "Blade Ball"
bladeBallBtn.TextColor3 = Color3.fromRGB(210, 210, 210)
bladeBallBtn.Font = Enum.Font.Gotham
bladeBallBtn.TextSize = 16
bladeBallBtn.AutoButtonColor = false
bladeBallBtn.Parent = menuFrame
bladeBallBtn.BackgroundTransparency = 0

-- Content frame (bên phải)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -130, 1, -30)
contentFrame.Position = UDim2.new(0, 130, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 12)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

-- Các chức năng blade ball với toggle button
local functions = {
    {Name = "Fix Lag", Enabled = false},
    {Name = "Auto Parry", Enabled = false},
    {Name = "Change Skin", Enabled = false},
    {Name = "Super Speed", Enabled = false},  -- Bạn có thể thêm các chức năng ảo khác
}

local function createToggleButton(func)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.BackgroundTransparency = 1
    frame.Parent = contentFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = func.Name
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.3, -5, 0.7, 0)
    toggleBtn.Position = UDim2.new(0.7, 5, 0.15, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggleBtn.Text = "Off"
    toggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 14
    toggleBtn.Parent = frame

    toggleBtn.MouseButton1Click:Connect(function()
        func.Enabled = not func.Enabled
        if func.Enabled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            toggleBtn.Text = "On"
            toggleBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggleBtn.Text = "Off"
            toggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
    end)

    return frame
end

-- Tạo các nút toggle cho chức năng
for _, func in ipairs(functions) do
    createToggleButton(func)
end
