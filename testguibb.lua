-- ⚔️ Blade Ball Mini Script Hub (Clean + Smooth)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local setclipboard = setclipboard or toclipboard or set_clipboard

-- remove old
local old = playerGui:FindFirstChild("BladeBallMenu")
if old then old:Destroy() end

-- run main script
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- click sound
local click = Instance.new("Sound")
click.SoundId = "rbxassetid://12221967"
click.Volume = 1
click.Parent = game:GetService("SoundService")

-- gui
local gui = Instance.new("ScreenGui")
gui.Name = "BladeBallMenu"
gui.Parent = playerGui
gui.ResetOnSpawn = false

-- main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,330,0,250)
frame.Position = UDim2.new(0.5,-165,0.5,-125)
frame.BackgroundColor3 = Color3.fromRGB(18,20,28)
frame.BorderSizePixel = 0

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,10)

-- border color
local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(130,150,255)
stroke.Thickness = 2
stroke.Transparency = 0.2

-- drag gui
local dragging=false
local dragStart,startPos

frame.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=i.Position
startPos=frame.Position
end
end)

frame.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputChanged:Connect(function(i)
if dragging then
local delta=i.Position-dragStart
frame.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)
end
end)

-- title
local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,0,0,32)
title.BackgroundTransparency = 1
title.Text = "⚔ Blade Ball Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(170,200,255)

-- hide button
local hide = Instance.new("TextButton",frame)
hide.Size = UDim2.new(0,22,0,22)
hide.Position = UDim2.new(1,-28,0,5)
hide.Text = "-"
hide.Font = Enum.Font.GothamBold
hide.TextSize = 18
hide.BackgroundColor3 = Color3.fromRGB(35,35,45)
hide.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",hide)

-- reopen button
local reopen = Instance.new("TextButton",gui)
reopen.Size = UDim2.new(0,40,0,40)
reopen.Position = UDim2.new(0,10,0,70)
reopen.Visible = false
reopen.Text = "⚔"
reopen.Font = Enum.Font.GothamBold
reopen.TextSize = 20
reopen.BackgroundColor3 = Color3.fromRGB(35,35,45)
reopen.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",reopen).CornerRadius = UDim.new(1,0)

-- hide animation
hide.MouseButton1Click:Connect(function()

```
click:Play()

TweenService:Create(frame,TweenInfo.new(0.25),{
	Size=UDim2.new(0,330,0,0),
	BackgroundTransparency=1
}):Play()

task.wait(0.25)

frame.Visible=false
reopen.Visible=true
```

end)

-- reopen animation
reopen.MouseButton1Click:Connect(function()

```
click:Play()

frame.Visible=true
reopen.Visible=false

frame.Size=UDim2.new(0,330,0,0)

TweenService:Create(frame,TweenInfo.new(0.25),{
	Size=UDim2.new(0,330,0,250),
	BackgroundTransparency=0
}):Play()
```

end)

-- scroll
local scroll = Instance.new("ScrollingFrame",frame)
scroll.Size = UDim2.new(1,-16,1,-80)
scroll.Position = UDim2.new(0,8,0,35)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4

local list = Instance.new("UIListLayout",scroll)
list.Padding = UDim.new(0,8)

-- button
local function createScriptBtn(text,url,premium,copy)

```
local btn=Instance.new("TextButton",scroll)

btn.Size=UDim2.new(1,0,0,36)
btn.Font=Enum.Font.Gotham
btn.TextSize=14
btn.Text=text

if premium then
	btn.BackgroundColor3=Color3.fromRGB(45,30,70)
	btn.TextColor3=Color3.fromRGB(255,220,120)

	local s=Instance.new("UIStroke",btn)
	s.Color=Color3.fromRGB(255,200,80)
	s.Thickness=1.5
else
	btn.BackgroundColor3=Color3.fromRGB(28,30,38)
	btn.TextColor3=Color3.fromRGB(220,220,230)
end

Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)

btn.MouseButton1Click:Connect(function()

	click:Play()

	if copy then
		if setclipboard then
			setclipboard("www.tiktok.com/@renan1627")
		end
	else
		if url then
			loadstring(game:HttpGet(url))()
		end
	end

end)
```

end

-- scripts
createScriptBtn("Makzinn Hub","https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createScriptBtn("Argon Hub","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createScriptBtn("Frostware","https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createScriptBtn("Catsus Parry","https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createScriptBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
createScriptBtn("Allusive",nil,true,true)
createScriptBtn("UwU",nil,true,true)

-- social buttons
local socialFrame = Instance.new("Frame",frame)
socialFrame.Size = UDim2.new(1,-16,0,35)
socialFrame.Position = UDim2.new(0,8,1,-40)
socialFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout",socialFrame)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.Padding = UDim.new(0,6)

local socialButtons = {

{name="TikTok", color1=Color3.fromRGB(255,0,128), color2=Color3.fromRGB(0,255,255), link="[www.tiktok.com/@renan1627](http://www.tiktok.com/@renan1627)"},
{name="YouTube", color1=Color3.fromRGB(200,0,0), color2=Color3.fromRGB(255,100,100), link="https://www.youtube.com/@user-qe3dv7iy2j"},
{name="Discord", color1=Color3.fromRGB(88,101,242), color2=Color3.fromRGB(120,140,255), link="https://discord.gg/RbhFbKbABe"}

}

for _,v in pairs(socialButtons) do

local b = Instance.new("TextButton",socialFrame)
b.Size = UDim2.new(0.33,-4,1,0)
b.Text = v.name
b.Font = Enum.Font.GothamBold
b.TextSize = 13
b.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)

local grad = Instance.new("UIGradient",b)
grad.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,v.color1),
ColorSequenceKeypoint.new(1,v.color2)
}

b.MouseButton1Click:Connect(function()

click:Play()

if setclipboard then
setclipboard(v.link)
end

end)

end
