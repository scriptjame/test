-- ⚔️ Blade Ball GUI phụ (modern + sound + border + draggable)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
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

-- 🔊 Sound click
local function playClick()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://911342077"
    s.Volume = 1
    s.Parent = workspace
    s:Play()
    game.Debris:AddItem(s,2)
end

-- GUI chính
local subGui = Instance.new("ScreenGui", playerGui)
subGui.Name = "BladeBallMenu"
subGui.ResetOnSpawn = false

-- Frame chính
local frame = Instance.new("Frame", subGui)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.05
Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)

-- viền
local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(120,255,160)
stroke.Thickness = 1.5
stroke.Transparency = 0.3

-- Shadow
local shadow = Instance.new("ImageLabel", frame)
shadow.ZIndex = 0
shadow.Size = UDim2.new(1,60,1,60)
shadow.Position = UDim2.new(0.5,0,0.5,0)
shadow.AnchorPoint = Vector2.new(0.5,0.5)
shadow.Image = "rbxassetid://6015897843"
shadow.ImageTransparency = 0.4
shadow.BackgroundTransparency = 1

-- resize nhỏ gọn hơn
local function resizeFrame()
    local screenSize = workspace.CurrentCamera.ViewportSize
    local w = math.clamp(screenSize.X * 0.38,300,580)
    local h = math.clamp(screenSize.Y * 0.38,240,460)
    frame.Size = UDim2.new(0,w,0,h)
end
resizeFrame()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resizeFrame)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,-20,0,40)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(180,255,200)
title.Text = "⚔️ Blade Ball Scripts"

-- Scroll
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1,-20,1,-110)
scroll.Position = UDim2.new(0,10,0,50)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 5
scroll.CanvasSize = UDim2.new(0,0,0,0)

local list = Instance.new("UIListLayout",scroll)
list.Padding = UDim.new(0,7)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Hàm tạo nút
local function createScriptBtn(text,url,premium,copyTikTok)

    local btn = Instance.new("TextButton",scroll)
    btn.Size = UDim2.new(0.9,0,0,42)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.Text = text
    btn.AutoButtonColor = false

    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

    local bstroke = Instance.new("UIStroke",btn)
    bstroke.Color = Color3.fromRGB(90,200,255)
    bstroke.Transparency = 0.5

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(60,60,90)}):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(35,35,45)}):Play()
    end)

    -- rainbow premium
    if premium then
        task.spawn(function()
            local hue = 0
            while btn.Parent do
                hue = (hue+1)%360
                btn.TextColor3 = Color3.fromHSV(hue/360,0.8,1)
                task.wait(0.05)
            end
        end)
    end

    btn.MouseButton1Click:Connect(function()
        playClick()

        if copyTikTok then
            if setclipboard then
                setclipboard("www.tiktok.com/@renan1627")
            end
        else
            if url then
                loadstring(game:HttpGet(url))()
            end
        end
    end)

    scroll.CanvasSize = UDim2.new(0,0,0,list.AbsoluteContentSize.Y+20)

end

-- Scripts
createScriptBtn("Makzinn Hub","https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createScriptBtn("Argon Hub X","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createScriptBtn("Frostware Hub need key","https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createScriptBtn("Catsus Hub","https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createScriptBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
createScriptBtn("Allusive",nil,true,true)
createScriptBtn("UwU",nil,true,true)

-- 🔘 Nút ẩn kiểu chrome
local miniBtn = Instance.new("TextButton",subGui)
miniBtn.Size = UDim2.new(0,40,0,40)
miniBtn.Position = UDim2.new(0,15,0.75,0)
miniBtn.Text = "≡"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
miniBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Active = true
miniBtn.Draggable = true

Instance.new("UICorner",miniBtn).CornerRadius = UDim.new(1,0)

local visible = true

miniBtn.MouseButton1Click:Connect(function()

    playClick()

    visible = not visible

    if visible then
        frame.Visible = true
    else
        frame.Visible = false
    end

end)

-- Frame draggable
frame.Active = true
frame.Draggable = true
