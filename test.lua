-- Multi-Game Hub (preload Blade Ball + loading UI + open GUI on click)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- LINK script Blade Ball (the one you gave)
local BLADE_URL = "https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"

-- -------- openLink helper: try to open directly if executor supports, else copy ----------
local function openLink(url)
    -- prefer direct open if executor exposes functions
    local ok
    if type(openbrowser) == "function" then
        pcall(openbrowser, url)
        return
    end
    if type(syn) == "table" and type(syn.request) == "function" then
        pcall(syn.request, {Url = url, Method = "GET"})
        return
    end
    if type(request) == "function" then
        pcall(request, {Url = url, Method = "GET"})
        return
    end
    -- fallback: copy to clipboard + notify
    if setclipboard then
        pcall(setclipboard, url)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Link copied",
                Text = "Đã sao chép link vào clipboard. Paste vào trình duyệt để mở.",
                Duration = 4
            })
        end)
    else
        -- no setclipboard available
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Copy failed",
                Text = "Không thể copy vào clipboard trên client này.",
                Duration = 4
            })
        end)
    end
end

-- -------- showLoading: progress bar ~5s, no percent text, rotating phrases ----------
local function showLoading(durationSeconds, parentGui, onDone)
    durationSeconds = durationSeconds or 5
    local gui = Instance.new("ScreenGui")
    gui.Name = "Hub_LoadingGui"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0.46, 0, 0.14, 0)
    frame.Position = UDim2.new(0.27, 0, 0.42, 0)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -20, 0.45, 0)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = "Preparing script..."
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.TextYAlignment = Enum.TextYAlignment.Center

    local barBG = Instance.new("Frame", frame)
    barBG.Size = UDim2.new(0.9, 0, 0.28, 0)
    barBG.Position = UDim2.new(0.05, 0, 0.55, 0)
    barBG.BackgroundColor3 = Color3.fromRGB(45,45,45)
    barBG.BorderSizePixel = 0
    Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 8)

    local bar = Instance.new("Frame", barBG)
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 8)

    local phrases = {
        "Injecting magic modules...",
        "Optimizing local hooks...",
        "Calibrating anti-miss...",
        "Loading GUI components...",
        "Almost ready — hold on..."
    }

    -- animate
    local steps = 100
    local stepTime = durationSeconds / steps
    spawn(function()
        for i = 1, steps do
            local pct = i/steps
            -- tween bar size smoothly
            pcall(function()
                bar:TweenSize(UDim2.new(pct,0,1,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, stepTime, true)
            end)
            -- random phrase
            title.Text = phrases[math.random(1, #phrases)]
            task.wait(stepTime)
        end
        gui:Destroy()
        if type(onDone) == "function" then pcall(onDone) end
    end)
end

-- -------- Preload Blade Ball script immediately (when hub runs) ----------
spawn(function()
    local ok, err = pcall(function()
        -- execute the remote script now (preload)
        loadstring(game:HttpGet(BLADE_URL))()
    end)
    if not ok then
        warn("[Hub] Failed to preload Blade Ball script:", err)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Preload failed",
                Text = "Không thể tải Blade Ball script: "..tostring(err),
                Duration = 5
            })
        end)
        return
    end
    -- try to hide the Blade Ball GUI if it created a ScreenGui named "rutoairas"
    -- wait a short time for it to be created, then disable it so hub stays visible
    local start = tick()
    while tick() - start < 6 do
        local sg = playerGui:FindFirstChild("rutoairas")
        if sg and sg:IsA("ScreenGui") then
            -- hide it for now (so hub can show). When user clicks Blade Ball, we'll re-enable
            pcall(function() sg.Enabled = false end)
            break
        end
        task.wait(0.15)
    end
end)

-- -------- Build Hub GUI (cards + social buttons) ----------
-- remove old
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

local hubGui = Instance.new("ScreenGui")
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.Parent = playerGui
hubGui.IgnoreGuiInset = true

local bg = Instance.new("Frame", hubGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundTransparency = 1

-- grid container
local container = Instance.new("Frame", bg)
container.Size = UDim2.new(1, -60, 0.78, 0)
container.Position = UDim2.new(0, 30, 0.06, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0, 300, 0, 240)
grid.CellPadding = UDim2.new(0, 18, 0, 18)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

-- games table (image assetIDs you provided)
local games = {
    {
        id = "PetSim99",
        name = "Pet Simulator 99",
        desc = "Script Auto Farm, Dupe Pets, Unlock Areas...",
        img = "rbxassetid://103879354899468",
        -- no separate script URL provided, we do not load extra script here
        openFn = function()
            -- If the script created its GUI under some name, try to enable it. For blade ball we expect 'rutoairas'.
            -- PetSim's GUI unknown -> notify
            pcall(function()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Not available",
                    Text = "Script Pet Simulator 99 chưa được gắn. Liên hệ để thêm.",
                    Duration = 4
                })
            end)
        end
    },
    {
        id = "GrowGarden",
        name = "Grow a Garden",
        desc = "Script Auto Plant, Auto Sell, Auto Upgrade...",
        img = "rbxassetid://110811575269598",
        openFn = function()
            pcall(function()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Not available",
                    Text = "Script Grow a Garden chưa được gắn.",
                    Duration = 4
                })
            end)
        end
    },
    {
        id = "MM2",
        name = "Murder Mystery 2",
        desc = "Script ESP, Auto Farm, Knife Aura...",
        img = "rbxassetid://120257957010430",
        openFn = function()
            pcall(function()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Not available",
                    Text = "Script MM2 chưa được gắn.",
                    Duration = 4
                })
            end)
        end
    },
    {
        id = "BladeBall",
        name = "Blade Ball",
        desc = "Script Auto Parry no miss, Changer Skin, Dupe...",
        img = "rbxassetid://127537802436978",
        openFn = function()
            -- show the preloaded Blade Ball GUI if present (ScreenGui named "rutoairas")
            local sg = playerGui:FindFirstChild("rutoairas")
            if sg and sg:IsA("ScreenGui") then
                sg.Enabled = true
                -- optional: bring it to front
                sg.Parent = playerGui
            else
                -- fallback: if preloaded failed, try load again then wait for GUI
                local ok, err = pcall(function()
                    loadstring(game:HttpGet(BLADE_URL))()
                end)
                if not ok then
                    pcall(function()
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "Failed",
                            Text = "Không mở được Blade Ball GUI: "..tostring(err),
                            Duration = 5
                        })
                    end)
                else
                    -- try to enable shortly after
                    task.wait(0.5)
                    local sg2 = playerGui:FindFirstChild("rutoairas")
                    if sg2 then sg2.Enabled = true end
                end
            end
        end
    }
}

-- create card UI
for _, info in ipairs(games) do
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 300, 0, 240)
    card.BackgroundColor3 = Color3.fromRGB(24,24,24)
    card.Parent = container
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local img = Instance.new("ImageButton")
    img.Size = UDim2.new(1,0,0.62,0)
    img.Position = UDim2.new(0,0,0,0)
    img.AutoButtonColor = false
    img.BackgroundTransparency = 1
    img.Image = info.img
    img.Parent = card

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -18, 0, 30)
    title.Position = UDim2.new(0, 10, 0.64, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Text = info.name
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -18, 0, 54)
    desc.Position = UDim2.new(0,10,0.74,0)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 14
    desc.TextColor3 = Color3.fromRGB(190,190,190)
    desc.Text = info.desc
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = card

    -- hover effect
    img.MouseEnter:Connect(function()
        pcall(function()
            TweenService:Create(card, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(36,36,36)}):Play()
        end)
    end)
    img.MouseLeave:Connect(function()
        pcall(function()
            TweenService:Create(card, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(24,24,24)}):Play()
        end)
    end)

    -- click: show loading then execute openFn (which will show GUI that script made)
    img.MouseButton1Click:Connect(function()
        -- show loading 5s then call openFn
        showLoading(5, hubGui, function()
            -- hide hub
            pcall(function() hubGui.Enabled = false end)
            -- call the game's open logic safely
            pcall(info.openFn)
        end)
    end)
end

-- ---------- Social buttons (Discord + YouTube) ----------
local function createSocialBtn(xScale, text, color3, link, iconAsset)
    local btn = Instance.new("TextButton", hubGui)
    btn.Size = UDim2.new(0, 220, 0, 54)
    btn.Position = UDim2.new(xScale, -110, 0.9, 0)
    btn.BackgroundColor3 = Color3.fromRGB(10,10,10)
    btn.BorderSizePixel = 0
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
    lbl.Text = text
    lbl.TextColor3 = color3
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    btn.MouseButton1Click:Connect(function()
        openLink(link)
    end)
end

-- create social buttons with icons (use provided assets or replace)
createSocialBtn(0.25, "Join Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
createSocialBtn(0.75, "Subscribe", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")

-- Done. Hub loaded and Blade Ball was preloaded in background.
