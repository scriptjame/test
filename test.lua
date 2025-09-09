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
titleLabel.Text = "Project Reverse [Fun]"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close button
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
menuFrame.Size = UDim2.new(0, 150, 1, -30)
menuFrame.Position = UDim2.new(0, 0, 0, 30)
menuFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = mainFrame

-- Section labels
local gamesLabel = Instance.new("TextLabel")
gamesLabel.Size = UDim2.new(1, 0, 0, 20)
gamesLabel.Position = UDim2.new(0, 10, 0, 10)
gamesLabel.BackgroundTransparency = 1
gamesLabel.Text = "Games"
gamesLabel.Font = Enum.Font.GothamSemibold
gamesLabel.TextSize = 14
gamesLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
gamesLabel.TextXAlignment = Enum.TextXAlignment.Left
gamesLabel.Parent = menuFrame

-- List of games
local games = {"Murder Mystery 2", "Grow A Garden", "Adopt Me", "Blade Ball"}

local selectedGame = nil

local function createMenuButton(text, posY, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(210, 210, 210)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = parent
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
    end)
    btn.MouseLeave:Connect(function()
        if selectedGame ~= text then
            btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        end
    end)
    
    return btn
end

local gameButtons = {}
local startY = 35
for i, gameName in ipairs(games) do
    local btn = createMenuButton(gameName, startY + (i-1)*35, menuFrame)
    gameButtons[gameName] = btn
end

-- Settings label
local settingsLabel = Instance.new("TextLabel")
settingsLabel.Size = UDim2.new(1, 0, 0, 20)
settingsLabel.Position = UDim2.new(0, 10, 0, startY + #games*35 + 10)
settingsLabel.BackgroundTransparency = 1
settingsLabel.Text = "Settings"
settingsLabel.Font = Enum.Font.GothamSemibold
settingsLabel.TextSize = 14
settingsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
settingsLabel.TextXAlignment = Enum.TextXAlignment.Left
settingsLabel.Parent = menuFrame

-- Settings button (Customization)
local customizationBtn = createMenuButton("Customization", startY + #games*35 + 35, menuFrame)

-- Right content frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -150, 1, -30)
contentFrame.Position = UDim2.new(0, 150, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentListLayout = Instance.new("UIListLayout")
contentListLayout.Padding = UDim.new(0, 10)
contentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentListLayout.Parent = contentFrame

local function clearContent()
    for _, child in ipairs(contentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

-- Các mục chức năng từng game
local gameFunctions = {
    ["Blade Ball"] = {"Visuals", "Farming"},
    ["Murder Mystery 2"] = {"ESP", "Aimbot"},
    ["Grow A Garden"] = {"Auto Plant", "Auto Harvest"},
    ["Adopt Me"] = {"Auto Feed", "Auto Hatch"},
    ["Customization"] = {"Theme", "Font Size", "Colors"},
}

local function updateContent(name)
    clearContent()
    local funcs = gameFunctions[name]
    if not funcs then return end
    
    for i, funcName in ipairs(funcs) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 30)
        label.BackgroundTransparency = 1
        label.Text = funcName
        label.Font = Enum.Font.Gotham
        label.TextSize = 16
        label.TextColor3 = Color3.fromRGB(230, 230, 230)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.LayoutOrder = i
        label.Parent = contentFrame
    end
end

-- Khi click game, update content và đổi màu nút được chọn
local function selectGame(name)
    selectedGame = name
    for gameName, btn in pairs(gameButtons) do
        if gameName == name then
            btn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
        else
            btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        end
    end
    
    updateContent(name)
end

-- Gán sự kiện click cho các nút game
for gameName, btn in pairs(gameButtons) do
    btn.MouseButton1Click:Connect(function()
        selectGame(gameName)
    end)
end

-- Click nút settings
customizationBtn.MouseButton1Click:Connect(function()
    selectGame("Customization")
end)

-- Mặc định chọn Blade Ball
selectGame("Blade Ball")
