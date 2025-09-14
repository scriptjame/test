-- thay vì danh sách 'games', tạo 1 nút chung cho mọi game
local container = Instance.new("Frame", hubGui)
container.Size = UDim2.new(1, -60, 0.78, 0)
container.Position = UDim2.new(0, 30, 0.06, 0)
container.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", container)
grid.CellSize = UDim2.new(0, 300, 0, 240)
grid.CellPadding = UDim2.new(0, 18, 0, 18)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 4

-- tạo 1 nút cho tất cả game
local card = Instance.new("Frame", container)
card.BackgroundColor3 = Color3.fromRGB(24,24,24)
card.Size = UDim2.new(0, 300, 0, 240)
Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

local img = Instance.new("ImageButton", card)
img.Size = UDim2.new(1,0,0.62,0)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://127537802436978" -- ảnh mặc định Blade Ball

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1,-18,0,30)
title.Position = UDim2.new(0,10,0.64,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "All Game Scripts"

local desc = Instance.new("TextLabel", card)
desc.Size = UDim2.new(1,-18,0,54)
desc.Position = UDim2.new(0,10,0.74,0)
desc.BackgroundTransparency = 1
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextColor3 = Color3.fromRGB(190,190,190)
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.Text = "Universal hub for all games."

img.MouseButton1Click:Connect(openBladeBallMenu)
