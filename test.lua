-- Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BladeBallVisual"
screenGui.Parent = PlayerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 140)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -70)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Blade Ball Visual"
titleLabel.TextColor3 = Color3.fromRGB(0, 153, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 30
titleLabel.Parent = mainFrame

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 40)
statusLabel.Position = UDim2.new(0, 0, 0, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Visual: OFF"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 24
statusLabel.Parent = mainFrame

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 140, 0, 40)
toggleButton.Position = UDim2.new(0.5, -70, 1, -50)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Toggle Visual"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.Parent = mainFrame

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -35, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 24
minimizeButton.Parent = mainFrame

-- Hidden Frame (for minimized)
local hiddenFrame = Instance.new("Frame")
hiddenFrame.Size = UDim2.new(0, 160, 0, 40)
hiddenFrame.Position = mainFrame.Position
hiddenFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
hiddenFrame.BorderSizePixel = 0
hiddenFrame.AnchorPoint = Vector2.new(0.5, 0.5)
hiddenFrame.Visible = false
hiddenFrame.Parent = screenGui

local showButton = Instance.new("TextButton")
showButton.Size = UDim2.new(1, 0, 1, 0)
showButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
showButton.BorderSizePixel = 0
showButton.Text = "Show Visual"
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.Font = Enum.Font.GothamBold
showButton.TextSize = 22
showButton.Parent = hiddenFrame

-- Toggle visual state variable
local visualOn = false

toggleButton.MouseButton1Click:Connect(function()
    visualOn = not visualOn
    if visualOn then
        statusLabel.Text = "Visual: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    else
        statusLabel.Text = "Visual: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    end
    -- Bạn có thể thêm code visual blade ball ở đây khi bật/tắt
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    hiddenFrame.Visible = true
end)

showButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    hiddenFrame.Visible = false
end)
