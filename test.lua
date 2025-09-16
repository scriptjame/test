-- // Main Script Loader
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- remove old gui if exists
local old = playerGui:FindFirstChild("rutoairas")
if old then old:Destroy() end

-- create ScreenGui
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "rutoairas"
screenGui.ResetOnSpawn = false

-- ui corner helper
local function makeCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

-- main frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 750, 0, 420)
mainFrame.Position = UDim2.new(0.5, -375, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
makeCorner(mainFrame, 12)

-- grid for cards
local layout = Instance.new("UIGridLayout", mainFrame)
layout.CellSize = UDim2.new(0, 230, 0, 140)
layout.CellPadding = UDim2.new(0, 10, 0, 10)
layout.FillDirectionMaxCells = 3
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

-- yellow footer text
local footer = Instance.new("TextLabel", screenGui)
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.Text = "Join our Discord group to get scripts for other games"
footer.TextColor3 = Color3.fromRGB(255, 255, 0)
footer.TextStrokeTransparency = 0.5
footer.Font = Enum.Font.GothamBold
footer.TextSize = 18

-- helper for card creation
local function createCard(title, desc, imageId, callback)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    makeCorner(card, 10)

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""

    local img = Instance.new("ImageLabel", card)
    img.Size = UDim2.new(1, 0, 0.6, 0)
    img.Position = UDim2.new(0, 0, 0, 0)
    img.BackgroundTransparency = 1
    img.Image = imageId or ""

    local titleLabel = Instance.new("TextLabel", card)
    titleLabel.Size = UDim2.new(1, -10, 0, 25)
    titleLabel.Position = UDim2.new(0, 5, 0.6, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextSize = 18

    local descLabel = Instance.new("TextLabel", card)
    descLabel.Size = UDim2.new(1, -10, 0, 20)
    descLabel.Position = UDim2.new(0, 5, 0.8, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextSize = 14

    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)

    return card
end

-- card definitions
local cards = {
    {
        "Pet Simulator 99",
        "Auto Farm, Dupe Pets, Unlock Areas...",
        "rbxassetid://137509940940918",
        function()
            print("Pet Sim script executed")
        end
    },
    {
        "Grow a Garden",
        "Auto Plant, Auto Sell, Auto Upgrade...",
        "rbxassetid://137510042865871",
        function()
            print("Grow a Garden script executed")
        end
    },
    {
        "Murder Mystery 2",
        "ESP, Auto Farm, Knife Aura...",
        "rbxassetid://137510101662510",
        function()
            print("MM2 script executed")
        end
    },
    {
        "Blade Ball",
        "Auto Parry, Skin Changer, Dupe...",
        "rbxassetid://137510146002973",
        function()
            print("Blade Ball script executed")
        end
    },
    {
        "UwU",
        "Premium exclusive features...",
        "rbxassetid://137510200374927",
        function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "UwU",
                Text = "Update soon",
                Duration = 5
            })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
        end
    },
    {
        "Allusive",
        "Premium exclusive features...",
        "rbxassetid://137510237485161",
        function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Allusive",
                Text = "Update soon",
                Duration = 5
            })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/anhlinh1136/bladeball/refs/heads/main/Protected_2903763962339231.lua"))()
        end
    },
    {
        "Discord",
        "Join our Discord group for updates!",
        "",
        function()
            setclipboard("https://discord.gg/yourinvite")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Discord",
                Text = "Discord link copied to clipboard",
                Duration = 5
            })
        end
    },
    {
        "YouTube",
        "My channel is close to 3k subs, pls subscribe!",
        "rbxassetid://137510274857391",
        function()
            setclipboard("https://youtube.com/yourchannel")
            game.StarterGui:SetCore("SendNotification", {
                Title = "YouTube",
                Text = "Channel link copied to clipboard",
                Duration = 5
            })
        end
    }
}

-- create cards
for _, v in ipairs(cards) do
    local card = createCard(v[1], v[2], v[3], v[4])
    card.Parent = mainFrame
end

-- gradient animation for premium cards UwU + Allusive
local function addGradient(card)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    }
    grad.Rotation = 45
    grad.Parent = card
    task.spawn(function()
        while card.Parent do
            for i = 0, 1, 0.01 do
                grad.Offset = Vector2.new(i, i)
                task.wait(0.05)
            end
        end
    end)
end

for _, c in pairs(mainFrame:GetChildren()) do
    if c:IsA("Frame") then
        local title = c:FindFirstChildOfClass("TextLabel")
        if title and (title.Text == "UwU" or title.Text == "Allusive") then
            addGradient(c)
        end
    end
end
