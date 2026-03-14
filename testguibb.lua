-- ⚔️ Blade Ball GUI phụ (RGB border + premium gradient + click sound FIX)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local setclipboard = setclipboard or toclipboard or set_clipboard

-- xoá gui cũ
local old = playerGui:FindFirstChild("BladeBallMenu")
if old then
	old:Destroy()
end

-- chạy script chính
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
end)

-- 🔊 CLICK SOUND (FIX)
local function clickSound()

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://9114487369"
	sound.Volume = 2
	sound.PlayOnRemove = true
	sound.Parent = SoundService

	sound:Destroy()

end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BladeBallMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,350,0,280)
frame.Position = UDim2.new(0.5,-175,0.5,-140)
frame.BackgroundColor3 = Color3.fromRGB(30,32,40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,10)

-- RGB border
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Parent = frame

task.spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		stroke.Color = Color3.fromHSV(hue/360,1,1)
		task.wait(0.05)
	end
end)

-- title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-60,0,30)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(180,255,200)
title.Text = "⚔️ Blade Ball Scripts"
title.Parent = frame

-- minimize
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,24,0,24)
minimize.Position = UDim2.new(1,-30,0,6)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.BackgroundColor3 = Color3.fromRGB(60,60,70)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Parent = frame

Instance.new("UICorner",minimize).CornerRadius = UDim.new(1,0)

-- reopen
local reopen = Instance.new("TextButton")
reopen.Size = UDim2.new(0,36,0,36)
reopen.Position = UDim2.new(0,20,0.75,0)
reopen.Text = "≡"
reopen.Visible = false
reopen.BackgroundColor3 = Color3.fromRGB(50,55,70)
reopen.TextColor3 = Color3.new(1,1,1)
reopen.Font = Enum.Font.GothamBold
reopen.TextSize = 16
reopen.Active = true
reopen.Draggable = true
reopen.Parent = gui

Instance.new("UICorner",reopen).CornerRadius = UDim.new(1,0)

minimize.MouseButton1Click:Connect(function()
	clickSound()
	frame.Visible = false
	reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
	clickSound()
	frame.Visible = true
	reopen.Visible = false
end)

-- scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-20,1,-80)
scroll.Position = UDim2.new(0,10,0,40)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4
scroll.Parent = frame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0,5)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.Parent = scroll

-- tạo nút
local function createBtn(text,url,premium)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9,0,0,30)
	btn.BackgroundColor3 = Color3.fromRGB(45,48,60)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = text
	btn.AutoButtonColor = false
	btn.Parent = scroll

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6)

	if premium then

		local gradient = Instance.new("UIGradient")
		gradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0,Color3.fromRGB(255,120,0)),
			ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,200))
		}
		gradient.Rotation = 45
		gradient.Parent = btn

	end

	btn.MouseButton1Click:Connect(function()

		clickSound()

		if premium then

			game.StarterGui:SetCore("SendNotification",{
				Title="Premium Script",
				Text="Follow my TikTok and YouTube and wait for update!",
				Duration=5
			})

			if setclipboard then
				setclipboard("www.tiktok.com/@renan1627")
			end

		else

			loadstring(game:HttpGet(url))()

		end

	end)

end

-- scripts
createBtn("Makzinn Hub","https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createBtn("Argon Hub X","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createBtn("Frostware Hub need key","https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createBtn("Catsus Hub","https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")

createBtn("Allusive",nil,true)
createBtn("UwU",nil,true)

-- social
local socialFrame = Instance.new("Frame")
socialFrame.Size = UDim2.new(1,-20,0,34)
socialFrame.Position = UDim2.new(0,10,1,-38)
socialFrame.BackgroundTransparency = 1
socialFrame.Parent = frame

local socialList = Instance.new("UIListLayout")
socialList.FillDirection = Enum.FillDirection.Horizontal
socialList.Padding = UDim.new(0,6)
socialList.HorizontalAlignment = Enum.HorizontalAlignment.Center
socialList.Parent = socialFrame

local socials = {

{name="TikTok",link="www.tiktok.com/@renan1627",color=Color3.fromRGB(255,0,128)},
{name="YouTube",link="https://www.youtube.com/@user-qe3dv7iy2j",color=Color3.fromRGB(255,0,0)},
{name="Discord",link="https://discord.gg/RbhFbKbABe",color=Color3.fromRGB(88,101,242)}

}

for _,s in pairs(socials) do

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.28,0,1,0)
	btn.Text = s.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = s.color
	btn.Parent = socialFrame

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6)

	btn.MouseButton1Click:Connect(function()

		clickSound()

		if setclipboard then
			setclipboard(s.link)
		end

		game.StarterGui:SetCore("SendNotification",{
			Title="Copied!",
			Text=s.name.." link copied to clipboard",
			Duration=4
		})

	end)

end
