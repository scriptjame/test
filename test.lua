local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "BladeBallGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Khung chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 460, 0, 160)
frame.Position = UDim2.new(0.5, -230, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
Instance.new("UIStroke", frame).ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 60)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "Blade Ball Auto Parry"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.BackgroundTransparency = 1

-- Trạng thái Auto Parry
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -40, 0, 30)
status.Position = UDim2.new(0, 20, 0, 80)
status.Text = "Auto Parry: OFF"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.FredokaOne
status.TextScaled = true
status.BackgroundTransparency = 1

-- Nút bật/tắt Auto Parry
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0, 150, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -75, 1, -50)
toggleBtn.Text = "Toggle Auto Parry"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.FredokaOne
toggleBtn.TextScaled = true
toggleBtn.AutoButtonColor = true
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

-- Nút ẩn/hiện GUI
local hideBtn = Instance.new("TextButton", frame)
hideBtn.Size = UDim2.new(0, 30, 0, 30)
hideBtn.Position = UDim2.new(1, -35, 0, 5)
hideBtn.Text = "-"
hideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
hideBtn.TextColor3 = Color3.new(1,1,1)
hideBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 8)

local isHidden = false
hideBtn.MouseButton1Click:Connect(function()
    if isHidden then
        -- Hiện GUI lại
        frame.Size = UDim2.new(0, 460, 0, 160)
        status.Visible = true
        toggleBtn.Visible = true
        title.Text = "Blade Ball Auto Parry"
        hideBtn.Text = "-"
        isHidden = false
    else
        -- Thu nhỏ GUI chỉ còn nút ẩn
        frame.Size = UDim2.new(0, 100, 0, 40)
        status.Visible = false
        toggleBtn.Visible = false
        title.Text = "BB Parry"
        hideBtn.Text = "+"
        isHidden = true
    end
end)

-- Auto Parry logic (ví dụ)
local autoParryOn = false
toggleBtn.MouseButton1Click:Connect(function()
    autoParryOn = not autoParryOn
    status.Text = "Auto Parry: " .. (autoParryOn and "ON" or "OFF")
    -- Gắn logic auto parry ở đây
end)
