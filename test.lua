local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BladeBallGUI"
ScreenGui.Parent = playerGui

-- Main frame (black background)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Project Reverse [Fun]"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.fromRGB(100, 210, 255)
titleLabel.Parent = titleBar

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 50, 1, 0)
closeBtn.Position = UDim2.new(1, -50, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Left menu frame
local menuFrame = Instance.new("ScrollingFrame")
menuFrame.Size = UDim2.new(0, 150, 1, -30)
menuFrame.Position = UDim2.new(0, 0, 0, 30)
menuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
menuFrame.BorderSizePixel = 0
menuFrame.CanvasSize = UDim2.new(0, 0, 3, 0)
menuFrame.ScrollBarThickness = 5
menuFrame.Parent = mainFrame

-- Add game buttons to left menu
local games = {"Murder Mystery 2", "Grow A Garden", "Adopt Me", "Blade Ball"}
local yPos = 10
for _, gameName in ipairs(games) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = gameName
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = menuFrame
    
    yPos = yPos + 50
    
    btn.MouseButton1Click:Connect(function()
        -- Thay đổi tab nội dung bên phải tùy game được chọn
        contentTitle.Text = gameName
        -- update phần nội dung khác ở đây nếu cần
    end)
end

-- Content frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -150, 1, -30)
contentFrame.Position = UDim2.new(0, 150, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentTitle = Instance.new("TextLabel")
contentTitle.Size = UDim2.new(1, 0, 0, 40)
contentTitle.BackgroundTransparency = 1
contentTitle.TextColor3 = Color3.fromRGB(100, 210, 255)
contentTitle.Font = Enum.Font.GothamBold
contentTitle.TextSize = 20
contentTitle.Text = "Blade Ball"
contentTitle.Parent = contentFrame

-- Example button in content frame
local toggleVisualBtn = Instance.new("TextButton")
toggleVisualBtn.Size = UDim2.new(0, 140, 0, 40)
toggleVisualBtn.Position = UDim2.new(0, 20, 0, 60)
toggleVisualBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleVisualBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleVisualBtn.Font = Enum.Font.GothamBold
toggleVisualBtn.TextSize = 16
toggleVisualBtn.Text = "Toggle Visual"
toggleVisualBtn.Parent = contentFrame

local visualEnabled = true
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 120, 0, 30)
statusLabel.Position = UDim2.new(0, 180, 0, 70)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 18
statusLabel.Text = "Visual: ON"
statusLabel.Parent = contentFrame

toggleVisualBtn.MouseButton1Click:Connect(function()
    visualEnabled = not visualEnabled
    if visualEnabled then
        statusLabel.Text = "Visual: ON"
    else
        statusLabel.Text = "Visual: OFF"
    end
end)
