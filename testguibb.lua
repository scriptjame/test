--// ⚡ YUNGAKO HUB - UI v2
--// Beautiful Cards / Search / Sound / Hover / Minimize / Reopen
--// PC + Mobile

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- REMOVE OLD GUI
--==================================================

local old = PlayerGui:FindFirstChild("YungakoHub")
if old then
    old:Destroy()
end

--==================================================
-- SETTINGS
--==================================================

local CLICK_SOUND = "rbxassetid://876939830"

--==================================================
-- GAME DATA
--==================================================

local Games = {
    {
        Name = "Blade Ball",
        Description = "Blade Ball Script",
        Icon = "⚔",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/test3/refs/heads/main/test.lua", true))()
        end
    },

    {
        Name = "MM2",
        Description = "Murder Mystery 2",
        Icon = "🔪",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/mm2/refs/heads/main/bawe.lua", true))()
        end
    },

    {
        Name = "Adopt Me",
        Description = "Adopt Me Script",
        Icon = "🏠",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/testadp/main/adpt.lua"))()
        end
    },

    {
        Name = "Blox Fruits",
        Description = "Blox Fruits Script",
        Icon = "🍎",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/bloxfruit/refs/heads/main/main.lua"))()
        end
    },

    {
        Name = "Steal a Brainrot",
        Description = "Steal a Brainrot Script",
        Icon = "🧠",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/stealabrainrot/refs/heads/main/shiba.lua"))()
        end
    },

    {
        Name = "99 Nights in the Forest",
        Description = "99 Nights Script",
        Icon = "🌲",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/99Nights/refs/heads/main/shiba.lua"))()
        end
    },

    {
        Name = "The Strongest Battlegrounds",
        Description = "TSB Script",
        Icon = "⚡",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/TheStrongestBattlegrounds/refs/heads/main/main.lua"))()
        end
    },

    {
        Name = "Pls Donate",
        Description = "Pls Donate Script",
        Icon = "💰",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/plsdonat_e/refs/heads/main/zzz.lua"))()
        end
    },

    {
        Name = "Evade",
        Description = "Evade Script",
        Icon = "👁",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/evade/refs/heads/main/shabi.lua"))()
        end
    },

    {
        Name = "Fish It",
        Description = "Fish It Script",
        Icon = "🎣",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/fishit/refs/heads/main/nice.lua"))()
        end
    },

    {
        Name = "Doors",
        Description = "Doors Script",
        Icon = "🚪",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Doors/refs/heads/main/wwsp.lua"))()
        end
    },

    {
        Name = "Sailor Piece",
        Description = "Sailor Piece Script",
        Icon = "⚓",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/SailorPiece/refs/heads/main/heh.lua"))()
        end
    },

    {
        Name = "Jujutsu Shenanigans",
        Description = "Jujutsu Script",
        Icon = "👊",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Jujutsu-Shenanigans/refs/heads/main/hai.lua"))()
        end
    },

    {
        Name = "Forsaken",
        Description = "Forsaken Script",
        Icon = "☠",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Forsaken/refs/heads/main/null.lua"))()
        end
    },

    {
        Name = "Rivals",
        Description = "Rivals Script",
        Icon = "🎯",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/rivals/refs/heads/main/loot.lua"))()
        end
    },

    {
        Name = "Arsenal",
        Description = "Arsenal Script",
        Icon = "🔫",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Arsenal/refs/heads/main/nah.lua"))()
        end
    },

    {
        Name = "Bee Swarm Simulator",
        Description = "Bee Swarm Script",
        Icon = "🐝",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/BeeSwarmSimulator/refs/heads/main/loot.lua"))()
        end
    },

    {
        Name = "Brookhaven RP",
        Description = "Brookhaven Script",
        Icon = "🏡",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Brookhaven-RP/refs/heads/main/wsp.lua"))()
        end
    },

    {
        Name = "Aura Ascension",
        Description = "Aura Ascension Script",
        Icon = "✨",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Aura-Ascension/refs/heads/main/looot.lua"))()
        end
    },

    {
        Name = "Dead Rails",
        Description = "Dead Rails Script",
        Icon = "🚂",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/Dead-Rails/refs/heads/main/hola.lua"))()
        end
    },

    {
        Name = "Bite By Night",
        Description = "Bite By Night Script",
        Icon = "🌙",
        Action = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptjame/BiteBynight/refs/heads/main/ty.lua"))()
        end
    },
}

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(13, 15, 21)
local HEADER_BG = Color3.fromRGB(17, 20, 28)

local CARD = Color3.fromRGB(23, 27, 36)
local CARD_HOVER = Color3.fromRGB(32, 38, 50)

local ICON_BG = Color3.fromRGB(31, 36, 48)

local TEXT = Color3.fromRGB(245, 247, 252)
local SUBTEXT = Color3.fromRGB(145, 153, 170)

local ACCENT = Color3.fromRGB(110, 165, 255)
local ACCENT2 = Color3.fromRGB(170, 110, 255)

local SEARCH_BG = Color3.fromRGB(19, 23, 31)

--==================================================
-- HELPERS
--==================================================

local function Corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, transparency, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = thickness or 1
    s.Parent = parent
    return s
end

local function Tween(obj, time, properties)
    return TweenService:Create(
        obj,
        TweenInfo.new(
            time,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        properties
    )
end

local function ClickSound(parent)
    local sound = Instance.new("Sound")
    sound.SoundId = CLICK_SOUND
    sound.Volume = 0.65
    sound.Parent = parent
    sound:Play()

    Debris:AddItem(sound, 2)
end

--==================================================
-- SCREEN GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "YungakoHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.new(0.78, 0, 0.72, 0)

Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

Corner(Main, 18)

local MainStroke = Stroke(
    Main,
    Color3.fromRGB(90, 125, 180),
    0.55,
    1
)

--==================================================
-- HEADER BACKGROUND
--==================================================

local HeaderBG = Instance.new("Frame")
HeaderBG.Name = "HeaderBG"
HeaderBG.Size = UDim2.new(1, 0, 0, 58)
HeaderBG.BackgroundColor3 = HEADER_BG
HeaderBG.BorderSizePixel = 0
HeaderBG.Parent = Main

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 26, 37)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 18, 26))
})
HeaderGradient.Parent = HeaderBG

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 58)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 18, 0, 6)
Title.Size = UDim2.new(1, -100, 0, 27)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ YUNGAKO HUB | Shiba HUB"
Title.TextSize = 19
Title.TextColor3 = TEXT
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Count = Instance.new("TextLabel")
Count.BackgroundTransparency = 1
Count.Position = UDim2.new(0, 19, 0, 32)
Count.Size = UDim2.new(1, -100, 0, 17)
Count.Font = Enum.Font.Gotham
Count.Text = tostring(#Games) .. " Games  •  Ready"
Count.TextSize = 11
Count.TextColor3 = SUBTEXT
Count.TextXAlignment = Enum.TextXAlignment.Left
Count.Parent = Header

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -43, 0, 13)

Close.BackgroundColor3 = Color3.fromRGB(34, 39, 50)
Close.BorderSizePixel = 0

Close.Text = "×"
Close.TextColor3 = TEXT
Close.TextSize = 20
Close.Font = Enum.Font.GothamBold

Close.AutoButtonColor = false
Close.Parent = Header

Corner(Close, 9)

Close.MouseEnter:Connect(function()
    Tween(Close, .12, {
        BackgroundColor3 = Color3.fromRGB(65, 48, 55)
    }):Play()
end)

Close.MouseLeave:Connect(function()
    Tween(Close, .12, {
        BackgroundColor3 = Color3.fromRGB(34, 39, 50)
    }):Play()
end)

--==================================================
-- SEARCH
--==================================================

local SearchFrame = Instance.new("Frame")
SearchFrame.Name = "SearchFrame"

SearchFrame.Position = UDim2.new(0, 14, 0, 68)
SearchFrame.Size = UDim2.new(1, -28, 0, 40)

SearchFrame.BackgroundColor3 = SEARCH_BG
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = Main

Corner(SearchFrame, 11)

local SearchStroke = Stroke(
    SearchFrame,
    Color3.fromRGB(70, 80, 100),
    0.7,
    1
)

local SearchIcon = Instance.new("TextLabel")
SearchIcon.BackgroundTransparency = 1
SearchIcon.Position = UDim2.new(0, 11, 0, 0)
SearchIcon.Size = UDim2.new(0, 25, 1, 0)

SearchIcon.Text = "⌕"
SearchIcon.TextColor3 = SUBTEXT
SearchIcon.TextSize = 20
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.BackgroundTransparency = 1
SearchBox.Position = UDim2.new(0, 39, 0, 0)
SearchBox.Size = UDim2.new(1, -50, 1, 0)

SearchBox.ClearTextOnFocus = false
SearchBox.Text = ""
SearchBox.PlaceholderText = "Search games..."
SearchBox.PlaceholderColor3 = SUBTEXT

SearchBox.TextColor3 = TEXT
SearchBox.TextSize = 13
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

SearchBox.Parent = SearchFrame

SearchBox.Focused:Connect(function()
    Tween(SearchStroke, .15, {
        Transparency = 0.25,
        Color = ACCENT
    }):Play()
end)

SearchBox.FocusLost:Connect(function()
    Tween(SearchStroke, .15, {
        Transparency = 0.7,
        Color = Color3.fromRGB(70, 80, 100)
    }):Play()
end)

--==================================================
-- GAME SCROLL
--==================================================

local GameScroll = Instance.new("ScrollingFrame")
GameScroll.Name = "GameScroll"

GameScroll.Position = UDim2.new(0, 14, 0, 117)
GameScroll.Size = UDim2.new(1, -28, 1, -132)

GameScroll.BackgroundTransparency = 1
GameScroll.BorderSizePixel = 0

GameScroll.ScrollBarThickness = 3
GameScroll.ScrollBarImageColor3 = ACCENT
GameScroll.ScrollBarImageTransparency = 0.25

GameScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
GameScroll.ScrollingDirection = Enum.ScrollingDirection.Y
GameScroll.Parent = Main

--==================================================
-- GRID
--==================================================

local Grid = Instance.new("UIGridLayout")
Grid.Name = "Grid"

Grid.CellPadding = UDim2.new(0, 9, 0, 9)
Grid.CellSize = UDim2.new(0.5, -5, 0, 70)

Grid.SortOrder = Enum.SortOrder.LayoutOrder

Grid.Parent = GameScroll

--==================================================
-- PADDING
--==================================================

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 3)
Padding.PaddingBottom = UDim.new(0, 10)
Padding.PaddingLeft = UDim.new(0, 2)
Padding.PaddingRight = UDim.new(0, 2)
Padding.Parent = GameScroll

--==================================================
-- NO RESULTS
--==================================================

local NoResults = Instance.new("Frame")
NoResults.Name = "NoResults"

NoResults.Size = UDim2.new(1, -10, 0, 100)
NoResults.BackgroundTransparency = 1
NoResults.Visible = false
NoResults.Parent = Main

local NoText = Instance.new("TextLabel")
NoText.BackgroundTransparency = 1
NoText.Size = UDim2.new(1, 0, 0, 25)
NoText.Position = UDim2.new(0, 0, 0, 12)

NoText.Text = "No games found"
NoText.TextColor3 = TEXT
NoText.TextSize = 15
NoText.Font = Enum.Font.GothamBold
NoText.Parent = NoResults

local NoSub = Instance.new("TextLabel")
NoSub.BackgroundTransparency = 1
NoSub.Size = UDim2.new(1, 0, 0, 22)
NoSub.Position = UDim2.new(0, 0, 0, 40)

NoSub.Text = "Try another search"
NoSub.TextColor3 = SUBTEXT
NoSub.TextSize = 11
NoSub.Font = Enum.Font.Gotham
NoSub.Parent = NoResults

--==================================================
-- CARDS
--==================================================

local Cards = {}

local function CreateCard(gameData, index)

    local Card = Instance.new("TextButton")

    Card.Name = "Card_" .. gameData.Name
    Card.Text = ""
    Card.AutoButtonColor = false

    Card.BackgroundColor3 = CARD
    Card.BorderSizePixel = 0

    Card.LayoutOrder = index
    Card.Parent = GameScroll

    Corner(Card, 12)

    local CardStroke = Stroke(
        Card,
        Color3.fromRGB(70, 78, 98),
        0.78,
        1
    )

    --==================================================
    -- ICON BOX
    --==================================================

    local IconBox = Instance.new("Frame")

    IconBox.Size = UDim2.new(0, 44, 0, 44)
    IconBox.Position = UDim2.new(0, 10, 0.5, -22)

    IconBox.BackgroundColor3 = ICON_BG
    IconBox.BorderSizePixel = 0

    IconBox.Parent = Card

    Corner(IconBox, 11)

    local IconGradient = Instance.new("UIGradient")

    IconGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(
            0,
            Color3.fromRGB(38, 44, 58)
        ),

        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(28, 32, 43)
        )
    })

    IconGradient.Rotation = 90
    IconGradient.Parent = IconBox

    local Icon = Instance.new("TextLabel")

    Icon.BackgroundTransparency = 1
    Icon.Size = UDim2.fromScale(1, 1)

    Icon.Text = gameData.Icon
    Icon.TextSize = 20
    Icon.Font = Enum.Font.GothamBold

    Icon.TextColor3 = TEXT
    Icon.Parent = IconBox

    --==================================================
    -- NAME
    --==================================================

    local Name = Instance.new("TextLabel")

    Name.BackgroundTransparency = 1

    Name.Position = UDim2.new(0, 64, 0, 12)
    Name.Size = UDim2.new(1, -102, 0, 20)

    Name.Font = Enum.Font.GothamSemibold

    Name.Text = gameData.Name
    Name.TextSize = 13
    Name.TextColor3 = TEXT

    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextTruncate = Enum.TextTruncate.AtEnd

    Name.Parent = Card

    --==================================================
    -- DESCRIPTION
    --==================================================

    local Description = Instance.new("TextLabel")

    Description.BackgroundTransparency = 1

    Description.Position = UDim2.new(0, 64, 0, 35)
    Description.Size = UDim2.new(1, -106, 0, 17)

    Description.Font = Enum.Font.Gotham

    Description.Text = gameData.Description
    Description.TextSize = 10
    Description.TextColor3 = SUBTEXT

    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextTruncate = Enum.TextTruncate.AtEnd

    Description.Parent = Card

    --==================================================
    -- ARROW
    --==================================================

    local Arrow = Instance.new("TextLabel")

    Arrow.BackgroundTransparency = 1

    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.Position = UDim2.new(1, -11, 0.5, 0)

    Arrow.Size = UDim2.new(0, 20, 0, 25)

    Arrow.Text = "›"

    Arrow.TextColor3 = SUBTEXT
    Arrow.TextSize = 20
    Arrow.Font = Enum.Font.GothamBold

    Arrow.Parent = Card

    --==================================================
    -- CARD DATA
    --==================================================

    local cardData = {
        Button = Card,
        Data = gameData,
        Stroke = CardStroke,
        Arrow = Arrow,
    }

    table.insert(Cards, cardData)

    --==================================================
    -- HOVER
    --==================================================

    Card.MouseEnter:Connect(function()

        Tween(Card, .13, {
            BackgroundColor3 = CARD_HOVER
        }):Play()

        Tween(CardStroke, .13, {
            Transparency = 0.25,
            Color = ACCENT
        }):Play()

        Tween(IconBox, .13, {
            BackgroundColor3 = Color3.fromRGB(43, 50, 67)
        }):Play()

        Tween(Arrow, .13, {
            TextColor3 = ACCENT,
            Position = UDim2.new(1, -7, 0.5, 0)
        }):Play()

    end)

    Card.MouseLeave:Connect(function()

        Tween(Card, .13, {
            BackgroundColor3 = CARD
        }):Play()

        Tween(CardStroke, .13, {
            Transparency = 0.78,
            Color = Color3.fromRGB(70, 78, 98)
        }):Play()

        Tween(IconBox, .13, {
            BackgroundColor3 = ICON_BG
        }):Play()

        Tween(Arrow, .13, {
            TextColor3 = SUBTEXT,
            Position = UDim2.new(1, -11, 0.5, 0)
        }):Play()

    end)

    --==================================================
    -- CLICK
    --==================================================

    Card.Activated:Connect(function()

        ClickSound(Card)

        -- press animation
        Tween(Card, .07, {
            BackgroundColor3 = Color3.fromRGB(40, 46, 60)
        }):Play()

        Tween(IconBox, .07, {
            Size = UDim2.new(0, 40, 0, 40),
            Position = UDim2.new(0, 12, 0.5, -20)
        }):Play()

        task.wait(.07)

        Tween(Card, .1, {
            BackgroundColor3 = CARD_HOVER
        }):Play()

        Tween(IconBox, .1, {
            Size = UDim2.new(0, 44, 0, 44),
            Position = UDim2.new(0, 10, 0.5, -22)
        }):Play()

        -- callback
        if typeof(gameData.Action) == "function" then

            task.spawn(function()

                local success, err = pcall(
                    gameData.Action
                )

                if not success then
                    warn(
                        "[YUNGAKO HUB] " ..
                        tostring(gameData.Name) ..
                        " callback error: " ..
                        tostring(err)
                    )
                end

            end)

        end

    end)
end

--==================================================
-- CREATE CARDS
--==================================================

for i, gameData in ipairs(Games) do
    CreateCard(gameData, i)
end

--==================================================
-- UPDATE CANVAS
--==================================================

local function UpdateCanvas()

    local contentHeight =
        Grid.AbsoluteContentSize.Y

    GameScroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            contentHeight + 18
        )

end

Grid:GetPropertyChangedSignal(
    "AbsoluteContentSize"
):Connect(UpdateCanvas)

task.defer(UpdateCanvas)

--==================================================
-- SEARCH
--==================================================

local function SearchGames(query)

    query = string.lower(query or "")

    query = string.gsub(
        query,
        "^%s+",
        ""
    )

    query = string.gsub(
        query,
        "%s+$",
        ""
    )

    local visibleCount = 0

    for _, item in ipairs(Cards) do

        local name =
            string.lower(item.Data.Name)

        local description =
            string.lower(item.Data.Description)

        local found =
            query == ""
            or string.find(
                name,
                query,
                1,
                true
            )
            or string.find(
                description,
                query,
                1,
                true
            )

        item.Button.Visible = found

        if found then
            visibleCount += 1
        end
    end

    NoResults.Visible =
        visibleCount == 0

    if NoResults.Visible then

        NoResults.Position =
            UDim2.new(
                0,
                14,
                0,
                125
            )

        NoResults.Size =
            UDim2.new(
                1,
                -28,
                0,
                100
            )

    end

    GameScroll.CanvasPosition =
        Vector2.new(0, 0)

    task.defer(UpdateCanvas)

end

SearchBox:GetPropertyChangedSignal(
    "Text"
):Connect(function()

    SearchGames(
        SearchBox.Text
    )

end)

--==================================================
-- RESPONSIVE GRID
--==================================================

local function UpdateGrid()

    local width =
        Main.AbsoluteSize.X

    if width < 500 then

        -- phone portrait
        Grid.CellSize =
            UDim2.new(
                1,
                -2,
                0,
                70
            )

    elseif width < 850 then

        -- mobile landscape / small window
        Grid.CellSize =
            UDim2.new(
                0.5,
                -5,
                0,
                70
            )

    else

        -- desktop
        Grid.CellSize =
            UDim2.new(
                0.333,
                -7,
                0,
                70
            )

    end

    task.defer(UpdateCanvas)

end

Main:GetPropertyChangedSignal(
    "AbsoluteSize"
):Connect(UpdateGrid)

task.defer(UpdateGrid)

--==================================================
-- REOPEN BUTTON
--==================================================

local Reopen = Instance.new("TextButton")

Reopen.Name = "Reopen"

Reopen.AnchorPoint =
    Vector2.new(0, 0.5)

Reopen.Position =
    UDim2.new(0, 18, 0.7, 0)

Reopen.Size =
    UDim2.new(0, 48, 0, 48)

Reopen.BackgroundColor3 =
    Color3.fromRGB(24, 28, 38)

Reopen.BorderSizePixel = 0

Reopen.Text = "⚡"

Reopen.TextColor3 = TEXT
Reopen.TextSize = 20
Reopen.Font = Enum.Font.GothamBold

Reopen.Visible = false
Reopen.AutoButtonColor = false

Reopen.Parent = Gui

Corner(Reopen, 24)

local ReopenStroke =
    Stroke(
        Reopen,
        ACCENT,
        0.45,
        1
    )

--==================================================
-- REOPEN HOVER
--==================================================

Reopen.MouseEnter:Connect(function()

    Tween(Reopen, .13, {
        BackgroundColor3 =
            Color3.fromRGB(37, 44, 59)
    }):Play()

    Tween(ReopenStroke, .13, {
        Transparency = 0.05
    }):Play()

end)

Reopen.MouseLeave:Connect(function()

    Tween(Reopen, .13, {
        BackgroundColor3 =
            Color3.fromRGB(24, 28, 38)
    }):Play()

    Tween(ReopenStroke, .13, {
        Transparency = 0.45
    }):Play()

end)

--==================================================
-- MINIMIZE
--==================================================

Close.Activated:Connect(function()

    ClickSound(Close)

    Tween(Main, .18, {
        Size = UDim2.new(
            Main.Size.X.Scale,
            Main.Size.X.Offset,
            0,
            0
        )
    }):Play()

    task.wait(.18)

    Main.Visible = false
    Reopen.Visible = true

end)

--==================================================
-- REOPEN
--==================================================

Reopen.Activated:Connect(function()

    ClickSound(Reopen)

    Reopen.Visible = false
    Main.Visible = true

    Main.Size =
        UDim2.new(
            Main.Size.X.Scale,
            Main.Size.X.Offset,
            0,
            0
        )

    Tween(Main, .24, {
        Size =
            UDim2.new(
                0.78,
                0,
                0.72,
                0
            )
    }):Play()

end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true

        DragStart =
            input.Position

        StartPosition =
            Main.Position

    end

end)

UIS.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ~=
        Enum.UserInputType.MouseMovement
        and input.UserInputType ~=
        Enum.UserInputType.Touch then

        return

    end

    local Delta =
        input.Position - DragStart

    Main.Position =
        UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

end)

UIS.InputEnded:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = false

    end

end)
--==================================================
-- REOPEN BUTTON DRAG
--==================================================

local ReopenDragging = false
local ReopenDragStart
local ReopenStartPosition

Reopen.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        ReopenDragging = true
        ReopenDragStart = input.Position
        ReopenStartPosition = Reopen.Position
    end
end)

UIS.InputChanged:Connect(function(input)

    if not ReopenDragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = input.Position - ReopenDragStart

    Reopen.Position = UDim2.new(
        ReopenStartPosition.X.Scale,
        ReopenStartPosition.X.Offset + Delta.X,
        ReopenStartPosition.Y.Scale,
        ReopenStartPosition.Y.Offset + Delta.Y
    )
end)

UIS.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        ReopenDragging = false
    end
end)

--==================================================
-- OPEN ANIMATION
--==================================================

Main.Size =
    UDim2.new(
        0.78,
        0,
        0,
        0
    )

Tween(Main, .3, {
    Size =
        UDim2.new(
            0.78,
            0,
            0.72,
            0
        )
}):Play()

--==================================================
-- FINAL
--==================================================

print(
    "[YUNGAKO HUB] UI v2 loaded - " ..
    tostring(#Games) ..
    " games"
)
