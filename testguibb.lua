-- ⚔️ Blade Ball GUI phụ (improved UI + animation + drag + hide button)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local setclipboard = setclipboard or toclipboard or set_clipboard

-- sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://6026984224"
clickSound.Volume = 1

-- remove old gui
local old = playerGui:FindFirstChild("BladeBallMenu")
if old then old:Destroy() end

-- run main script
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- GUI
local subGui = Instance.new("ScreenGui",playerGui)
subGui.Name="BladeBallMenu"
subGui.ResetOnSpawn=false

-- main frame
local frame=Instance.new("Frame",subGui)
frame.AnchorPoint=Vector2.new(0.5,0.5)
frame.Position=UDim2.new(0.5,0,0.5,0)
frame.Size=UDim2.new(0,420,0,360)
frame.BackgroundColor3=Color3.fromRGB(28,30,36)
frame.BackgroundTransparency=0.08
frame.BorderSizePixel=0
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,14)

-- gradient (style giống ảnh)
local grad=Instance.new("UIGradient",frame)
grad.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(40,45,55)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(25,27,33))
}

-- stroke
local stroke=Instance.new("UIStroke",frame)
stroke.Color=Color3.fromRGB(120,170,255)
stroke.Transparency=0.4
stroke.Thickness=1.5

-- title bar
local titleBar=Instance.new("Frame",frame)
titleBar.Size=UDim2.new(1,0,0,40)
titleBar.BackgroundTransparency=1

-- title
local title=Instance.new("TextLabel",titleBar)
title.Size=UDim2.new(1,-60,1,0)
title.Position=UDim2.new(0,10,0,0)
title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold
title.TextSize=20
title.TextColor3=Color3.fromRGB(220,255,220)
title.Text="⚔️ Blade Ball Scripts"
title.TextXAlignment="Left"

-- hide button
local hideBtn=Instance.new("TextButton",titleBar)
hideBtn.Size=UDim2.new(0,30,0,25)
hideBtn.Position=UDim2.new(1,-35,0.5,-12)
hideBtn.Text="-"
hideBtn.Font=Enum.Font.GothamBold
hideBtn.TextSize=20
hideBtn.TextColor3=Color3.new(1,1,1)
hideBtn.BackgroundColor3=Color3.fromRGB(45,48,55)
hideBtn.BorderSizePixel=0
Instance.new("UICorner",hideBtn).CornerRadius=UDim.new(0,6)

-- scroll
local scroll=Instance.new("ScrollingFrame",frame)
scroll.Size=UDim2.new(1,-20,1,-110)
scroll.Position=UDim2.new(0,10,0,45)
scroll.BackgroundTransparency=1
scroll.ScrollBarThickness=6

local list=Instance.new("UIListLayout",scroll)
list.Padding=UDim.new(0,8)
list.HorizontalAlignment="Center"

-- button function
local function createScriptBtn(text,url,premium,copyTikTok)

local btn=Instance.new("TextButton",scroll)
btn.Size=UDim2.new(0.9,0,0,40)
btn.BackgroundColor3=Color3.fromRGB(40,42,50)
btn.TextColor3=Color3.fromRGB(235,235,235)
btn.Font=Enum.Font.GothamMedium
btn.TextSize=15
btn.Text=text
btn.AutoButtonColor=false
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)

-- hover
btn.MouseEnter:Connect(function()
TweenService:Create(btn,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(60,65,80)}):Play()
end)

btn.MouseLeave:Connect(function()
TweenService:Create(btn,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(40,42,50)}):Play()
end)

-- premium color
if premium then
task.spawn(function()
local t=0
while btn.Parent do
t+=0.02
btn.TextColor3=Color3.fromHSV((math.sin(t)+1)/2,0.8,1)
task.wait(.05)
end
end)
end

-- click
btn.MouseButton1Click:Connect(function()

clickSound:Play()

if copyTikTok then
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

scroll.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+20)

end

-- scripts
createScriptBtn("Makzinn Hub","https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createScriptBtn("Argon Hub X","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createScriptBtn("Frostware Hub need key","https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createScriptBtn("Catsus Hub","https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createScriptBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
createScriptBtn("Allusive",nil,true,true)
createScriptBtn("UwU",nil,true,true)

-- social frame
local socialFrame=Instance.new("Frame",frame)
socialFrame.Size=UDim2.new(1,-20,0,40)
socialFrame.Position=UDim2.new(0,10,1,-50)
socialFrame.BackgroundTransparency=1

local socialList=Instance.new("UIListLayout",socialFrame)
socialList.FillDirection="Horizontal"
socialList.HorizontalAlignment="Center"
socialList.Padding=UDim.new(0,10)

local socials={
{name="TikTok",color1=Color3.fromRGB(255,0,128),color2=Color3.fromRGB(0,255,255),link="https://www.tiktok.com"},
{name="YouTube",color1=Color3.fromRGB(200,0,0),color2=Color3.fromRGB(255,100,100),link="https://youtube.com"},
{name="Discord",color1=Color3.fromRGB(88,101,242),color2=Color3.fromRGB(120,140,255),link="https://discord.gg"}
}

for _,s in ipairs(socials) do

local btn=Instance.new("TextButton",socialFrame)
btn.Size=UDim2.new(0.25,0,1,0)
btn.Text=s.name
btn.Font=Enum.Font.GothamBold
btn.TextSize=15
btn.TextColor3=Color3.new(1,1,1)
btn.AutoButtonColor=false
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)

task.spawn(function()
local t=0
while btn.Parent do
t+=.03
btn.BackgroundColor3=s.color1:Lerp(s.color2,(math.sin(t)+1)/2)
task.wait(.05)
end
end)

btn.MouseButton1Click:Connect(function()

clickSound:Play()

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

-- toggle icon
local reopen=Instance.new("TextButton",subGui)
reopen.Size=UDim2.new(0,40,0,40)
reopen.Position=UDim2.new(0,20,0.7,0)
reopen.Text="≡"
reopen.Visible=false
reopen.Font=Enum.Font.GothamBold
reopen.TextSize=18
reopen.TextColor3=Color3.new(1,1,1)
reopen.BackgroundColor3=Color3.fromRGB(40,45,55)
Instance.new("UICorner",reopen).CornerRadius=UDim.new(1,0)

-- animation hide
hideBtn.MouseButton1Click:Connect(function()

clickSound:Play()

TweenService:Create(frame,TweenInfo.new(.25),{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1
}):Play()

task.wait(.25)

frame.Visible=false
reopen.Visible=true

end)

-- reopen
reopen.MouseButton1Click:Connect(function()

clickSound:Play()

frame.Visible=true
reopen.Visible=false

frame.Size=UDim2.new(0,0,0,0)

TweenService:Create(frame,TweenInfo.new(.3,Enum.EasingStyle.Back),{
Size=UDim2.new(0,420,0,360),
BackgroundTransparency=0.08
}):Play()

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
