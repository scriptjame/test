local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- auto chạy script chính khi mở menu
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
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
container.Size = UDim2.new(1, -40, 0.78, 0)
container.Position = UDim2.new(0, 20, 0.06, 0)
container.BackgroundTransparency = 1

-- layout để tự căn cho PC & mobile
local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0.25, 0, 0.28, 0) -- tự co theo màn hình
grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 3 -- 3 cột (PC rộng, mobile thì dồn xuống)

-- danh sách game
local games = {
    {
        name = "Pet Simulator 99",
        desc = "Script Auto Farm, Dupe Pets, Unlock Areas...",
        img = "rbxassetid://103879354899468",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Pet Sim 99", Text="No script yet!", Duration=3})
        end
    },
    {
        name = "Grow a Garden",
        desc = "Script Auto Plant, Auto Sell, Auto Upgrade...",
        img = "rbxassetid://110811575269598",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Grow a Garden", Text="No script yet!", Duration=3})
        end
    },
    {
        name = "Murder Mystery 2",
        desc = "Script ESP, Auto Farm, Knife Aura...",
        img = "rbxassetid://120257957010430",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="MM2", Text="No script yet!", Duration=3})
        end
    },
    {
        name = "Blade Ball",
        desc = "Auto Parry no miss, Changer Skin, Dupe...",
        img = "rbxassetid://127537802436978",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Blade Ball", Text="Coming soon...", Duration=3})
        end
    }
}

-- tạo card game
for _, info in ipairs(games) do
    local card = Instance.new("Frame", container)
    card.BackgroundColor3 = Color3.fromRGB(24,24,24)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local img = Instance.new("ImageButton", card)
    img.Size = UDim2.new(1,0,0.62,0)
    img.BackgroundTransparency = 1
    img.Image = info.img

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1,-18,0,30)
    title.Position = UDim2.new(0,10,0.64,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = info.name

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

    img.MouseButton1Click:Connect(info.openFn)

    local sizeLimit = Instance.new("UISizeConstraint", card)
    sizeLimit.MinSize = Vector2.new(160, 120)
    sizeLimit.MaxSize = Vector2.new(320, 260)
end

-- Thông báo cuối cùng
local note = Instance.new("TextLabel", hubGui)
note.Size = UDim2.new(1,0,0,30)
note.Position = UDim2.new(0,0,0.88,0)
note.BackgroundTransparency = 1
note.Font = Enum.Font.GothamBold
note.TextSize = 18
note.TextColor3 = Color3.fromRGB(255,255,100)
note.Text = "Subscribe & Join Discord for more updates!"
