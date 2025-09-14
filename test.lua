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

-- helper mở link (ép buộc có thông báo)
local function openLink(url)
    local copied = false
    if setclipboard then
        pcall(setclipboard, url)
        copied = true
    end
    if type(openbrowser) == "function" then
        pcall(openbrowser, url)
        copied = true
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Link",
        Text = copied and "Đã sao chép link, hãy dán vào trình duyệt!" or "Không thể sao chép, copy thủ công: "..url,
        Duration = 5
    })
    warn("Link:", url)
end

-- loading GUI
local function showLoading(durationSeconds, onDone)
    durationSeconds = durationSeconds or 5
    local gui = Instance.new("ScreenGui", playerGui)
    gui.Name = "Hub_LoadingGui"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0.46, 0, 0.14, 0)
    frame.Position = UDim2.new(0.27, 0, 0.42, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(120, 120, 255)
    stroke.Thickness = 2

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -20, 0.45, 0)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = "Preparing script..."
    title.TextXAlignment = Enum.TextXAlignment.Center

    local barBG = Instance.new("Frame", frame)
    barBG.Size = UDim2.new(0.9, 0, 0.28, 0)
    barBG.Position = UDim2.new(0.05, 0, 0.55, 0)
    barBG.BackgroundColor3 = Color3.fromRGB(45,45,45)
    barBG.BorderSizePixel = 0
    Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 8)

    local bar = Instance.new("Frame", barBG)
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(120, 120, 255)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 8)

    local phrases = {
        "Injecting magic modules...",
        "Optimizing local hooks...",
        "Calibrating anti-miss...",
        "Loading GUI components...",
        "Almost ready — hold on..."
    }
    local steps = 100
    local stepTime = durationSeconds / steps

    task.spawn(function()
        for i = 1, steps do
            local pct = i/steps
            bar:TweenSize(UDim2.new(pct,0,1,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, stepTime, true)
            title.Text = phrases[math.random(1, #phrases)]
            task.wait(stepTime)
        end
        gui:Destroy()
        if onDone then onDone() end
    end)
end

-- container chính
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(1, -60, 0.78, 0)
container.Position = UDim2.new(0, 30, 0.06, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0, 300, 0, 240)
grid.CellPadding = UDim2.new(0, 18, 0, 18)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

-- Blade Ball menu phụ
local function openBladeBallMenu()
    hubGui.Enabled = false
    local subGui = Instance.new("ScreenGui", playerGui)
    subGui.Name = "BladeBallMenu"
    subGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", subGui)
    frame.Size = UDim2.new(0, 480, 0, 360)
    frame.Position = UDim2.new(0.5, -240, 0.5, -180)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(200,200,200)
    stroke.Thickness = 2

    local icon = Instance.new("ImageLabel", frame)
    icon.Size = UDim2.new(0,28,0,28)
    icon.Position = UDim2.new(0,10,0,6)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://127537802436978"

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -40, 0, 40)
    title.Position = UDim2.new(0, 40, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Gotham
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(230,230,230)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "All Game Scripts"

    local list = Instance.new("UIListLayout", frame)
    list.FillDirection = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Top
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0,10)
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        frame.Size = UDim2.new(0,480,0,list.AbsoluteContentSize.Y+60)
    end)

    local function createScriptBtn(text, url)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.9,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = "Script - "..text
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(180,180,180)
        stroke.Thickness = 1

        btn.MouseButton1Click:Connect(function()
            subGui.Enabled = false
            showLoading(5, function()
                local ok, err = pcall(function()
                    loadstring(game:HttpGet(url))()
                end)
                if not ok then
                    warn("Script failed:", err)
                end
                subGui.Enabled = true
            end)
        end)
    end

    createScriptBtn("AUTO PARRY SUPPORT FOR HIGH PING", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
    createScriptBtn("AUTO PARRY, Unlock All Sword, Explosion, Emote", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
    createScriptBtn("AUTO PARRY, Spam – I Think U Like ❤️", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")

    local backBtn = Instance.new("TextButton", frame)
    backBtn.Size = UDim2.new(0.9,0,0,40)
    backBtn.BackgroundColor3 = Color3.fromRGB(50,0,0)
    backBtn.Font = Enum.Font.GothamBold
    backBtn.TextSize = 16
    backBtn.TextColor3 = Color3.fromRGB(255,255,255)
    backBtn.Text = "← Back"
    Instance.new("UICorner", backBtn).CornerRadius = UDim.new(0,8)

    backBtn.MouseButton1Click:Connect(function()
        subGui:Destroy()
        hubGui.Enabled = true
    end)
end

-- Tạo 1 nút chính cho mọi game
local card = Instance.new("Frame", container)
card.BackgroundColor3 = Color3.fromRGB(24,24,24)
card.Size = UDim2.new(0, 300, 0, 240)
Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

local img = Instance.new("ImageButton", card)
img.Size = UDim2.new(1,0,0.62,0)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://127537802436978"

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1,-18,0,30)
title.Position = UDim2.new(0,10,0.64,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "All Game Scripts"

local desc = Instance.new("TextLabel", card)
desc.Size = UDim2.new(1,-18,0,54)
desc.Position = UDim2.new(0,10,0.74,0)
desc.BackgroundTransparency = 1
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextColor3 = Color3.fromRGB(190,190,190)
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.Text = "Universal hub for all games."

img.MouseButton1Click:Connect(openBladeBallMenu)

-- Social buttons
local function createSocialBtn(xScale, text, color3, link, iconAsset)
    local btn = Instance.new("TextButton", hubGui)
    btn.Size = UDim2.new(0, 220, 0, 54)
    btn.Position = UDim2.new(xScale, -110, 0.9, 0)
    btn.BackgroundColor3 = Color3.fromRGB(10,10,10)
    btn.BorderSizePixel = 0
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = color3
    stroke.Thickness = 3

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0,36,0,36)
    icon.Position = UDim2.new(0,12,0.5,-18)
    icon.BackgroundTransparency = 1
    icon.Image = iconAsset

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1,-70,1,0)
    lbl.Position = UDim2.new(0,60,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 20
    lbl.TextColor3 = color3
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = text

    btn.MouseButton1Click:Connect(function()
        openLink(link)
    end)
end

createSocialBtn(0.25, "Join Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
createSocialBtn(0.75, "Subscribe", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")
