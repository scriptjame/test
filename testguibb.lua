-- ⚔️ Blade Ball GUI (Optimized + Clean UI)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local setclipboard = setclipboard or toclipboard or set_clipboard

-- remove old
local old = playerGui:FindFirstChild("BladeBallMenu")
if old then old:Destroy() end

-- play script first
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
frame.Size = UDim2.new(0,420,0,360)
frame.Position = UDim2.new(0.5,-210,0.5,-180)
frame.BackgroundColor3 = Color3.fromRGB(18,18,22)
frame.BorderSizePixel = 0

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)

-- stroke
local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(255,70,70)
stroke.Thickness = 1.2
stroke.Transparency = 0.3

-- title bar
local top = Instance.new("Frame",frame)
top.Size = UDim2.new(1,0,0,38)
top.BackgroundTransparency = 1

local title = Instance.new("TextLabel",top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "⚔ Blade Ball Script Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,90,90)

-- minimize button
local hide = Instance.new("TextButton",top)
hide.Size = UDim2.new(0,28,0,28)
hide.Position = UDim2.new(1,-35,0.5,-14)
hide.Text = "-"
hide.Font = Enum.Font.GothamBold
hide.TextSize = 20
hide.BackgroundColor3 = Color3.fromRGB(40,40,50)
hide.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",hide)

-- reopen button
local reopen = Instance.new("TextButton",gui)
reopen.Size = UDim2.new(0,42,0,42)
reopen.Position = UDim2.new(0,15,0.75,0)
reopen.Text = "⚔"
reopen.Visible = false
reopen.BackgroundColor3 = Color3.fromRGB(40,40,50)
reopen.TextColor3 = Color3.new(1,1,1)
reopen.Font = Enum.Font.GothamBold
reopen.TextSize = 20

Instance.new("UICorner",reopen).CornerRadius = UDim.new(1,0)

-- hide gui
hide.MouseButton1Click:Connect(function()
	click:Play()

	TweenService:Create(frame,TweenInfo.new(0.25),{
		Size = UDim2.new(0,420,0,0)
	}):Play()

	task.wait(0.25)

	frame.Visible = false
	reopen.Visible = true
end)

-- reopen
reopen.MouseButton1Click:Connect(function()

	click:Play()

	frame.Visible = true
	reopen.Visible = false

	frame.Size = UDim2.new(0,420,0,0)

	TweenService:Create(frame,TweenInfo.new(0.25),{
		Size = UDim2.new(0,420,0,360)
	}):Play()

end)

-- scroll
local scroll = Instance.new("ScrollingFrame",frame)
scroll.Size = UDim2.new(1,-20,1,-110)
scroll.Position = UDim2.new(0,10,0,45)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4

local list = Instance.new("UIListLayout",scroll)
list.Padding = UDim.new(0,6)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- script button
local function createScriptBtn(text,url,premium,copy)

	local btn = Instance.new("TextButton",scroll)

	btn.Size = UDim2.new(0.95,0,0,38)
	btn.BackgroundColor3 = Color3.fromRGB(30,30,35)
	btn.TextColor3 = Color3.fromRGB(230,230,230)
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 15
	btn.AutoButtonColor = false

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn,TweenInfo.new(0.15),{
			BackgroundColor3 = Color3.fromRGB(55,55,70)
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn,TweenInfo.new(0.15),{
			BackgroundColor3 = Color3.fromRGB(30,30,35)
		}):Play()
	end)

	btn.MouseButton1Click:Connect(function()

		click:Play()

		if copy then

			if setclipboard then
				setclipboard("www.tiktok.com/@renan1627")
			end

			game.StarterGui:SetCore("SendNotification",{
				Title="Copied!",
				Text="Follow TikTok & YouTube",
				Duration=4
			})

		else

			if url then
				loadstring(game:HttpGet(url))()
			end

		end

	end)

	scroll.CanvasSize = UDim2.new(0,0,0,list.AbsoluteContentSize.Y+10)

end

-- scripts
createScriptBtn("Makzinn Hub","https://raw.githubusercontent.com/MagoKazinn/Makzinn_hub/main/makzinn_Hub")
createScriptBtn("Argon Hub X","https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
createScriptBtn("Frostware Hub need key","https://raw.githubusercontent.com/Fsploit/F-R-O-S-T-W-A-R-E/refs/heads/main/Main")
createScriptBtn("Catsus Hub","https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua")
createScriptBtn("RX Hub","https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
createScriptBtn("Allusive",nil,true,true)
createScriptBtn("UwU",nil,true,true)

-- social
local socialFrame = Instance.new("Frame",frame)
socialFrame.Size = UDim2.new(1,-20,0,40)
socialFrame.Position = UDim2.new(0,10,1,-45)
socialFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout",socialFrame)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0,10)

local socials = {

{"TikTok","www.tiktok.com/@renan1627",Color3.fromRGB(255,0,120)},
{"YouTube","https://www.youtube.com/@user-qe3dv7iy2j",Color3.fromRGB(200,0,0)},
{"Discord","https://discord.gg/RbhFbKbABe",Color3.fromRGB(88,101,242)}

}

for _,s in ipairs(socials) do

	local b = Instance.new("TextButton",socialFrame)

	b.Size = UDim2.new(0.25,0,1,0)
	b.Text = s[1]
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = s[3]

	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)

	b.MouseButton1Click:Connect(function()

		click:Play()

		if setclipboard then
			setclipboard(s[2])
		end

		game.StarterGui:SetCore("SendNotification",{
			Title="Copied!",
			Text=s[1].." link copied",
			Duration=4
		})

	end)

end
