-- Xóa GUI cũ nếu có
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("HubUI")
if old then old:Destroy() end

-- Tạo ScreenGui
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "HubUI"
hubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
hubGui.ResetOnSpawn = false

-- Container chính
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(0.9, 0, 0.8, 0)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.BackgroundTransparency = 1

-- Layout dạng lưới
local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0.45, -10, 0.28, -10)
grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 2

-- Hàm tạo card đẹp
local function createCard(title, desc, imageId, callback)
    local card = Instance.new("Frame")
    card.Parent = container
    card.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    card.BackgroundTransparency = 0.15
    card.ClipsDescendants = true

    -- Bo góc
    local corner = Instance.new("UICorner", card)
    corner.CornerRadius = UDim.new(0, 12)

    -- Viền sáng
    local stroke = Instance.new("UIStroke", card)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.5

    -- Giữ tỉ lệ card
    local aspect = Instance.new("UIAspectRatioConstraint", card)
    aspect.AspectRatio = 1.6

    -- Ảnh thumbnail
    local thumb = Instance.new("ImageLabel", card)
    thumb.Size = UDim2.new(1, 0, 0.6, 0)
    thumb.Position = UDim2.new(0, 0, 0, 0)
    thumb.BackgroundTransparency = 1
    thumb.Image = imageId
    thumb.ScaleType = Enum.ScaleType.Crop

    -- Nền mờ chữ
    local bottomBar = Instance.new("Frame", card)
    bottomBar.Size = UDim2.new(1, 0, 0.4, 0)
    bottomBar.Position = UDim2.new(0, 0, 0.6, 0)
    bottomBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bottomBar.BackgroundTransparency = 0.25

    local bCorner = Instance.new("UICorner", bottomBar)
    bCorner.CornerRadius = UDim.new(0, 12)

    -- Tiêu đề
    local titleLabel = Instance.new("TextLabel", bottomBar)
    titleLabel.Size = UDim2.new(1, -10, 0.4, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 2)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = title

    -- Mô tả
    local descLabel = Instance.new("TextLabel", bottomBar)
    descLabel.Size = UDim2.new(1, -10, 0.6, -5)
    descLabel.Position = UDim2.new(0, 5, 0.4, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 16
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.TextWrapped = true
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.Text = desc

    -- Nút click (toàn card)
    local button = Instance.new("TextButton", card)
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.MouseButton1Click:Connect(callback)
end

-- Ví dụ các card
createCard("Pet Simulator 99", "Script Auto Farm, Dupe Pets, Unlock Areas...", "rbxassetid://12345678", function()
    print("Pet Simulator script chạy")
end)

createCard("Blade Ball", "Auto Parry, No Miss, Skin Changer...", "rbxassetid://23456789", function()
    print("Blade Ball script chạy")
end)

createCard("Discord", "Join our Discord group for exclusive scripts!", "rbxassetid://80637427855653", function()
    setclipboard("https://discord.gg/yourdiscord")
end)

createCard("YouTube", "Subscribe for more scripts!", "rbxassetid://95429734677601", function()
    setclipboard("https://youtube.com/yourchannel")
end)
