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

-- auto scale cho PC/mobile
local scale = Instance.new("UIScale", hubGui)
scale.Scale = 1
game:GetService("RunService").RenderStepped:Connect(function()
    local s = workspace.CurrentCamera.ViewportSize
    if s.X < 1000 or s.Y < 600 then
        scale.Scale = 0.8 -- thu nhỏ nếu màn hình nhỏ (điện thoại)
    else
        scale.Scale = 1 -- PC giữ nguyên
    end
end)

-- ép tỉ lệ card không bị méo
local aspect = Instance.new("UIAspectRatioConstraint", hubGui)
aspect.AspectRatio = 1.6

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
        Text = copied and "Link copied, paste it in your browser!" or "Cannot copy, copy manually: "..url,
        Duration = 5
    })
    warn("Link:", url)
end

-- loading GUI (giữ nguyên)
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

-- container chính (căn giữa)
local container = Instance.new("Frame", hubGui)
container.AnchorPoint = Vector2.new(0.5,0.5)
container.Position = UDim2.new(0.5,0,0.48,0)
container.Size = UDim2.new(0.92, 0, 0.75, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0, 300, 0, 240)
grid.CellPadding = UDim2.new(0, 18, 0, 18)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 3

-- (tất cả phần còn lại của script bạn giữ nguyên, không thay đổi gì)
