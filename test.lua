-- Xoá GUI cũ nếu có
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainMenu"
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true

-- Frame chứa game
local gameFrame = Instance.new("Frame")
gameFrame.Size = UDim2.new(1, 0, 0.8, 0)
gameFrame.Position = UDim2.new(0, 0, 0, 20)
gameFrame.BackgroundTransparency = 1
gameFrame.Parent = screenGui

local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.new(0, 280, 0, 220)
grid.CellPadding = UDim2.new(0, 20, 0, 20)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4
grid.Parent = gameFrame

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

-- Tạo card game
local function createGameCard(info)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(20,20,20)
    card.BorderSizePixel = 0
    card.Parent = gameFrame

    local uic = Instance.new("UICorner", card)
    uic.CornerRadius = UDim.new(0, 12)

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, 0, 0.6, 0)
    img.BackgroundTransparency = 1
    img.Image = info.img
    img.Parent = card

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 28)
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

for _, g in ipairs(games) do
    createGameCard(g)
end

-- Hàm tạo nút social
local function createSocialButton(text, color, link, icon, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 55)
    btn.Position = UDim2.new(posX, -110, 0.9, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.Text = ""
    btn.Parent = screenGui

    local uic = Instance.new("UICorner", btn)
    uic.CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 3
    stroke.Color = color

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, 30, 0, 30)
    img.Position = UDim2.new(0, 15, 0.5, -15)
    img.BackgroundTransparency = 1
    img.Image = icon
    img.Parent = btn

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 55, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.TextColor3 = color
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(link)
            game.StarterGui:SetCore("SendNotification", {
                Title = "📌 Link Copied",
                Text = "Paste vào trình duyệt để mở: "..link,
                Duration = 5
            })
        end
    end)
end

-- Nút Discord
createSocialButton("Join Discord", Color3.fromRGB(88, 101, 242),
    "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938", 0.3)

-- Nút YouTube
createSocialButton("Subscribe", Color3.fromRGB(255,0,0),
    "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939", 0.7)
