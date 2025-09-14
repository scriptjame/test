--// Loading GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("ScriptHubGUI")
if old then old:Destroy() end

local loadingGui = Instance.new("ScreenGui", playerGui)
loadingGui.Name = "ScriptHubGUI"

local loadingFrame = Instance.new("Frame", loadingGui)
loadingFrame.Size = UDim2.new(0, 300, 0, 100)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
loadingFrame.BorderSizePixel = 0
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0,12)

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1,0,1,0)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 20
loadingText.TextColor3 = Color3.fromRGB(255,255,255)
loadingText.Text = "Đang tải Script Hub..."
Instance.new("UIStroke", loadingText).Thickness = 1.5

task.wait(5)
loadingGui:ClearAllChildren()

--// Main Hub
local hubFrame = Instance.new("Frame", loadingGui)
hubFrame.Size = UDim2.new(0, 520, 0, 340)
hubFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
hubFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
hubFrame.BorderSizePixel = 0
Instance.new("UICorner", hubFrame).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", hubFrame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "🔥 Script Hub Menu"
Instance.new("UIStroke", title).Thickness = 1.6

-- helper tạo nút
local function createBtn(parent, text, color3, yPos, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9,0,0,50)
    btn.Position = UDim2.new(0.05,0,0,yPos)
    btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = color3
    btn.Text = text
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = color3
    stroke.Thickness = 2
    btn.MouseButton1Click:Connect(callback)
    return btn
end

--// Sub-GUI Blade Ball
local bladeGui = Instance.new("Frame", loadingGui)
bladeGui.Size = UDim2.new(0, 500, 0, 320)
bladeGui.Position = UDim2.new(0.5, -250, 0.5, -160)
bladeGui.BackgroundColor3 = Color3.fromRGB(18,18,18)
bladeGui.BorderSizePixel = 0
bladeGui.Visible = false
Instance.new("UICorner", bladeGui).CornerRadius = UDim.new(0,14)

local bladeTitle = Instance.new("TextLabel", bladeGui)
bladeTitle.Size = UDim2.new(1,0,0,50)
bladeTitle.BackgroundTransparency = 1
bladeTitle.Font = Enum.Font.GothamBold
bladeTitle.TextSize = 24
bladeTitle.TextColor3 = Color3.fromRGB(255,255,255)
bladeTitle.Text = "⚔️ Blade Ball Scripts"
Instance.new("UIStroke", bladeTitle).Thickness = 1.5

local function createBladeBtn(name, link, order)
    return createBtn(bladeGui, name, Color3.fromRGB(0,200,255), 60 + (order*60), function()
        loadstring(game:HttpGet(link))()
    end)
end

createBladeBtn("AUTO PARRY SUPPORT HIGH PING", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua", 0)
createBladeBtn("AUTO PARRY + UNLOCK ALL + EXPLOSION", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua", 1)
createBladeBtn("AUTO PARRY + SPAM (FUN)", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua", 2)

createBtn(bladeGui, "⬅️ Quay lại Menu", Color3.fromRGB(255,120,120), 250, function()
    bladeGui.Visible = false
    hubFrame.Visible = true
end)

--// Main Hub Buttons
createBtn(hubFrame, "⚔️ Blade Ball", Color3.fromRGB(0,200,255), 60, function()
    hubFrame.Visible = false
    bladeGui.Visible = true
end)

--// Social Buttons
local function createSocialBtn(xScale, text, color3, link, iconAsset)
    local btn = Instance.new("TextButton", hubFrame)
    btn.Size = UDim2.new(0, 220, 0, 54)
    btn.Position = UDim2.new(xScale, -110, 0.85, 0)
    btn.BackgroundColor3 = Color3.fromRGB(10,10,10)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = color3
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "   " .. text
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = color3
    stroke.Thickness = 3

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0,36,0,36)
    icon.Position = UDim2.new(0,12,0.5,-18)
    icon.BackgroundTransparency = 1
    icon.Image = iconAsset

    btn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(link)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "🌐 Link Copied";
                Text = "Đã sao chép: " .. text;
                Duration = 4;
            })
        end
    end)
end

createSocialBtn(0.25, "Join Discord", Color3.fromRGB(88,101,242), "https://discord.gg/fkDMHngGCk", "rbxassetid://6031075938")
createSocialBtn(0.75, "Subscribe YouTube", Color3.fromRGB(255,0,0), "https://www.youtube.com/@user-qe3dv7iy2j", "rbxassetid://6031075939")

--// Script chính tự chạy khi mở Hub
loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
