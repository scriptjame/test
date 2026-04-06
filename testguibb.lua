-- 🔥 LOADING GUI (3s)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local loadingGui = Instance.new("ScreenGui", playerGui)
loadingGui.Name = "LoadingGui"
loadingGui.IgnoreGuiInset = true

local bg = Instance.new("Frame", loadingGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(15,15,20)

local box = Instance.new("Frame", bg)
box.Size = UDim2.new(0,300,0,80)
box.Position = UDim2.new(0.5,-150,0.5,-40)
box.BackgroundColor3 = Color3.fromRGB(25,28,35)
Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

local barBg = Instance.new("Frame", box)
barBg.Size = UDim2.new(0.9,0,0,14)
barBg.Position = UDim2.new(0.05,0,0.65,0)
barBg.BackgroundColor3 = Color3.fromRGB(40,45,60)
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1,0)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(120,170,255)
Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

-- tween tiến độ 3s
TweenService:Create(bar, TweenInfo.new(3, Enum.EasingStyle.Linear), {
	Size = UDim2.new(1,0,1,0)
}):Play()

task.wait(3)
loadingGui:Destroy()
-- ⚔️ Blade Ball GUI PRO

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

-- main script
pcall(function()
loadstring(game:HttpGet("https://pastefy.app/lXtua1cc/raw"))()
end)

-- GUI
local gui=Instance.new("ScreenGui",playerGui)
gui.Name="BladeBallMenu"
gui.ResetOnSpawn=false

-- FRAME
local frame=Instance.new("Frame",gui)
frame.AnchorPoint=Vector2.new(0.5,0.5)
frame.Position=UDim2.new(0.5,0,0.5,0)
frame.Size=UDim2.new(0,340,0,280)
frame.BackgroundColor3=Color3.fromRGB(18,20,26)
frame.BackgroundTransparency=0.15
frame.BorderSizePixel=0
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,14)

local stroke=Instance.new("UIStroke",frame)
stroke.Color=Color3.fromRGB(120,170,255)
stroke.Transparency=0.7

-- 🔥 TITLE BAR (DRAG HERE)
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1,0,0,40)
titleBar.BackgroundTransparency = 1

local title=Instance.new("TextLabel",titleBar)
title.Size=UDim2.new(1,-40,1,0)
title.Position=UDim2.new(0,10,0,0)
title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold
title.TextSize=17
title.Text="⚔️ Blade Ball Script"
title.TextColor3=Color3.fromRGB(220,255,255)
title.TextXAlignment="Left"

-- hide
local hideBtn=Instance.new("TextButton",titleBar)
hideBtn.Size=UDim2.new(0,28,0,28)
hideBtn.Position=UDim2.new(1,-35,0.5,-14)
hideBtn.Text="×"
hideBtn.Font=Enum.Font.GothamBold
hideBtn.TextSize=18
hideBtn.TextColor3=Color3.new(1,1,1)
hideBtn.BackgroundColor3=Color3.fromRGB(40,45,60)
Instance.new("UICorner",hideBtn).CornerRadius=UDim.new(1,0)

-- scroll
local scroll=Instance.new("ScrollingFrame",frame)
scroll.Size=UDim2.new(1,-20,1,-90)
scroll.Position=UDim2.new(0,10,0,45)
scroll.BackgroundTransparency=1
scroll.ScrollBarThickness=3

local list=Instance.new("UIListLayout",scroll)
list.Padding=UDim.new(0,8)
list.HorizontalAlignment="Center"

-- button
local function createBtn(text,url,premium,copy)

local btn=Instance.new("TextButton",scroll)
btn.Size=UDim2.new(0.92,0,0,34)
btn.Text=text
btn.Font=Enum.Font.GothamSemibold
btn.TextSize=14
btn.TextColor3=Color3.fromRGB(240,240,240)
btn.AutoButtonColor=false
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,10)

if premium then
	btn.BackgroundColor3=Color3.fromRGB(80,60,120)

	local g=Instance.new("UIGradient",btn)
	g.Color=ColorSequence.new{
		ColorSequenceKeypoint.new(0,Color3.fromRGB(255,120,220)),
		ColorSequenceKeypoint.new(1,Color3.fromRGB(120,180,255))
	}

	local glow=Instance.new("UIStroke",btn)
	glow.Color=Color3.fromRGB(255,255,255)
	glow.Thickness=1.5
	glow.Transparency=0.5
else
	btn.BackgroundColor3=Color3.fromRGB(35,38,45)
end

btn.MouseButton1Click:Connect(function()

click(btn)

TweenService:Create(btn,TweenInfo.new(.08),{Size=UDim2.new(0.95,0,0,36)}):Play()
task.wait(.08)
TweenService:Create(btn,TweenInfo.new(.08),{Size=UDim2.new(0.92,0,0,34)}):Play()

if copy then
if setclipboard then
setclipboard("www.tiktok.com/@renan1627")
end
game.StarterGui:SetCore("SendNotification",{
Title="Copied!",
Text="Follow TikTok!",
Duration=4
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
createBtn("Levi Hub","https://levi-hub-x.vercel.app/Loader.lua")
createBtn("Corolla Hub","https://raw.githubusercontent.com/7190000/Corolla-Hub/main/ch.lua")
createBtn("Plutonium Hub","https://raw.githubusercontent.com/PawsThePaw/Plutonium.AA/main/Plutonium.Loader.lua")
createBtn("Mur4exe Hub","https://gist.githubusercontent.com/Mur4exe/3f324715641be103e3ee2a8317765e13/raw/a9749a78feffaa7f535b8335454d9888aa8f530c/Blade_ball_modern_ui_v2.lua")
createBtn("Vylera Hub","https://raw.githubusercontent.com/vylerascripts/vylera-scripts/main/vylerabladeball.lua")
createBtn("Rixton Hub (snare hub - keyless)","https://rawscripts.net/raw/Universal-Script-Argon-X-Hub-138276")

createBtn("Allusive",nil,true,true)
createBtn("UwU",nil,true,true)

-- TikTok
local tiktok=Instance.new("TextButton",frame)
tiktok.Size=UDim2.new(1,-40,0,28)
tiktok.Position=UDim2.new(0,20,1,-35)
tiktok.Text="TikTok"
tiktok.Font=Enum.Font.GothamBold
tiktok.TextSize=13
tiktok.TextColor3=Color3.new(1,1,1)
tiktok.BackgroundColor3=Color3.fromRGB(255,0,128)
Instance.new("UICorner",tiktok).CornerRadius=UDim.new(0,8)

tiktok.MouseButton1Click:Connect(function()
click(tiktok)
if setclipboard then
setclipboard("www.tiktok.com/@renan1627")
end
game.StarterGui:SetCore("SendNotification",{
Title="Copied!",
Text="TikTok copied.",
Duration=4
})
end)

-- reopen
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

-- 🔥 DRAG (ONLY TITLE BAR = FIX 100%)
local dragging=false
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=true
		dragStart=input.Position
		startPos=frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
		local delta=input.Position-dragStart
		frame.Position=UDim2.new(
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
