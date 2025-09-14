-- Multi-Game Hub
--  - Preload BladeBall script khi hub mở
--  - Khi click Blade Ball: show loading (5s) -> run Loader.lua
--  - Social buttons: try open in executor, else copy to clipboard + notify

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === URLs (the ones bạn yêu cầu) ===
local PRELOAD_URL  = "https://raw.githubusercontent.com/scriptjame/test2/refs/heads/main/bladeball.lua"   -- chạy ngay khi hub mở
local CLICK_LOAD_URL = "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua"             -- chạy khi bấm vào Blade Ball

-- ===== helper: try open link (executor-friendly), else copy + notify =====
local function openLink(url)
    local opened = false

    -- try common direct-open functions used by some executors
    if type(openbrowser) == "function" then
        pcall(openbrowser, url); opened = true
    end

    if not opened and type(syn) == "table" then
        -- some executors have syn.open_url or syn.open_url; try a few options defensively
        if type(syn.open_url) == "function" then pcall(syn.open_url, url); opened = true end
        if not opened and type(syn.request) == "function" then
            -- syn.request won't open the browser, but try it (some custom runtimes may handle)
            pcall(syn.request, {Url = url, Method = "GET"}); -- doesn't guarantee open
        end
    end

    if not opened and type(request) == "function" then
        pcall(request, {Url = url, Method = "GET"})
    end

    -- If any of above "opened" we still show notification to user
    if opened then
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Opened link",
                Text = "Link đã được mở bởi executor (nếu có).",
                Duration = 4
            })
        end)
        return true
    end

    -- fallback: copy to clipboard if possible
    if setclipboard then
        pcall(setclipboard, url)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Link đã được sao chép",
                Text = "Dán (Ctrl+V) vào trình duyệt để mở: "..url,
                Duration = 5
            })
        end)
        return true
    end

    -- cuối cùng: không thể mở hoặc copy
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Không thể mở/copy link",
            Text = "Trình client hiện tại không hỗ trợ mở link tự động hoặc copy.",
            Duration = 5
        })
    end)
    return false
end

-- ===== helper: loading UI (duration seconds, callback khi xong) =====
local function showLoading(durationSeconds, onDone)
    durationSeconds = durationSeconds or 5
    local gui = Instance.new("ScreenGui")
    gui.Name = "Hub_LoadingGui"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0.46, 0, 0.14, 0)
    frame.Position = UDim2.new(0.27, 0, 0.42, 0)
    frame.AnchorPoint = Vector2.new(0,0)
    frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -20, 0.45, 0)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = "Preparing..."
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.TextYAlignment = Enum.TextYAlignment.Center

    local barBG = Instance.new("Frame", frame)
    barBG.Size = UDim2.new(0.9, 0, 0.28, 0)
    barBG.Position = UDim2.new(0.05, 0, 0.55, 0)
    barBG.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", barBG).CornerRadius = UDim.new(0,8)

    local bar = Instance.new("Frame", barBG)
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(0,200,130)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0,8)

    local phrases = {
        "Injecting modules...",
        "Calibrating anti-miss...",
        "Optimizing local hooks...",
        "Loading GUI assets...",
        "Almost ready — hold on..."
    }

    local steps = 100
    local stepTime = durationSeconds / steps
    spawn(function()
        for i = 1, steps do
            local pct = i/steps
            pcall(function()
                bar:TweenSize(UDim2.new(pct,0,1,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, stepTime, true)
            end)
            title.Text = phrases[math.random(1,#phrases)]
            task.wait(stepTime)
        end
        gui:Destroy()
        if type(onDone) == "function" then
            pcall(onDone)
        end
    end)
end

-- ===== Preload Blade Ball script when hub opens (run immediately) =====
spawn(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet(PRELOAD_URL))()
    end)
    if not ok then
        warn("[Hub] Preload failed:", err)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Preload failed",
                Text = "Không tải được Blade Ball (preload).",
                Duration = 4
            })
        end)
    else
        -- nếu script tạo GUI tên "rutoairas", tắt tạm để hub không bị che:
        for i=1,30 do
            local sg = playerGui:FindFirstChild("rutoairas")
            if sg and sg:IsA("ScreenGui") then
                pcall(function() sg.Enabled = false end)
                break
            end
            task.wait(0.15)
        end
    end
end)

-- ===== Build Hub GUI (cards + social) =====
local function buildHub()
    -- remove old
    local old = playerGui:FindFirstChild("MainMenu")
    if old then old:Destroy() end

    local hubGui = Instance.new("ScreenGui", playerGui)
    hubGui.Name = "MainMenu"
    hubGui.ResetOnSpawn = false
    hubGui.IgnoreGuiInset = true

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

    local games = {
        {
            name = "Pet Simulator 99",
            desc = "Script Auto Farm, Dupe Pets, Unlock Areas...",
            img = "rbxassetid://103879354899468",
            openFn = function()
                game.StarterGui:SetCore("SendNotification", {Title="Pet Sim 99", Text="Script chưa được gắn.", Duration=3})
            end
        },
        {
            name = "Grow a Garden",
            desc = "Script Auto Plant, Auto Sell, Auto Upgrade...",
            img = "rbxassetid://110811575269598",
            openFn = function()
                game.StarterGui:SetCore("SendNotification", {Title="Grow a Garden", Text="Script chưa được gắn.", Duration=3})
            end
        },
        {
            name = "Murder Mystery 2",
            desc = "Script ESP, Auto Farm, Knife Aura...",
            img = "rbxassetid://120257957010430",
            openFn = function()
                game.StarterGui:SetCore("SendNotification", {Title="MM2", Text="Script chưa được gắn.", Duration=3})
            end
        },
        {
            name = "Blade Ball",
            desc = "Script Auto Parry no miss, Changer Skin, Dupe...",
            img = "rbxassetid://127537802436978",
            openFn = function()
                -- khi click Blade Ball: show loading 5s rồi chạy LOADER script (AgentX771)
                showLoading(5, function()
                    -- ẩn hub trước khi chạy loader
                    pcall(function() hubGui.Enabled = false end)
                    local ok, err = pcall(function()
                        loadstring(game:HttpGet(CLICK_LOAD_URL))()
                    end)
                    if not ok then
                        pcall(function()
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Loader failed",
                                Text = "Không chạy được loader: "..tostring(err),
                                Duration = 5
                            })
                        end)
                        -- nếu lỗi, show hub lại
                        pcall(function() hubGui.Enabled = true end)
                    end
                end)
            end
        }
    }

    for _, info in ipairs(games) do
        local card = Instance.new("Frame", container)
        card.BackgroundColor3 = Color3.fromRGB(24,24,24)
        card.Size = UDim2.new(0, 300, 0, 240)
        Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

        local img = Instance.new("ImageButton", card)
        img.Size = UDim2.new(1,0,0.62,0)
        img.BackgroundTransparency = 1
        img.Image = info.img
        img.AutoButtonColor = true
        img.Parent = card

        local title = Instance.new("TextLabel", card)
        title.Size = UDim2.new(1,-18,0,30)
        title.Position = UDim2.new(0,10,0.64,0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 20
        title.TextColor3 = Color3.fromRGB(255,255,255)
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Text = info.name
        title.Parent = card

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
        desc.Parent = card

        -- hover feedback
        img.MouseEnter:Connect(function()
            pcall(function()
                TweenService:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(36,36,36)}):Play()
            end)
        end)
        img.MouseLeave:Connect(function()
            pcall(function()
                TweenService:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(24,24,24)}):Play()
            end)
        end)

        -- click -> call openFn
        img.MouseButton1Click:Connect(info.openFn)
    end

    -- Social buttons builder
    local function createSocialBtn(xScale, text, color3, link, iconAsset)
        local btn = Instance.new("TextButton", hubGui)
        btn.Size = UDim2.new(0, 220, 0, 54)
        btn.Position = UDim2.new(xScale, -110, 0.9, 0)
        btn.BackgroundColor3 = Color3.fromRGB(10,10,10)
        btn.BorderSizePixel = 0
        btn.Text = "" -- remove default
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

    -- Create Discord + YouTube (icons assets used before; đổi nếu cần)
    createSocialBtn(0.25, "Join Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
    createSocialBtn(0.75, "Subscribe", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")
end

-- Build and show the hub
buildHub()
