local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa GUI cũ nếu có
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- Tạo GUI chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainMenu"
screenGui.Parent = playerGui

-- Background mờ
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bg.BackgroundTransparency = 0.3
bg.Parent = screenGui

-- Hàm tạo nút game
local function createGameButton(parent, imageId, position, gameName, description, scriptFunc)
    local button = Instance.new("ImageButton")
    button.Size = UDim2.new(0, 200, 0, 200)
    button.Position = position
    button.Image = imageId
    button.Parent = parent
    button.BackgroundTransparency = 0.2
    button.BackgroundColor3 = Color3.fromRGB(50,50,50)
    button.ScaleType = Enum.ScaleType.Fit
    button.AutoButtonColor = true
    button.BorderSizePixel = 0
    button.ImageTransparency = 0

    -- Tên game
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = gameName
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Parent = button

    -- Mô tả script
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, 0, 0, 40)
    desc.Position = UDim2.new(0, 0, 1, 30)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextScaled = true
    desc.Font = Enum.Font.Gotham
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.TextWrapped = true
    desc.Parent = button

    -- Khi bấm -> gọi scriptFunc (sẽ mở GUI riêng)
    button.MouseButton1Click:Connect(function()
        scriptFunc()
    end)
end

-- Ví dụ script cho từng game (placeholder)
local function BladeBallScript()
    print("Mở GUI Blade Ball: Auto Parry, Changer Skin, Dupe...")
end

local function MM2Script()
    print("Mở GUI Murder Mystery 2: ESP, Auto Farm, Knife Aura...")
end

local function PetSim99Script()
    print("Mở GUI Pet Simulator 99: Auto Farm, Dupe Pets, Unlock Areas...")
end

local function GrowAGardenScript()
    print("Mở GUI Grow a Garden: Auto Plant, Auto Sell, Auto Upgrade...")
end

-- Sắp xếp ảnh đúng game + mô tả
createGameButton(bg, "rbxassetid://103879354899468", UDim2.new(0, 50, 0, 50), 
    "Grow a Garden", "Script Auto Plant, Auto Sell, Auto Upgrade...", GrowAGardenScript)

createGameButton(bg, "rbxassetid://110811575269598", UDim2.new(0, 300, 0, 50), 
    "Murder Mystery 2", "Script ESP, Auto Farm, Knife Aura...", MM2Script)

createGameButton(bg, "rbxassetid://120257957010430", UDim2.new(0, 550, 0, 50), 
    "Blade Ball", "Script Auto Parry no miss, Changer Skin, Dupe...", BladeBallScript)

createGameButton(bg, "rbxassetid://127537802436978", UDim2.new(0, 800, 0, 50), 
    "Pet Simulator 99", "Script Auto Farm, Dupe Pets, Unlock Areas...", PetSim99Script)
