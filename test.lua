local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa hub cũ nếu có
local old = playerGui:FindFirstChild("GameHub")
if old then old:Destroy() end

-- Hub GUI
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "GameHub"

local mainFrame = Instance.new("Frame", hubGui)
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "⚔️ Multi Game Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

local gameList = Instance.new("Frame", mainFrame)
gameList.Size = UDim2.new(1, -20, 1, -60)
gameList.Position = UDim2.new(0, 10, 0, 50)
gameList.BackgroundTransparency = 1

local uiList = Instance.new("UIListLayout", gameList)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 10)

-- Hàm tạo dòng game
local function createGameItem(imgId, gameName, desc, callback)
    local item = Instance.new("Frame", gameList)
    item.Size = UDim2.new(1, 0, 0, 80)
    item.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 10)

    local icon = Instance.new("ImageLabel", item)
    icon.Size = UDim2.new(0, 80, 0, 80)
    icon.BackgroundTransparency = 1
    icon.Image = imgId  -- 🟢 imgId phải là dạng "rbxassetid://..."

    local textFrame = Instance.new("Frame", item)
    textFrame.Size = UDim2.new(1, -90, 1, 0)
    textFrame.Position = UDim2.new(0, 90, 0, 0)
    textFrame.BackgroundTransparency = 1

    local gameTitle = Instance.new("TextLabel", textFrame)
    gameTitle.Size = UDim2.new(1, 0, 0, 30)
    gameTitle.Text = gameName
    gameTitle.Font = Enum.Font.GothamBold
    gameTitle.TextSize = 20
    gameTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
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

    local btn = Instance.new("TextButton", item)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.MouseButton1Click:Connect(callback)
end

----------------------------------------------------------------
-- 🟢 Thêm game với ảnh thật
----------------------------------------------------------------
createGameItem("rbxassetid://18414426580", "Blade Ball", "Auto Parry, Change Skin, Dupe...", function()
    hubGui.Enabled = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

createGameItem("rbxassetid://14742116869", "Murder Mystery 2", "ESP, Auto Farm, Knife Changer...", function()
    hubGui.Enabled = false
    -- chèn link script MM2 của bạn
end)

createGameItem("rbxassetid://14880146236", "Blox Fruits", "Auto Farm, Devil Fruit Sniper, Raid...", function()
    hubGui.Enabled = false
    -- chèn link script BloxFruit của bạn
end)

createGameItem("rbxassetid://15299254591", "Pet Simulator 99", "Auto Hatch, Auto Farm, Dupe Pet...", function()
    hubGui.Enabled = false
    -- chèn link script Pet99 của bạn
end)
