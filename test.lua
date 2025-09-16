--== MAIN HUB ==--

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa hub cũ nếu có
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- Tạo ScreenGui
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.IgnoreGuiInset = true
hubGui.Parent = playerGui

-- Hàm mở link
local function openLink(url)
    local copied = false
    if setclipboard then
        pcall(setclipboard, url)
        copied = true
    end
    if typeof(openbrowser) == "function" then
        pcall(openbrowser, url)
        copied = true
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Link",
        Text = copied and "Link đã copy, dán vào trình duyệt!" or "Không thể copy, link: "..url,
        Duration = 5
    })
    warn("Link:", url)
end

-- Container chính
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -40, 0.8, 0)
container.Position = UDim2.new(0, 20, 0.05, 0)
container.BackgroundTransparency = 1
container.Parent = hubGui

local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.new(0.25, -20, 0, 220) -- tự co giãn theo màn hình
grid.CellPadding = UDim2.new(0, 12, 0, 12)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.Parent = container

-- Hàm tạo thẻ game
local function createCard(name, desc, img, callback)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(28,28,28)
    card.BorderSizePixel = 0
    card.Parent = container

    local corner = Instance.new("UICorner", card)
    corner.CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = Color3.fromRGB(90,90,90)
    stroke.Thickness = 2

    local image = Instance.new("ImageButton", card)
    image.Size = UDim2.new(1,0,0.55,0)
    image.BackgroundTransparency = 1
    image.Image = img

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1, -20, 0, 28)
    title.Position = UDim2.new(0, 10, 0.6, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = name

    local descLabel = Instance.new("TextLabel", card)
    descLabel.Size = UDim2.new(1, -20, 0.3, 0)
    descLabel.Position = UDim2.new(0, 10, 0.75, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 14
    descLabel.TextColor3 = Color3.fromRGB(200,200,200)
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.Text = desc

    image.MouseButton1Click:Connect(callback)
end

-- Danh sách game / link
createCard("Pet Simulator 99", "Auto Farm, Dupe Pets...", "rbxassetid://103879354899468", function()
    game.StarterGui:SetCore("SendNotification",{Title="Pet Sim 99", Text="Chưa có script!", Duration=3})
end)

createCard("Grow a Garden", "Auto Plant, Auto Sell...", "rbxassetid://110811575269598", function()
    game.StarterGui:SetCore("SendNotification",{Title="Grow a Garden", Text="Chưa có script!", Duration=3})
end)

createCard("Murder Mystery 2", "ESP, Auto Farm...", "rbxassetid://120257957010430", function()
    game.StarterGui:SetCore("SendNotification",{Title="MM2", Text="Chưa có script!", Duration=3})
end)

createCard("Blade Ball", "Auto Parry, Skin Changer...", "rbxassetid://127537802436978", function()
    game.StarterGui:SetCore("SendNotification",{Title="Blade Ball", Text="Sub menu chưa viết!", Duration=3})
end)

createCard("Discord", "Join Discord để nhận script mới!", "rbxassetid://80637427855653", function()
    openLink("https://discord.gg/fkDMHngGCk")
end)

createCard("YouTube", "Sub kênh gần 3k subs để ủng hộ!", "rbxassetid://95429734677601", function()
    openLink("https://www.youtube.com/@user-qe3dv7iy2j")
end)

-- Nút social dưới cùng
local function createSocialBtn(xScale, text, color3, link, iconAsset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.Position = UDim2.new(xScale, -100, 0.9, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.Text = ""
    btn.Parent = hubGui

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = color3
    stroke.Thickness = 2

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0,32,0,32)
    icon.Position = UDim2.new(0,10,0.5,-16)
    icon.BackgroundTransparency = 1
    icon.Image = iconAsset

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1,-50,1,0)
    lbl.Position = UDim2.new(0,50,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 18
    lbl.TextColor3 = color3
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = text

    btn.MouseButton1Click:Connect(function()
        openLink(link)
    end)
end

createSocialBtn(0.25, "Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
createSocialBtn(0.75, "YouTube", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")

-- Thông báo cuối
local note = Instance.new("TextLabel")
note.Size = UDim2.new(1,0,0,30)
note.Position = UDim2.new(0,0,0.85,0)
note.BackgroundTransparency = 1
note.Font = Enum.Font.GothamBold
note.TextSize = 16
note.TextColor3 = Color3.fromRGB(255,255,150)
note.Text = "👉 Muốn thêm script game khác? Hãy sub kênh + join Discord!"
note.Parent = hubGui
