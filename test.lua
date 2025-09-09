local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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

-- Logic Auto Parry

local autoParryOn = false
local mouse = player:GetMouse()

toggleBtn.MouseButton1Click:Connect(function()
    autoParryOn = not autoParryOn
    status.Text = "Auto Parry: " .. (autoParryOn and "ON" or "OFF")
end)

-- Hàm kiểm tra bóng bay về phía người chơi
local function isBallComingToPlayer(ball)
    if not ball or not ball:IsA("BasePart") then return false end
    -- Tính vector hướng bóng di chuyển
    local velocity = ball.Velocity
    if velocity.Magnitude < 1 then return false end
    
    -- Vector từ bóng đến người chơi
    local playerPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position
    if not playerPos then return false end
    
    local directionToPlayer = (playerPos - ball.Position).Unit
    
    -- Kiểm tra nếu bóng bay gần hướng về người chơi (góc nhỏ hơn 30 độ)
    local dot = velocity.Unit:Dot(directionToPlayer)
    if dot > 0.85 then
        return true
    end
    return false
end

-- Tìm bóng trong workspace (bạn cần chỉnh theo tên hoặc cách xác định bóng)
local function getBalls()
    local balls = {}
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BasePart") and v.Name:lower():find("ball") then
            table.insert(balls, v)
        end
    end
    return balls
end

-- Thực hiện parry (bấm phím block)
local function parry()
    -- Thường game sẽ gán block vào 1 phím (ví dụ F hoặc Q), mình giả định là "F"
    UserInputService:SetKeyDown(Enum.KeyCode.F)
    wait(0.1)
    UserInputService:SetKeyUp(Enum.KeyCode.F)
end

-- Loop kiểm tra và auto parry
RunService.RenderStepped:Connect(function()
    if autoParryOn then
        local balls = getBalls()
        for _, ball in pairs(balls) do
            if isBallComingToPlayer(ball) then
                parry()
                break -- chỉ parry 1 lần mỗi frame
            end
        end
    end
end)
