-- Main hub (đã chỉnh: Blade Ball về như cũ, note vàng giữa, nút ẩn/hiện ngoài trên Discord)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- chạy script chính NGAY LẬP TỨC (giữ nguyên cách bạn dùng)
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- xóa hub cũ nếu có
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- ScreenGui chính (có thể ẩn/bật bằng nút bên ngoài)
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.IgnoreGuiInset = true

-- Toggle GUI (nút ẩn/hiện) -- đặt ngoài hubGui để luôn còn nút khi hubGui.Enabled = false
local toggleGui = Instance.new("ScreenGui", playerGui)
toggleGui.Name = "MainMenu_Toggle"
toggleGui.ResetOnSpawn = false
toggleGui.IgnoreGuiInset = true

local toggleBtn = Instance.new("TextButton", toggleGui)
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0, 44, 0, 44)
toggleBtn.AnchorPoint = Vector2.new(0.5, 0.5)
-- vị trí: khoảng trên cùng, hơi về bên trái (trên Discord card)
toggleBtn.Position = UDim2.new(0.14, 0, 0.08, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 24
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)

toggleBtn.MouseButton1Click:Connect(function()
    hubGui.Enabled = not hubGui.Enabled
end)

-- helper mở link
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
        Text = copied and "Link copied!" or "Copy manually: "..url,
        Duration = 5
    })
    warn("Link:", url)
end

-- loading GUI (tạm)
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
            pcall(function()
                bar:TweenSize(UDim2.new(pct,0,1,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, stepTime, true)
            end)
            title.Text = phrases[math.random(1, #phrases)]
            task.wait(stepTime)
        end
        gui:Destroy()
        if onDone then onDone() end
    end)
end

-- container chính
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(1, -40, 0.78, 0)
container.Position = UDim2.new(0, 20, 0.06, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
-- responsive cell size (phù hợp PC + Mobile)
grid.CellSize = UDim2.new(0.25, 0, 0.30, 0)
grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

-- Blade Ball menu (trả về như cũ, chạy lại script chính cho Allusive/UwU, và ẩn hub khi xong)
local function openBladeBallMenu()
    hubGui.Enabled = false
    local subGui = Instance.new("ScreenGui", playerGui)
    subGui.Name = "BladeBallMenu"
    subGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", subGui)
    frame.Size = UDim2.new(0, 480, 0, 360)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(200,200,200)
    stroke.Thickness = 2

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -40, 0, 40)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Gotham
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(230,230,230)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "Blade Ball Scripts"

    local list = Instance.new("UIListLayout", frame)
    list.Padding = UDim.new(0,10)
    list.FillDirection = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Top
    list.SortOrder = Enum.SortOrder.LayoutOrder

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
                    warn("BladeBall script failed:", err)
                end
                -- destroy sub menu và ẩn hub chính (để không che tầm nhìn)
                if subGui and subGui.Parent then
                    pcall(function() subGui:Destroy() end)
                end
                hubGui.Enabled = false
            end)
        end)
    end

    local function createPremiumBtn(text, theme)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.9,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextStrokeTransparency = 0.2
        btn.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        btn.Text = "Script - "..text
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        local gradient = Instance.new("UIGradient", btn)
        if theme == "Allusive" then
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(200,0,255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160,60,255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(220,140,255))
            }
        elseif theme == "UwU" then
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255,120,180)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,170,220)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255,100,160))
            }
        end
        gradient.Rotation = 0

        task.spawn(function()
            while btn.Parent do
                gradient.Rotation = (gradient.Rotation + 1) % 360
                task.wait(0.05)
            end
        end)

        btn.MouseButton1Click:Connect(function()
            -- thông báo "Coming Soon" + chạy script chính của bạn
            game.StarterGui:SetCore("SendNotification", {
                Title = text,
                Text = "Coming soon",
                Duration = 3
            })
            subGui.Enabled = false
            showLoading(3, function()
                local ok, err = pcall(function()
                    -- chạy script chính của bạn
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
                end)
                if not ok then warn("BladeBall (premium) lỗi:", err) end
                -- destroy sub menu và ẩn hub chính để tránh che tầm nhìn
                if subGui and subGui.Parent then
                    pcall(function() subGui:Destroy() end)
                end
                hubGui.Enabled = false
            end)
        end)
    end

    -- các script trong Blade Ball (giữ nguyên tên và hành vi như trước)
    createScriptBtn("Argon Hub X", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
    createScriptBtn("Sinaloa Hub", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
    createScriptBtn("RX Hub", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
    createPremiumBtn("Allusive", "Allusive")
    createPremiumBtn("UwU", "UwU")

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

-- danh sách game + Discord + YouTube (giữ 2 GUI lớn Discord + YouTube)
local games = {
    {
        name = "Discord",
        desc = "Join our Discord community!",
        img = "rbxassetid://80637427855653",
        openFn = function() openLink("https://discord.gg/fkDMHngGCk") end
    },
    {
        name = "YouTube",
        desc = "Subscribe for more scripts!",
        img = "rbxassetid://95429734677601",
        openFn = function() openLink("https://www.youtube.com/@user-qe3dv7iy2j") end
    },
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
        openFn = openBladeBallMenu
    }
}

-- tạo các card trong grid
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
    sizeLimit.MaxSize = Vector2.new(420, 340) -- giới hạn to hơn một chút cho mobile lớn
end

-- Thông báo vàng (đặt giữa màn hình khoảng giữa hàng 1 và hàng 2, không chạm GUI)
local note = Instance.new("TextLabel", hubGui)
note.AnchorPoint = Vector2.new(0.5, 0.5)
-- vị trí: ở giữa ngang, giữa hai hàng (dưới YouTube, trên Murder Mystery 2)
note.Position = UDim2.new(0.5, 0, 0.36, 0)
note.Size = UDim2.new(0.6, 0, 0, 36)
note.BackgroundTransparency = 1
note.Font = Enum.Font.GothamBold
note.TextSize = 16
note.TextColor3 = Color3.fromRGB(255,255,100)
note.Text = "If you want scripts for other games, please subscribe to the channel and join the Discord group!"
note.TextWrapped = true
note.ZIndex = 50

-- đảm bảo toggle luôn phía trên (nếu muốn thay đổi vị trí, chỉnh toggleBtn.Position)
toggleGui.Enabled = true
hubGui.Enabled = true
