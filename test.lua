local TeleportService = game:GetService("TeleportService")
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

-- Hàm tạo nút hình ảnh
local function createGameButton(parent, imageId, position, gameName, placeId)
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

    -- Thêm chữ tên game
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = gameName
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Parent = button

    -- Sự kiện bấm -> teleport
    button.MouseButton1Click:Connect(function()
        TeleportService:Teleport(placeId, player)
    end)

    return button
end

-- Tạo 4 nút game với ảnh + placeId
createGameButton(bg, "rbxassetid://103879354899468", UDim2.new(0, 50, 0, 50), "Grow a Garden", 126884695634066)
createGameButton(bg, "rbxassetid://110811575269598", UDim2.new(0, 300, 0, 50), "Murder Mystery 2", 142823291)
createGameButton(bg, "rbxassetid://120257957010430", UDim2.new(0, 550, 0, 50), "Blade Ball", 13772394625)
createGameButton(bg, "rbxassetid://127537802436978", UDim2.new(0, 800, 0, 50), "Pet Simulator 99", 8737899170)
