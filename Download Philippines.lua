--[[
    UFO HUB X • Download Screen (Philippines 🇵🇭)
    BG Image: 130548594326307
    Title PH: "Sentro ng UFO HUB X"
      - "UFO" = white
      - "HUB X" = green
    Progress: 0 → 100% in 5 seconds
    Flag 🇵🇭 large, attached to green bar
    Fade out after complete
]]

local Players      = game:GetService("Players")
local CoreGui      = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- remove old UI
local OLD = CoreGui:FindFirstChild("UFOX_DownloadScreen")
if OLD then OLD:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "UFOX_DownloadScreen"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = CoreGui

-- Background
local bg = Instance.new("ImageLabel")
bg.Parent = gui
bg.Size = UDim2.fromScale(1,1)
bg.Position = UDim2.fromScale(0.5,0.5)
bg.AnchorPoint = Vector2.new(0.5,0.5)
bg.BackgroundTransparency = 1
bg.Image = "rbxassetid://130548594326307"
bg.ScaleType = Enum.ScaleType.Crop
bg.ImageTransparency = 0

---------------------------------------------------------------------
-- TITLE: Sentro ng UFO HUB X (PH)
---------------------------------------------------------------------
local fullText = "Sentro ng UFO HUB X"
local hubIndex = string.find(fullText, "HUB X", 1, true) or (#fullText + 1)

local title = Instance.new("TextLabel")
title.Parent = gui
title.AnchorPoint = Vector2.new(0.5,0.5)
title.Position = UDim2.new(0.5,0,0.32,0)
title.Size = UDim2.new(0.9,0,0,90)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.RichText = true
title.TextScaled = true
title.TextStrokeColor3 = Color3.new(0,0,0)
title.TextStrokeTransparency = 0
title.TextColor3 = Color3.new(1,1,1)
title.Text = ""

local totalTime = 4
local steps = #fullText
local stepDelay = totalTime / steps

task.spawn(function()
    for i = 1, steps do
        local partial = fullText:sub(1, i)

        if i < hubIndex then
            title.Text = partial  -- all white before HUB X
        else
            local whitePart = partial:sub(1, hubIndex - 1)
            local greenPart = partial:sub(hubIndex)

            title.Text = string.format(
                '%s<font color="rgb(25,255,125)">%s</font>',
                whitePart, greenPart
            )
        end

        task.wait(stepDelay)
    end
end)

---------------------------------------------------------------------
-- Progress Bar
---------------------------------------------------------------------
local barHolder = Instance.new("Frame")
barHolder.Parent = gui
barHolder.AnchorPoint = Vector2.new(0.5,0.5)
barHolder.Position = UDim2.new(0.5,0,0.55,0)
barHolder.Size = UDim2.new(0.65,0,0,42)
barHolder.BackgroundColor3 = Color3.new(0,0,0)
barHolder.BackgroundTransparency = 0.25
barHolder.ClipsDescendants = false

Instance.new("UICorner", barHolder).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", barHolder).Thickness = 2

local fill = Instance.new("Frame")
fill.Parent = barHolder
fill.AnchorPoint = Vector2.new(0,0.5)
fill.Position = UDim2.new(0,3,0.5,0)
fill.Size = UDim2.new(0,-6,1,-8)
fill.BackgroundColor3 = Color3.fromRGB(25,255,125)

Instance.new("UICorner", fill).CornerRadius = UDim.new(0,14)

-- Philippine Flag 🇵🇭
local flag = Instance.new("TextLabel")
flag.Parent = fill
flag.BackgroundTransparency = 1
flag.AnchorPoint = Vector2.new(0.5,0.5)
flag.Position = UDim2.new(1, 24, 0.5, 0)
flag.Size = UDim2.new(0, 70, 0, 70)
flag.Font = Enum.Font.GothamBold
flag.TextScaled = true
flag.Text = "🇵🇭"
flag.ZIndex = 20

-- Text: PH
local label = Instance.new("TextLabel")
label.Parent = barHolder
label.BackgroundTransparency = 1
label.Size = UDim2.new(1,0,1,0)
label.Font = Enum.Font.GothamBold
label.TextSize = 20
label.TextColor3 = Color3.new(1,1,1)
label.TextStrokeColor3 = Color3.new(0,0,0)
label.TextStrokeTransparency = 0
label.Text = "Nagda-download 0%"
label.ZIndex = 30

---------------------------------------------------------------------
-- Progress 0 → 100
---------------------------------------------------------------------

local duration = 5
local delayStep = duration / 100

task.spawn(function()
    for i = 0, 100 do
        local alpha = i / 100
        fill.Size = UDim2.new(alpha, -6, 1, -8)
        label.Text = ("Nagda-download %d%%"):format(i)
        task.wait(delayStep)
    end

    -- Fade out
    local fade = 0.6
    TweenService:Create(bg, TweenInfo.new(fade), {ImageTransparency = 1}):Play()
    TweenService:Create(title, TweenInfo.new(fade), {TextTransparency = 1}):Play()
    TweenService:Create(label, TweenInfo.new(fade), {TextTransparency = 1}):Play()
    TweenService:Create(barHolder, TweenInfo.new(fade), {BackgroundTransparency = 1}):Play()
    TweenService:Create(fill, TweenInfo.new(fade), {BackgroundTransparency = 1}):Play()

    task.wait(fade + 0.2)
    gui:Destroy()
end)
