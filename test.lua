-- Xoá GUI cũ nếu có
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainMenu"
screenGui.Parent = playerGui

-- Tạo Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = screenGui

-- UIGrid cho game list
local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.new(0, 280, 0, 220)
grid.CellPadding = UDim2.new(0, 15, 0, 15)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Center
grid.Parent = mainFrame

-- Danh sách game
local games = {
    {
        name = "Pet Simulator 99",
        desc = "Script Auto Farm, Dupe Pets, Unlock Areas...",
        img = "rbxassetid://103879354899468"
    },
    {
        name = "Grow a Garden",
        desc = "Script Auto Plant, Auto Sell, Auto Upgrade...",
        img = "rbxassetid://110811575269598"
    },
    {
        name = "Murder Mystery 2",
        desc = "Script ESP, Auto Farm, Knife Aura...",
        img = "rbxassetid://120257957010430"
    },
    {
        name = "Blade Ball",
        desc = "Script Auto Parry no miss, Changer Skin, Dupe...",
        img = "rbxassetid://127537802436978"
    }
}

-- Hàm tạo card game
local function createGameCard(info)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 280, 0, 220)
    card.BackgroundColor3 = Color3.fromRGB(30,30,30)
    card.BorderSizePixel = 0
    card.Parent = mainFrame

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, 0, 0.6, 0)
    img.BackgroundTransparency = 1
    img.Image = info.img
    img.Parent = card

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0.65, 0)
    title.BackgroundTransparency = 1
    title.Text = info.name
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -10, 0.25, 0)
    desc.Position = UDim2.new(0, 5, 0.8, 0)
    desc.BackgroundTransparency = 1
    desc.Text = info.desc
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 14
    desc.TextWrapped = true
    desc.TextColor3 = Color3.fromRGB(200,200,200)
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = card
end

-- Tạo card cho từng game
for _, gameInfo in ipairs(games) do
    createGameCard(gameInfo)
end

-- ===== Nút Discord + YouTube =====
local function createSocialButton(text, color, link, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.BorderSizePixel = 2
    btn.Text = "  " .. text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = color
    btn.Parent = screenGui

    -- bo tròn
    local uic = Instance.new("UICorner")
    uic.CornerRadius = UDim.new(0, 12)
    uic.Parent = btn

    -- viền
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = color
    stroke.Parent = btn

    -- icon
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, 28, 0, 28)
    img.Position = UDim2.new(0, 10, 0.5, -14)
    img.BackgroundTransparency = 1
    img.Image = icon
    img.Parent = btn

    -- khi bấm mở link
    btn.MouseButton1Click:Connect(function()
        game:GetService("GuiService"):OpenBrowserWindow(link)
    end)

    return btn
end

-- Nút Discord
local discordBtn = createSocialButton("Join Discord", Color3.fromRGB(88, 101, 242), 
    "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
discordBtn.Position = UDim2.new(0.25, -100, 0.9, 0)

-- Nút YouTube
local ytBtn = createSocialButton("Subscribe", Color3.fromRGB(255,0,0), 
    "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")
ytBtn.Position = UDim2.new(0.75, -100, 0.9, 0)
