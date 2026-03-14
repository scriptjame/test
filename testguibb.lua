-- ⚔️ Blade Ball GUI phụ (hiện đại + auto resize + hiệu ứng + mạng xã hội nổi bật)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local setclipboard = setclipboard or toclipboard or set_clipboard

-- Xoá gui cũ nếu có
local old = playerGui:FindFirstChild("BladeBallMenu")
if old then old:Destroy() end

-- ⚡ Chạy script chính trước
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- GUI chính
local subGui = Instance.new("ScreenGui", playerGui)
subGui.Name = "BladeBallMenu"
subGui.ResetOnSpawn = false

-- Frame chính
local frame = Instance.new("Frame", subGui)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

-- Shadow
local shadow = Instance.new("ImageLabel", frame)
shadow.ZIndex = 0
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Image = "rbxassetid://6015897843"
shadow.ImageTransparency = 0.4
shadow.BackgroundTransparency = 1

-- Auto resize
local function resizeFrame()
local screenSize = workspace.CurrentCamera.ViewportSize
local w = math.clamp(screenSize.X * 0.45, 320, 650)
local h = math.clamp(screenSize.Y * 0.45, 260, 520)
frame.Size = UDim2.new(0, w, 0, h)
end
resizeFrame()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resizeFrame)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -20, 0, 45)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(180, 255, 200)
title.TextStrokeTransparency = 0.5
title.Text = "⚔️ Blade Ball Scripts"

-- Scroll
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -20, 1, -115)
scroll.Position = UDim2.new(0, 10, 0, 55)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local list = Instance.new("UIListLayout", scroll)
list.Padding = UDim.new(0, 8)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder

-- Hàm tạo nút script
local function createScriptBtn(text, url, premium, copyTikTok)
local btn = Instance.new("TextButton", scroll)
btn.Size = UDim2.new(0.9, 0, 0, 45)
btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
btn.AutoButtonColor = false
btn.Font = Enum.Font.GothamMedium
btn.TextSize = 16
btn.TextColor3 = Color3.fromRGB(230, 230, 230)
btn.Text = text
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

```
btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
end)
btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
end)

if premium then
    task.spawn(function()
        local hue = 0
        while btn.Parent do
            hue = (hue + 1) % 360
            btn.TextColor3 = Color3.fromHSV(hue/360, 0.8, 1)
            task.wait(0.05)
        end
    end)
end

btn.MouseButton1Click:Connect(function()
    if copyTikTok then
        if setclipboard then setclipboard("www.tiktok.com/@renan1627") end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Copied!",
            Text = "Follow my TikTok and Follow my Youtube for updates!",
            Duration = 5
        })
    else
        local ok, err = pcall(function()
            if url then
                local loading = Instance.new("TextLabel", frame)
                loading.Size = UDim2.new(1, 0, 0, 30)
                loading.Position = UDim2.new(0, 0, 1, -35)
                loading.BackgroundTransparency = 1
                loading.Text = "Loading..."
                loading.Font = Enum.Font.GothamBold
                loading.TextSize = 18
                loading.TextColor3 = Color3.fromRGB(255, 255, 0)
                task.wait(3)
                loading:Destroy()
                loadstring(game:HttpGet(url))()
            end
        end)
        if not ok then warn("⚠️ Script error:", err) end
    end
end)

scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 20)
```

end

-- Scripts
createScriptBtn("Makzinn Hub", "https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createScriptBtn("Argon Hub X", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createScriptBtn("Frostware Hub need key", "https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createScriptBtn("Catsus Hub", "https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createScriptBtn("RX Hub", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
createScriptBtn("Allusive", nil, true, true)
createScriptBtn("UwU", nil, true, true)

-- Social buttons (GIỮ NGUYÊN)
local socialFrame = Instance.new("Frame", frame)
socialFrame.Size = UDim2.new(1, -20, 0, 45)
socialFrame.Position = UDim2.new(0, 10, 1, -55)
socialFrame.BackgroundTransparency = 1

local socialList = Instance.new("UIListLayout", socialFrame)
socialList.FillDirection = Enum.FillDirection.Horizontal
socialList.Padding = UDim.new(0, 10)
socialList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local socials = {
{name="TikTok", color1=Color3.fromRGB(255,0,128), color2=Color3.fromRGB(0,255,255), link="[www.tiktok.com/@renan1627](http://www.tiktok.com/@renan1627)"},
{name="YouTube", color1=Color3.fromRGB(200,0,0), color2=Color3.fromRGB(255,100,100), link="https://www.youtube.com/@user-qe3dv7iy2j"},
{name="Discord", color1=Color3.fromRGB(88,101,242), color2=Color3.fromRGB(120,140,255), link="https://discord.gg/RbhFbKbABe"},
}

for _, s in ipairs(socials) do
local btn = Instance.new("TextButton", socialFrame)
btn.Size = UDim2.new(0.18, -5, 1, 0)
btn.Text = s.name
btn.Font = Enum.Font.GothamBold
btn.TextSize = 16
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.AutoButtonColor = false
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

```
task.spawn(function()
    local t = 0
    while btn.Parent do
        t += 0.03
        local r = s.color1:Lerp(s.color2, (math.sin(t)+1)/2)
        btn.BackgroundColor3 = r
        task.wait(0.05)
    end
end)

btn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(s.link) end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Copied!",
        Text = s.name .. " link copied to clipboard.",
        Duration = 4
    })
end)
```

end

-- Toggle nút (FIX vị trí + kéo được)
local toggleBtn = Instance.new("TextButton", subGui)
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 10, 0, 80)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 20
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

local dragging = false
local dragStart
local startPos

toggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = toggleBtn.Position
end
end)

toggleBtn.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
local delta = input.Position - dragStart
toggleBtn.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)

local visible = true
toggleBtn.MouseButton1Click:Connect(function()
visible = not visible
if visible then
frame.Visible = true
frame.BackgroundTransparency = 1
TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
else
TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
task.delay(0.3, function()
if not visible then frame.Visible = false end
end)
end
end)
