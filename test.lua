-- LocalScript - đặt trong StarterPlayerScripts để test Auto Parry

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "CustomGUI"

-- Main Frame
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 200)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Text = "Auto Parry Test"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- Toggle Button
local toggleBtn = Instance.new("TextButton", mainFrame)
toggleBtn.Size = UDim2.new(0, 150, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -75, 0.5, -20)
toggleBtn.Text = "Auto Parry [OFF]"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 18

local autoParryEnabled = false

-- Hàm Auto Parry
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoParryEnabled then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Tìm các bóng (phần tên “Ball” đặt thử)
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj.Name == "Ball" and obj:IsA("BasePart") then
                        local dist = (obj.Position - char.HumanoidRootPart.Position).Magnitude
                        if dist < 20 then  -- khoảng cách thử
                            -- Gọi Remote ParryButtonPress
                            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                            if remotes then
                                local parryRemote = remotes:FindFirstChild("ParryButtonPress")
                                if parryRemote then
                                    parryRemote:FireServer()
                                    -- print để kiểm tra
                                    print("ParryRemote fired for ball: "..obj.Name)
                                end
                            end
                            -- sau khi Parry rồi có thể wait 1s để tránh spam
                            task.wait(1)
                        end
                    end
                end
            end
        end
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    autoParryEnabled = not autoParryEnabled
    toggleBtn.Text = "Auto Parry [" .. (autoParryEnabled and "ON" or "OFF") .. "]"
end)
