local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- auto chạy script chính khi mở menu
pcall(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
    end)
    if not ok then
        warn("❌ Script chính không chạy:", err)
    else
        warn("✅ Script chính đã chạy thành công!")
    end
end)

-- xoá hub cũ nếu có
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- tạo hub gui
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.IgnoreGuiInset = true

-- container chính
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(1, -60, 0.78, 0)
container.Position = UDim2.new(0, 30, 0.06, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0.25, 0, 0.3, 0)
grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

-- danh sách game
local games = {
    {
        name = "Pet Simulator 99",
        desc = "Script Auto Farm, Dupe Pets, Unlock Areas...",
        img = "rbxassetid://103879354899468",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Pet Sim 99", Text="No script attached yet!", Duration=3})
        end
    },
    {
        name = "Grow a Garden",
        desc = "Script Auto Plant, Auto Sell, Auto Upgrade...",
        img = "rbxassetid://110811575269598",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Grow a Garden", Text="No script attached yet!", Duration=3})
        end
    },
    {
        name = "Murder Mystery 2",
        desc = "Script ESP, Auto Farm, Knife Aura...",
        img = "rbxassetid://120257957010430",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="MM2", Text="No script attached yet!", Duration=3})
        end
    },
    {
        name = "Blade Ball",
        desc = "Auto Parry no miss, Changer Skin, Dupe...",
        img = "rbxassetid://127537802436978",
        openFn = function()
            -- mở menu blade ball
            game.StarterGui:SetCore("SendNotification", {Title="Blade Ball", Text="Menu scripts here!", Duration=3})
        end
    },
    {
        name = "Discord",
        desc = "Join our Discord group for updates and exclusive scripts!",
        img = "rbxassetid://80637427855653",
        openFn = function()
            setclipboard("https://discord.gg/fkDMHngGCk")
            game.StarterGui:SetCore("SendNotification", {Title="Discord", Text="Link copied!", Duration=3})
        end
    },
    {
        name = "YouTube",
        desc = "Subscribe to my channel with almost 3k subs for more scripts!",
        img = "rbxassetid://95429734677601",
        openFn = function()
            setclipboard("https://www.youtube.com/@user-qe3dv7iy2j")
            game.StarterGui:SetCore("SendNotification", {Title="YouTube", Text="Link copied!", Duration=3})
        end
    }
}

for _, info in ipairs(games) do
    local card = Instance.new("Frame", container)
    card.BackgroundColor3 = Color3.fromRGB(24,24,24)
    card.Size = UDim2.new(1, 0, 1, 0)
    card.ZIndex = 1
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local img = Instance.new("ImageButton", card)
    img.Size = UDim2.new(1,0,0.62,0)
    img.BackgroundTransparency = 1
    img.Image = info.img
    img.ZIndex = 2

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1,-18,0,30)
    title.Position = UDim2.new(0,10,0.64,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = info.name
    title.ZIndex = 2

    local desc = Instance.new("TextLabel", card)
    desc.Size = UDim2.new(1,-18,0,54)
    desc.Position = UDim2.new(0,10,0.74,0)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 14
    desc.TextColor3 = Color3.fromRGB(190,190,190)
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Text = info.desc
    desc.ZIndex = 2

    img.MouseButton1Click:Connect(info.openFn)

    local sizeLimit = Instance.new("UISizeConstraint", card)
    sizeLimit.MinSize = Vector2.new(160, 120)
    sizeLimit.MaxSize = Vector2.new(320, 260)
end

-- Nút ẩn/hiện GUI (chữ R)
local toggleBtn = Instance.new("TextButton", playerGui)
toggleBtn.Size = UDim2.new(0,40,0,40)
toggleBtn.Position = UDim2.new(0,10,0.5,-20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.Text = "R"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 20
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)

toggleBtn.MouseButton1Click:Connect(function()
    hubGui.Enabled = not hubGui.Enabled
end)
