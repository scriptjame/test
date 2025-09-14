-- // Game Hub Full Script // --
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

local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.IgnoreGuiInset = true

-- helper mở link (executor hoặc copy link)
local function openLink(url)
    if typeof(openbrowser) == "function" then
        openbrowser(url)
        return
    elseif syn and syn.open_url then
        syn.open_url(url)
        return
    elseif typeof(request) == "function" then
        request({Url = url, Method = "GET"})
        return
    end
    if setclipboard then
        setclipboard(url)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Link copied",
            Text = "Không mở trực tiếp được, link đã copy!",
            Duration = 4
        })
    else
        warn("Không mở được link, executor không hỗ trợ.")
    end
end

-- Blade Ball sub menu
local function openBladeBallMenu()
    hubGui.Enabled = false

    local subGui = Instance.new("ScreenGui", playerGui)
    subGui.Name = "BladeBallMenu"
    subGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", subGui)
    frame.Size = UDim2.new(0, 480, 0, 360)
    frame.Position = UDim2.new(0.5, -240, 0.5, -180)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,40)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.fromRGB(0,255,0)
    title.Text = "Blade Ball Scripts"

    local list = Instance.new("UIListLayout", frame)
    list.Padding = UDim.new(0,12)
    list.FillDirection = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Top
    list.SortOrder = Enum.SortOrder.LayoutOrder

    local function createScriptBtn(text, url)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.9,0,0,44)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = "Script - " .. text
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        -- thêm viền xanh lá
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(0,255,0)
        stroke.Thickness = 2

        btn.MouseButton1Click:Connect(function()
            subGui:Destroy()
            local ok, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not ok then
                warn("BladeBall script failed:", err)
                hubGui.Enabled = true
            end
        end)
    end

    createScriptBtn("BLADE BALL AUTO PARRY SUPPORT FOR HIGH PING👇", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
    createScriptBtn("BLADE BALL AUTO PARRY, UNLOCK ALL SWORD, EXPLOSION, EMOTE👇", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
    createScriptBtn("BLADE BALL AUTO PARRY, SPAM – I THINK U LIKE ❤️👇", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")

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

-- nút Discord & Youtube
createSocialBtn(0.25, "Join Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
createSocialBtn(0.75, "Subscribe", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")
