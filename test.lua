local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- auto chạy script chính khi mở menu (Grow A Garden thay vì Blade Ball)
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/rtete/refs/heads/main/rtete"))()
end)

-- xoá hub cũ nếu có
local old = playerGui:FindFirstChild("MainMenu")
if old then old:Destroy() end

-- === từ đây giữ nguyên toàn bộ GUI code bạn đã làm ===
-- chỉ sửa chỗ "Blade Ball" trong danh sách game để nó thành nút thông báo như các game khác

-- danh sách game (sửa Blade Ball thành notify)
local games = {
    {
        name = "Pet Simulator 99",
        desc = "Script Auto Farm, Dupe Pets, Unlock Areas...",
        img = "rbxassetid://103879354899468",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Pet Sim 99", Text="No script attached yet!", Duration=3})
        end
    },
    {
        name = "Grow a Garden",
        desc = "Script Auto Plant, Auto Sell, Auto Upgrade...",
        img = "rbxassetid://110811575269598",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Grow a Garden", Text="GUI loaded successfully!", Duration=3})
        end
    },
    {
        name = "Murder Mystery 2",
        desc = "Script ESP, Auto Farm, Knife Aura...",
        img = "rbxassetid://120257957010430",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="MM2", Text="No script attached yet!", Duration=3})
        end
    },
    {
        name = "Blade Ball",
        desc = "Auto Parry no miss, Changer Skin, Dupe...",
        img = "rbxassetid://127537802436978",
        openFn = function()
            game.StarterGui:SetCore("SendNotification", {Title="Blade Ball", Text="Not available in Grow A Garden hub!", Duration=3})
        end
    }
}

-- === phần dưới (GUI card, social buttons, loading UI...) giữ nguyên code bạn đã làm ===
