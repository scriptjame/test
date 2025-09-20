local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- chạy script chính NGAY LẬP TỨC
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bbnew/refs/heads/main/V2.lua"))()
end)

-- xoá hub cũ nếu có
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- tạo hub gui
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.IgnoreGuiInset = true

-- helper mở link / copy
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

-- nền duy nhất phủ tất cả menu
local backgroundFrame = Instance.new("Frame", hubGui)
backgroundFrame.Size = UDim2.new(1, -40, 0.78, 0)
backgroundFrame.Position = UDim2.new(0, 20, 0.06, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
backgroundFrame.BackgroundTransparency = 1 -- fade-in start
backgroundFrame.BorderSizePixel = 0
Instance.new("UICorner", backgroundFrame).CornerRadius = UDim.new(0,12)

-- container chính
local container = Instance.new("Frame", backgroundFrame)
container.Size = UDim2.new(1, 0, 1, 0)
container.Position = UDim2.new(0, 0, 0, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0.25, 0, 0.3, 0)
grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

-- Chữ vàng thông báo
local infoLabel = Instance.new("TextLabel", hubGui)
infoLabel.Size = UDim2.new(0.6,0,0,30)
infoLabel.Position = UDim2.new(0.2,0,0.6,0)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextSize = 18
infoLabel.TextColor3 = Color3.fromRGB(255, 221, 0)
infoLabel.Text = "Join my Discord to get scripts for other games"
infoLabel.TextStrokeTransparency = 0.5
infoLabel.TextXAlignment = Enum.TextXAlignment.Center
infoLabel.TextYAlignment = Enum.TextYAlignment.Center
infoLabel.ZIndex = 10
infoLabel.TextTransparency = 1 -- fade-in start

-- ✨ Thêm quảng bá TikTok (click được)
local tiktokLabel = Instance.new("TextButton", hubGui)
tiktokLabel.Size = UDim2.new(0.6,0,0,30)
tiktokLabel.Position = UDim2.new(0.2,0,0.65,0)
tiktokLabel.BackgroundTransparency = 1
tiktokLabel.Font = Enum.Font.GothamBold
tiktokLabel.TextSize = 20
tiktokLabel.TextColor3 = Color3.fromRGB(255, 0, 100)
tiktokLabel.Text = "Follow my TikTok: @evenher6"
tiktokLabel.TextStrokeTransparency = 0.5
tiktokLabel.TextXAlignment = Enum.TextXAlignment.Center
tiktokLabel.TextYAlignment = Enum.TextYAlignment.Center
tiktokLabel.ZIndex = 10
tiktokLabel.TextTransparency = 0

-- Hiệu ứng đổi màu TikTok
task.spawn(function()
    local hue = 0
    while tiktokLabel.Parent do
        hue = (hue + 1) % 360
        tiktokLabel.TextColor3 = Color3.fromHSV(hue/360, 0.8, 1)
        task.wait(0.05)
    end
end)

-- Click để mở/copy TikTok
tiktokLabel.MouseButton1Click:Connect(function()
    openLink("https://www.tiktok.com/@evenher6?is_from_webapp=1&sender_device=pc")
end)

-- Fade-in background + text
TweenService:Create(backgroundFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
TweenService:Create(infoLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()

-- loading helper
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

-- Blade Ball menu phụ
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

    local btnContainer = Instance.new("Frame", frame)
    btnContainer.Size = UDim2.new(1, 0, 1, -60)
    btnContainer.Position = UDim2.new(0, 0, 0, 50)
    btnContainer.BackgroundTransparency = 1

    local list = Instance.new("UIListLayout", btnContainer)
    list.Padding = UDim.new(0,10)
    list.FillDirection = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Top
    list.SortOrder = Enum.SortOrder.LayoutOrder

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local newH = list.AbsoluteContentSize.Y + 80
        if newH < 160 then newH = 160 end
        if newH > 720 then newH = 720 end
        frame.Size = UDim2.new(0, 480, 0, newH)
        frame.AnchorPoint = Vector2.new(0.5,0.5)
        frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    end)

    local function createScriptBtn(text, url, mode)
        local btn = Instance.new("TextButton", btnContainer)
        btn.Size = UDim2.new(0.9,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = "Script - "..text
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        local strokeBtn = Instance.new("UIStroke", btn)
        strokeBtn.Color = Color3.fromRGB(180,180,180)
        strokeBtn.Thickness = 1

        if mode == "premium" then
            task.spawn(function()
                local hue = 0
                while btn.Parent do
                    hue = (hue + 2) % 360
                    btn.BackgroundColor3 = Color3.fromHSV(hue/360, 0.8, 0.9)
                    task.wait(0.05)
                end
            end)
        end

        -- Hover animation
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.92,0,0,52)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9,0,0,50)}):Play()
        end)

        btn.MouseButton1Click:Connect(function()
            subGui.Enabled = false
            showLoading(3, function()
                local ok, err = pcall(function()
                    if mode == "premium" then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = text,
                            Text = "Follow my TikTok @evenher6 and stay tuned!",
                            Duration = 4
                        })
                    else
                        loadstring(game:HttpGet(url))()
                    end
                end)
                if not ok then warn("⚠️ Script lỗi:", err) end
                subGui:Destroy()
                hubGui.Enabled = true
            end)
        end)
    end

    -- ✅ Menu Scripts
    createScriptBtn("Sinaloa Hub", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
    createScriptBtn("RX Hub", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
    createScriptBtn("Makzinn Hub", "https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
    createScriptBtn("Allusive", nil, "premium")
    createScriptBtn("UwU", nil, "premium")

    -- 🔥 Nút quảng bá TikTok trong menu Blade Ball
    local tiktokBtn = Instance.new("TextButton", btnContainer)
    tiktokBtn.Size = UDim2.new(0.9,0,0,50)
    tiktokBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    tiktokBtn.Font = Enum.Font.GothamBold
    tiktokBtn.TextSize = 18
    tiktokBtn.TextColor3 = Color3.fromRGB(255,0,100)
    tiktokBtn.Text = "🔥 Follow my TikTok: @evenher6"
    Instance.new("UICorner", tiktokBtn).CornerRadius = UDim.new(0,8)

    task.spawn(function()
        local hue = 0
        while tiktokBtn.Parent do
            hue = (hue + 2) % 360
            tiktokBtn.TextColor3 = Color3.fromHSV(hue/360, 0.9, 1)
            task.wait(0.05)
        end
    end)

    tiktokBtn.MouseButton1Click:Connect(function()
        openLink("https://www.tiktok.com/@evenher6?is_from_webapp=1&sender_device=pc")
    end)

    local backBtn = Instance.new("TextButton", btnContainer)
    backBtn.Size = UDim2.new(0.9,0,0,40)
    backBtn.BackgroundColor3 = Color3.fromRGB(50,0,0)
    backBtn.Font = Enum.Font.GothamBold
    backBtn.TextSize = 16
    backBtn.TextColor3 = Color3.fromRGB(255,255,255)
    backBtn.Text = "← Back"
    Instance.new("UICorner", backBtn).CornerRadius = UDim.new(0,8)
    backBtn.MouseEnter:Connect(function()
        TweenService:Create(backBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.92,0,0,42)}):Play()
    end)
    backBtn.MouseLeave:Connect(function()
        TweenService:Create(backBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9,0,0,40)}):Play()
    end)
    backBtn.MouseButton1Click:Connect(function()
        subGui:Destroy()
        hubGui.Enabled = true
    end)

    -- Open animation Blade Ball menu
    frame.Size = frame.Size * 0.8
    frame.BackgroundTransparency = 1
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,480,0,360), BackgroundTransparency = 0}):Play()
end

-- DANH SÁCH GAME
local games = {
    { name = "Discord", desc = "Join our Discord community!", img = "rbxassetid://80637427855653", openFn = function() openLink("https://discord.gg/fkDMHngGCk") end },
    { name = "YouTube", desc = "Subscribe for more scripts!", img = "rbxassetid://95429734677601", openFn = function() openLink("https://www.youtube.com/@user-qe3dv7iy2j") end },
    { name = "Pet Simulator 99", desc = "Script Auto Farm, Dupe Pets, Unlock Areas...", img = "rbxassetid://103879354899468", openFn = function() game.StarterGui:SetCore("SendNotification", {Title="Pet Sim 99", Text="No script attached yet!", Duration=3}) end },
    { name = "Grow a Garden", desc = "Script Auto Plant, Auto Sell, Auto Upgrade...", img = "rbxassetid://110811575269598", openFn = function() game.StarterGui:SetCore("SendNotification", {Title="Grow a Garden", Text="No script attached yet!", Duration=3}) end },
    { name = "Murder Mystery 2", desc = "Script ESP, Auto Farm, Knife Aura...", img = "rbxassetid://120257957010430", openFn = function() game.StarterGui:SetCore("SendNotification", {Title="MM2", Text="No script attached yet!", Duration=3}) end },
    { name = "Blade Ball", desc = "Auto Parry no miss, Changer Skin, Dupe...", img = "rbxassetid://105164345050378", openFn = function() openBladeBallMenu() end },
}

-- tạo card game
for _, g in ipairs(games) do
    local card = Instance.new("TextButton", container)
    card.Size = UDim2.new(0,180,0,220)
    card.BackgroundColor3 = Color3.fromRGB(30,30,30)
    card.Text = ""
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,12)
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = Color3.fromRGB(80,80,80)
    stroke.Thickness = 2
    card.SizeConstraint = Enum.SizeConstraint.RelativeYY
    card.AutomaticSize = Enum.AutomaticSize.None

    local img = Instance.new("ImageLabel", card)
    img.Size = UDim2.new(1,-20,0.6,0)
    img.Position = UDim2.new(0,10,0,10)
    img.BackgroundTransparency = 1
    img.Image = g.img
    img.ScaleType = Enum.ScaleType.Fit
    Instance.new("UICorner", img).CornerRadius = UDim.new(0,10)

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1,-20,0,25)
    title.Position = UDim2.new(0,10,0.65,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = g.name
    title.TextXAlignment = Enum.TextXAlignment.Left

    local desc = Instance.new("TextLabel", card)
    desc.Size = UDim2.new(1,-20,0,50)
    desc.Position = UDim2.new(0,10,0.8,0)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 14
    desc.TextColor3 = Color3.fromRGB(180,180,180)
    desc.TextWrapped = true
    desc.Text = g.desc
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextYAlignment = Enum.TextYAlignment.Top

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,185,0,225)}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,180,0,220)}):Play()
    end)

    card.MouseButton1Click:Connect(function() g.openFn() end)
end

-- Nút ẩn/hiện hub
local toggleBtn = Instance.new("TextButton", hubGui)
toggleBtn.Size = UDim2.new(0,40,0,40)
toggleBtn.Position = UDim2.new(0,10,0,10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 20
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Text = "+"
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1,0)

toggleBtn.MouseButton1Click:Connect(function()
    hubGui.Enabled = not hubGui.Enabled
end)
