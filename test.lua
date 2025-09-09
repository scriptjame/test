-- Auto Parry Blade Ball with Visual GUI

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Add Blur Effect
local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = Lighting

-- Create ScreenGui
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BladeBallAutoParry"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 460, 0, 160)
frame.Position = UDim2.new(0.5, -230, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0, 0)

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
Instance.new("UIStroke", frame).ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Shadow Effect
local shadow = Instance.new("ImageLabel", frame)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.75
shadow.Size = UDim2.new(1, 80, 1, 80)
shadow.Position = UDim2.new(0.5, -240, 0.5, -90)
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1

-- Title Label
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 60)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "Blade Ball Auto Parry"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextTransparency = 0.2
title.TextStrokeTransparency = 0.6
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.BackgroundTransparency = 1

-- Title Pulse Animation
task.spawn(function()
	while title and title.Parent do
		TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0.05}):Play()
		task.wait(1)
		TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0.25}):Play()
		task.wait(1)
	end
end)

-- Loading Text Label
local loading = Instance.new("TextLabel", frame)
loading.Size = UDim2.new(1, -40, 0, 30)
loading.Position = UDim2.new(0, 20, 0, 70)
loading.Text = "Auto Parry: OFF"
loading.TextColor3 = Color3.fromRGB(200, 200, 200)
loading.Font = Enum.Font.FredokaOne
loading.TextScaled = true
loading.BackgroundTransparency = 1
loading.TextStrokeTransparency = 1

-- Toggle Button
local toggleButton = Instance.new("TextButton", frame)
toggleButton.Size = UDim2.new(0, 140, 0, 40)
toggleButton.Position = UDim2.new(0.5, -70, 1, -50)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.TextScaled = true
toggleButton.Text = "Toggle Auto Parry"
toggleButton.AutoButtonColor = true

Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 10)

-- State variable
local autoParryEnabled = false

-- Toggle function
toggleButton.MouseButton1Click:Connect(function()
	autoParryEnabled = not autoParryEnabled
	if autoParryEnabled then
		loading.Text = "Auto Parry: ON"
		toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
	else
		loading.Text = "Auto Parry: OFF"
		toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	end
end)

-- Function to detect ball coming towards player
local function isBallNear()
	local character = player.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then
		return false
	end

	local hrp = character.HumanoidRootPart
	for _, obj in pairs(workspace:GetChildren()) do
		if obj.Name == "Ball" or obj.Name == "BladeBall" then
			if obj:IsA("BasePart") then
				local dist = (obj.Position - hrp.Position).Magnitude
				if dist < 15 then -- distance threshold
					if obj.Velocity and obj.Velocity.Magnitude > 5 then
						local directionToPlayer = (hrp.Position - obj.Position).Unit
						local ballDirection = obj.Velocity.Unit
						local dot = ballDirection:Dot(directionToPlayer)
						if dot > 0.7 then -- ball heading roughly towards player
							return true
						end
					end
				end
			end
		end
	end
	return false
end

-- Function to perform parry (simulate pressing F)
local function doParry()
	game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
	task.wait(0.1)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
end

-- RunService loop to auto parry
RunService.Heartbeat:Connect(function()
	if autoParryEnabled then
		if isBallNear() then
			doParry()
		end
	end
end)

-- Cleanup function when player leaves or script disabled
player.AncestryChanged:Connect(function(_, parent)
	if not parent then
		blur:Destroy()
		gui:Destroy()
	end
end)
