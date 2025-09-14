-- MENU SCRIPT HUB (không phụ thuộc game)
-- Tác giả: tuỳ chỉnh theo yêu cầu của bạn

if getgenv().GameHubLoaded then
    warn("⚠️ Hub đã chạy rồi!")
    return
end
getgenv().GameHubLoaded = true

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xoá menu cũ nếu tồn tại
local old = playerGui:FindFirstChild("GameHubUI")
if old then old:Destroy() end

-- Tạo GUI chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GameHubUI"
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Text = "🌐 UNIVERSAL SCRIPT HUB"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

-- Khung danh sách game
local GameList = Instance.new("Frame")
GameList.Size = UDim2.new(1, -20, 1, -120)
GameList.Position = UDim2.new(0, 10, 0, 60)
GameList.BackgroundTransparency = 1
GameList.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout", GameList)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Danh sách game + script
local Games = {
    {
        Name = "Pet 99",
        Desc = "Script Auto Farm, Unlock Pet, Fast Hatch...",
        Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/yourlink/pet99.lua"))()'
    },
    {
        Name = "Grow A Garden",
        Desc = "Script Auto Plant, Auto Water, Unlock Tools...",
        Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/yourlink/gag.lua"))()'
    },
    {
        Name = "Murder Mystery 2",
        Desc = "Script ESP, Aimbot, Auto Win...",
        Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/yourlink/mm2.lua"))()'
    },
    {
        Name = "Blade Ball",
        Desc = "Script Auto Parry, Unlock Sword, Emote...",
        -- Bạn có thể thêm nhiều script phụ trong 1 bảng con sau này
        Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua"))()'
    }
}

-- Hàm tạo nút game
local function CreateGameButton(gameData)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -20, 0, 60)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Text = ""
    Btn.Parent = GameList

    local UICorner = Instance.new("UICorner", Btn)
    UICorner.CornerRadius = UDim.new(0, 8)

    -- Tên game
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Text = gameData.Name
    NameLabel.Size = UDim2.new(1, -10, 0, 25)
    NameLabel.Position = UDim2.new(0, 5, 0, 2)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 20
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Btn

    -- Mô tả
    local Desc = Instance.new("TextLabel")
    Desc.Text = gameData.Desc
    Desc.Size = UDim2.new(1, -10, 0, 25)
    Desc.Position = UDim2.new(0, 5, 0, 30)
    Desc.BackgroundTransparency = 1
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 14
    Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.Parent = Btn

    -- Khi nhấn vào game
    Btn.MouseButton1Click:Connect(function()
        -- Loading GUI
        local LoadingFrame = Instance.new("Frame")
        LoadingFrame.Size = UDim2.new(0, 300, 0, 120)
        LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
        LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        LoadingFrame.BorderSizePixel = 0
        LoadingFrame.Parent = ScreenGui
        Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)

        local LoadingLabel = Instance.new("TextLabel")
        LoadingLabel.Text = "Đang tải script..."
        LoadingLabel.Size = UDim2.new(1, 0, 0, 40)
        LoadingLabel.Position = UDim2.new(0, 0, 0, 10)
        LoadingLabel.BackgroundTransparency = 1
        LoadingLabel.Font = Enum.Font.GothamBold
        LoadingLabel.TextSize = 18
        LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoadingLabel.Parent = LoadingFrame

        local BarBg = Instance.new("Frame")
        BarBg.Size = UDim2.new(1, -40, 0, 20)
        BarBg.Position = UDim2.new(0, 20, 0.7, 0)
        BarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        BarBg.BorderSizePixel = 0
        BarBg.Parent = LoadingFrame
        Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 10)

        local BarFill = Instance.new("Frame")
        BarFill.Size = UDim2.new(0, 0, 1, 0)
        BarFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        BarFill.BorderSizePixel = 0
        BarFill.Parent = BarBg
        Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 10)

        -- Animation loading
        spawn(function()
            for i = 1, 100 do
                BarFill.Size = UDim2.new(i/100, 0, 1, 0)
                wait(0.05)
            end
            LoadingLabel.Text = "Hoàn tất! Đang mở script..."
            wait(0.5)
            LoadingFrame:Destroy()

            -- Chạy script game
            loadstring(gameData.Script)()
        end)
    end)
end

-- Tạo nút cho từng game
for _, gameData in ipairs(Games) do
    CreateGameButton(gameData)
end

-- Nút Discord
local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0.45, 0, 0, 40)
DiscordBtn.Position = UDim2.new(0.05, 0, 1, -50)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- màu Discord
DiscordBtn.Text = "Join Discord"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 16
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.Parent = MainFrame
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 8)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/fkDMHngGCk")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "📌 Discord",
        Text = "Link đã copy! Dán vào trình duyệt.",
        Duration = 5
    })
end)

-- Nút YouTube
local YoutubeBtn = Instance.new("TextButton")
YoutubeBtn.Size = UDim2.new(0.45, 0, 0, 40)
YoutubeBtn.Position = UDim2.new(0.5, 0, 1, -50)
YoutubeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- màu YouTube
YoutubeBtn.Text = "YouTube Channel"
YoutubeBtn.Font = Enum.Font.GothamBold
YoutubeBtn.TextSize = 16
YoutubeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YoutubeBtn.Parent = MainFrame
Instance.new("UICorner", YoutubeBtn).CornerRadius = UDim.new(0, 8)

YoutubeBtn.MouseButton1Click:Connect(function()
    setclipboard("https://www.youtube.com/@user-qe3dv7iy2j")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "📌 YouTube",
        Text = "Link đã copy! Dán vào trình duyệt.",
        Duration = 5
    })
end)
