local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa hub cũ nếu có
local old = playerGui:FindFirstChild("GameHub")
if old then old:Destroy() end

-- Hub GUI
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "GameHub"

local mainFrame = Instance.new("Frame", hubGui)
mainFrame.Size = UDim2.new(0, 600, 0, 420)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Gradient nền động
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 180, 255))
}
gradient.Rotation = 45
task.spawn(function()
    while task.wait(0.05) do
        gradient.Rotation = gradient.Rotation + 1
    end
end)

-- Hiệu ứng viền
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 255, 120)

-- Nút đóng
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.new(1, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.MouseButton1Click:Connect(function()
    hubGui:Destroy()
end)

-- Tiêu đề
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🎮 Multi Game Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(0, 255, 120)
title.BackgroundTransparency = 1

local gameList = Instance.new("Frame", mainFrame)
gameList.Size = UDim2.new(1, -20, 1, -60)
gameList.Position = UDim2.new(0, 10, 0, 50)
gameList.BackgroundTransparency = 1

local uiList = Instance.new("UIListLayout", gameList)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 10)

-- Hàm tạo game item
local function createGameItem(imgId, gameName, desc, callback, iconEmoji)
    local item = Instance.new("Frame", gameList)
    item.Size = UDim2.new(1, 0, 0, 90)
    item.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", item)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(60, 60, 60)

    -- Ảnh game
    local icon = Instance.new("ImageLabel", item)
    icon.Size = UDim2.new(0, 80, 0, 80)
    icon.Position = UDim2.new(0, 5, 0.5, -40)
    icon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    icon.Image = imgId
    Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 8)

    -- Text
    local textFrame = Instance.new("Frame", item)
    textFrame.Size = UDim2.new(1, -100, 1, 0)
    textFrame.Position = UDim2.new(0, 95, 0, 0)
    textFrame.BackgroundTransparency = 1

    local gameTitle = Instance.new("TextLabel", textFrame)
    gameTitle.Size = UDim2.new(1, 0, 0, 30)
    gameTitle.Text = iconEmoji .. " " .. gameName
    gameTitle.Font = Enum.Font.GothamBold
    gameTitle.TextSize = 20
    gameTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
    gameTitle.BackgroundTransparency = 1
    gameTitle.TextXAlignment = Enum.TextXAlignment.Left

    local descLabel = Instance.new("TextLabel", textFrame)
    descLabel.Size = UDim2.new(1, 0, 0, 50)
    descLabel.Position = UDim2.new(0, 0, 0, 30)
    descLabel.Text = desc
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 16
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.BackgroundTransparency = 1
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true

    -- Hover effect (phóng to + sáng)
    item.MouseEnter:Connect(function()
        TweenService:Create(item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        stroke.Color = Color3.fromRGB(0, 255, 120)
        TweenService:Create(item, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 95)}):Play()
    end)
    item.MouseLeave:Connect(function()
        TweenService:Create(item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
        stroke.Color = Color3.fromRGB(60, 60, 60)
        TweenService:Create(item, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 90)}):Play()
    end)

    -- Click
    local btn = Instance.new("TextButton", item)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.MouseButton1Click:Connect(callback)
end

----------------------------------------------------------------
-- Games
----------------------------------------------------------------
createGameItem("rbxassetid://18414426580", "Blade Ball", "Auto Parry, Change Skin, Dupe...", function()
    hubGui.Enabled = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end, "⚔️")

createGameItem("rbxassetid://14742116869", "Murder Mystery 2", "ESP, Auto Farm, Knife Changer...", function()
    hubGui.Enabled = false
    -- script MM2 của bạn
end, "🔪")

createGameItem("rbxassetid://14821627043", "Grow a Garden", "Auto Farm, Fast Plant, Unlimited Coins...", function()
    hubGui.Enabled = false
    -- script Grow a Garden của bạn
end, "🌱")

createGameItem("rbxassetid://15299254591", "Pet Simulator 99", "Auto Hatch, Auto Farm, Dupe Pet...", function()
    hubGui.Enabled = false
    -- script Pet99 của bạn
end, "🐾")
