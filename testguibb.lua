-- ⚔️ Blade Ball GUI phụ (compact + premium buttons + fixed socials)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local setclipboard = setclipboard or toclipboard or set_clipboard

-- click sound
local function click(parent)
local s=Instance.new("Sound")
s.SoundId="rbxassetid://876939830"
s.Volume=1
s.Parent=parent
s:Play()
game:GetService("Debris"):AddItem(s,2)
end

-- remove old gui
local old = playerGui:FindFirstChild("BladeBallMenu")
if old then old:Destroy() end

-- run main script
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- GUI
local gui=Instance.new("ScreenGui",playerGui)
gui.Name="BladeBallMenu"
gui.ResetOnSpawn=false

-- main frame
local frame=Instance.new("Frame",gui)
frame.AnchorPoint=Vector2.new(0.5,0.5)
frame.Position=UDim2.new(0.5,0,0.5,0)
frame.Size=UDim2.new(0,330,0,270)
frame.BackgroundColor3=Color3.fromRGB(30,32,38)
frame.BackgroundTransparency=0.05
frame.BorderSizePixel=0
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,12)

-- border
local border=Instance.new("UIStroke",frame)
border.Color=Color3.fromRGB(120,170,255)
border.Thickness=1.5
border.Transparency=0.4

-- title bar
local titleBar=Instance.new("Frame",frame)
titleBar.Size=UDim2.new(1,0,0,30)
titleBar.BackgroundTransparency=1

local title=Instance.new("TextLabel",titleBar)
title.Size=UDim2.new(1,-60,1,0)
title.Position=UDim2.new(0,10,0,0)
title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold
title.TextSize=16
title.Text="⚔️ Blade Ball Scripts"
title.TextColor3=Color3.fromRGB(220,255,220)
title.TextXAlignment="Left"

-- hide button (BIGGER)
local hideBtn=Instance.new("TextButton",titleBar)
hideBtn.Size=UDim2.new(0,35,0,25)
hideBtn.Position=UDim2.new(1,-40,0.5,-12)
hideBtn.Text="-"
hideBtn.Font=Enum.Font.GothamBold
hideBtn.TextSize=20
hideBtn.TextColor3=Color3.new(1,1,1)
hideBtn.BackgroundColor3=Color3.fromRGB(50,55,70)
Instance.new("UICorner",hideBtn).CornerRadius=UDim.new(0,6)

-- scroll
local scroll=Instance.new("ScrollingFrame",frame)
scroll.Size=UDim2.new(1,-20,1,-90)
scroll.Position=UDim2.new(0,10,0,35)
scroll.BackgroundTransparency=1
scroll.ScrollBarThickness=5

local list=Instance.new("UIListLayout",scroll)
list.Padding=UDim.new(0,6)
list.HorizontalAlignment="Center"

-- script button
local function createBtn(text,url,premium,copy)

local btn=Instance.new("TextButton",scroll)
btn.Size=UDim2.new(0.92,0,0,32)
btn.Text=text
btn.Font=Enum.Font.GothamMedium
btn.TextSize=14
btn.TextColor3=Color3.fromRGB(235,235,235)
btn.AutoButtonColor=false
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,7)

if premium then

btn.BackgroundColor3=Color3.fromRGB(60,60,70)

local g=Instance.new("UIGradient",btn)
g.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,120,220)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(120,180,255))
}

else

btn.BackgroundColor3=Color3.fromRGB(42,45,52)

local stroke=Instance.new("UIStroke",btn)
stroke.Color=Color3.fromRGB(120,170,255)
stroke.Transparency=0.5
stroke.Thickness=1

end

btn.MouseButton1Click:Connect(function()

click(btn)

if copy then

if setclipboard then
setclipboard("https://www.tiktok.com/@evenher6")
end

game.StarterGui:SetCore("SendNotification",{
Title="Copied!",
Text="Follow my TikTok for updates!",
Duration=5
})

else

if url then
loadstring(game:HttpGet(url))()
end

end

end)

scroll.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+10)

end

-- scripts
createBtn("Makzinn Hub","https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createBtn("Argon Hub X","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createBtn("Frostware Hub need key","https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createBtn("Catsus Hub","https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")

-- premium
createBtn("Allusive",nil,true,true)
createBtn("UwU",nil,true,true)

-- socials
local socialFrame=Instance.new("Frame",frame)
socialFrame.Size=UDim2.new(1,-20,0,30)
socialFrame.Position=UDim2.new(0,10,1,-35)
socialFrame.BackgroundTransparency=1

local layout=Instance.new("UIListLayout",socialFrame)
layout.FillDirection="Horizontal"
layout.Padding=UDim.new(0,8)
layout.HorizontalAlignment="Center"

local socials={
{name="TikTok",link="https://www.tiktok.com/@renan1627?is_from_webapp=1&sender_device=pc"},
{name="YouTube",link="https://www.youtube.com/@user-qe3dv7iy2j"},
{name="Discord",link="https://discord.gg/NgxXnRGRYp"}
}

for _,s in pairs(socials) do

local b=Instance.new("TextButton",socialFrame)
b.Size=UDim2.new(0.3,0,1,0)
b.Text=s.name
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.TextColor3=Color3.new(1,1,1)
b.BackgroundColor3=Color3.fromRGB(60,65,80)
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)

b.MouseButton1Click:Connect(function()

click(b)

if setclipboard then
setclipboard(s.link)
end

game.StarterGui:SetCore("SendNotification",{
Title="Copied!",
Text=s.name.." link copied.",
Duration=4
})

end)

end

-- reopen button (BIGGER)
local reopen=Instance.new("TextButton",gui)
reopen.Size=UDim2.new(0,45,0,45)
reopen.Position=UDim2.new(0,20,0.7,0)
reopen.Text="≡"
reopen.Visible=false
reopen.Font=Enum.Font.GothamBold
reopen.TextSize=20
reopen.TextColor3=Color3.new(1,1,1)
reopen.BackgroundColor3=Color3.fromRGB(50,55,70)
Instance.new("UICorner",reopen).CornerRadius=UDim.new(1,0)

hideBtn.MouseButton1Click:Connect(function()
click(hideBtn)
frame.Visible=false
reopen.Visible=true
end)

reopen.MouseButton1Click:Connect(function()
click(reopen)
frame.Visible=true
reopen.Visible=false
end)

-- drag
local dragging=false
local dragInput
local start
local startPos

titleBar.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
start=input.Position
startPos=frame.Position

input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then
dragging=false
end
end)

end
end)

titleBar.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then
dragInput=input
end
end)

UIS.InputChanged:Connect(function(input)

if input==dragInput and dragging then

local delta=input.Position-start

frame.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)
