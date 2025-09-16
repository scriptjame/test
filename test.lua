--== MAIN HUB SCRIPT ==--

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- auto run your main Blade Ball script
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- remove old hub
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- create ScreenGui
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "MainMenu"
hubGui.ResetOnSpawn = false
hubGui.IgnoreGuiInset = true
hubGui.Parent = playerGui

-- helper open link
local function openLink(url)
    local copied = false
    if setclipboard then
        pcall(setclipboard, url)
        copied = true
    end
    if typeof(openbrowser) == "function" then
        pcall(openbrowser, url)
        copied = true
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Link",
        Text = copied and "Link copied to clipboard!" or "Copy manually: "..url,
        Duration = 5
    })
    warn("Link:", url)
end

-- Blade Ball Sub Menu
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
            local ok, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not ok then
                warn("BladeBall script failed:", err)
            end
        end)
    end

    local function createPremiumBtn(text)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.9,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = "Premium - "..text
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        btn.MouseButton1Click:Connect(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Coming Soon",
                Text = "Premium script not available yet",
                Duration = 4
            })
        end)
    end

    createScriptBtn("Argon Hub X", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
    createScriptBtn("Sinaloa Hub", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
    createScriptBtn("RX Hub", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
    createPremiumBtn("Allusive")
    createPremiumBtn("UwU")

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

-- Container
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(1, -40, 0.8, 0)
container.Position = UDim2.new(0, 20, 0.05, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0.25, -20, 0, 220)
grid.CellPadding = UDim2.new(0, 12, 0, 12)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.SortOrder = Enum.SortOrder.LayoutOrder

-- Game cards
local function createCard(name, desc, img, callback)
    local card = Instance.new("Frame", container)
    card.BackgroundColor3 = Color3.fromRGB(28,28,28)
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = Color3.fromRGB(90,90,90)
    stroke.Thickness = 2

    local image = Instance.new("ImageButton", card)
    image.Size = UDim2.new(1,0,0.55,0)
    image.BackgroundTransparency = 1
    image.Image = img

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1, -20, 0, 28)
    title.Position = UDim2.new(0, 10, 0.6, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = name

    local descLabel = Instance.new("TextLabel", card)
    descLabel.Size = UDim2.new(1, -20, 0.3, 0)
    descLabel.Position = UDim2.new(0, 10, 0.75, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 14
    descLabel.TextColor3 = Color3.fromRGB(200,200,200)
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.Text = desc

    image.MouseButton1Click:Connect(callback)
end

-- Game list
createCard("Pet Simulator 99", "Auto Farm, Dupe Pets, Unlock Areas...", "rbxassetid://103879354899468", function()
    game.StarterGui:SetCore("SendNotification",{Title="Pet Sim 99", Text="No script attached yet!", Duration=3})
end)

createCard("Grow a Garden", "Auto Plant, Auto Sell, Auto Upgrade...", "rbxassetid://110811575269598", function()
    game.StarterGui:SetCore("SendNotification",{Title="Grow a Garden", Text="No script attached yet!", Duration=3})
end)

createCard("Murder Mystery 2", "ESP, Auto Farm, Knife Aura...", "rbxassetid://120257957010430", function()
    game.StarterGui:SetCore("SendNotification",{Title="MM2", Text="No script attached yet!", Duration=3})
end)

createCard("Blade Ball", "Auto Parry, Skin Changer, Dupe...", "rbxassetid://127537802436978", openBladeBallMenu)

createCard("Discord", "Join our Discord group for updates!", "rbxassetid://80637427855653", function()
    openLink("https://discord.gg/fkDMHngGCk")
end)

createCard("YouTube", "Subscribe for more free scripts!", "rbxassetid://95429734677601", function()
    openLink("https://www.youtube.com/@user-qe3dv7iy2j")
end)

-- Social buttons
local function createSocialBtn(xScale, text, color3, link, iconAsset)
    local btn = Instance.new("TextButton", hubGui)
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.Position = UDim2.new(xScale, -100, 0.9, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = color3
    stroke.Thickness = 2

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0,32,0,32)
    icon.Position = UDim2.new(0,10,0.5,-16)
    icon.BackgroundTransparency = 1
    icon.Image = iconAsset

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1,-50,1,0)
    lbl.Position = UDim2.new(0,50,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 18
    lbl.TextColor3 = color3
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = text

    btn.MouseButton1Click:Connect(function()
        openLink(link)
    end)
end

createSocialBtn(0.25, "Join Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
createSocialBtn(0.75, "Subscribe", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")

-- Footer note
local note = Instance.new("TextLabel", hubGui)
note.Size = UDim2.new(1,0,0,30)
note.Position = UDim2.new(0,0,0.85,0)
note.BackgroundTransparency = 1
note.Font = Enum.Font.GothamBold
note.TextSize = 16
note.TextColor3 = Color3.fromRGB(255,255,150)
note.Text = "More scripts will be added soon. Stay tuned!"
