-- Main GUI Script
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Notify function
local function Notify(msg)
    StarterGui:SetCore("SendNotification", {
        Title = "Script Hub",
        Text = msg,
        Duration = 5
    })
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GameHubUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- UICorner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- UIListLayout
local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Top
Layout.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Game Script Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

-- Function create button
local function CreateButton(text, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 560, 0, 40)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    btn.Parent = MainFrame
end

-- Discord Button
CreateButton("Join Discord", function()
    setclipboard("https://discord.gg/fkDMHngGCk")
    Notify("Discord link has been copied!")
end, Color3.fromRGB(88, 101, 242)) -- Discord color

-- YouTube Button
CreateButton("Subscribe YouTube", function()
    setclipboard("https://www.youtube.com/@user-qe3dv7iy2j")
    Notify("YouTube link has been copied!")
end, Color3.fromRGB(255, 0, 0)) -- YouTube red

-- Spacer
local Spacer = Instance.new("Frame")
Spacer.Size = UDim2.new(1, -20, 0, 5)
Spacer.BackgroundTransparency = 1
Spacer.Parent = MainFrame

-- Blade Ball Section
local BBTitle = Instance.new("TextLabel")
BBTitle.Size = UDim2.new(1, -20, 0, 30)
BBTitle.BackgroundTransparency = 1
BBTitle.Text = "Blade Ball Scripts"
BBTitle.Font = Enum.Font.Gotham
BBTitle.TextSize = 20
BBTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
BBTitle.Parent = MainFrame

-- Function create script button (green border, no icons)
local function CreateScriptButton(text, script)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 560, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 200, 0)
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if script == "premium" then
            Notify("We will update this soon!")
        else
            loadstring(game:HttpGet(script))()
        end
    end)

    btn.Parent = MainFrame
end

-- Blade Ball scripts (renamed first 5 lines)
CreateScriptButton("Argon Hub X", "https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua")
CreateScriptButton("Sinaloa Hub", "https://api.luarmor.net/files/v3/loaders/63e751ce9ac5e9bcb4e7246c9775af78.lua")
CreateScriptButton("RX Hub", "https://raw.githubusercontent.com/NodeX-Enc/NodeX/refs/heads/main/Main.lua")
CreateScriptButton("Allusive", "premium")
CreateScriptButton("UwU", "premium")
