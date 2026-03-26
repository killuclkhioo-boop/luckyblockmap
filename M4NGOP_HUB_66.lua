-- ╔══════════════════════════════════════╗
-- ║       M4NGOP HUB  v2.0               ║
-- ║   Auto Lucky Block • แมพ 662417684   ║
-- ╚══════════════════════════════════════╝

local Players        = game:GetService("Players")
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService     = game:GetService("RunService")

local LP      = Players.LocalPlayer
local PlaceId = game.PlaceId

-- ─── ตรวจสอบแมพ ───────────────────────────────────────────────
if PlaceId ~= 662417684 then
    local m = Instance.new("Message", workspace)
    m.Text = "[ M4NGOP HUB ]  ใช้แมพอื่นไม่ได้ครับ จาก M4NGOP"
    task.delay(5, function() m:Destroy() end)
    return
end

-- ─── สถานะ ────────────────────────────────────────────────────
local running   = false
local count     = 0
local startTick = 0
local loopTask  = nil
local DELAY     = 0.3        -- วินาที ระหว่างแต่ละ fire

-- ─── สีหลัก ───────────────────────────────────────────────────
local C = {
    bg       = Color3.fromRGB(8, 7, 14),
    panel    = Color3.fromRGB(14, 12, 24),
    card     = Color3.fromRGB(20, 17, 36),
    accent   = Color3.fromRGB(255, 140, 0),
    accent2  = Color3.fromRGB(255, 200, 60),
    green    = Color3.fromRGB(60, 220, 120),
    red      = Color3.fromRGB(220, 60, 60),
    text     = Color3.fromRGB(240, 235, 255),
    muted    = Color3.fromRGB(110, 100, 150),
    border   = Color3.fromRGB(45, 38, 75),
}

-- ─── Tween helper ─────────────────────────────────────────────
local function tw(obj, props, t, sty, dir)
    TweenService:Create(obj,
        TweenInfo.new(t or .22, sty or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props):Play()
end

-- ─── Stroke helper ────────────────────────────────────────────
local function stroke(parent, col, thick)
    local s = Instance.new("UIStroke", parent)
    s.Color     = col or C.border
    s.Thickness = thick or 1
    return s
end

-- ─── Corner helper ────────────────────────────────────────────
local function corner(parent, r)
    local c2 = Instance.new("UICorner", parent)
    c2.CornerRadius = UDim.new(0, r or 10)
    return c2
end

-- ═══════════════════════════════════════════════════════════════
--  BUILD GUI
-- ═══════════════════════════════════════════════════════════════
local gui = Instance.new("ScreenGui")
gui.Name            = "M4NGOPv2"
gui.ResetOnSpawn    = false
gui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder    = 9999
gui.Parent          = LP.PlayerGui

-- ── Outer glow ring ──────────────────────────────────────────
local glowRing = Instance.new("Frame", gui)
glowRing.Size              = UDim2.new(0, 296, 0, 310)
glowRing.Position          = UDim2.new(0.5, -148, 0.5, -155)
glowRing.BackgroundColor3  = C.accent
glowRing.BorderSizePixel   = 0
glowRing.ZIndex            = 0
corner(glowRing, 18)

-- ── Main window ───────────────────────────────────────────────
local win = Instance.new("Frame", gui)
win.Name             = "Win"
win.Size             = UDim2.new(0, 290, 0, 304)
win.Position         = UDim2.new(0.5, -145, 0.5, -152)
win.BackgroundColor3 = C.bg
win.BorderSizePixel  = 0
win.ZIndex           = 2
corner(win, 16)

-- ── Header bar ────────────────────────────────────────────────
local header = Instance.new("Frame", win)
header.Size             = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = C.accent
header.BorderSizePixel  = 0
header.ZIndex           = 3
corner(header, 16)

-- Square off bottom of header
local hFix = Instance.new("Frame", header)
hFix.Size             = UDim2.new(1, 0, 0, 16)
hFix.Position         = UDim2.new(0, 0, 1, -16)
hFix.BackgroundColor3 = C.accent
hFix.BorderSizePixel  = 0

-- Diamond icon background
local iconBg = Instance.new("Frame", header)
iconBg.Size             = UDim2.new(0, 32, 0, 32)
iconBg.Position         = UDim2.new(0, 12, 0.5, -16)
iconBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
iconBg.BackgroundTransparency = 0.75
iconBg.BorderSizePixel  = 0
iconBg.ZIndex           = 4
corner(iconBg, 8)

local iconL = Instance.new("TextLabel", iconBg)
iconL.Text               = "M"
iconL.Size               = UDim2.fromScale(1,1)
iconL.BackgroundTransparency = 1
iconL.Font               = Enum.Font.GothamBold
iconL.TextSize           = 18
iconL.TextColor3         = Color3.fromRGB(255, 255, 255)
iconL.ZIndex             = 5

local titleL = Instance.new("TextLabel", header)
titleL.Text              = "M4NGOP HUB"
titleL.Size              = UDim2.new(1,-120, 0, 22)
titleL.Position          = UDim2.new(0, 52, 0, 8)
titleL.BackgroundTransparency = 1
titleL.Font              = Enum.Font.GothamBold
titleL.TextSize          = 15
titleL.TextColor3        = Color3.fromRGB(255, 255, 255)
titleL.TextXAlignment    = Enum.TextXAlignment.Left
titleL.ZIndex            = 4

local subtitleL = Instance.new("TextLabel", header)
subtitleL.Text           = "Auto Lucky Block  •  662417684"
subtitleL.Size           = UDim2.new(1,-120, 0, 14)
subtitleL.Position       = UDim2.new(0, 52, 0, 30)
subtitleL.BackgroundTransparency = 1
subtitleL.Font           = Enum.Font.Gotham
subtitleL.TextSize       = 10
subtitleL.TextColor3     = Color3.fromRGB(255, 230, 170)
subtitleL.TextXAlignment = Enum.TextXAlignment.Left
subtitleL.ZIndex         = 4

-- Min & Close buttons
local function makeHeaderBtn(xOff, bgCol, txt)
    local b = Instance.new("TextButton", header)
    b.Size             = UDim2.new(0, 26, 0, 26)
    b.Position         = UDim2.new(1, xOff, 0.5, -13)
    b.BackgroundColor3 = bgCol
    b.BorderSizePixel  = 0
    b.Font             = Enum.Font.GothamBold
    b.TextSize         = 12
    b.TextColor3       = Color3.fromRGB(255,255,255)
    b.Text             = txt
    b.ZIndex           = 5
    corner(b, 7)
    return b
end

local minBtn   = makeHeaderBtn(-60, Color3.fromRGB(255,255,255), "–")
minBtn.BackgroundTransparency = 0.65
local closeBtn = makeHeaderBtn(-30, Color3.fromRGB(210, 55, 55), "✕")

-- ── Content area ──────────────────────────────────────────────
local content = Instance.new("Frame", win)
content.Size             = UDim2.new(1, 0, 1, -52)
content.Position         = UDim2.new(0, 0, 0, 52)
content.BackgroundTransparency = 1
content.ZIndex           = 3

-- Padding
local pad = Instance.new("UIPadding", content)
pad.PaddingLeft   = UDim.new(0,14)
pad.PaddingRight  = UDim.new(0,14)
pad.PaddingTop    = UDim.new(0,14)
pad.PaddingBottom = UDim.new(0,10)

local layout = Instance.new("UIListLayout", content)
layout.Padding           = UDim.new(0, 10)
layout.SortOrder         = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ─── STAT CARDS (เสก / เวลา) ─────────────────────────────────
local statRow = Instance.new("Frame", content)
statRow.Size             = UDim2.new(1, 0, 0, 58)
statRow.BackgroundTransparency = 1
statRow.LayoutOrder      = 1

local statGrid = Instance.new("UIGridLayout", statRow)
statGrid.CellSize        = UDim2.new(0.5, -5, 1, 0)
statGrid.CellPadding     = UDim2.new(0, 10, 0, 0)

local function makeStatCard(labelTxt, defaultVal)
    local card = Instance.new("Frame", statRow)
    card.BackgroundColor3 = C.card
    card.BorderSizePixel  = 0
    corner(card, 10)
    stroke(card, C.border, 1)

    local lbl = Instance.new("TextLabel", card)
    lbl.Text             = labelTxt
    lbl.Size             = UDim2.new(1,0, 0, 16)
    lbl.Position         = UDim2.new(0,0, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.Font             = Enum.Font.Gotham
    lbl.TextSize         = 10
    lbl.TextColor3       = C.muted
    lbl.ZIndex           = 4

    local val = Instance.new("TextLabel", card)
    val.Text             = defaultVal
    val.Size             = UDim2.new(1,-8, 0, 24)
    val.Position         = UDim2.new(0,4, 0, 26)
    val.BackgroundTransparency = 1
    val.Font             = Enum.Font.GothamBold
    val.TextSize         = 20
    val.TextColor3       = C.accent
    val.ZIndex           = 4

    return val
end

local countVal = makeStatCard("จำนวนที่เสก", "0")
local timeVal  = makeStatCard("เวลาที่ใช้", "0s")

-- ─── STATUS PILL ──────────────────────────────────────────────
local statusRow = Instance.new("Frame", content)
statusRow.Size             = UDim2.new(1, 0, 0, 32)
statusRow.BackgroundColor3 = C.card
statusRow.BorderSizePixel  = 0
statusRow.LayoutOrder      = 2
corner(statusRow, 8)
stroke(statusRow, C.border, 1)

local dot = Instance.new("Frame", statusRow)
dot.Size             = UDim2.new(0, 8, 0, 8)
dot.Position         = UDim2.new(0, 12, 0.5, -4)
dot.BackgroundColor3 = C.muted
dot.BorderSizePixel  = 0
corner(dot, 99)

local statusL = Instance.new("TextLabel", statusRow)
statusL.Text             = "ปิดอยู่  —  กดปุ่มด้านล่างเพื่อเริ่ม"
statusL.Size             = UDim2.new(1,-28, 1, 0)
statusL.Position         = UDim2.new(0, 28, 0, 0)
statusL.BackgroundTransparency = 1
statusL.Font             = Enum.Font.Gotham
statusL.TextSize         = 11
statusL.TextColor3       = C.muted
statusL.TextXAlignment   = Enum.TextXAlignment.Left
statusL.ZIndex           = 4

-- ─── BIG TOGGLE BUTTON ───────────────────────────────────────
local toggleOuter = Instance.new("Frame", content)
toggleOuter.Size             = UDim2.new(1, 0, 0, 72)
toggleOuter.BackgroundColor3 = C.accent
toggleOuter.BorderSizePixel  = 0
toggleOuter.LayoutOrder      = 3
corner(toggleOuter, 14)

local toggleBtn = Instance.new("TextButton", toggleOuter)
toggleBtn.Size             = UDim2.new(1, -4, 1, -4)
toggleBtn.Position         = UDim2.new(0, 2, 0, 2)
toggleBtn.BackgroundColor3 = C.card
toggleBtn.BorderSizePixel  = 0
toggleBtn.Font             = Enum.Font.GothamBold
toggleBtn.TextSize         = 18
toggleBtn.TextColor3       = C.accent
toggleBtn.Text             = "เปิดออโต้เสก"
toggleBtn.ZIndex           = 4
corner(toggleBtn, 12)

-- subtle top line inside button
local topLine = Instance.new("Frame", toggleBtn)
topLine.Size             = UDim2.new(0.5, 0, 0, 1)
topLine.Position         = UDim2.new(0.25, 0, 0, 10)
topLine.BackgroundColor3 = C.accent
topLine.BackgroundTransparency = 0.7
topLine.BorderSizePixel  = 0

local toggleSub = Instance.new("TextLabel", toggleBtn)
toggleSub.Text             = "แตะเพื่อเปิด / ปิด"
toggleSub.Size             = UDim2.new(1, 0, 0, 14)
toggleSub.Position         = UDim2.new(0, 0, 1, -18)
toggleSub.BackgroundTransparency = 1
toggleSub.Font             = Enum.Font.Gotham
toggleSub.TextSize         = 10
toggleSub.TextColor3       = C.muted
toggleSub.ZIndex           = 5

-- ─── LOG STRIP ────────────────────────────────────────────────
local logFrame = Instance.new("ScrollingFrame", content)
logFrame.Size             = UDim2.new(1, 0, 0, 44)
logFrame.BackgroundColor3 = C.card
logFrame.BorderSizePixel  = 0
logFrame.ScrollBarThickness = 2
logFrame.CanvasSize        = UDim2.new(0,0,0,0)
logFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
logFrame.LayoutOrder      = 4
corner(logFrame, 8)
stroke(logFrame, C.border, 1)

local logLayout = Instance.new("UIListLayout", logFrame)
logLayout.Padding    = UDim.new(0,1)
logLayout.SortOrder  = Enum.SortOrder.LayoutOrder

local logPad = Instance.new("UIPadding", logFrame)
logPad.PaddingLeft  = UDim.new(0,8)
logPad.PaddingRight = UDim.new(0,4)
logPad.PaddingTop   = UDim.new(0,4)

local logIndex = 0
local function addLog(msg, col)
    logIndex += 1
    local lbl = Instance.new("TextLabel", logFrame)
    lbl.Name             = "L"..logIndex
    lbl.Text             = "› " .. msg
    lbl.Size             = UDim2.new(1,-4, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Font             = Enum.Font.Code
    lbl.TextSize         = 10
    lbl.TextColor3       = col or C.muted
    lbl.TextXAlignment   = Enum.TextXAlignment.Left
    lbl.ZIndex           = 4
    lbl.LayoutOrder      = logIndex
    -- ลบเก่า
    local all = logFrame:GetChildren()
    local lbls = {}
    for _, c in ipairs(all) do
        if c:IsA("TextLabel") then table.insert(lbls, c) end
    end
    if #lbls > 12 then
        table.sort(lbls, function(a,b) return a.LayoutOrder < b.LayoutOrder end)
        lbls[1]:Destroy()
    end
    task.wait()
    logFrame.CanvasPosition = Vector2.new(0, math.huge)
end

-- ═══════════════════════════════════════════════════════════════
--  MINI (ย่อ)
-- ═══════════════════════════════════════════════════════════════
local mini = Instance.new("Frame", gui)
mini.Name             = "Mini"
mini.Size             = UDim2.new(0, 170, 0, 38)
mini.Position         = win.Position
mini.BackgroundColor3 = C.bg
mini.BorderSizePixel  = 0
mini.Visible          = false
mini.ZIndex           = 10
corner(mini, 10)
stroke(mini, C.accent, 1.5)

local miniL = Instance.new("TextLabel", mini)
miniL.Text            = "M4NGOP HUB"
miniL.Size            = UDim2.new(1,-40,1,0)
miniL.Position        = UDim2.new(0,12,0,0)
miniL.BackgroundTransparency = 1
miniL.Font            = Enum.Font.GothamBold
miniL.TextSize        = 12
miniL.TextColor3      = C.accent
miniL.TextXAlignment  = Enum.TextXAlignment.Left

local miniDot = Instance.new("Frame", mini)
miniDot.Size          = UDim2.new(0,7,0,7)
miniDot.Position      = UDim2.new(1,-38,0.5,-3.5)
miniDot.BackgroundColor3 = C.muted
miniDot.BorderSizePixel = 0
corner(miniDot, 99)

local maxBtn = Instance.new("TextButton", mini)
maxBtn.Text           = "□"
maxBtn.Size           = UDim2.new(0,26,0,26)
maxBtn.Position       = UDim2.new(1,-30,0.5,-13)
maxBtn.BackgroundTransparency = 1
maxBtn.BorderSizePixel = 0
maxBtn.Font           = Enum.Font.GothamBold
maxBtn.TextSize       = 14
maxBtn.TextColor3     = C.accent

-- ═══════════════════════════════════════════════════════════════
--  DRAGGING  (PC + มือถือ)
-- ═══════════════════════════════════════════════════════════════
local function makeDraggable(frame, handle)
    local drag, ds, sp = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = i.Position; sp = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
                  or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            frame.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X,
                                       sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then drag = false end
    end)
end

makeDraggable(win,  header)
makeDraggable(mini, mini)

-- ═══════════════════════════════════════════════════════════════
--  LOGIC
-- ═══════════════════════════════════════════════════════════════
local function setRunning(val)
    running = val
    if running then
        -- OPEN state
        toggleOuter.BackgroundColor3 = C.green
        toggleBtn.BackgroundColor3   = Color3.fromRGB(14, 32, 20)
        toggleBtn.TextColor3         = C.green
        toggleBtn.Text               = "กำลังเสกอยู่..."
        dot.BackgroundColor3         = C.green
        statusL.Text                 = "กำลังทำงาน  —  ออโต้ fire รัวๆ"
        statusL.TextColor3           = C.green
        miniDot.BackgroundColor3     = C.green
        startTick = tick()

        -- pulse dot
        task.spawn(function()
            while running do
                tw(dot, {BackgroundTransparency=0.6}, 0.45)
                task.wait(0.45)
                tw(dot, {BackgroundTransparency=0}, 0.45)
                task.wait(0.45)
            end
        end)

        loopTask = task.spawn(function()
            while running do
                local ok, err = pcall(function()
                    ReplicatedStorage:WaitForChild("SpawnLuckyBlock", 3):FireServer()
                end)
                count += 1
                countVal.Text = tostring(count)
                if not ok then
                    addLog("ERR: "..tostring(err), Color3.fromRGB(220,80,80))
                end
                task.wait(DELAY)
            end
        end)

        addLog("เปิดออโต้เสก (delay "..DELAY.."s)", C.accent)
    else
        -- CLOSED state
        if loopTask then task.cancel(loopTask); loopTask = nil end
        toggleOuter.BackgroundColor3 = C.accent
        toggleBtn.BackgroundColor3   = C.card
        toggleBtn.TextColor3         = C.accent
        toggleBtn.Text               = "เปิดออโต้เสก"
        dot.BackgroundColor3         = C.muted
        statusL.Text                 = "ปิดอยู่  —  กดปุ่มด้านล่างเพื่อเริ่ม"
        statusL.TextColor3           = C.muted
        miniDot.BackgroundColor3     = C.muted
        addLog("ปิดออโต้เสก  (เสกทั้งหมด "..count.." ครั้ง)", Color3.fromRGB(200,180,100))
    end
end

-- update timer every second
task.spawn(function()
    while gui.Parent do
        if running then
            local elapsed = math.floor(tick() - startTick)
            timeVal.Text = tostring(elapsed).."s"
        end
        task.wait(1)
    end
end)

-- ─── Button events ────────────────────────────────────────────
local function onToggle()
    setRunning(not running)
end
toggleBtn.MouseButton1Click:Connect(onToggle)
toggleBtn.TouchTap:Connect(onToggle)

-- Hover glow on toggle
toggleBtn.MouseEnter:Connect(function()
    tw(toggleOuter, {BackgroundColor3 = running and C.green or C.accent2}, .15)
end)
toggleBtn.MouseLeave:Connect(function()
    tw(toggleOuter, {BackgroundColor3 = running and C.green or C.accent}, .15)
end)

-- Minimize / Maximize
local function doMin()
    mini.Position = win.Position
    mini.Visible  = true
    win.Visible   = false
    glowRing.Visible = false
end
local function doMax()
    win.Position  = mini.Position
    win.Visible   = true
    glowRing.Visible = true
    mini.Visible  = false
end
minBtn.MouseButton1Click:Connect(doMin)
minBtn.TouchTap:Connect(doMin)
maxBtn.MouseButton1Click:Connect(doMax)
maxBtn.TouchTap:Connect(doMax)

-- Close
local function doClose()
    setRunning(false)
    gui:Destroy()
end
closeBtn.MouseButton1Click:Connect(doClose)
closeBtn.TouchTap:Connect(doClose)

-- ─── Animate open ────────────────────────────────────────────
win.BackgroundTransparency   = 1
glowRing.BackgroundTransparency = 1
tw(win,      {BackgroundTransparency = 0}, .35)
tw(glowRing, {BackgroundTransparency = 0.82}, .35)

-- ─── Ready ───────────────────────────────────────────────────
addLog("M4NGOP HUB โหลดสำเร็จ!", C.accent)
addLog("แมพ: "..tostring(PlaceId), C.muted)
