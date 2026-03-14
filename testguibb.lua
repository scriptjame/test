-- ⚔️ Blade Ball GUI phụ (modern + border + sound + chrome minimize)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

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

-- sound click
local function clickSound()
	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://911342077"
	s.Volume = 1
	s.Parent = workspace
	s:Play()
	Debris:AddItem(s,2)
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BladeBallMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,520,0,420)
frame.Position = UDim2.new(0.5,-260,0.5,-210)
frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = frame

-- border
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120,255,160)
stroke.Thickness = 1.5
stroke.Transparency = 0.3
stroke.Parent = frame

-- title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-60,0,40)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(180,255,200)
title.Text = "⚔️ Blade Ball Scripts"
title.Parent = frame

-- nút minimize giống chrome
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,30,0,30)
minimize.Position = UDim2.new(1,-35,0,5)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.BackgroundColor3 = Color3.fromRGB(50,50,60)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Parent = frame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1,0)
minCorner.Parent = minimize

-- nút reopen
local reopen = Instance.new("TextButton")
reopen.Size = UDim2.new(0,40,0,40)
reopen.Position = UDim2.new(0,20,0.75,0)
reopen.Text = "≡"
reopen.Visible = false
reopen.BackgroundColor3 = Color3.fromRGB(40,40,50)
reopen.TextColor3 = Color3.new(1,1,1)
reopen.Font = Enum.Font.GothamBold
reopen.TextSize = 18
reopen.Active = true
reopen.Draggable = true
reopen.Parent = gui

local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(1,0)
reopenCorner.Parent = reopen

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
scroll.Size = UDim2.new(1,-20,1,-120)
scroll.Position = UDim2.new(0,10,0,50)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 5
scroll.Parent = frame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0,7)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.Parent = scroll

-- tạo nút script
local function createBtn(text,url,premium)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9,0,0,40)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 15
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = text
	btn.AutoButtonColor = false
	btn.Parent = scroll

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,8)
	c.Parent = btn

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

-- premium
createBtn("Allusive",nil,true)
createBtn("UwU",nil,true)

-- social
local socialFrame = Instance.new("Frame")
socialFrame.Size = UDim2.new(1,-20,0,45)
socialFrame.Position = UDim2.new(0,10,1,-50)
socialFrame.BackgroundTransparency = 1
socialFrame.Parent = frame

local socialList = Instance.new("UIListLayout")
socialList.FillDirection = Enum.FillDirection.Horizontal
socialList.Padding = UDim.new(0,10)
socialList.HorizontalAlignment = Enum.HorizontalAlignment.Center
socialList.Parent = socialFrame

local socials = {

{name="TikTok",link="www.tiktok.com/@renan1627"},
{name="YouTube",link="https://www.youtube.com/@user-qe3dv7iy2j"},
{name="Discord",link="https://discord.gg/RbhFbKbABe"}

}

for _,s in pairs(socials) do

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.18,0,1,0)
	btn.Text = s.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
	btn.Parent = socialFrame

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,8)
	c.Parent = btn

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
