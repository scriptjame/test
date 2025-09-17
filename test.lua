local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- chạy script chính NGAY LẬP TỨC
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

-- container chính
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(1, -40, 0.78, 0)
container.Position = UDim2.new(0, 20, 0.06, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0.25, 0, 0.3, 0)
grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

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

-- Blade Ball menu phụ với overlay
local function openBladeBallMenu()
    hubGui.Enabled = false

    -- tạo overlay nền mờ
    local overlay = Instance.new("Frame", playerGui)
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.Position = UDim2.new(0,0,0,0)
    overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    overlay.BackgroundTransparency = 0.5
    overlay.ZIndex = 50

    local subGui = Instance.new("ScreenGui", playerGui)
    subGui.Name = "BladeBallMenu"
    subGui.ResetOnSpawn = false
    subGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- responsive size
    local frame = Instance.new("Frame", subGui)
    frame.Size = UDim2.new(0.8, 0, 0.7, 0)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.Position = UDim2.new(0.5,0,0.5,0)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(200,200,200)
    stroke.Thickness = 2

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,-40,0,40)
    title.Position = UDim2.new(0,20,0,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Gotham
    title.TextSize = math.clamp(frame.AbsoluteSize.Y*0.05, 16, 28)
    title.TextColor3 = Color3.fromRGB(230,230,230)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "Blade Ball Scripts"

    local btnContainer = Instance.new("Frame", frame)
    btnContainer.Size = UDim2.new(1,0,1,-60)
    btnContainer.Position = UDim2.new(0,0,0,50)
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
        frame.Size = UDim2.new(0.8,0,0,newH)
        frame.Position = UDim2.new(0.5,0,0.5,0)
    end)

    local function createScriptBtn(text,url,mode)
        local btn = Instance.new("TextButton", btnContainer)
        btn.Size = UDim2.new(0.9,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = math.clamp(frame.AbsoluteSize.Y*0.04, 14, 20)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = "Script - "..text
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        local strokeBtn = Instance.new("UIStroke", btn)
        strokeBtn.Color = Color3.fromRGB(180,180,180)
        strokeBtn.Thickness = 1

        if mode=="premium" then
            task.spawn(function()
                local hue=0
                while btn.Parent do
                    hue = (hue+2)%360
                    btn.BackgroundColor3=Color3.fromHSV(hue/360,0.8,0.8)
                    task.wait(0.05)
                end
            end)
        end

        btn.MouseButton1Click:Connect(function()
            subGui.Enabled=false
            showLoading(3,function()
                local ok,err=pcall(function()
                    if mode=="premium" then
                        game.StarterGui:SetCore("SendNotification",{Title=text,Text="Coming soon",Duration=3})
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
                    else
                        loadstring(game:HttpGet(url))()
                    end
                end)
                if not ok then warn("⚠️ Script lỗi:",err) end
                subGui:Destroy()
                overlay:Destroy()
                hubGui.Enabled=true
            end)
        end)
    end

    -- tạo các nút script
    createScriptBtn("Argon Hub X","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
    createScriptBtn("Sinaloa Hub","https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
    createScriptBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
    createScriptBtn("Allusive",nil,"premium")
    createScriptBtn("UwU",nil,"premium")

    local backBtn = Instance.new("TextButton", btnContainer)
    backBtn.Size=UDim2.new(0.9,0,0,40)
    backBtn.BackgroundColor3=Color3.fromRGB(50,0,0)
    backBtn.Font=Enum.Font.GothamBold
    backBtn.TextSize=math.clamp(frame.AbsoluteSize.Y*0.035,14,18)
    backBtn.TextColor3=Color3.fromRGB(255,255,255)
    backBtn.Text="← Back"
    Instance.new("UICorner",backBtn).CornerRadius=UDim.new(0,8)

    backBtn.MouseButton1Click:Connect(function()
        subGui:Destroy()
        overlay:Destroy()
        hubGui.Enabled=true
    end)
end

-- [phần còn lại của script không thay đổi: danh sách game, toggle button, drag, etc.]
