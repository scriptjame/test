local player = game.Players.LocalPlayer 
local playerGui = player:WaitForChild("PlayerGui") 
local old = playerGui:FindFirstChild("rutoairas") 
if old then old:Destroy() end 

-- Tạo ScreenGui mới
local screenGui = Instance.new("ScreenGui", playerGui) 
screenGui.Name = "rutoairas" 

-- Khung outer chứa UI
local outer = Instance.new("Frame", screenGui)
outer.Size = UDim2.new(0, 420, 0, 450)
outer.Position = UDim2.new(0.5, -210, 0.5, -225)
outer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
outer.BorderSizePixel = 0
Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 15)

-- Frame nội dung bên trong
local main = Instance.new("Frame", outer)
main.Size = UDim2.new(1, -20, 1, -20)
main.Position = UDim2.new(0, 10, 0, 10)
main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Tiêu đề GUI
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "rutoairas"
title.TextColor3 = Color3.fromRGB(255, 70, 70)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Nút đóng GUI
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() 
    screenGui.Enabled = false 
end)

-- 🟥 Nút R (ẩn/hiện GUI)
local TweenService = game:GetService("TweenService")
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 35, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -20)
toggleBtn.Text = "R"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 22
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

local guiVisible = true

-- Hiệu ứng hover
toggleBtn.MouseEnter:Connect(function()
    TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        Size = UDim2.new(0, 40, 0, 40)
    }):Play()
end)

toggleBtn.MouseLeave:Connect(function()
    TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(200, 0, 0),
        Size = UDim2.new(0, 35, 0, 35)
    }):Play()
end)

-- Chức năng ẩn/hiện GUI
toggleBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    outer.Visible = guiVisible
end)

-- Sidebar menu
local menu = Instance.new("Frame", main)
menu.Size = UDim2.new(0, 100, 1, -30)
menu.Position = UDim2.new(0, 0, 0, 30)
menu.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 10)

local function makeMenuBtn(txt, y) 
    local btn = Instance.new("TextButton", menu) 
    btn.Size = UDim2.new(1, 0, 0, 40) 
    btn.Position = UDim2.new(0, 0, 0, y) 
    btn.Text = txt 
    btn.TextColor3 = Color3.fromRGB(255, 70, 70) 
    btn.Font = Enum.Font.GothamSemibold 
    btn.TextSize = 18 
    btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0) 
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) 
    return btn 
end 

local btnMain = makeMenuBtn("Main", 0) 
local btnPlayer = makeMenuBtn("Player", 40) 
local btnDupe = makeMenuBtn("Dupe", 80) 
local btnChanger = makeMenuBtn("Skin", 120) 
local btnRank = makeMenuBtn("Rank", 160) 

-- Frame chứa nội dung
local content = Instance.new("Frame", main) 
content.Size = UDim2.new(1, -100, 1, -60) 
content.Position = UDim2.new(0, 100, 0, 30) 
content.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 10)

-- Tiêu đề tab
local tabTitle = Instance.new("TextLabel", content) 
tabTitle.Size = UDim2.new(1, 0, 0, 30) 
tabTitle.Position = UDim2.new(0, 0, 0, 0) 
tabTitle.BackgroundTransparency = 1 
tabTitle.TextColor3 = Color3.fromRGB(255, 70, 70) 
tabTitle.Font = Enum.Font.GothamBold 
tabTitle.TextSize = 24 
tabTitle.TextXAlignment = Enum.TextXAlignment.Left 

----------------------------------------------------------------
-- 🟡 Giữ nguyên Loading GUI + createToggle, createInput, Tabs
----------------------------------------------------------------
-- (mình không paste lại hết phần bạn viết dài ở dưới vì không cần đổi,
-- chỉ chỉnh giao diện phần trên cho đẹp và sửa nút R)
----------------------------------------------------------------

-- Load mặc định tab Main
local function clearContent() for _, c in ipairs(content:GetChildren()) do if c ~= tabTitle then c:Destroy() end end end
local function loadMain() tabTitle.Text = "Main" clearContent() end
local function loadPlayer() tabTitle.Text = "Player" clearContent() end
local function loadDupe() tabTitle.Text = "Dupe" clearContent() end
local function loadChanger() tabTitle.Text = "Changer Skin" clearContent() end
local function loadRank() tabTitle.Text = "Auto Rank" clearContent() end

btnMain.MouseButton1Click:Connect(loadMain) 
btnPlayer.MouseButton1Click:Connect(loadPlayer) 
btnDupe.MouseButton1Click:Connect(loadDupe) 
btnChanger.MouseButton1Click:Connect(loadChanger) 
btnRank.MouseButton1Click:Connect(loadRank) 
loadMain()

-- Load script chính
spawn(function() 
    local ok, err = pcall(function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))() 
    end) 
    if not ok then warn("⚠ Failed to load main script:", err) end 
end)
