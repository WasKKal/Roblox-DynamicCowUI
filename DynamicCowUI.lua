local svc = {
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
}

local RunService = svc.RunService
local TweenService = svc.TweenService
local UserInputService = svc.UserInputService

local HTTP_UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

local function httpGet(url)
    local req = request or http_request or (syn and syn.request) or (http and http.request)
    if req then
        local ok, res = pcall(req, {
            Url = url,
            Method = "GET",
            Headers = { ["User-Agent"] = HTTP_UA },
        })
        if ok then
            if type(res) == "table" then
                local body = res.Body or res.body
                if body and #body > 0 then return body end
            elseif type(res) == "string" and #res > 0 then
                return res
            end
        end
    end
    local ok, res = pcall(game.HttpGet, game, url)
    if ok and res then return res end
    return nil
end

local Config = {
    RainbowColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 128, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(128, 255, 0),
        Color3.fromRGB(0, 255, 128),
        Color3.fromRGB(0, 128, 255),
        Color3.fromRGB(128, 0, 255),
        Color3.fromRGB(255, 0, 128),
    },
    BorderThickness = 2,
    FlowSpeed = 28,
    FlowSpeedFast = 140,
    FadeInTime = 0.6,
    TargetTransparency = 0.5,
    ShrinkDelay = 1,
    ShrinkTime = 1.5,
    IslandSize = UDim2.new(0, 180, 0, 36),
    IslandPosition = UDim2.new(0.5, -90, 0, 10),
    IslandCornerRadius = UDim.new(0, 18),
    TitleText = "Dynamic Cow",
    TitleShrinkScale = 0.85,
    TitleShrinkTime = 0.6,
    FillTime = 0.5,
    LucideIcon = "check",
    LucideColor = Color3.fromRGB(0, 255, 120),
    LucideIconSize = 22,
    DefaultTitleIcon = "carton",
    DefaultTitleIconColor = Color3.new(1, 1, 1),
    RingThickness = 3,
    RingColor = Color3.fromRGB(0, 255, 120),
    RingSpeed = 120,
    BallSplitOffset = 50,
    BallSplitTime = 0.9,
    BallHoldTime = 1.5,
    IslandText = "DynamicCow",
    IslandTextColor = Color3.fromRGB(0, 255, 120),
    IslandTextSize = 20,
    CJKFont = Enum.Font.GothamMedium,
    TitleLeftShift = 10,
    IslandTapScale = 1.06,
    TapExpandTime = 0.25,
    TapShrinkTime = 0.3,
    TapCooldown = 0.2,
    TapWindow = 0.8,
    HintText = "长按灵动岛以展开面板",
    HintTextSize = 17,
    HintExtendPad = 36,
    HintHoldTime = 4,
    HintRevealStep = 0.04,
    HintRevealTime = 0.3,
    LongPressThreshold = 0.5,
    IslandDragThreshold = 8,
    IslandDragDamp = 0.55,
    IslandDragMax = 70,
    IslandDragFixed = 54,
    IslandDragStopDelay = 0.35,
    IslandDragHold = 1.5,
    PanelExpandTime = 0.55,
    PanelMargin = 20,
    BackdropDim = 0.4,
    IslandFinalTransparency = 0.4,
    ErrorText = "格式错误",
    ErrorTextColor = Color3.fromRGB(255, 80, 80),
    RedXColor = Color3.fromRGB(255, 60, 60),
    ParticleCount = 26,
    ParticleSize = 5,
    ParticleGravity = 700,
    InfoTextSize = 16,
    InfoColor = Color3.fromRGB(200, 205, 210),
    HeaderPad = 8,
    PanelDrop = 8,
    TitleDrop = 4,
    InfoRise = 3,
    TitleColor = Color3.new(1, 1, 1),
    TitleIconSize = 28,
    TitleIconGap = 10,
    TitleIconNudgeX = 4,
    InfoBoxHeight = 22,
    InfoTopGap = 4,
    IslandHandoffDelay = 0.1,
    IslandHandoffFade = 0.15,
    DividerColor = Color3.fromRGB(64, 64, 72),
    HeaderDividerGap = 12,
    TabAreaGap = 12,
    TabWidth = 130,
    TabRowHeight = 30,
    TabRowGap = 4,
    TabIconSize = 18,
    TabTextSize = 15,
    TabTextGap = 8,
    TabRowPadX = 6,
    TabActiveColor = Color3.fromRGB(255, 255, 255),
    TabInactiveColor = Color3.fromRGB(150, 152, 162),
    TabStagger = 0.06,
    TabFadeIn = 0.25,
    ContentEmptyIconSize = 48,
    PanelBounce = 0.7,
    InfoEnterDelay = 0.1,
    BorderSweepFade = 0.3,
    ContentEmptyIcon = "mouse-pointer-click",
    ContentEmptyText = "请先选中一个页面",
    ContentNoCtrlIcon = "ghost",
    ContentNoCtrlText = "这里还没有控件",
    ContentScrollBarThickness = 4,
    ContentScrollBarTransparency = 0.5,
    TabSelFill = Color3.fromRGB(34, 34, 42),
    TabSelFillTransparency = 0.15,
    TabSelStroke = Color3.new(1, 1, 1),
    TabSelStrokeThickness = 1,
    TabSelCorner = UDim.new(0, 8),
    SubTitleRowHeight = 30,
    SubTitleIconSize = 20,
    SubTitleTextSize = 16,
    SubTitleArrowSize = 18,
    SubTitleArrowRotate = -90,
    SubTitleColor = Color3.new(1, 1, 1),
    SubTitleBodyHeight = 48,
    SubTitleBodyFill = Color3.fromRGB(28, 28, 34),
    SubTitleBodyFillTransparency = 0.35,
    SubTitleDividerGap = 10,
    SubTitleBlockGap = 10,
    SubTitleCollapseTime = 0.3,
    SubTitleBodyPadY = 8,
    SubTitleBodyPadX = 4,
    ButtonHeight = 34,
    ButtonGap = 8,
    ButtonCorner = UDim.new(0.5, 0),
    ButtonFill = Color3.fromRGB(40, 40, 48),
    ButtonFillTransparency = 0.2,
    ButtonStroke = Color3.fromRGB(92, 94, 106),
    ButtonStrokeTransparency = 0.5,
    ButtonTextSize = 15,
    ButtonTextColor = Color3.new(1, 1, 1),
    ButtonIconSize = 18,
    ButtonIconGap = 8,
    ToggleWidth = 46,
    ToggleHeight = 26,
    TogglePad = 3,
    ToggleIconRatio = 0.6,
    ToggleTrackColor = Color3.fromRGB(72, 72, 84),
    ToggleThumbColor = Color3.new(1, 1, 1),
    ToggleOnColor = Color3.fromRGB(0, 200, 120),
    ToggleIconColor = Color3.fromRGB(44, 44, 54),
    ActionHoldTime = 3,
    ActionExtendW = 40,
    ActionExtendH = 12,
    NotifyDrop = 36,
    PageAnimTime = 0.28,
    CloseHoldTime = 0.45,
    CloseDialogW = 460,
    CloseDialogH = 168,
    CloseDialogFill = Color3.fromRGB(22, 22, 28),
    CloseDialogFillTransparency = 0.4,
    CloseDialogCorner = UDim.new(0, 18),
    CloseDialogPad = 22,
    CloseDialogBtnH = 42,
    CloseDialogBtnGap = 18,
    CloseDialogBtnW = 170,
    CloseDialogTextSize = 18,
    CloseDialogTextColor = Color3.new(1, 1, 1),
    CloseCancelColor = Color3.fromRGB(64, 64, 76),
    CloseConfirmColor = Color3.fromRGB(210, 66, 66),
    IslandActionStrokeTransparency = 0.35,
    IslandActionReveal = 0.3,
    ActionFlashTime = 0.3,
    ActionFlashHold = 0.25,
    ActionInterruptExit = 0.18,
    ParagraphIconSize = 18,
    ParagraphIconGap = 8,
    ParagraphTitleSize = 14,
    ParagraphTitleColor = Color3.new(1, 1, 1),
    ParagraphInfoSize = 12,
    ParagraphInfoColor = Color3.fromRGB(190, 195, 200),
    ParagraphTextGap = 2,
    ParagraphRowHeight = 48,
    ParagraphTitlePad = 2,
    ParagraphCorner = UDim.new(0, 8),
    ParagraphBackColor = Color3.fromRGB(34, 34, 42),
    ParagraphBackTransparency = 0.25,
    ParagraphBorderThickness = 1,
    ParagraphBackPad = 8,
    ParagraphDarken = 0.1,
    SliderRowHeight = 34,
    SliderTitleSize = 14,
    SliderTitleColor = Color3.new(1, 1, 1),
    SliderTitlePadX = 10,
    SliderTitleMinW = 40,
    SliderTitleGap = 10,
    SliderTrackVPad = 9,
    SliderTrackColor = Color3.fromRGB(58, 58, 70),
    SliderTrackTransparency = 0.35,
    SliderTrackCorner = UDim.new(0, 8),
    SliderFillColor = Color3.fromRGB(120, 160, 255),
    SliderThumbColor = Color3.fromRGB(245, 245, 248),
    SliderThumbSize = 16,
    SliderAnimTime = 0.3,
}

local Library = {}

-- 统一错误上报通道：所有错误都经由此处，默认用 warn() 打印到控制台。
-- 若已存在等价通道可忽略；外部可挂接 Library.OnError(msg) 订阅全部错误上报。
local function reportError(msg)
    msg = tostring(msg)
    warn("[DynamicCowUI] " .. msg)
    if type(Library.OnError) == "function" then
        pcall(Library.OnError, msg)
    end
end

local function darkenColor(c, amt)
    local r = c.R - amt
    local g = c.G - amt
    local b = c.B - amt
    if r < 0 then r = 0 end
    if g < 0 then g = 0 end
    if b < 0 then b = 0 end
    return Color3.new(r, g, b)
end

function Library.CreateWindow(opts)
    opts = opts or {}
    if Library._demoWin and not Library._demoWin._added then
        pcall(function() Library._demoWin:_closeNow() end)
        Library._demoWin = nil
    end
    -- 异常值检测：避免直接抛出报错，非法输入统一改为播放错误动画
    local isError = opts._error == true
    local errReason = isError and "CreateWindow 异常触发（缺失或未正常调用）" or nil
    local title = Config.TitleText
    local info = ""
    local iconName = Config.DefaultTitleIcon
    local iconColor = Config.DefaultTitleIconColor
    if not isError then
        if type(opts) ~= "table" then
            isError = true
            errReason = "CreateWindow 入参不是 table（收到 " .. type(opts) .. "）"
        elseif opts.Title ~= nil and (type(opts.Title) ~= "string" or #opts.Title == 0) then
            isError = true
            errReason = "CreateWindow Title 非法（收到 " .. type(opts.Title) .. "）"
        elseif opts.Title == nil then
            title = Config.TitleText
        else
            title = opts.Title
        end
        if not isError and opts.Info ~= nil then
            if type(opts.Info) ~= "string" then
                isError = true
                errReason = "CreateWindow Info 非法（收到 " .. type(opts.Info) .. "）"
            else
                info = opts.Info
            end
        end
        if not isError and opts.Icon ~= nil then
            if type(opts.Icon) ~= "string" then
                isError = true
                errReason = "CreateWindow Icon 非法（收到 " .. type(opts.Icon) .. "）"
            else
                iconName = opts.Icon
            end
        end
        if not isError and opts.IconColor ~= nil then
            if typeof(opts.IconColor) ~= "Color3" then
                isError = true
                errReason = "CreateWindow IconColor 非法（收到 " .. (typeof(opts.IconColor) or type(opts.IconColor)) .. "）"
            else
                iconColor = opts.IconColor
            end
        end
    end
    if isError then
        title = Config.ErrorText
        if opts._error ~= true then reportError(errReason) end
    end
    if isfolder and isfolder("lucide-icon-latest") then
        pcall(delfolder, "lucide-icon-latest")
    end

    local lucideModule = nil
    local function loadLucide()
        if lucideModule then return lucideModule end
        local content
        local localCachePath = "DynamicCowUI/Cache/lucide_v6.lua"
        if isfile and isfile(localCachePath) then
            local ok, lc = pcall(readfile, localCachePath)
            if ok and lc and #lc > 5000 and string.find(lc, "lucide%-icon%-latest") then content = lc end
        end
        if not content then
            local urls = {
                "https://gcore.jsdelivr.net/gh/WasKKal/DeltaExecutor-UI-Rebuild@lucide-v6/lucide/init.lua",
                "https://cdn.jsdelivr.net/gh/WasKKal/DeltaExecutor-UI-Rebuild@lucide-v6/lucide/init.lua",
                "https://raw.githubusercontent.com/WasKKal/DeltaExecutor-UI-Rebuild@lucide-v6/lucide/init.lua",
            }
            for _, url in ipairs(urls) do
                local res = httpGet(url)
                if res and #res > 5000 then content = res break end
                task.wait(0.3)
            end
            if content then
                pcall(function()
                    if isfolder and not isfolder("DynamicCowUI") then makefolder("DynamicCowUI") end
                    if isfolder and not isfolder("DynamicCowUI/Cache") then makefolder("DynamicCowUI/Cache") end
                    writefile(localCachePath, content)
                end)
            end
        end
        if not content then reportError("Lucide 资源下载失败，已取消加载 UI") return nil end
        local func, err = loadstring(content)
        if not func then reportError("Lucide 解析失败: " .. tostring(err)) return nil end
        local ok, module = pcall(func)
        if not ok or type(module) ~= "table" or type(module.GetAsset) ~= "function" then return nil end
        lucideModule = module
        return lucideModule
    end

    if not loadLucide() then
        reportError("Lucide 资源未就绪，已取消加载 UI")
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DynamicCowUI"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 100
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = gethui()

    local backdrop = Instance.new("Frame")
    backdrop.Name = "Backdrop"
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.Position = UDim2.new(0, 0, 0, 0)
    backdrop.BackgroundColor3 = Color3.new(0, 0, 0)
    backdrop.BackgroundTransparency = Config.BackdropDim
    backdrop.BorderSizePixel = 0
    backdrop.Parent = screenGui

    local edge = Instance.new("Frame")
    edge.Name = "EdgeFrame"
    local inset = Config.BorderThickness
    edge.Size = UDim2.new(1, -inset * 2, 1, -inset * 2)
    edge.Position = UDim2.new(0, inset, 0, inset)
    edge.BackgroundTransparency = 1
    edge.ClipsDescendants = true
    edge.BorderSizePixel = 0
    edge.Parent = screenGui

    local islandScale = Instance.new("UIScale")
    islandScale.Scale = 1
    islandScale.Parent = edge

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 0)
    corner.Parent = edge

    local fillFrame = Instance.new("Frame")
    fillFrame.Name = "FillFrame"
    fillFrame.Size = UDim2.new(0, 0, 0, 0)
    fillFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    fillFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    fillFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    fillFrame.BackgroundTransparency = 0
    fillFrame.BorderSizePixel = 0
    fillFrame.Parent = edge

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = Config.IslandCornerRadius
    fillCorner.Parent = fillFrame

    local contentRoot = Instance.new("CanvasGroup")
    contentRoot.Name = "ContentRoot"
    contentRoot.Size = UDim2.new(1, 0, 1, 0)
    contentRoot.Position = UDim2.new(0, 0, 0, 0)
    contentRoot.BackgroundTransparency = 1
    contentRoot.BorderSizePixel = 0
    contentRoot.ClipsDescendants = false
    contentRoot.ZIndex = 2
    contentRoot.Parent = edge

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = Config.BorderThickness
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Transparency = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    stroke.Parent = edge

    local fastColors = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(128, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
    })
    local rainbowColors = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.RainbowColors[1]),
        ColorSequenceKeypoint.new(0.14, Config.RainbowColors[2]),
        ColorSequenceKeypoint.new(0.28, Config.RainbowColors[3]),
        ColorSequenceKeypoint.new(0.42, Config.RainbowColors[4]),
        ColorSequenceKeypoint.new(0.57, Config.RainbowColors[5]),
        ColorSequenceKeypoint.new(0.71, Config.RainbowColors[6]),
        ColorSequenceKeypoint.new(0.85, Config.RainbowColors[7]),
        ColorSequenceKeypoint.new(1, Config.RainbowColors[8]),
    })
    local whiteToSilver = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180)),
    })
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 0
    gradient.Color = fastColors
    gradient.Parent = stroke

    local silverStroke = Instance.new("UIStroke")
    silverStroke.Thickness = Config.BorderThickness
    silverStroke.Color = Color3.new(1, 1, 1)
    silverStroke.Transparency = 1
    silverStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    silverStroke.Parent = edge

    local silverGradient = Instance.new("UIGradient")
    silverGradient.Rotation = 0
    silverGradient.Color = whiteToSilver
    silverGradient.Parent = silverStroke

    local titleFrame = Instance.new("Frame")
    titleFrame.Name = "TitleFrame"
    titleFrame.Size = UDim2.new(0, 600, 0, 140)
    titleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    titleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    titleFrame.BackgroundTransparency = 1
    titleFrame.BorderSizePixel = 0
    titleFrame.Parent = screenGui

    local titleScale = Instance.new("UIScale")
    titleScale.Scale = 1
    titleScale.Parent = titleFrame

    local glowLabel = Instance.new("TextLabel")
    glowLabel.Name = "GlowLabel"
    glowLabel.Size = UDim2.new(1, 0, 1, 0)
    glowLabel.BackgroundTransparency = 1
    glowLabel.Text = Config.IslandText
    glowLabel.TextColor3 = Color3.new(1, 1, 1)
    glowLabel.TextStrokeColor3 = Color3.new(1, 1, 1)
    glowLabel.TextStrokeTransparency = 1
    glowLabel.TextTransparency = 1
    glowLabel.TextSize = 64
    glowLabel.Font = Enum.Font.FredokaOne
    glowLabel.TextXAlignment = Enum.TextXAlignment.Center
    glowLabel.TextYAlignment = Enum.TextYAlignment.Center
    glowLabel.Parent = titleFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = Config.IslandText
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextStrokeTransparency = 1
    titleLabel.TextTransparency = 1
    titleLabel.TextSize = 64
    titleLabel.Font = Enum.Font.FredokaOne
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = titleFrame

    TweenService:Create(stroke, TweenInfo.new(Config.FadeInTime), {
        Transparency = Config.TargetTransparency,
    }):Play()

    TweenService:Create(glowLabel, TweenInfo.new(Config.FadeInTime), {
        TextTransparency = 0.5,
        TextStrokeTransparency = 0,
    }):Play()

    TweenService:Create(titleLabel, TweenInfo.new(Config.FadeInTime), {
        TextTransparency = 0,
    }):Play()

    local flowSpeed = Config.FlowSpeedFast
    RunService.Heartbeat:Connect(function(deltaTime)
        if not alive then return end
        gradient.Rotation = (gradient.Rotation + deltaTime * flowSpeed) % 360
    end)

    local function createCheckIcon(parent)
        local lucide = loadLucide()
        if not lucide then
            reportError("createCheckIcon: lucide 模块未就绪, 跳过图标")
            return
        end
        local ok, icon = pcall(lucide.GetAsset, Config.LucideIcon)
        if not ok then
            reportError("createCheckIcon: GetAsset 报错: " .. tostring(icon))
            return
        end
        if not icon or not icon.Url or icon.Url == "" then
            reportError("createCheckIcon: 图标 '" .. tostring(Config.LucideIcon) .. "' 资源为空 (getcustomasset/getsynasset 可能不可用), 跳过图标")
            return
        end

        local ringSize = Config.LucideIconSize + Config.RingThickness * 2 + 2
        local ring = Instance.new("Frame")
        ring.Name = "CheckRing"
        ring.Size = UDim2.new(0, ringSize, 0, ringSize)
        ring.Position = UDim2.new(0.5, 0, 0.5, 0)
        ring.AnchorPoint = Vector2.new(0.5, 0.5)
        ring.BackgroundTransparency = 1
        ring.BorderSizePixel = 0
        ring.Parent = parent

        local ringCorner = Instance.new("UICorner")
        ringCorner.CornerRadius = UDim.new(0.5, 0)
        ringCorner.Parent = ring

        local ringStroke = Instance.new("UIStroke")
        ringStroke.Thickness = Config.RingThickness
        ringStroke.Color = Config.RingColor
        ringStroke.Transparency = 1
        ringStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        ringStroke.Parent = ring

        local ringGradient = Instance.new("UIGradient")
        ringGradient.Rotation = 0
        ringGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.25, 0),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(0.75, 1),
            NumberSequenceKeypoint.new(1, 0),
        })
        ringGradient.Parent = ringStroke

        local screenGui = parent:FindFirstAncestorOfClass("ScreenGui")

        local img = Instance.new("ImageLabel")
        img.Name = "CheckIcon"
        img.Image = icon.Url
        img.Size = UDim2.new(0, Config.LucideIconSize, 0, Config.LucideIconSize)
        img.Position = parent.Position
        img.AnchorPoint = Vector2.new(0.5, 0.5)
        img.BackgroundTransparency = 1
        img.ImageColor3 = Config.LucideColor
        img.ScaleType = Enum.ScaleType.Fit
        img.ImageTransparency = 0
        if icon.ImageRectOffset then
            img.ImageRectOffset = icon.ImageRectOffset
            img.ImageRectSize = icon.ImageRectSize
        end
        img.Parent = screenGui

        TweenService:Create(ringStroke, TweenInfo.new(Config.FadeInTime), { Transparency = 0 }):Play()

        local trackConn
        trackConn = RunService.Heartbeat:Connect(function()
            if not parent or not parent.Parent then
                if img and img.Parent then img:Destroy() end
                if trackConn then trackConn:Disconnect() end
                return
            end
            img.Position = parent.Position
        end)

        task.delay(Config.BallHoldTime, function()
            if img and img.Parent then
                TweenService:Create(img, TweenInfo.new(Config.FadeInTime), { ImageTransparency = 1 }):Play()
            end
        end)

        RunService.Heartbeat:Connect(function(dt)
            ringGradient.Rotation = (ringGradient.Rotation + dt * Config.RingSpeed) % 360
        end)

        return ring
    end

    local function parseColoredChars(text, baseColor)
        local out = {}
        local color = baseColor
        local i = 1
        local n = #text
        while i <= n do
            local rest = string.sub(text, i)
            local s, e, hex = string.find(rest, "^<font%s+color%s*=%s*[\"']?(#?%x+)[\"']?%s*>")
            local closeTag = string.match(rest, "^</font%s*>")
            if s then
                local okc, c = pcall(Color3.fromHex, (string.gsub(hex, "#", "")))
                color = (okc and c) or color
                i = i + e
            elseif closeTag then
                color = baseColor
                i = i + #closeTag
            else
                local nxt = utf8.offset(text, 2, i) or (i + 1)
                out[#out + 1] = { ch = string.sub(text, i, nxt - 1), color = color }
                i = nxt
            end
        end
        return out
    end

    local function charIsCJK(ch)
        local ok, cp = pcall(utf8.codepoint, ch)
        if not ok then return false end
        return (cp >= 0x3000 and cp <= 0x303F)
            or (cp >= 0x3400 and cp <= 0x4DBF)
            or (cp >= 0x4E00 and cp <= 0x9FFF)
            or (cp >= 0xF900 and cp <= 0xFAFF)
            or (cp >= 0xFF00 and cp <= 0xFFEF)
            or (cp >= 0x20000 and cp <= 0x2FA1F)
    end

    local function charFont(ch)
        return charIsCJK(ch) and Config.CJKFont or Enum.Font.FredokaOne
    end

    local function textHasCJK(t)
        if type(t) ~= "string" then return false end
        for _, cp in utf8.codes(t) do
            if charIsCJK(utf8.char(cp)) then return true end
        end
        return false
    end

    local function measureTextWidth(text, size)
        local w = 0
        for _, cp in utf8.codes(text) do
            local ch = utf8.char(cp)
            if ch == " " then
                w = w + size * 0.32
            else
                local ok, s = pcall(function()
                    return game:GetService("TextService"):GetTextSize(ch, size, charFont(ch), Vector2.new(4000, 1))
                end)
                w = w + (ok and s.X or size)
            end
        end
        return w
    end

    local function createIslandText(text, color, instant)
        text = text or Config.IslandText
        color = color or Config.IslandTextColor
        local ballD = Config.IslandSize.Y.Offset
        local container = Instance.new("Frame")
        container.Name = "IslandTextContainer"
        container.Size = UDim2.new(0, Config.IslandSize.X.Offset - 8, 0, Config.IslandSize.Y.Offset - 8)
        container.Position = UDim2.new(
            Config.IslandPosition.X.Scale,
            Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2,
            Config.IslandPosition.Y.Scale,
            Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
        )
        container.AnchorPoint = Vector2.new(0.5, 0.5)
        container.BackgroundColor3 = Color3.new(0, 0, 0)
        container.BackgroundTransparency = 1
        container.BorderSizePixel = 0
        container.Parent = screenGui

        local textCorner = Instance.new("UICorner")
        textCorner.CornerRadius = Config.IslandCornerRadius
        textCorner.Parent = container

        local list = Instance.new("UIListLayout")
        list.FillDirection = Enum.FillDirection.Horizontal
        list.HorizontalAlignment = Enum.HorizontalAlignment.Center
        list.VerticalAlignment = Enum.VerticalAlignment.Center
        list.Parent = container

        local idx = 0
        for _, item in ipairs(parseColoredChars(text, color)) do
            local ch = item.ch
            if ch ~= " " then
                local charFrame = Instance.new("Frame")
                charFrame.Size = UDim2.new(0, 0, 1, 0)
                charFrame.AutomaticSize = Enum.AutomaticSize.X
                charFrame.BackgroundTransparency = 1
                charFrame.BorderSizePixel = 0
                charFrame.Parent = container

                local charLabel = Instance.new("TextLabel")
                charLabel.Size = UDim2.new(1, 0, 1, 0)
                charLabel.BackgroundTransparency = 1
                charLabel.Text = ch
                charLabel.TextColor3 = item.color
                charLabel.TextTransparency = 1
                charLabel.TextSize = Config.IslandTextSize
                charLabel.Font = charFont(ch)
                charLabel.TextXAlignment = Enum.TextXAlignment.Center
                charLabel.TextYAlignment = Enum.TextYAlignment.Center
                charLabel.Parent = charFrame

                if instant then
                    charLabel.Position = UDim2.new(0, 0, 0, 0)
                    charLabel.TextTransparency = 0
                else
                    local dir = (idx % 2 == 0) and -1 or 1
                    local offset = Config.IslandSize.Y.Offset + 8
                    charLabel.Position = UDim2.new(0, 0, 0, dir * offset)
                    TweenService:Create(charLabel, TweenInfo.new(
                        Config.TitleShrinkTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
                    ), {
                        Position = UDim2.new(0, 0, 0, 0),
                        TextTransparency = 0,
                    }):Play()
                end
                idx = idx + 1
            end
        end
        return container
    end

    local function setIslandText(text, color)
        text = text or Config.IslandText
        color = color or Config.TitleColor
        if not (islandTextContainer and islandTextContainer.Parent) then
            islandTextContainer = createIslandText(text, color, true)
            return
        end
        for _, child in ipairs(islandTextContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        for _, item in ipairs(parseColoredChars(text, color)) do
            local ch = item.ch
            if ch ~= " " then
                local charFrame = Instance.new("Frame")
                charFrame.Size = UDim2.new(0, 0, 1, 0)
                charFrame.AutomaticSize = Enum.AutomaticSize.X
                charFrame.BackgroundTransparency = 1
                charFrame.BorderSizePixel = 0
                charFrame.Parent = islandTextContainer
                local charLabel = Instance.new("TextLabel")
                charLabel.Size = UDim2.new(1, 0, 1, 0)
                charLabel.BackgroundTransparency = 1
                charLabel.Text = ch
                charLabel.TextColor3 = item.color
                charLabel.TextTransparency = 0
                charLabel.TextSize = Config.IslandTextSize
                charLabel.Font = charFont(ch)
                charLabel.TextXAlignment = Enum.TextXAlignment.Center
                charLabel.TextYAlignment = Enum.TextYAlignment.Center
                charLabel.Parent = charFrame
            end
        end
    end

    local expanded = false
    local winOpen = false
    local islandTextContainer = nil
    local alive = true
    local shutdown = false
    local ready = false
    local actionEnd = nil
    local win = { _tabs = {}, _activeTab = 0, _rebuildTabs = nil }
    local titleIcon = nil
    local infoLabel = nil
    local brandLbl = nil
    local titleGen = 0
    local titleTweens = {}
    local function cancelTitleTweens()
        for _, tw in ipairs(titleTweens) do
            pcall(function() tw:Cancel() end)
        end
        titleTweens = {}
    end

    local function animateEdge(targetSize, targetPos, dur, over, onDone)
        local s0 = edge.Size
        local p0 = edge.Position
        local c1 = over or Config.PanelBounce
        local c3 = c1 + 1
        local t0 = os.clock()
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not alive then if conn then conn:Disconnect() end return end
            local t = math.clamp((os.clock() - t0) / dur, 0, 1)
            local e = 1 + c3 * (t - 1) ^ 3 + c1 * (t - 1) ^ 2
            local function L(a, b) return a + (b - a) * e end
            edge.Size = UDim2.new(L(s0.X.Scale, targetSize.X.Scale), L(s0.X.Offset, targetSize.X.Offset), L(s0.Y.Scale, targetSize.Y.Scale), L(s0.Y.Offset, targetSize.Y.Offset))
            edge.Position = UDim2.new(L(p0.X.Scale, targetPos.X.Scale), L(p0.X.Offset, targetPos.X.Offset), L(p0.Y.Scale, targetPos.Y.Scale), L(p0.Y.Offset, targetPos.Y.Offset))
            if t >= 1 then
                if conn then conn:Disconnect() end
                edge.Size = targetSize
                edge.Position = targetPos
                if onDone then onDone() end
            end
        end)
    end

    local function playBorderSweep()
        if not alive then return end
        if gradient then
            gradient.Color = rainbowColors
            gradient.Rotation = 90
            gradient.Transparency = NumberSequence.new(0)
        end
        stroke.Transparency = 0
        silverStroke.Transparency = 1
        local dur = Config.PanelExpandTime
        local t0 = os.clock()
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not alive then if conn then conn:Disconnect() end return end
            local e = math.clamp((os.clock() - t0) / dur, 0, 1)
            if gradient then
                local a = math.min(e, 0.995)
                local b = math.min(a + 0.004, 0.999)
                gradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(a, 0),
                    NumberSequenceKeypoint.new(b, 1),
                    NumberSequenceKeypoint.new(1, 1),
                })
            end
            if e >= 1 then
                if conn then conn:Disconnect() end
                local fi = Config.BorderSweepFade
                TweenService:Create(stroke, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                TweenService:Create(silverStroke, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = Config.TargetTransparency }):Play()
                task.delay(fi, function()
                    if gradient then gradient.Transparency = NumberSequence.new(0) end
                end)
            end
        end)
    end

    local function explode()
        local sw = screenGui.AbsoluteSize.X
        local sh = screenGui.AbsoluteSize.Y
        local aPos = Vector2.new(
            Config.IslandPosition.X.Scale * sw + Config.IslandPosition.X.Offset,
            Config.IslandPosition.Y.Scale * sh + Config.IslandPosition.Y.Offset
        )
        local aSize = Vector2.new(Config.IslandSize.X.Offset, Config.IslandSize.Y.Offset)
        local cx = aPos.X + aSize.X / 2
        local cy = aPos.Y + aSize.Y / 2
        local iw = aSize.X
        local ih = aSize.Y
        local parts = {}
        for _ = 1, Config.ParticleCount do
            local p = Instance.new("Frame")
            p.Size = UDim2.fromOffset(Config.ParticleSize, Config.ParticleSize)
            p.BackgroundColor3 = Color3.new(1, 1, 1)
            p.BorderSizePixel = 0
            p.AnchorPoint = Vector2.new(0.5, 0.5)
            local px = cx + (math.random() * 2 - 1) * iw / 2
            local py = cy + (math.random() * 2 - 1) * ih / 2
            p.Position = UDim2.new(0, px, 0, py)
            p.Parent = screenGui
            local ang = math.random() * math.pi * 2
            local spd = 140 + math.random() * 220
            parts[#parts + 1] = { f = p, vx = math.cos(ang) * spd, vy = math.sin(ang) * spd - 160 }
        end
        local grav = Config.ParticleGravity
        local conn
        conn = RunService.Heartbeat:Connect(function(dt)
            if not alive then if conn then conn:Disconnect() end return end
            local sh = screenGui.AbsoluteSize.Y
            local any = false
            for _, pt in ipairs(parts) do
                local p = pt.f
                if p and p.Parent then
                    pt.vy = pt.vy + grav * dt
                    p.Position = UDim2.new(0, p.Position.X.Offset + pt.vx * dt, 0, p.Position.Y.Offset + pt.vy * dt)
                    if p.AbsolutePosition.Y > sh + 30 then p:Destroy() else any = true end
                end
            end
            if not any then if conn then conn:Disconnect() end end
        end)
    end

    local function splitBall(isError)
        local ballD = Config.IslandSize.Y.Offset
        local ballInitX = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset - ballD / 2
        local ballCenterY = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2

        local ball = Instance.new("Frame")
        ball.Name = "SplitBall"
        ball.Size = UDim2.new(0, ballD, 0, ballD)
        ball.Position = UDim2.new(0.5, ballInitX, 0, ballCenterY)
        ball.AnchorPoint = Vector2.new(0.5, 0.5)
        ball.BackgroundColor3 = Color3.new(0, 0, 0)
        ball.BackgroundTransparency = 0
        ball.BorderSizePixel = 0
        ball.ClipsDescendants = true
        ball.Parent = screenGui

        local ballCorner = Instance.new("UICorner")
        ballCorner.CornerRadius = UDim.new(0.5, 0)
        ballCorner.Parent = ball

        local splitTween = TweenService:Create(ball, TweenInfo.new(
            Config.BallSplitTime, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out
        ), {
            Position = UDim2.new(0.5, ballInitX + Config.BallSplitOffset, 0, ballCenterY),
        })
        splitTween:Play()
        if isError then
            local red = Config.RedXColor
            local function makeRedLine(rot)
                local f = Instance.new("Frame")
                f.Size = UDim2.new(0, 0, 0, 3)
                f.Position = UDim2.new(0.5, 0, 0.5, 0)
                f.AnchorPoint = Vector2.new(0.5, 0.5)
                f.BackgroundColor3 = red
                f.BorderSizePixel = 0
                f.Rotation = rot
                f.Parent = ball
                return f
            end
            local l1 = makeRedLine(45)
            local l2 = makeRedLine(-45)
            TweenService:Create(l1, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, ballD * 0.5, 0, 3) }):Play()
            task.delay(0.16, function()
                if l2 and l2.Parent then
                    TweenService:Create(l2, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, ballD * 0.5, 0, 3) }):Play()
                end
            end)
        else
            task.spawn(createCheckIcon, ball)
        end

        task.delay(Config.BallHoldTime, function()
            for _, node in ipairs(ball:GetChildren()) do
                if node.Name == "CheckRing" then
                    local rs = node:FindFirstChildOfClass("UIStroke")
                    if rs then TweenService:Create(rs, TweenInfo.new(Config.FadeInTime), { Transparency = 1 }):Play() end
                end
            end
            task.delay(Config.FadeInTime, function()
                local mergeTween = TweenService:Create(ball, TweenInfo.new(
                    Config.BallSplitTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out
                ), {
                    Position = UDim2.new(0.5, ballInitX, 0, ballCenterY),
                })
                mergeTween:Play()
                mergeTween.Completed:Connect(function()
                    if isError then
                        local fi = Config.FadeInTime
                        for _, node in ipairs(ball:GetChildren()) do
                            if node:IsA("GuiObject") then
                                TweenService:Create(node, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
                            end
                        end
                        TweenService:Create(ball, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
                        task.delay(fi, function() if ball and ball.Parent then ball:Destroy() end end)

                        flowSpeed = 0
                        TweenService:Create(stroke, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                        silverStroke.Color = Config.RedXColor
                        TweenService:Create(silverStroke, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = Config.TargetTransparency }):Play()

                        task.delay(0.2, function()
                            if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
                            islandTextContainer = createIslandText(Config.ErrorText, Config.ErrorTextColor, true)
                            explode()
                            for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                local lb = cf:FindFirstChildOfClass("TextLabel")
                                if lb then TweenService:Create(lb, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                            end
                            if fillFrame and fillFrame.Parent then
                                TweenService:Create(fillFrame, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
                            end
                            TweenService:Create(silverStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                            TweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                            task.delay(1.0, function()
                                alive = false
                                if screenGui and screenGui.Parent then screenGui:Destroy() end
                            end)
                        end)
                    else
                        if islandTextContainer then
                            for _, charFrame in ipairs(islandTextContainer:GetChildren()) do
                                local lbl = charFrame:FindFirstChildOfClass("TextLabel")
                                if lbl then
                                    TweenService:Create(lbl, TweenInfo.new(Config.FadeInTime), { TextColor3 = Color3.new(1, 1, 1) }):Play()
                                end
                            end
                        end
                        ball:Destroy()
                        task.delay(Config.IslandHandoffDelay, function()
                            if islandTextContainer and islandTextContainer.Parent then
                                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                    local lb = cf:FindFirstChildOfClass("TextLabel")
                                    if lb then TweenService:Create(lb, TweenInfo.new(Config.IslandHandoffFade, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                                end
                            end
                            task.delay(Config.IslandHandoffFade, function()
                                if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
                                islandTextContainer = createIslandText(title, Config.TitleColor, true)
                                ready = true
                            end)
                        end)
                        flowSpeed = 0
                        TweenService:Create(stroke, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                        TweenService:Create(silverStroke, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = Config.TargetTransparency }):Play()
                        TweenService:Create(fillFrame, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = Config.IslandFinalTransparency }):Play()
                    end
                end)
            end)
        end)
    end

    local function spawnRedXBall()
        local ballD = Config.IslandSize.Y.Offset
        local ballInitX = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset - ballD / 2
        local ballCenterY = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2

        local ball = Instance.new("Frame")
        ball.Name = "ErrorBall"
        ball.Size = UDim2.new(0, ballD, 0, ballD)
        ball.Position = UDim2.new(0.5, ballInitX, 0, ballCenterY)
        ball.AnchorPoint = Vector2.new(0.5, 0.5)
        ball.BackgroundColor3 = Color3.new(0, 0, 0)
        ball.BackgroundTransparency = 0
        ball.BorderSizePixel = 0
        ball.ClipsDescendants = true
        ball.Parent = screenGui

        local ballCorner = Instance.new("UICorner")
        ballCorner.CornerRadius = UDim.new(0.5, 0)
        ballCorner.Parent = ball

        local lineLen = ballD * 0.5
        local lineThick = 3
        local red = Config.RedXColor
        local function makeLine(rot)
            local f = Instance.new("Frame")
            f.Size = UDim2.new(0, 0, 0, lineThick)
            f.Position = UDim2.new(0.5, 0, 0.5, 0)
            f.AnchorPoint = Vector2.new(0.5, 0.5)
            f.BackgroundColor3 = red
            f.BorderSizePixel = 0
            f.Rotation = rot
            f.Parent = ball
            return f
        end
        local line1 = makeLine(45)
        local line2 = makeLine(-45)
        TweenService:Create(line1, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, lineLen, 0, lineThick) }):Play()
        task.delay(0.16, function()
            if line2 and line2.Parent then
                TweenService:Create(line2, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, lineLen, 0, lineThick) }):Play()
            end
        end)

        local splitTween = TweenService:Create(ball, TweenInfo.new(Config.BallSplitTime, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, ballInitX + Config.BallSplitOffset, 0, ballCenterY),
        })
        splitTween:Play()
        task.delay(Config.BallHoldTime, function()
            if not ball or not ball.Parent then return end
            local mergeTween = TweenService:Create(ball, TweenInfo.new(Config.BallSplitTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, ballInitX, 0, ballCenterY),
            })
            mergeTween:Play()
            mergeTween.Completed:Connect(function()
                for _, node in ipairs(ball:GetChildren()) do
                    if node:IsA("GuiObject") then
                        TweenService:Create(node, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
                    end
                end
                TweenService:Create(ball, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
                task.delay(Config.FadeInTime, function() if ball and ball.Parent then ball:Destroy() end end)
            end)
        end)
        return ball
    end

    local function playErrorSequence()
        expanded = false
        winOpen = false
        flowSpeed = 0
        if backdrop and backdrop.Parent then backdrop:Destroy() end
        -- 1) 渐隐：面板内所有控件（选项卡/按钮/开关等）与标题图标/副标题先淡出，避免被压缩进灵动岛
        local fadeDur = 0.35
        if contentRoot and contentRoot.Parent then
            TweenService:Create(contentRoot, TweenInfo.new(fadeDur, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { GroupTransparency = 1, BackgroundTransparency = 1 }):Play()
        end
        if titleIcon and titleIcon.Parent then
            TweenService:Create(titleIcon, TweenInfo.new(fadeDur, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
        end
        if brandLbl and brandLbl.Parent then brandLbl:Destroy() brandLbl = nil end
        if infoLabel and infoLabel.Parent then
            TweenService:Create(infoLabel, TweenInfo.new(fadeDur, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
        end
        -- 2) 收起：内容淡出后再把灵动岛胶囊复位（避免控件被压缩）
        task.delay(fadeDur, function()
            if not alive then return end
            edge.AnchorPoint = Vector2.new(0.5, 0.5)
            TweenService:Create(edge, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = Config.IslandSize, Position = UDim2.new(0.5, Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2, 0, Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2) }):Play()
            TweenService:Create(stroke, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
            TweenService:Create(silverStroke, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = Config.TargetTransparency }):Play()
            TweenService:Create(titleLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
            TweenService:Create(glowLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
            TweenService:Create(titleScale, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Scale = 1 }):Play()
            if fillFrame and fillFrame.Parent then
                TweenService:Create(fillFrame, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = Config.IslandFinalTransparency }):Play()
            end
        end)

        task.delay(0.5, function()
            if islandTextContainer and islandTextContainer.Parent then
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then TweenService:Create(lb, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                end
            end
        end)
        task.delay(0.75, function()
            if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
            islandTextContainer = createIslandText(Config.ErrorText, Config.ErrorTextColor)
        end)

        task.delay(fadeDur + 0.6, function()
            spawnRedXBall()
        end)

        task.delay(fadeDur + 0.6 + Config.BallHoldTime + 0.95, function()
            explode()
            if fillFrame and fillFrame.Parent then
                TweenService:Create(fillFrame, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
            end
            TweenService:Create(silverStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
            TweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
            task.delay(1.0, function()
                alive = false
                if screenGui and screenGui.Parent then screenGui:Destroy() end
            end)
        end)
    end

    task.delay(Config.ShrinkDelay, function()
        flowSpeed = Config.FlowSpeed
        gradient.Color = rainbowColors
        local shrinkTween = TweenService:Create(edge, TweenInfo.new(
            Config.ShrinkTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
        ), {
            Size = Config.IslandSize,
            Position = Config.IslandPosition,
        })
        shrinkTween:Play()
        TweenService:Create(corner, TweenInfo.new(
            Config.ShrinkTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out
        ), {
            CornerRadius = Config.IslandCornerRadius,
        }):Play()
        local titleShrinkTween = TweenService:Create(titleScale, TweenInfo.new(
            Config.TitleShrinkTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
        ), {
            Scale = Config.TitleShrinkScale,
        })
        titleShrinkTween:Play()
        TweenService:Create(backdrop, TweenInfo.new(
            Config.TitleShrinkTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
        ), {
            BackgroundTransparency = 1,
        }):Play()
        titleShrinkTween.Completed:Connect(function()
            TweenService:Create(titleLabel, TweenInfo.new(
                Config.TitleShrinkTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
            ), {
                TextTransparency = 1,
            }):Play()
        end)
        TweenService:Create(glowLabel, TweenInfo.new(
            Config.TitleShrinkTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
        ), {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
        }):Play()
        shrinkTween.Completed:Connect(function()
            local fillTween = TweenService:Create(fillFrame, TweenInfo.new(
                Config.FillTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
            ), {
                Size = UDim2.new(1, 0, 1, 0),
            })
            fillTween:Play()
            fillTween.Completed:Connect(function()
                if backdrop and backdrop.Parent then backdrop:Destroy() end
                islandTextContainer = createIslandText(Config.IslandText, Config.IslandTextColor)
                task.spawn(function() splitBall(isError) end)
                edge.AnchorPoint = Vector2.new(0.5, 0.5)
                edge.Position = UDim2.new(0.5, Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2, 0, Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2)
                edge.Active = true
                local interacting = false
                local holding = false
                local longPress = nil
                local dragStartX = nil
                local dragBaseSize = nil
                local dragging = false
                local dragStopTmr = nil
                local dragRestoreTmr = nil
                local tapCount = 0
                local tapWindowTmr = nil
                local hintActive = false
                local hintContainer = nil
                local hintTmr = nil
                local hintBaseSize = nil
                local hintBaseAnchor = nil
                local hintBasePos = nil
                local islandRest = UDim2.new(0.5, Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2, 0, Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2)
                local function clearHint()
                    if tapWindowTmr then task.cancel(tapWindowTmr) tapWindowTmr = nil end
                    if hintTmr then task.cancel(hintTmr) hintTmr = nil end
                    if hintContainer and hintContainer.Parent then hintContainer:Destroy() end
                    hintContainer = nil
                    if hintActive and edge and edge.Parent and hintBaseSize and not expanded then
                        if hintBaseAnchor then edge.AnchorPoint = hintBaseAnchor end
                        if hintBasePos then edge.Position = hintBasePos end
                        TweenService:Create(edge, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = hintBaseSize }):Play()
                    end
                    hintBaseSize = nil
                    hintBaseAnchor = nil
                    hintBasePos = nil
                    hintActive = false
                    if islandTextContainer and islandTextContainer.Parent then
                        for _, cf in ipairs(islandTextContainer:GetChildren()) do
                            local lb = cf:FindFirstChildOfClass("TextLabel")
                            if lb then TweenService:Create(lb, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
                        end
                    end
                end
                local function playHintAnimation()
                    if hintActive or expanded or not alive or not ready then return end
                    if actionBusy and actionEnd then actionEnd(true) end
                    hintActive = true
                    if islandTextContainer and islandTextContainer.Parent then
                        for _, cf in ipairs(islandTextContainer:GetChildren()) do
                            local lb = cf:FindFirstChildOfClass("TextLabel")
                            if lb then TweenService:Create(lb, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                        end
                    end
                    hintBaseSize = edge.Size
                    hintBaseAnchor = edge.AnchorPoint
                    hintBasePos = edge.Position
                    edge.AnchorPoint = Vector2.new(0.5, 0.5)
                    edge.Position = islandRest
                    local txt = Config.HintText
                    local tsize = Config.HintTextSize
                    local tw = measureTextWidth(txt, tsize) + Config.HintExtendPad
                    local baseW = Config.IslandSize.X.Offset
                    local targetW = math.max(baseW + 80, tw)
                    TweenService:Create(edge, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, targetW, 0, Config.IslandSize.Y.Offset),
                    }):Play()
                    local hc = Instance.new("Frame")
                    hc.Name = "IslandHintContainer"
                    hc.Size = UDim2.new(1, 0, 1, 0)
                    hc.BackgroundTransparency = 1
                    hc.BorderSizePixel = 0
                    hc.ClipsDescendants = true
                    hc.ZIndex = 55
                    hc.Parent = edge
                    local hl = Instance.new("UIListLayout")
                    hl.FillDirection = Enum.FillDirection.Horizontal
                    hl.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    hl.VerticalAlignment = Enum.VerticalAlignment.Center
                    hl.Parent = hc
                    local chars = {}
                    local idx = 0
                    for _, item in ipairs(parseColoredChars(txt, Config.TitleColor)) do
                        local ch = item.ch
                        if ch ~= " " then
                            local cf2 = Instance.new("Frame")
                            cf2.Size = UDim2.new(0, 0, 1, 0)
                            cf2.AutomaticSize = Enum.AutomaticSize.X
                            cf2.BackgroundTransparency = 1
                            cf2.BorderSizePixel = 0
                            cf2.Parent = hc
                            local cl = Instance.new("TextLabel")
                            cl.Size = UDim2.new(1, 0, 1, 0)
                            cl.BackgroundTransparency = 1
                            cl.Text = ch
                            cl.TextColor3 = Config.TitleColor
                            cl.TextTransparency = 1
                            cl.TextSize = tsize
                            cl.Font = charFont(ch)
                            cl.TextXAlignment = Enum.TextXAlignment.Center
                            cl.TextYAlignment = Enum.TextYAlignment.Center
                            cl.Parent = cf2
                            chars[#chars + 1] = { label = cl, order = idx }
                            idx = idx + 1
                        end
                    end
                    local center = (#chars - 1) / 2
                    for _, c in ipairs(chars) do
                        local dist = math.abs(c.order - center)
                        task.delay(dist * Config.HintRevealStep, function()
                            if not hintActive or not c.label.Parent then return end
                            TweenService:Create(c.label, TweenInfo.new(Config.HintRevealTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
                        end)
                    end
                    hintContainer = hc
                    if hintTmr then task.cancel(hintTmr) end
                    hintTmr = task.delay(Config.HintHoldTime, function()
                        if hintActive then clearHint() end
                    end)
                end
                local function registerIslandTap()
                    if hintActive or expanded or not alive or not ready then return end
                    tapCount = tapCount + 1
                    if tapWindowTmr then task.cancel(tapWindowTmr) end
                    tapWindowTmr = task.delay(Config.TapWindow, function()
                        tapCount = 0
                        tapWindowTmr = nil
                    end)
                    if tapCount >= 3 then
                        tapCount = 0
                        if tapWindowTmr then task.cancel(tapWindowTmr) tapWindowTmr = nil end
                        playHintAnimation()
                    end
                end
                local function resetIslandDrag()
                    if dragStopTmr then task.cancel(dragStopTmr) dragStopTmr = nil end
                    if dragRestoreTmr then task.cancel(dragRestoreTmr) dragRestoreTmr = nil end
                    if dragging and dragBaseSize and not expanded then
                        local tgt = dragBaseSize
                        TweenService:Create(edge, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = tgt }):Play()
                    end
                    dragging = false
                    dragStartX = nil
                    dragBaseSize = nil
                end
                UserInputService.InputChanged:Connect(function(input)
                    if not holding or expanded or not ready then return end
                    if dragStartX == nil then return end
                    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
                    local dx = input.Position.X - dragStartX
                    if not dragging then
                        if dx > Config.IslandDragThreshold then
                            dragging = true
                            if longPress then task.cancel(longPress) longPress = nil end
                        else
                            return
                        end
                    end
                    if dx < 0 then dx = 0 end
                    if dragging and dragRestoreTmr then task.cancel(dragRestoreTmr) dragRestoreTmr = nil end
                    local extra = math.min(dx * Config.IslandDragDamp, Config.IslandDragMax)
                    if dragBaseSize then
                        edge.Size = UDim2.new(dragBaseSize.X.Scale, dragBaseSize.X.Offset + extra, dragBaseSize.Y.Scale, dragBaseSize.Y.Offset)
                    end
                    if dragStopTmr then task.cancel(dragStopTmr) end
                    dragStopTmr = task.delay(Config.IslandDragStopDelay, function()
                        dragStopTmr = nil
                        if dragging and holding and not expanded and dragBaseSize then
                            TweenService:Create(edge, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(dragBaseSize.X.Scale, dragBaseSize.X.Offset + math.min(Config.IslandDragFixed, Config.IslandDragMax), dragBaseSize.Y.Scale, dragBaseSize.Y.Offset),
                            }):Play()
                            if dragRestoreTmr then task.cancel(dragRestoreTmr) end
                            dragRestoreTmr = task.delay(Config.IslandDragHold, function()
                                dragRestoreTmr = nil
                                resetIslandDrag()
                            end)
                        end
                    end)
                end)
                local closeBtn = nil
                local tabListContainer = nil
                local tabContentContainer = nil
                local tabContentBase = nil
                local headerDivider = nil
                local tabSeparator = nil
                local tabEmptyLabel = nil
                local tabContentEmpty = nil
                local tabContentNoCtrl = nil
                local tabSubtitleList = nil
                local function destroyTabUI()
                    if tabListContainer then tabListContainer:Destroy() tabListContainer = nil end
                    if tabContentContainer then tabContentContainer:Destroy() tabContentContainer = nil end
                    if headerDivider then headerDivider:Destroy() headerDivider = nil end
                    if tabSeparator then tabSeparator:Destroy() tabSeparator = nil end
                    if tabEmptyLabel then tabEmptyLabel:Destroy() tabEmptyLabel = nil end
                    tabContentEmpty = nil
                    tabContentNoCtrl = nil
                    tabSubtitleList = nil
                    tabContentBase = nil
                end
                local function renderSubtitles(tab)
                    if not tabSubtitleList then return end
                    for _, ch in ipairs(tabSubtitleList:GetChildren()) do
                        if ch:IsA("GuiObject") then ch:Destroy() end
                    end
                    if not tab or not tab._subtitles then return end
                    local headH = Config.SubTitleRowHeight
                    local divGap = Config.SubTitleDividerGap
                    local function makeButton(bt, order)
                        local btn = Instance.new("TextButton")
                        btn.Name = "SubButton"
                        btn.Size = UDim2.new(1, 0, 0, Config.ButtonHeight)
                        btn.BackgroundColor3 = Config.ButtonFill
                        btn.BackgroundTransparency = Config.ButtonFillTransparency
                        btn.Text = ""
                        btn.AutoButtonColor = false
                        btn.LayoutOrder = order
                        btn.ZIndex = 3
                        local bcorner = Instance.new("UICorner")
                        bcorner.CornerRadius = Config.ButtonCorner
                        bcorner.Parent = btn
                        local bstroke = Instance.new("UIStroke")
                        bstroke.Color = Config.ButtonStroke
                        bstroke.Transparency = Config.ButtonStrokeTransparency
                        bstroke.Thickness = 1
                        bstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        bstroke.Parent = btn
                        local row = Instance.new("Frame")
                        row.Name = "Row"
                        row.BackgroundTransparency = 1
                        row.Size = UDim2.new(1, 0, 1, 0)
                        row.ZIndex = 3
                        row.Parent = btn
                        local rl = Instance.new("UIListLayout")
                        rl.FillDirection = Enum.FillDirection.Horizontal
                        rl.HorizontalAlignment = Enum.HorizontalAlignment.Center
                        rl.VerticalAlignment = Enum.VerticalAlignment.Center
                        rl.SortOrder = Enum.SortOrder.LayoutOrder
                        rl.Padding = UDim.new(0, Config.ButtonIconGap)
                        rl.Parent = row
                        if bt.Icon ~= nil and bt.Icon ~= "" then
                            local ic = Instance.new("ImageLabel")
                            ic.Name = "BtnIcon"
                            ic.Size = UDim2.fromOffset(Config.ButtonIconSize, Config.ButtonIconSize)
                            ic.BackgroundTransparency = 1
                            ic.ImageColor3 = bt.IconColor or Config.ButtonTextColor
                            ic.ScaleType = Enum.ScaleType.Fit
                            ic.LayoutOrder = 1
                            ic.ZIndex = 3
                            ic.Parent = row
                            task.spawn(function()
                                local lucide = loadLucide()
                                if lucide then
                                    local okB, asset = pcall(lucide.GetAsset, bt.Icon)
                                    if okB and asset and asset.Url then
                                        ic.Image = asset.Url
                                        if asset.ImageRectOffset then ic.ImageRectOffset = asset.ImageRectOffset ic.ImageRectSize = asset.ImageRectSize end
                                    end
                                end
                            end)
                        end
                        local tx = Instance.new("TextLabel")
                        tx.Name = "BtnText"
                        tx.BackgroundTransparency = 1
                        tx.Size = UDim2.new(0, 0, 1, 0)
                        tx.AutomaticSize = Enum.AutomaticSize.X
                        tx.Text = bt.Title
                        tx.TextColor3 = Config.ButtonTextColor
                        tx.TextSize = Config.ButtonTextSize
                        tx.Font = Enum.Font.GothamMedium
                        tx.TextXAlignment = Enum.TextXAlignment.Center
                        tx.TextYAlignment = Enum.TextYAlignment.Center
                        tx.LayoutOrder = 2
                        tx.ZIndex = 3
                        tx.Parent = row
                        btn.MouseButton1Click:Connect(function()
                            if shutdown or not bt then return end
                            btn.BackgroundColor3 = Color3.fromRGB(96, 98, 112)
                            btn.BackgroundTransparency = 0
                            TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                BackgroundColor3 = Config.ButtonFill,
                                BackgroundTransparency = Config.ButtonFillTransparency,
                            }):Play()
                            if typeof(bt.OnClick) == "function" then
                                local okC, errC = pcall(bt.OnClick)
                                if not okC then reportError("AddButton OnClick 报错: " .. tostring(errC)) end
                            end
                        end)
                        return btn
                    end
                    local function makeToggle(tg, order)
                        local row = Instance.new("TextButton")
                        row.Name = "SubToggle"
                        row.Size = UDim2.new(1, 0, 0, Config.ButtonHeight)
                        row.BackgroundTransparency = 1
                        row.Text = ""
                        row.AutoButtonColor = false
                        row.LayoutOrder = order
                        row.ZIndex = 3
                        local tlbl = Instance.new("TextLabel")
                        tlbl.Name = "TglText"
                        tlbl.BackgroundTransparency = 1
                        tlbl.AnchorPoint = Vector2.new(0, 0.5)
                        tlbl.Position = UDim2.new(0, 0, 0.5, 0)
                        tlbl.Size = UDim2.new(1, -(Config.ToggleWidth + 14), 1, 0)
                        tlbl.Text = tg.Title
                        tlbl.TextColor3 = Config.ButtonTextColor
                        tlbl.TextSize = Config.ButtonTextSize
                        tlbl.Font = Enum.Font.GothamMedium
                        tlbl.TextXAlignment = Enum.TextXAlignment.Left
                        tlbl.TextYAlignment = Enum.TextYAlignment.Center
                        tlbl.ZIndex = 3
                        tlbl.Parent = row
                        local trackW = Config.ToggleWidth
                        local trackH = Config.ToggleHeight
                        local pad = Config.TogglePad
                        local thumbS = trackH - pad * 2
                        local track = Instance.new("Frame")
                        track.Name = "TglTrack"
                        track.AnchorPoint = Vector2.new(1, 0.5)
                        track.Position = UDim2.new(1, 0, 0.5, 0)
                        track.Size = UDim2.fromOffset(trackW, trackH)
                        track.BackgroundColor3 = tg.TrackColor or Config.ToggleTrackColor
                        track.BorderSizePixel = 0
                        track.ZIndex = 3
                        track.Parent = row
                        local tcc0 = Instance.new("UICorner")
                        tcc0.CornerRadius = UDim.new(0.5, 0)
                        tcc0.Parent = track
                        local thumb = Instance.new("Frame")
                        thumb.Name = "TglThumb"
                        thumb.AnchorPoint = Vector2.new(0, 0.5)
                        thumb.Position = UDim2.new(0, pad, 0.5, 0)
                        thumb.Size = UDim2.fromOffset(thumbS, thumbS)
                        thumb.BackgroundColor3 = tg.ThumbColor or Config.ToggleThumbColor
                        thumb.BorderSizePixel = 0
                        thumb.ZIndex = 4
                        thumb.Parent = track
                        local tcc1 = Instance.new("UICorner")
                        tcc1.CornerRadius = UDim.new(0.5, 0)
                        tcc1.Parent = thumb
                        if tg.Icon ~= nil and tg.Icon ~= "" then
                            local tic = Instance.new("ImageLabel")
                            tic.Name = "TglIcon"
                            tic.AnchorPoint = Vector2.new(0.5, 0.5)
                            tic.Position = UDim2.new(0.5, 0, 0.5, 0)
                            tic.Size = UDim2.fromOffset(thumbS * Config.ToggleIconRatio, thumbS * Config.ToggleIconRatio)
                            tic.BackgroundTransparency = 1
                            tic.ImageColor3 = tg.IconColor or Config.ToggleIconColor
                            tic.ScaleType = Enum.ScaleType.Fit
                            tic.ZIndex = 5
                            tic.Parent = thumb
                            task.spawn(function()
                                local lucide = loadLucide()
                                if lucide then
                                    local okI, asset = pcall(lucide.GetAsset, tg.Icon)
                                    if okI and asset and asset.Url then
                                        tic.Image = asset.Url
                                        if asset.ImageRectOffset then tic.ImageRectOffset = asset.ImageRectOffset tic.ImageRectSize = asset.ImageRectSize end
                                    end
                                end
                            end)
                        end
                        local function apply()
                            local on = tg.Value
                            local targetX = on and (trackW - pad - thumbS) or pad
                            TweenService:Create(thumb, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0, targetX, 0.5, 0),
                            }):Play()
                            TweenService:Create(track, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                BackgroundColor3 = on and Config.ToggleOnColor or (tg.TrackColor or Config.ToggleTrackColor),
                            }):Play()
                        end
                        apply()
                        row.MouseButton1Click:Connect(function()
                            if shutdown then return end
                            tg.Value = not tg.Value
                            apply()
                            if typeof(tg.Callback) == "function" then
                                local okC, errC = pcall(tg.Callback, tg.Value)
                                if not okC then reportError("AddToggle Callback 报错: " .. tostring(errC)) end
                            end
                        end)
                        return row
                    end
                    local function makeParagraph(p, order)
                        local frame = Instance.new("Frame")
                        frame.Name = "SubParagraph"
                        frame.BackgroundColor3 = p.BackColor or Config.ParagraphBackColor
                        frame.BackgroundTransparency = Config.ParagraphBackTransparency
                        frame.Size = UDim2.new(1, 0, 0, Config.ParagraphRowHeight)
                        frame.LayoutOrder = order
                        frame.ZIndex = 3
                        local corner = Instance.new("UICorner")
                        corner.CornerRadius = Config.ParagraphCorner
                        corner.Parent = frame
                        local stroke = Instance.new("UIStroke")
                        stroke.Color = darkenColor(frame.BackgroundColor3, Config.ParagraphDarken)
                        stroke.Thickness = Config.ParagraphBorderThickness
                        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        stroke.Parent = frame
                        local pad = Instance.new("UIPadding")
                        pad.PaddingLeft = UDim.new(0, Config.ParagraphBackPad)
                        pad.PaddingRight = UDim.new(0, Config.ParagraphBackPad)
                        pad.Parent = frame
                        local hl = Instance.new("UIListLayout")
                        hl.FillDirection = Enum.FillDirection.Horizontal
                        hl.HorizontalAlignment = Enum.HorizontalAlignment.Left
                        hl.VerticalAlignment = Enum.VerticalAlignment.Center
                        hl.SortOrder = Enum.SortOrder.LayoutOrder
                        hl.Padding = UDim.new(0, Config.ParagraphIconGap)
                        hl.Parent = frame
                        local hasIco = (p.Icon ~= nil and p.Icon ~= "")
                        if hasIco then
                            local ic = Instance.new("ImageLabel")
                            ic.Name = "ParaIcon"
                            ic.Size = UDim2.fromOffset(Config.ParagraphIconSize, Config.ParagraphIconSize)
                            ic.BackgroundTransparency = 1
                            ic.ImageColor3 = p.IconColor or Config.ParagraphInfoColor
                            ic.ScaleType = Enum.ScaleType.Fit
                            ic.LayoutOrder = 1
                            ic.ZIndex = 3
                            ic.Parent = frame
                            task.spawn(function()
                                local lucide = loadLucide()
                                if lucide then
                                    local okP, asset = pcall(lucide.GetAsset, p.Icon)
                                    if okP and asset and asset.Url then
                                        ic.Image = asset.Url
                                        if asset.ImageRectOffset then ic.ImageRectOffset = asset.ImageRectOffset ic.ImageRectSize = asset.ImageRectSize end
                                    end
                                end
                            end)
                            p._iconLbl = ic
                        end
                        local txt = Instance.new("Frame")
                        txt.Name = "ParaText"
                        txt.BackgroundTransparency = 1
                        txt.Size = UDim2.new(1, hasIco and -(Config.ParagraphIconSize + Config.ParagraphIconGap) or 0, 1, 0)
                        txt.LayoutOrder = 2
                        txt.ZIndex = 3
                        txt.Parent = frame
                        local vl = Instance.new("UIListLayout")
                        vl.FillDirection = Enum.FillDirection.Vertical
                        vl.HorizontalAlignment = Enum.HorizontalAlignment.Left
                        vl.VerticalAlignment = Enum.VerticalAlignment.Center
                        vl.SortOrder = Enum.SortOrder.LayoutOrder
                        vl.Padding = UDim.new(0, Config.ParagraphTextGap)
                        vl.Parent = txt
                        local titleLbl = Instance.new("TextLabel")
                        titleLbl.Name = "ParaTitle"
                        titleLbl.BackgroundTransparency = 1
                        titleLbl.Size = UDim2.new(1, 0, 0, Config.ParagraphTitleSize + Config.ParagraphTitlePad)
                        titleLbl.Text = p.Title or ""
                        titleLbl.TextColor3 = Config.ParagraphTitleColor
                        titleLbl.TextSize = Config.ParagraphTitleSize
                        titleLbl.Font = Enum.Font.GothamBold
                        titleLbl.RichText = true
                        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
                        titleLbl.TextYAlignment = Enum.TextYAlignment.Center
                        titleLbl.LayoutOrder = 1
                        titleLbl.ZIndex = 3
                        titleLbl.Parent = txt
                        local infoLbl = Instance.new("TextLabel")
                        infoLbl.Name = "ParaInfo"
                        infoLbl.BackgroundTransparency = 1
                        infoLbl.Size = UDim2.new(1, 0, 1, -(Config.ParagraphTitleSize + Config.ParagraphTitlePad + Config.ParagraphTextGap))
                        infoLbl.Text = p.Info or ""
                        infoLbl.TextColor3 = Config.ParagraphInfoColor
                        infoLbl.TextSize = Config.ParagraphInfoSize
                        infoLbl.Font = Enum.Font.Gotham
                        infoLbl.RichText = true
                        infoLbl.TextWrapped = true
                        infoLbl.TextXAlignment = Enum.TextXAlignment.Left
                        infoLbl.TextYAlignment = Enum.TextYAlignment.Center
                        infoLbl.LayoutOrder = 2
                        infoLbl.ZIndex = 3
                        infoLbl.Parent = txt
                        p._titleLbl = titleLbl
                        p._infoLbl = infoLbl
                        p._iconLbl = hasIco and ic or nil
                        p._frame = frame
                        p._stroke = stroke
                        return frame
                    end
                    local function makeSlider(sl, order)
                        local rowH = Config.SliderRowHeight
                        local frame = Instance.new("Frame")
                        frame.Name = "SubSlider"
                        frame.BackgroundTransparency = 1
                        frame.Size = UDim2.new(1, 0, 0, rowH)
                        frame.LayoutOrder = order
                        frame.ZIndex = 3
                        local titleW = measureTextWidth(sl.Title or "", Config.SliderTitleSize) + Config.SliderTitlePadX
                        if titleW < Config.SliderTitleMinW then titleW = Config.SliderTitleMinW end
                        local titleLbl = Instance.new("TextLabel")
                        titleLbl.Name = "SliderTitle"
                        titleLbl.BackgroundTransparency = 1
                        titleLbl.Size = UDim2.new(0, titleW, 1, 0)
                        titleLbl.Position = UDim2.new(0, 0, 0, 0)
                        titleLbl.Text = sl.Title or ""
                        titleLbl.TextColor3 = Config.SliderTitleColor
                        titleLbl.TextSize = Config.SliderTitleSize
                        titleLbl.Font = Enum.Font.GothamBold
                        titleLbl.RichText = true
                        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
                        titleLbl.TextYAlignment = Enum.TextYAlignment.Center
                        titleLbl.ZIndex = 3
                        titleLbl.Parent = frame
                        local track = Instance.new("Frame")
                        track.Name = "SliderTrack"
                        track.BackgroundColor3 = Config.SliderTrackColor
                        track.BackgroundTransparency = Config.SliderTrackTransparency
                        track.Size = UDim2.new(1, -(titleW + Config.SliderTitleGap), 1, -Config.SliderTrackVPad * 2)
                        track.Position = UDim2.new(0, titleW + Config.SliderTitleGap, 0, Config.SliderTrackVPad)
                        track.ZIndex = 3
                        local trackCorner = Instance.new("UICorner")
                        trackCorner.CornerRadius = Config.SliderTrackCorner
                        trackCorner.Parent = track
                        track.Parent = frame
                        local fill = Instance.new("Frame")
                        fill.Name = "SliderFill"
                        fill.BackgroundColor3 = sl.FillColor or Config.SliderFillColor
                        fill.BackgroundTransparency = 0
                        fill.Size = UDim2.new(0, 0, 1, 0)
                        fill.ZIndex = 4
                        local fillCorner = Instance.new("UICorner")
                        fillCorner.CornerRadius = Config.SliderTrackCorner
                        fillCorner.Parent = fill
                        fill.Parent = track
                        local thumb = Instance.new("Frame")
                        thumb.Name = "SliderThumb"
                        thumb.BackgroundColor3 = Config.SliderThumbColor
                        thumb.Size = UDim2.fromOffset(Config.SliderThumbSize, Config.SliderThumbSize)
                        thumb.AnchorPoint = Vector2.new(0.5, 0.5)
                        thumb.Position = UDim2.new(0, 0, 0.5, 0)
                        thumb.ZIndex = 5
                        local thumbCorner = Instance.new("UICorner")
                        thumbCorner.CornerRadius = UDim.new(1, 0)
                        thumbCorner.Parent = thumb
                        thumb.Parent = track
                        local function clampFrac(f)
                            if f < 0 then f = 0 elseif f > 1 then f = 1 end
                            return f
                        end
                        local function getRange() return sl.MaxValue - sl.MinValue end
                        local function snapVal(v)
                            local r = getRange()
                            if r <= 0 then return sl.MinValue end
                            if sl.Degree and sl.Degree > 0 then
                                v = sl.MinValue + math.floor((v - sl.MinValue) / sl.Degree + 0.5) * sl.Degree
                            end
                            if v < sl.MinValue then v = sl.MinValue end
                            if v > sl.MaxValue then v = sl.MaxValue end
                            return v
                        end
                        local function valToFrac(v)
                            local r = getRange()
                            if r <= 0 then return 0 end
                            return clampFrac((v - sl.MinValue) / r)
                        end
                        sl._refresh = function(animate)
                            local f2 = valToFrac(sl.Value)
                            if sl._tween then sl._tween:Cancel() end
                            if animate then
                                sl._tween = TweenService:Create(sl._fill, TweenInfo.new(Config.SliderAnimTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(f2, 0, 1, 0) })
                                sl._tween:Play()
                            else
                                sl._fill.Size = UDim2.new(f2, 0, 1, 0)
                            end
                            if sl._thumb then sl._thumb.Position = UDim2.new(f2, 0, 0.5, 0) end
                        end
                        sl._applyFrac = function(f, animate)
                            f = clampFrac(f)
                            sl.Value = snapVal(sl.MinValue + f * getRange())
                            sl._refresh(animate)
                            if type(sl.OnChanged) == "function" then
                                local okC, errC = pcall(sl.OnChanged, sl.Value)
                                if not okC then reportError("AddSlider OnChanged 报错: " .. tostring(errC)) end
                            end
                        end
                        sl.Value = sl.Value or sl.MinValue
                        sl._refresh(false)
                        local dragging = false
                        local function pointFrac(input)
                            local aw = sl._track.AbsoluteSize.X
                            if aw <= 0 then return 0 end
                            local x = (input.Position.X - sl._track.AbsolutePosition.X) / aw
                            return clampFrac(x)
                        end
                        track.Active = true
                        fill.Active = false
                        thumb.Active = false
                        track.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                dragging = true
                                sl._applyFrac(pointFrac(input), true)
                                local moveConn
                                moveConn = input.Changed:Connect(function()
                                    if input.UserInputState == Enum.UserInputState.End then
                                        dragging = false
                                        if moveConn then moveConn:Disconnect() end
                                    elseif input.Position then
                                        sl._applyFrac(pointFrac(input), false)
                                    end
                                end)
                            end
                        end)
                        sl._frame = frame
                        sl._track = track
                        sl._fill = fill
                        sl._thumb = thumb
                        sl._titleLbl = titleLbl
                        return frame
                    end
                    for _, st in ipairs(tab._subtitles) do
                        local btns = st._buttons or {}
                        local tgts = st._toggles or {}
                        local pgrs = st._paragraphs or {}
                        local slds = st._sliders or {}
                        local itemH = {}
                        for _ in ipairs(btns) do itemH[#itemH + 1] = Config.ButtonHeight end
                        for _ in ipairs(tgts) do itemH[#itemH + 1] = Config.ButtonHeight end
                        for _ in ipairs(pgrs) do itemH[#itemH + 1] = Config.ParagraphRowHeight end
                        for _ in ipairs(slds) do itemH[#itemH + 1] = Config.SliderRowHeight end
                        local ccount = #itemH
                        local sumH = 0
                        for _, h in ipairs(itemH) do sumH = sumH + h end
                        local contentH
                        if ccount > 0 then
                            contentH = Config.SubTitleBodyPadY * 2 + sumH + (ccount - 1) * Config.ButtonGap
                        else
                            contentH = 0
                        end
                        local fullH = headH + divGap + contentH
                        local minH = headH + divGap
                        local block = Instance.new("Frame")
                        block.Name = "SubBlock"
                        block.BackgroundTransparency = 1
                        block.Size = UDim2.new(1, 0, 0, st.collapsed and minH or fullH)
                        block.ClipsDescendants = true
                        block.ZIndex = 2
                        block.Parent = tabSubtitleList
                        local div = Instance.new("Frame")
                        div.Size = UDim2.new(1, 0, 0, 1)
                        div.Position = UDim2.new(0, 0, 0, headH)
                        div.BackgroundColor3 = Config.DividerColor
                        div.BorderSizePixel = 0
                        div.ZIndex = 2
                        div.Parent = block
                        local body = Instance.new("Frame")
                        body.Name = "SubBody"
                        body.Size = UDim2.new(1, 0, 0, contentH)
                        body.Position = UDim2.new(0, 0, 0, headH + divGap)
                        body.BackgroundColor3 = Config.SubTitleBodyFill
                        body.BackgroundTransparency = 1
                        body.BorderSizePixel = 0
                        body.ZIndex = 1
                        body.Parent = block
                        local bc = Instance.new("UICorner")
                        bc.CornerRadius = UDim.new(0, 6)
                        bc.Parent = body
                        if ccount > 0 then
                            local bl = Instance.new("UIListLayout")
                            bl.FillDirection = Enum.FillDirection.Vertical
                            bl.SortOrder = Enum.SortOrder.LayoutOrder
                            bl.Padding = UDim.new(0, Config.ButtonGap)
                            bl.Parent = body
                            local bp = Instance.new("UIPadding")
                            bp.PaddingTop = UDim.new(0, Config.SubTitleBodyPadY)
                            bp.PaddingBottom = UDim.new(0, Config.SubTitleBodyPadY)
                            bp.PaddingLeft = UDim.new(0, Config.SubTitleBodyPadX)
                            bp.PaddingRight = UDim.new(0, Config.SubTitleBodyPadX)
                            bp.Parent = body
                            for bi, bt in ipairs(btns) do
                                makeButton(bt, bi).Parent = body
                            end
                            for ti, tg in ipairs(tgts) do
                                makeToggle(tg, #btns + ti).Parent = body
                            end
                            for pi, pg in ipairs(pgrs) do
                                makeParagraph(pg, #btns + #tgts + pi).Parent = body
                            end
                            for si, sl in ipairs(slds) do
                                makeSlider(sl, #btns + #tgts + #pgrs + si).Parent = body
                            end
                        end
                        local hasIco = (st.Icon ~= nil and st.Icon ~= "")
                        local tX = 0
                        if hasIco then
                            local hicon = Instance.new("ImageLabel")
                            hicon.Name = "SubIcon"
                            hicon.Size = UDim2.fromOffset(Config.SubTitleIconSize, Config.SubTitleIconSize)
                            hicon.Position = UDim2.new(0, 0, 0, (headH - Config.SubTitleIconSize) / 2)
                            hicon.BackgroundTransparency = 1
                            hicon.ImageColor3 = st.IconColor or Config.SubTitleColor
                            hicon.ScaleType = Enum.ScaleType.Fit
                            hicon.ZIndex = 3
                            hicon.Parent = block
                            tX = Config.SubTitleIconSize + 8
                            task.spawn(function()
                                local lucide = loadLucide()
                                if lucide then
                                    local okI, asset = pcall(lucide.GetAsset, st.Icon)
                                    if okI and asset and asset.Url then
                                        hicon.Image = asset.Url
                                        if asset.ImageRectOffset then hicon.ImageRectOffset = asset.ImageRectOffset hicon.ImageRectSize = asset.ImageRectSize end
                                    end
                                end
                            end)
                        end
                        local htext = Instance.new("TextLabel")
                        htext.Name = "SubText"
                        htext.Size = UDim2.new(1, -(tX + Config.SubTitleArrowSize + 10), 0, headH)
                        htext.Position = UDim2.new(0, tX, 0, 0)
                        htext.BackgroundTransparency = 1
                        htext.Text = st.Title
                        htext.TextColor3 = Config.SubTitleColor
                        htext.TextSize = Config.SubTitleTextSize
                        htext.Font = Enum.Font.GothamBold
                        htext.TextXAlignment = Enum.TextXAlignment.Left
                        htext.TextYAlignment = Enum.TextYAlignment.Center
                        htext.ZIndex = 3
                        htext.Parent = block
                        local arrow = Instance.new("ImageLabel")
                        arrow.Name = "SubArrow"
                        arrow.Size = UDim2.fromOffset(Config.SubTitleArrowSize, Config.SubTitleArrowSize)
                        arrow.AnchorPoint = Vector2.new(1, 0.5)
                        arrow.Position = UDim2.new(1, 0, 0, headH / 2)
                        arrow.BackgroundTransparency = 1
                        arrow.ImageColor3 = Config.SubTitleColor
                        arrow.ScaleType = Enum.ScaleType.Fit
                        arrow.Rotation = st.collapsed and Config.SubTitleArrowRotate or 0
                        arrow.ZIndex = 3
                        arrow.Parent = block
                        task.spawn(function()
                            local lucide = loadLucide()
                            if lucide then
                                local okA, asset = pcall(lucide.GetAsset, "chevron-down")
                                if okA and asset and asset.Url then
                                    arrow.Image = asset.Url
                                    if asset.ImageRectOffset then arrow.ImageRectOffset = asset.ImageRectOffset arrow.ImageRectSize = asset.ImageRectSize end
                                end
                            end
                        end)
                        local hit = Instance.new("TextButton")
                        hit.Size = UDim2.new(1, 0, 0, headH)
                        hit.Position = UDim2.new(0, 0, 0, 0)
                        hit.BackgroundTransparency = 1
                        hit.Text = ""
                        hit.AutoButtonColor = false
                        hit.ZIndex = 4
                        hit.Parent = block
                        hit.MouseButton1Click:Connect(function()
                            st.collapsed = not st.collapsed
                            TweenService:Create(block, TweenInfo.new(Config.SubTitleCollapseTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(1, 0, 0, st.collapsed and minH or fullH),
                            }):Play()
                            TweenService:Create(arrow, TweenInfo.new(Config.SubTitleCollapseTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Rotation = st.collapsed and Config.SubTitleArrowRotate or 0,
                            }):Play()
                        end)
                    end
                end
                local function animateContentIn()
                    if not tabContentContainer or not tabContentBase then return end
                    local sc = tabContentContainer:FindFirstChild("TabScroll")
                    if sc then sc.CanvasPosition = Vector2.new(0, 0) end
                    tabContentContainer.GroupTransparency = 1
                    tabContentContainer.Position = UDim2.new(tabContentBase.X.Scale, tabContentBase.X.Offset + 18, tabContentBase.Y.Scale, tabContentBase.Y.Offset)
                    TweenService:Create(tabContentContainer, TweenInfo.new(Config.PageAnimTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        GroupTransparency = 0,
                        Position = tabContentBase,
                    }):Play()
                end
                local function updateContentArea()
                    local hasSel = (win._activeTab ~= 0)
                    local tab = hasSel and win._tabs[win._activeTab] or nil
                    local hasSub = (tab and tab._subtitles and #tab._subtitles > 0)
                    if tabContentEmpty then tabContentEmpty.Visible = (not hasSel) end
                    if tabContentNoCtrl then tabContentNoCtrl.Visible = (hasSel and not hasSub) end
                    renderSubtitles(hasSub and tab or nil)
                end
                local function updateTabsHighlight()
                    if not tabListContainer then return end
                    for _, row in ipairs(tabListContainer:GetChildren()) do
                        if row:IsA("TextButton") then
                            local idx = row.LayoutOrder
                            local active = (win._activeTab == idx)
                            local nl = row:FindFirstChild("TabName")
                            local ic2 = row:FindFirstChild("TabIcon")
                            local sel = row:FindFirstChild("TabSel")
                            if nl then TweenService:Create(nl, TweenInfo.new(0.15), { TextColor3 = active and Config.TabActiveColor or Config.TabInactiveColor }):Play() end
                            if ic2 then
                                local td = win._tabs[idx]
                                local base = (td and td.IconColor) or Config.TabInactiveColor
                                TweenService:Create(ic2, TweenInfo.new(0.15), { ImageColor3 = active and Config.TabActiveColor or base }):Play()
                            end
                            if sel then sel.Visible = active end
                        end
                    end
                end

                local function collapsePanel()
                    if not expanded then return end
                    titleGen = titleGen + 1
                    cancelTitleTweens()
                    if actionEnd then actionEnd() end
                    local ll = islandTextContainer and islandTextContainer:FindFirstChildOfClass("UIListLayout")
                    if ll then ll.HorizontalAlignment = Enum.HorizontalAlignment.Center end
                    local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                    local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
                    animateEdge(Config.IslandSize, Config.IslandPosition, Config.PanelExpandTime, Config.PanelBounce, function()
                        edge.AnchorPoint = Vector2.new(0.5, 0.5)
                        edge.Position = UDim2.new(0.5, cx, 0, cy)
                        winOpen = false
                    end)
                    TweenService:Create(islandTextContainer, TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Position = UDim2.new(Config.IslandPosition.X.Scale, cx, Config.IslandPosition.Y.Scale, cy),
                    }):Play()
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do local lb = cf:FindFirstChildOfClass("TextLabel") if lb then lb.TextTransparency = 0 end end
                    if closeBtn then closeBtn:Destroy() closeBtn = nil end
                    if titleIcon then titleIcon:Destroy() titleIcon = nil end
                    if infoLabel then infoLabel:Destroy() infoLabel = nil end
                    if brandLbl then brandLbl:Destroy() brandLbl = nil end
                    destroyTabUI()
                    win._rebuildTabs = nil
                    expanded = false
                    setIslandText(title, Config.TitleColor)
                    interacting = false
                end

                edge.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                    if not ready then return end
                    if interacting then return end
                    if expanded then return end
                    interacting = true
                    holding = true
                    dragStartX = input.Position.X
                    dragBaseSize = edge.Size
                    dragging = false
                    TweenService:Create(islandScale, TweenInfo.new(Config.TapExpandTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = Config.IslandTapScale }):Play()
                    longPress = task.delay(Config.LongPressThreshold, function()
                            if holding then
                                if hintActive then clearHint() end
                                expanded = true
                                titleGen = titleGen + 1
                                local myTitleGen = titleGen
                                islandScale.Scale = 1
                            edge.AnchorPoint = Vector2.new(0, 0)
                            edge.Position = Config.IslandPosition
                            local sw = screenGui.AbsoluteSize.X
                            local sh = screenGui.AbsoluteSize.Y
                            local m = Config.PanelMargin
                            local top = Config.IslandPosition.Y.Offset + Config.PanelDrop
                            animateEdge(
                                UDim2.new(0, sw - m * 2, 0, sh - top - m),
                                UDim2.new(0, m, 0, top),
                                Config.PanelExpandTime
                            )
                            playBorderSweep()
                            task.delay(Config.PanelExpandTime, function() winOpen = true end)
                            local titlePad = Config.HeaderPad
                            local iconS = Config.TitleIconSize
                            local iconGap = Config.TitleIconGap
                            local titleW = islandTextContainer.AbsoluteSize.X
                            local titleH = islandTextContainer.AbsoluteSize.Y
                            local infoH = Config.InfoBoxHeight
                            local vGap = Config.InfoTopGap
                            local blockH = (info ~= "") and (titleH + vGap + infoH) or titleH
                            local blockTop = top + titlePad
                            local blockCY = blockTop + blockH / 2
                            local iconLeft = m + titlePad + Config.TitleIconNudgeX
                            local contentLeftX = iconLeft + iconS + iconGap
                            local titleTargetX = contentLeftX + titleW / 2
                            local titleTargetY = blockTop + titleH / 2 + Config.TitleDrop
                            local infoTop = blockTop + titleH + vGap - Config.InfoRise
                            local listLayout = islandTextContainer:FindFirstChildOfClass("UIListLayout")
                            win._titleLeftX = contentLeftX
                            win._titleY = titleTargetY
                            local function fadeTitleLabels(t)
                                cancelTitleTweens()
                                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                    local lb = cf:FindFirstChildOfClass("TextLabel")
                                    if lb then
                                        local tw = TweenService:Create(lb, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = t })
                                        table.insert(titleTweens, tw)
                                        tw:Play()
                                    end
                                end
                            end
                            fadeTitleLabels(1)
                            task.delay(Config.FadeInTime, function()
                                if not expanded or myTitleGen ~= titleGen then return end
                                if listLayout then listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left end
                                local slide = 40
                                islandTextContainer.Position = UDim2.new(0, titleTargetX + slide, 0, titleTargetY)
                                TweenService:Create(islandTextContainer, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    Position = UDim2.new(0, titleTargetX, 0, titleTargetY),
                                }):Play()
                                fadeTitleLabels(0)
                                task.delay(Config.InfoEnterDelay, function()
                                    if not expanded or myTitleGen ~= titleGen then return end
                                    if infoLabel and infoLabel.Parent then
                                        TweenService:Create(infoLabel, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                            Position = UDim2.new(0, contentLeftX, 0, infoTop),
                                            TextTransparency = 0,
                                        }):Play()
                                    end
                                end)
                            end)
                            if titleIcon then titleIcon:Destroy() end
                            local ic = Instance.new("ImageLabel")
                            ic.Name = "TitleIcon"
                            ic.Size = UDim2.fromOffset(iconS, iconS)
                            ic.AnchorPoint = Vector2.new(0.5, 0.5)
                            ic.BackgroundTransparency = 1
                            ic.ImageTransparency = 1
                            ic.ImageColor3 = iconColor
                            ic.ScaleType = Enum.ScaleType.Fit
                            ic.Position = UDim2.new(0, iconLeft + iconS / 2, 0, blockCY)
                            ic.Parent = screenGui
                            titleIcon = ic
                            task.spawn(function()
                                local lucide = loadLucide()
                                if lucide then
                                    local ok, asset = pcall(lucide.GetAsset, iconName)
                                    if ok and asset and asset.Url then
                                        ic.Image = asset.Url
                                        if asset.ImageRectOffset then ic.ImageRectOffset = asset.ImageRectOffset ic.ImageRectSize = asset.ImageRectSize end
                                    end
                                end
                                task.delay(Config.PanelExpandTime, function()
                                    if ic and ic.Parent then
                                        TweenService:Create(ic, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play()
                                    end
                                end)
                            end)
                            if info ~= "" then
                                if infoLabel then infoLabel:Destroy() end
                                local il = Instance.new("TextLabel")
                                il.Name = "InfoLabel"
                                il.Size = UDim2.new(1, -(contentLeftX + titlePad), 0, infoH)
                                il.AutomaticSize = Enum.AutomaticSize.Y
                                il.AnchorPoint = Vector2.new(0, 0)
                                il.BackgroundTransparency = 1
                                il.BorderSizePixel = 0
                                il.Text = info
                                il.TextColor3 = Config.InfoColor
                                il.TextTransparency = 1
                                il.TextSize = Config.InfoTextSize
                                il.Font = Enum.Font.Gotham
                                il.TextWrapped = true
                                il.TextXAlignment = Enum.TextXAlignment.Left
                                il.TextYAlignment = Enum.TextYAlignment.Top
                                il.Position = UDim2.new(0, contentLeftX + 40, 0, infoTop)
                                il.Parent = screenGui
                                infoLabel = il
                            end
                            local function buildTabUI()
                                destroyTabUI()
                                local divY = titlePad + blockH + Config.HeaderDividerGap
                                local div = Instance.new("Frame")
                                div.Name = "HeaderDivider"
                                div.Size = UDim2.new(1, -(titlePad * 2), 0, 1)
                                div.Position = UDim2.new(0, titlePad, 0, divY)
                                div.BackgroundColor3 = Config.DividerColor
                                div.BorderSizePixel = 0
                                div.ZIndex = 2
                                div.Parent = contentRoot
                                headerDivider = div
                                local listTop = divY + Config.HeaderDividerGap
                                local listW = Config.TabWidth
                                if #win._tabs > 0 then
                                    local listFrame = Instance.new("Frame")
                                    listFrame.Name = "TabList"
                                    listFrame.BackgroundTransparency = 1
                                    listFrame.Position = UDim2.new(0, titlePad, 0, listTop)
                                    listFrame.Size = UDim2.new(0, listW, 1, -(listTop + m))
                                    listFrame.ZIndex = 2
                                    listFrame.Parent = contentRoot
                                    tabListContainer = listFrame
                                    local sep = Instance.new("Frame")
                                    sep.Name = "TabSeparator"
                                    sep.Size = UDim2.new(0, 1, 1, -(listTop + m))
                                    sep.Position = UDim2.new(0, titlePad + listW + Config.TabAreaGap / 2, 0, listTop)
                                    sep.BackgroundColor3 = Config.DividerColor
                                    sep.BorderSizePixel = 0
                                    sep.ZIndex = 2
                                    sep.Parent = contentRoot
                                    tabSeparator = sep
                                    local contentX = titlePad + listW + Config.TabAreaGap
                                    local contentFrame = Instance.new("CanvasGroup")
                                    contentFrame.Name = "TabContent"
                                    contentFrame.BackgroundTransparency = 1
                                    contentFrame.Position = UDim2.new(0, contentX, 0, listTop)
                                    contentFrame.Size = UDim2.new(1, -(contentX + titlePad), 1, -(listTop + m))
                                    contentFrame.ClipsDescendants = true
                                    contentFrame.ZIndex = 2
                                    contentFrame.Parent = contentRoot
                                    tabContentContainer = contentFrame
                                    tabContentBase = contentFrame.Position
                                    local function makeStateGroup(iconName, text)
                                        local g = Instance.new("Frame")
                                        g.Name = "StateGroup"
                                        g.BackgroundTransparency = 1
                                        g.AnchorPoint = Vector2.new(0.5, 0.5)
                                        g.Position = UDim2.new(0.5, 0, 0.5, 0)
                                        g.Size = UDim2.fromOffset(220, 130)
                                        g.ZIndex = 3
                                        g.Parent = contentFrame
                                        local ic = Instance.new("ImageLabel")
                                        ic.Name = "StateIcon"
                                        ic.Size = UDim2.fromOffset(Config.ContentEmptyIconSize, Config.ContentEmptyIconSize)
                                        ic.AnchorPoint = Vector2.new(0.5, 0)
                                        ic.Position = UDim2.new(0.5, 0, 0, 0)
                                        ic.BackgroundTransparency = 1
                                        ic.ImageColor3 = Config.TabInactiveColor
                                        ic.ScaleType = Enum.ScaleType.Fit
                                        ic.ZIndex = 3
                                        ic.Parent = g
                                        local tx = Instance.new("TextLabel")
                                        tx.Name = "StateText"
                                        tx.AnchorPoint = Vector2.new(0.5, 0)
                                        tx.Position = UDim2.new(0.5, 0, 0, Config.ContentEmptyIconSize + 14)
                                        tx.Size = UDim2.new(1, 0, 0, 24)
                                        tx.BackgroundTransparency = 1
                                        tx.Text = text
                                        tx.TextColor3 = Config.TabInactiveColor
                                        tx.TextSize = Config.TabTextSize
                                        tx.Font = Enum.Font.Gotham
                                        tx.TextXAlignment = Enum.TextXAlignment.Center
                                        tx.TextYAlignment = Enum.TextYAlignment.Center
                                        tx.ZIndex = 3
                                        tx.Parent = g
                                        task.spawn(function()
                                            local lucide = loadLucide()
                                            if lucide then
                                                local okE, asset = pcall(lucide.GetAsset, iconName)
                                                if okE and asset and asset.Url then
                                                    ic.Image = asset.Url
                                                    if asset.ImageRectOffset then ic.ImageRectOffset = asset.ImageRectOffset ic.ImageRectSize = asset.ImageRectSize end
                                                end
                                            end
                                        end)
                                        return g
                                    end
                                    tabContentEmpty = makeStateGroup(Config.ContentEmptyIcon, Config.ContentEmptyText)
                                    tabContentNoCtrl = makeStateGroup(Config.ContentNoCtrlIcon, Config.ContentNoCtrlText)
                                    local scroll = Instance.new("ScrollingFrame")
                                    scroll.Name = "TabScroll"
                                    scroll.BackgroundTransparency = 1
                                    scroll.BorderSizePixel = 0
                                    scroll.Size = UDim2.new(1, 0, 1, 0)
                                    scroll.Position = UDim2.new(0, 0, 0, 0)
                                    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                                    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                                    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
                                    scroll.ScrollingEnabled = true
                                    scroll.ScrollBarThickness = Config.ContentScrollBarThickness
                                    scroll.ScrollBarImageTransparency = Config.ContentScrollBarTransparency
                                    scroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
                                    scroll.ClipsDescendants = true
                                    scroll.ZIndex = 2
                                    scroll.Parent = contentFrame
                                    local subList = Instance.new("Frame")
                                    subList.Name = "TabSubtitleList"
                                    subList.BackgroundTransparency = 1
                                    subList.Size = UDim2.new(1, 0, 0, 0)
                                    subList.AutomaticSize = Enum.AutomaticSize.Y
                                    subList.ZIndex = 2
                                    subList.Parent = scroll
                                    local subListLayout = Instance.new("UIListLayout")
                                    subListLayout.FillDirection = Enum.FillDirection.Vertical
                                    subListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
                                    subListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                                    subListLayout.Padding = UDim.new(0, Config.SubTitleBlockGap)
                                    subListLayout.Parent = subList
                                    tabSubtitleList = subList
                                    for i, tab in ipairs(win._tabs) do
                                        local row = Instance.new("TextButton")
                                        row.Name = "TabRow"
                                        row.Size = UDim2.new(1, 0, 0, Config.TabRowHeight)
                                        row.Position = UDim2.new(0, 0, 0, (i - 1) * (Config.TabRowHeight + Config.TabRowGap))
                                        row.BackgroundTransparency = 1
                                        row.Text = ""
                                        row.AutoButtonColor = false
                                        row.LayoutOrder = i
                                        row.ZIndex = 3
                                        row.Parent = listFrame
                                        local sel = Instance.new("Frame")
                                        sel.Name = "TabSel"
                                        sel.Size = UDim2.new(1, 0, 1, 0)
                                        sel.Position = UDim2.new(0, 0, 0, 0)
                                        sel.BackgroundColor3 = Config.TabSelFill
                                        sel.BackgroundTransparency = Config.TabSelFillTransparency
                                        sel.BorderSizePixel = 0
                                        sel.Visible = false
                                        sel.ZIndex = 2
                                        sel.Parent = row
                                        local selCorner = Instance.new("UICorner")
                                        selCorner.CornerRadius = Config.TabSelCorner
                                        selCorner.Parent = sel
                                        local selStroke = Instance.new("UIStroke")
                                        selStroke.Color = Config.TabSelStroke
                                        selStroke.Thickness = Config.TabSelStrokeThickness
                                        selStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                                        selStroke.Parent = sel
                                        local selGrad = Instance.new("UIGradient")
                                        selGrad.Rotation = 135
                                        selGrad.Color = ColorSequence.new({
                                            ColorSequenceKeypoint.new(0, Color3.fromRGB(104, 106, 118)),
                                            ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 34)),
                                        })
                                        selGrad.Parent = sel
                                        local hasIcon = (tab.Icon ~= nil and tab.Icon ~= "")
                                        local ticon = nil
                                        if hasIcon then
                                            ticon = Instance.new("ImageLabel")
                                            ticon.Name = "TabIcon"
                                            ticon.Size = UDim2.fromOffset(Config.TabIconSize, Config.TabIconSize)
                                            ticon.Position = UDim2.new(0, Config.TabRowPadX, 0.5, 0)
                                            ticon.AnchorPoint = Vector2.new(0, 0.5)
                                            ticon.BackgroundTransparency = 1
                                            ticon.ImageColor3 = tab.IconColor or Config.TabInactiveColor
                                            ticon.ImageTransparency = 1
                                            ticon.ZIndex = 3
                                            ticon.Parent = row
                                        end
                                        local tname = Instance.new("TextLabel")
                                        tname.Name = "TabName"
                                        tname.BackgroundTransparency = 1
                                        tname.Text = tab.Title
                                        tname.TextColor3 = Config.TabInactiveColor
                                        tname.TextSize = Config.TabTextSize
                                        tname.Font = Enum.Font.Gotham
                                        tname.TextYAlignment = Enum.TextYAlignment.Center
                                        tname.TextTransparency = 1
                                        tname.ZIndex = 3
                                        if hasIcon then
                                            tname.Size = UDim2.new(1, -(Config.TabRowPadX + Config.TabIconSize + Config.TabTextGap), 1, 0)
                                            tname.Position = UDim2.new(0, Config.TabRowPadX + Config.TabIconSize + Config.TabTextGap, 0, 0)
                                            tname.TextXAlignment = Enum.TextXAlignment.Left
                                        else
                                            tname.Size = UDim2.new(1, -(Config.TabRowPadX * 2), 1, 0)
                                            tname.Position = UDim2.new(0, Config.TabRowPadX, 0, 0)
                                            tname.TextXAlignment = Enum.TextXAlignment.Left
                                        end
                                        tname.Parent = row
                                        task.delay(Config.PanelExpandTime + (i - 1) * Config.TabStagger, function()
                                            if not expanded then return end
                                            if ticon and ticon.Parent then TweenService:Create(ticon, TweenInfo.new(Config.TabFadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play() end
                                            if tname and tname.Parent then TweenService:Create(tname, TweenInfo.new(Config.TabFadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
                                        end)
                                        row.MouseButton1Click:Connect(function()
                                            if shutdown then return end
                                            win._activeTab = i
                                            updateTabsHighlight()
                                            updateContentArea()
                                            animateContentIn()
                                        end)
                                        if hasIcon then
                                            task.spawn(function()
                                                local lucide = loadLucide()
                                                if lucide then
                                                    local okA, asset = pcall(lucide.GetAsset, tab.Icon)
                                                    if okA and asset and asset.Url then
                                                        ticon.Image = asset.Url
                                                        if asset.ImageRectOffset then ticon.ImageRectOffset = asset.ImageRectOffset ticon.ImageRectSize = asset.ImageRectSize end
                                                    end
                                                end
                                            end)
                                        end
                                    end
                                    updateTabsHighlight()
                                    updateContentArea()
                                else
                                    local msg = "还没有任何选项卡"
                                    local parts = {}
                                    for _, cp in utf8.codes(msg) do parts[#parts + 1] = utf8.char(cp) end
                                    local lbl = Instance.new("TextLabel")
                                    lbl.Name = "TabEmpty"
                                    lbl.BackgroundTransparency = 1
                                    lbl.AnchorPoint = Vector2.new(0.5, 0.5)
                                    lbl.Size = UDim2.fromOffset(listW, 0)
                                    lbl.AutomaticSize = Enum.AutomaticSize.Y
                                    lbl.Position = UDim2.new(0, titlePad + listW / 2, 0, (listTop + (sh - top - m)) / 2)
                                    lbl.Text = table.concat(parts, "\n")
                                    lbl.TextColor3 = Config.TabInactiveColor
                                    lbl.TextSize = Config.TabTextSize
                                    lbl.Font = Enum.Font.Gotham
                                    lbl.TextXAlignment = Enum.TextXAlignment.Center
                                    lbl.TextYAlignment = Enum.TextYAlignment.Center
                                    lbl.ZIndex = 2
                                    lbl.Parent = contentRoot
                                    tabEmptyLabel = lbl
                                end
                            end
                            win._rebuildTabs = buildTabUI
                            buildTabUI()
                            local btn = Instance.new("ImageButton")
                            btn.Name = "PanelClose"
                            btn.Size = UDim2.new(0, 20, 0, 20)
                            btn.Position = UDim2.new(1, -26, 0, 6)
                            btn.BackgroundTransparency = 1
                            btn.ScaleType = Enum.ScaleType.Fit
                            btn.ImageColor3 = Color3.new(1, 1, 1)
                            btn.Parent = contentRoot
                            local closeHold = nil
                            local showCloseConfirm = nil
                            btn.InputBegan:Connect(function(bi)
                                if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
                                    if shutdown then return end
                                    TweenService:Create(btn, TweenInfo.new(Config.CloseHoldTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageColor3 = Config.RedXColor }):Play()
                                    if closeHold then task.cancel(closeHold) end
                                    closeHold = task.delay(Config.CloseHoldTime, function()
                                        closeHold = nil
                                        if showCloseConfirm then showCloseConfirm() end
                                    end)
                                end
                            end)
                            btn.InputEnded:Connect(function(bi)
                                if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
                                    TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageColor3 = Color3.new(1, 1, 1) }):Play()
                                    if closeHold then
                                        task.cancel(closeHold)
                                        closeHold = nil
                                        collapsePanel()
                                    end
                                end
                            end)
                            task.spawn(function()
                                local lucide = loadLucide()
                                if lucide then
                                    local ok, icon = pcall(lucide.GetAsset, "circle-x")
                                    if ok and icon and icon.Url then
                                        btn.Image = icon.Url
                                        if icon.ImageRectOffset then btn.ImageRectOffset = icon.ImageRectOffset btn.ImageRectSize = icon.ImageRectSize end
                                    end
                                end
                            end)
                            closeBtn = btn

                            local closeDialog = nil
                            local function setHeaderVisible(vis)
                                local t = vis and 0 or 1
                                if islandTextContainer and islandTextContainer.Parent then
                                    for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                        local lb = cf:FindFirstChildOfClass("TextLabel")
                                        if lb then TweenService:Create(lb, TweenInfo.new(0.22), { TextTransparency = t }):Play() end
                                    end
                                end
                                if titleIcon then TweenService:Create(titleIcon, TweenInfo.new(0.22), { ImageTransparency = t }):Play() end
                                if infoLabel then TweenService:Create(infoLabel, TweenInfo.new(0.22), { TextTransparency = t }):Play() end
                                if closeBtn then TweenService:Create(closeBtn, TweenInfo.new(0.22), { ImageTransparency = t }):Play() closeBtn.Active = vis end
                            end
                            local function makePill(label, color)
                                local b = Instance.new("TextButton")
                                b.Size = UDim2.new(0, Config.CloseDialogBtnW, 0, Config.CloseDialogBtnH)
                                b.BackgroundColor3 = color
                                b.Text = label
                                b.TextColor3 = Color3.new(1, 1, 1)
                                b.TextSize = 16
                                b.Font = Enum.Font.GothamBold
                                b.AutoButtonColor = false
                                b.ZIndex = 72
                                local c = Instance.new("UICorner")
                                c.CornerRadius = UDim.new(0.5, 0)
                                c.Parent = b
                                return b
                            end
                            local function runCloseSequence()
                                shutdown = true
                                if closeBtn then closeBtn:Destroy() closeBtn = nil end
                                if titleIcon then titleIcon:Destroy() titleIcon = nil end
                                if infoLabel then infoLabel:Destroy() infoLabel = nil end
                                if brandLbl then brandLbl:Destroy() brandLbl = nil end
                                destroyTabUI()
                                local cx2 = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                                local cy2 = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
                                animateEdge(Config.IslandSize, Config.IslandPosition, 0.45, 0.2, function()
                                    edge.AnchorPoint = Vector2.new(0.5, 0.5)
                                    edge.Position = UDim2.new(0.5, cx2, 0, cy2)
                                    local list = islandTextContainer and islandTextContainer:FindFirstChildOfClass("UIListLayout")
                                    if list then list.HorizontalAlignment = Enum.HorizontalAlignment.Center end
                                    if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
                                    islandTextContainer = createIslandText(Config.IslandText, Config.TitleColor, true)
                                    TweenService:Create(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                                    silverStroke.Color = Config.RedXColor
                                    TweenService:Create(silverStroke, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = Config.TargetTransparency }):Play()
                                    if fillFrame and fillFrame.Parent then
                                        TweenService:Create(fillFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = Config.IslandFinalTransparency }):Play()
                                    end
                                    task.delay(0.75, function()
                                        explode()
                                        if islandTextContainer and islandTextContainer.Parent then
                                            for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                                local lb = cf:FindFirstChildOfClass("TextLabel")
                                                if lb then TweenService:Create(lb, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                                            end
                                        end
                                        TweenService:Create(silverStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                                        TweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
                                        if fillFrame and fillFrame.Parent then
                                            TweenService:Create(fillFrame, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
                                        end
                                        task.delay(1.0, function()
                                            alive = false
                                            if screenGui and screenGui.Parent then screenGui:Destroy() end
                                        end)
                                    end)
                                end)
                            end
                            showCloseConfirm = function()
                                if closeDialog or shutdown then return end
                                setHeaderVisible(false)
                                destroyTabUI()
                                local dlg = Instance.new("Frame")
                                dlg.Name = "CloseDialog"
                                dlg.BackgroundColor3 = Config.CloseDialogFill
                                dlg.BackgroundTransparency = Config.CloseDialogFillTransparency
                                dlg.BorderSizePixel = 0
                                dlg.Size = UDim2.new(1, 0, 1, 0)
                                dlg.ZIndex = 70
                                dlg.ClipsDescendants = true
                                dlg.Parent = contentRoot
                                local dc = Instance.new("UICorner")
                                dc.CornerRadius = Config.CloseDialogCorner
                                dc.Parent = dlg
                                local txt = Instance.new("TextLabel")
                                txt.BackgroundTransparency = 1
                                txt.AnchorPoint = Vector2.new(0.5, 0)
                                txt.Position = UDim2.new(0.5, 0, 0, Config.CloseDialogPad)
                                txt.Size = UDim2.new(1, -Config.CloseDialogPad * 2, 0, 0)
                                txt.AutomaticSize = Enum.AutomaticSize.Y
                                txt.Text = "你要关闭 " .. (tostring(title):gsub("<[^>]*>", "")) .. " 吗？\n这将会关闭所有功能"
                                txt.TextColor3 = Config.CloseDialogTextColor
                                txt.TextSize = Config.CloseDialogTextSize
                                txt.Font = Enum.Font.Gotham
                                txt.TextWrapped = true
                                txt.ZIndex = 71
                                txt.Parent = dlg
                                local bars = Instance.new("Frame")
                                bars.BackgroundTransparency = 1
                                bars.AnchorPoint = Vector2.new(0.5, 1)
                                bars.Position = UDim2.new(0.5, 0, 1, -Config.CloseDialogPad)
                                bars.Size = UDim2.new(1, -Config.CloseDialogPad * 2, 0, Config.CloseDialogBtnH)
                                bars.ZIndex = 71
                                bars.Parent = dlg
                                local bl = Instance.new("UIListLayout")
                                bl.FillDirection = Enum.FillDirection.Horizontal
                                bl.HorizontalAlignment = Enum.HorizontalAlignment.Center
                                bl.VerticalAlignment = Enum.VerticalAlignment.Center
                                bl.SortOrder = Enum.SortOrder.LayoutOrder
                                bl.Padding = UDim.new(0, Config.CloseDialogBtnGap)
                                bl.Parent = bars
                                local cancelB = makePill("取消", Config.CloseCancelColor)
                                cancelB.LayoutOrder = 1
                                cancelB.Parent = bars
                                cancelB.MouseButton1Click:Connect(function()
                                    if closeDialog ~= dlg then return end
                                    closeDialog = nil
                                    dlg:Destroy()
                                    setHeaderVisible(true)
                                    buildTabUI()
                                    animateEdge(UDim2.new(0, sw - m * 2, 0, sh - top - m), UDim2.new(0, m, 0, top), Config.PanelExpandTime)
                                end)
                                local okBtn = makePill("确认", Config.CloseConfirmColor)
                                okBtn.LayoutOrder = 2
                                okBtn.Parent = bars
                                okBtn.MouseButton1Click:Connect(function()
                                    if closeDialog ~= dlg then return end
                                    closeDialog = nil
                                    dlg:Destroy()
                                    runCloseSequence()
                                end)
                                closeDialog = dlg
                                animateEdge(UDim2.new(0, Config.CloseDialogW, 0, Config.CloseDialogH), UDim2.new(0, (sw - Config.CloseDialogW) / 2, 0, (sh - Config.CloseDialogH) / 2), 0.35)
                            end
                        end
                    end)
                end)
                edge.InputEnded:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                    if not interacting then return end
                    holding = false
                    if longPress then task.cancel(longPress) longPress = nil end
                    resetIslandDrag()
                    if expanded then
                        task.delay(Config.TapShrinkTime + Config.TapCooldown, function()
                            interacting = false
                        end)
                    else
                        TweenService:Create(islandScale, TweenInfo.new(Config.TapShrinkTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = 1 }):Play()
                        if hintActive then
                            clearHint()
                            task.delay(Config.TapShrinkTime, function()
                                interacting = false
                            end)
                        else
                            registerIslandTap()
                            task.delay(Config.TapShrinkTime, function()
                                interacting = false
                            end)
                        end
                    end
                end)
            end)
        end)
    end)

    win.ScreenGui = screenGui
    win.EdgeFrame = edge
    win.Stroke = stroke
    win.Gradient = gradient
    win._added = false
    win.Add = function(self, content)
        self._added = true
        local ok, em = pcall(function()
            if content ~= nil and type(content) ~= "table" and typeof(content) ~= "Instance" then
                error("Add 接收了不支持的内容类型")
            end
        end)
        if not ok then
            reportError("Add 异常: " .. tostring(em))
            self:Error()
        end
    end
    win.AddTab = function(self, opts)
        opts = opts or {}
        local ok, em = pcall(function()
            if type(opts) ~= "table" then error("AddTab 入参不是 table") end
            if opts.Title ~= nil and (type(opts.Title) ~= "string" or #opts.Title == 0) then error("AddTab Title 非法") end
            if opts.Icon ~= nil and type(opts.Icon) ~= "string" then error("AddTab Icon 非法") end
            if opts.IconColor ~= nil and typeof(opts.IconColor) ~= "Color3" then error("AddTab IconColor 非法") end
        end)
        if not ok then
            reportError("AddTab 异常: " .. tostring(em))
            self:Error()
            return nil
        end
        local tab = {
            Title = opts.Title or Config.TitleText,
            Icon = opts.Icon,
            IconColor = opts.IconColor,
            _subtitles = {},
        }
        tab.AddSubTitle = function(self2, sopts)
            sopts = sopts or {}
            local ok2, em2 = pcall(function()
                if type(sopts) ~= "table" then error("AddSubTitle 入参不是 table") end
                if sopts.Title ~= nil and (type(sopts.Title) ~= "string" or #sopts.Title == 0) then error("AddSubTitle Title 非法") end
                if sopts.Icon ~= nil and type(sopts.Icon) ~= "string" then error("AddSubTitle Icon 非法") end
                if sopts.IconColor ~= nil and typeof(sopts.IconColor) ~= "Color3" then error("AddSubTitle IconColor 非法") end
            end)
            if not ok2 then
                reportError("AddSubTitle 异常: " .. tostring(em2))
                win:Error()
                return nil
            end
            local st = {
                Title = sopts.Title or "SubTitle",
                Icon = sopts.Icon,
                IconColor = sopts.IconColor,
                collapsed = false,
                _buttons = {},
                _toggles = {},
                _paragraphs = {},
                _sliders = {},
            }
            st.AddButton = function(self3, bopts)
                bopts = bopts or {}
                local ok3, em3 = pcall(function()
                    if type(bopts) ~= "table" then error("AddButton 入参不是 table") end
                    if bopts.Title ~= nil and (type(bopts.Title) ~= "string" or #bopts.Title == 0) then error("AddButton Title 非法") end
                    if bopts.Icon ~= nil and type(bopts.Icon) ~= "string" then error("AddButton Icon 非法") end
                    if bopts.IconColor ~= nil and typeof(bopts.IconColor) ~= "Color3" then error("AddButton IconColor 非法") end
                end)
                if not ok3 then
                    reportError("AddButton 异常: " .. tostring(em3))
                    win:Error()
                    return nil
                end
                local bt = {
                    Title = bopts.Title or "Button",
                    Icon = bopts.Icon,
                    IconColor = bopts.IconColor,
                    OnClick = bopts.OnClick,
                }
                table.insert(self3._buttons, bt)
                if win._rebuildTabs then win._rebuildTabs() end
                return bt
            end
            st.AddToggle = function(self3, topts)
                topts = topts or {}
                local ok4, em4 = pcall(function()
                    if type(topts) ~= "table" then error("AddToggle 入参不是 table") end
                    if topts.Title ~= nil and (type(topts.Title) ~= "string" or #topts.Title == 0) then error("AddToggle Title 非法") end
                    if topts.Icon ~= nil and type(topts.Icon) ~= "string" then error("AddToggle Icon 非法") end
                    if topts.IconColor ~= nil and typeof(topts.IconColor) ~= "Color3" then error("AddToggle IconColor 非法") end
                    if topts.ThumbColor ~= nil and typeof(topts.ThumbColor) ~= "Color3" then error("AddToggle ThumbColor 非法") end
                    if topts.TrackColor ~= nil and typeof(topts.TrackColor) ~= "Color3" then error("AddToggle TrackColor 非法") end
                end)
                if not ok4 then
                    reportError("AddToggle 异常: " .. tostring(em4))
                    win:Error()
                    return nil
                end
                local tg = {
                    Title = topts.Title or "Toggle",
                    Icon = topts.Icon,
                    IconColor = topts.IconColor,
                    ThumbColor = topts.ThumbColor,
                    TrackColor = topts.TrackColor,
                    Value = topts.Default == true,
                    Callback = topts.Callback,
                }
                tg.Set = function(self4, v)
                    self4.Value = v and true or false
                    if win._rebuildTabs then win._rebuildTabs() end
                end
                table.insert(self3._toggles, tg)
                if win._rebuildTabs then win._rebuildTabs() end
                return tg
            end
            st.AddParagraph = function(self3, popts)
                popts = popts or {}
                local okP, emP = pcall(function()
                    if type(popts) ~= "table" then error("AddParagraph 入参不是 table") end
                    if popts.Title == nil or type(popts.Title) ~= "string" or #popts.Title == 0 then error("AddParagraph Title 非法") end
                    if popts.Info ~= nil and type(popts.Info) ~= "string" then error("AddParagraph Info 非法") end
                    if popts.Icon ~= nil and type(popts.Icon) ~= "string" then error("AddParagraph Icon 非法") end
                    if popts.IconColor ~= nil and typeof(popts.IconColor) ~= "Color3" then error("AddParagraph IconColor 非法") end
                    if popts.BackColor ~= nil and typeof(popts.BackColor) ~= "Color3" then error("AddParagraph BackColor 非法") end
                end)
                if not okP then
                    reportError("AddParagraph 异常: " .. tostring(emP))
                    win:Error()
                    return nil
                end
                local pg = {
                    Title = popts.Title,
                    Info = popts.Info or "",
                    Icon = popts.Icon,
                    IconColor = popts.IconColor,
                    BackColor = popts.BackColor,
                }
                pg.SetTitle = function(self4, v)
                    self4.Title = v and tostring(v) or ""
                    if self4._titleLbl and self4._titleLbl.Parent then self4._titleLbl.Text = self4.Title end
                end
                pg.SetInfo = function(self4, v)
                    self4.Info = v and tostring(v) or ""
                    if self4._infoLbl and self4._infoLbl.Parent then self4._infoLbl.Text = self4.Info end
                end
                pg.SetIcon = function(self4, v)
                    self4.Icon = (type(v) == "string" and v ~= "") and v or nil
                    if win._rebuildTabs then win._rebuildTabs() end
                end
                pg.SetIconColor = function(self4, v)
                    if typeof(v) == "Color3" then
                        self4.IconColor = v
                        if self4._iconLbl and self4._iconLbl.Parent then self4._iconLbl.ImageColor3 = v end
                    end
                end
                pg.SetBackColor = function(self4, v)
                    if typeof(v) == "Color3" then
                        self4.BackColor = v
                        if self4._frame and self4._frame.Parent then
                            self4._frame.BackgroundColor3 = v
                            if self4._stroke and self4._stroke.Parent then self4._stroke.Color = darkenColor(v, Config.ParagraphDarken) end
                        end
                    end
                end
                table.insert(self3._paragraphs, pg)
                if win._rebuildTabs then win._rebuildTabs() end
                return pg
            end
            st.AddSlider = function(self3, a, b, c, d, e)
                local sopts
                if type(a) == "table" then
                    sopts = a
                else
                    sopts = { Title = a, Degree = b, MinValue = c, MaxValue = d, FillColor = e }
                end
                sopts = sopts or {}
                local ok5, em5 = pcall(function()
                    if type(sopts) ~= "table" then error("AddSlider 入参不是 table") end
                    if sopts.Title == nil or type(sopts.Title) ~= "string" or #sopts.Title == 0 then error("AddSlider Title 非法") end
                    if sopts.Degree == nil or type(sopts.Degree) ~= "number" then error("AddSlider Degree 非法") end
                    if sopts.MinValue == nil or type(sopts.MinValue) ~= "number" then error("AddSlider MinValue 非法") end
                    if sopts.MaxValue == nil or type(sopts.MaxValue) ~= "number" then error("AddSlider MaxValue 非法") end
                    if sopts.MinValue >= sopts.MaxValue then error("AddSlider MinValue 必须小于 MaxValue") end
                    if sopts.FillColor ~= nil and typeof(sopts.FillColor) ~= "Color3" then error("AddSlider FillColor 非法") end
                    if sopts.Value ~= nil and type(sopts.Value) ~= "number" then error("AddSlider Value 非法") end
                end)
                if not ok5 then
                    reportError("AddSlider 异常: " .. tostring(em5))
                    win:Error()
                    return nil
                end
                local sl = {
                    Title = sopts.Title,
                    Degree = sopts.Degree,
                    MinValue = sopts.MinValue,
                    MaxValue = sopts.MaxValue,
                    FillColor = sopts.FillColor,
                    Value = sopts.Value,
                    OnChanged = sopts.OnChanged,
                }
                sl.GetValue = function(self4)
                    return self4.Value
                end
                sl.SetValue = function(self4, v, animate)
                    v = tonumber(v)
                    if v == nil then return end
                    local r = self4.MaxValue - self4.MinValue
                    if r <= 0 then
                        self4.Value = self4.MinValue
                    else
                        if self4.Degree and self4.Degree > 0 then
                            v = self4.MinValue + math.floor((v - self4.MinValue) / self4.Degree + 0.5) * self4.Degree
                        end
                        if v < self4.MinValue then v = self4.MinValue end
                        if v > self4.MaxValue then v = self4.MaxValue end
                        self4.Value = v
                    end
                    if self4._refresh then self4._refresh(animate ~= false) end
                    if type(self4.OnChanged) == "function" then
                        local okC, errC = pcall(self4.OnChanged, self4.Value)
                        if not okC then reportError("AddSlider OnChanged 报错: " .. tostring(errC)) end
                    end
                end
                sl.SetTitle = function(self4, v)
                    self4.Title = v and tostring(v) or ""
                    if self4._titleLbl and self4._titleLbl.Parent then
                        self4._titleLbl.Text = self4.Title
                        local tw = measureTextWidth(self4.Title, Config.SliderTitleSize) + Config.SliderTitlePadX
                        if tw < Config.SliderTitleMinW then tw = Config.SliderTitleMinW end
                        self4._titleLbl.Size = UDim2.new(0, tw, 1, 0)
                        if self4._track and self4._track.Parent then
                            self4._track.Position = UDim2.new(0, tw + Config.SliderTitleGap, 0, Config.SliderTrackVPad)
                            self4._track.Size = UDim2.new(1, -(tw + Config.SliderTitleGap), 1, -Config.SliderTrackVPad * 2)
                        end
                    end
                end
                sl.SetFillColor = function(self4, v)
                    if typeof(v) == "Color3" then
                        self4.FillColor = v
                        if self4._fill and self4._fill.Parent then self4._fill.BackgroundColor3 = v end
                    end
                end
                sl.SetDegree = function(self4, v)
                    if type(v) == "number" then
                        self4.Degree = v
                        self4.SetValue(self4.Value, false)
                    end
                end
                sl.SetMin = function(self4, v)
                    if type(v) == "number" then
                        self4.MinValue = v
                        if self4.MinValue >= self4.MaxValue then self4.MinValue = self4.MaxValue - 1 end
                        self4.SetValue(self4.Value, false)
                    end
                end
                sl.SetMax = function(self4, v)
                    if type(v) == "number" then
                        self4.MaxValue = v
                        if self4.MaxValue <= self4.MinValue then self4.MaxValue = self4.MinValue + 1 end
                        self4.SetValue(self4.Value, false)
                    end
                end
                sl.SetOnChanged = function(self4, fn)
                    if type(fn) == "function" then self4.OnChanged = fn end
                end
                table.insert(self3._sliders, sl)
                if win._rebuildTabs then win._rebuildTabs() end
                return sl
            end
            table.insert(self2._subtitles, st)
            if win._rebuildTabs then win._rebuildTabs() end
            return st
        end
        table.insert(self._tabs, tab)
        if self._rebuildTabs then self._rebuildTabs() end
        return tab
    end
    win.Error = function(self)
        if not alive then return end
        reportError("触发错误销毁动画（格式错误 + 红 X + 爆炸）")
        task.spawn(playErrorSequence)
    end
    win._closeNow = function(self)
        alive = false
        if self.ScreenGui and self.ScreenGui.Parent then
            pcall(function() self.ScreenGui:Destroy() end)
        end
    end

    local actionBusy = false
    local actionGen = 0
    local function runIslandAction(text)
        if not alive then return end
        if type(text) ~= "string" or #text == 0 then
            reportError("ShowNotify 需要非空字符串")
            return
        end
        if actionBusy and actionEnd then
            actionEnd(true)
        end
        actionBusy = true
        actionGen = actionGen + 1
        local myGen = actionGen
        local hold = Config.ActionHoldTime
        local function flash(labels)
            task.delay(0.3, function()
                if not alive or myGen ~= actionGen then return end
                for _, lb in ipairs(labels) do
                    if lb and lb.Parent then TweenService:Create(lb, TweenInfo.new(Config.ActionFlashTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextColor3 = Config.IslandTextColor }):Play() end
                end
                task.delay(Config.ActionFlashHold, function()
                    if not alive or myGen ~= actionGen then return end
                    for _, lb in ipairs(labels) do
                        if lb and lb.Parent then TweenService:Create(lb, TweenInfo.new(Config.ActionFlashTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextColor3 = Color3.new(1, 1, 1) }):Play() end
                    end
                end)
            end)
        end
        local function colLabels(container)
            local ls = {}
            if container and container.Parent then
                for _, cf in ipairs(container:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then ls[#ls + 1] = lb end
                end
            end
            return ls
        end

        if expanded then
            if islandTextContainer and islandTextContainer.Parent then
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then TweenService:Create(lb, TweenInfo.new(0.2), { TextTransparency = 1 }):Play() end
                end
            end
            local myBrand = Instance.new("TextLabel")
            myBrand.Name = "IslandActionBrand"
            myBrand.BackgroundTransparency = 1
            myBrand.AnchorPoint = Vector2.new(0, 0.5)
            myBrand.Position = UDim2.new(0, win._titleLeftX or (Config.PanelMargin + Config.HeaderPad), 0, win._titleY or (Config.IslandPosition.Y.Offset + Config.HeaderPad + Config.IslandSize.Y.Offset / 2))
            myBrand.Size = UDim2.new(0, 400, 0, Config.IslandSize.Y.Offset)
            myBrand.Text = Config.IslandText
            myBrand.TextColor3 = Config.TitleColor
            myBrand.TextSize = Config.IslandTextSize
            myBrand.Font = Enum.Font.FredokaOne
            myBrand.TextXAlignment = Enum.TextXAlignment.Left
            myBrand.TextTransparency = 1
            myBrand.ZIndex = 60
            myBrand.Parent = screenGui
            brandLbl = myBrand
            task.delay(0.2, function()
                if myGen ~= actionGen then return end
                if myBrand and myBrand.Parent then TweenService:Create(myBrand, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
            end)
            local H = Config.IslandSize.Y.Offset
            local cy = Config.IslandPosition.Y.Scale * screenGui.AbsoluteSize.Y + Config.IslandPosition.Y.Offset + H / 2 + Config.NotifyDrop
            local pad = 20
            local textW = measureTextWidth(text, Config.IslandTextSize)
            local fullW = textW + pad * 2
            local cap = Instance.new("Frame")
            cap.Name = "IslandActionCapsule"
            cap.BackgroundTransparency = 1
            cap.AnchorPoint = Vector2.new(0.5, 0.5)
            cap.Position = UDim2.new(0.5, 0, 0, cy)
            cap.Size = UDim2.new(0, H, 0, H)
            cap.ClipsDescendants = true
            cap.ZIndex = 60
            cap.Parent = screenGui
            local cc = Instance.new("UICorner")
            cc.CornerRadius = UDim.new(0.5, 0)
            cc.Parent = cap
            local cs = Instance.new("UIStroke")
            cs.Color = Color3.new(1, 1, 1)
            cs.Thickness = Config.BorderThickness
            cs.Transparency = 1
            cs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            cs.Parent = cap
            local clbl = Instance.new("TextLabel")
            clbl.BackgroundTransparency = 1
            clbl.AnchorPoint = Vector2.new(0.5, 0.5)
            clbl.Position = UDim2.new(0.5, 0, 0.5, 0)
            clbl.Size = UDim2.new(0, fullW, 1, 0)
            clbl.Text = text
            clbl.TextColor3 = Color3.new(1, 1, 1)
            clbl.Font = textHasCJK(text) and Config.CJKFont or Enum.Font.FredokaOne
            clbl.TextSize = Config.IslandTextSize
            clbl.TextTransparency = 1
            clbl.ZIndex = 60
            clbl.Parent = cap
            local rv = Config.IslandActionReveal
            TweenService:Create(cs, TweenInfo.new(rv, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Transparency = Config.IslandActionStrokeTransparency }):Play()
            TweenService:Create(clbl, TweenInfo.new(rv, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
            TweenService:Create(cap, TweenInfo.new(rv, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, fullW, 0, H) }):Play()
            local ended = false
            local function endNow(interrupted)
                if ended then return end
                ended = true
                if actionEnd == endNow then actionEnd = nil end
                if not alive then
                    if myGen == actionGen then actionBusy = false end
                    return
                end
                local et = interrupted and Config.ActionInterruptExit or 0.35
                TweenService:Create(cs, TweenInfo.new(et, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Transparency = 1 }):Play()
                TweenService:Create(clbl, TweenInfo.new(et, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
                TweenService:Create(cap, TweenInfo.new(et, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Size = UDim2.new(0, H, 0, H) }):Play()
                task.delay(et + 0.03, function() if cap and cap.Parent then cap:Destroy() end end)
                if myBrand and myBrand.Parent then
                    TweenService:Create(myBrand, TweenInfo.new(et, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
                    task.delay(et + 0.03, function() if myBrand and myBrand.Parent then myBrand:Destroy() end end)
                end
                if myGen == actionGen then
                    if islandTextContainer and islandTextContainer.Parent then
                        for _, cf in ipairs(islandTextContainer:GetChildren()) do
                            local lb = cf:FindFirstChildOfClass("TextLabel")
                            if lb then TweenService:Create(lb, TweenInfo.new(et), { TextTransparency = 0 }):Play() end
                        end
                    end
                    actionBusy = false
                end
            end
            actionEnd = endNow
            flash({ clbl })
            task.delay(hold, function() endNow(false) end)
        else
            local dw = Config.ActionExtendW
            local dh = Config.ActionExtendH
            local curSize = edge.Size
            local curPos = edge.Position
            local oldContainer = islandTextContainer
            local ended = false
            local function endNow(interrupted)
                if ended then return end
                ended = true
                if actionEnd == endNow then actionEnd = nil end
                if not alive then
                    if myGen == actionGen then actionBusy = false end
                    return
                end
                local et = interrupted and Config.ActionInterruptExit or 0.35
                if oldContainer and oldContainer.Parent then
                    for _, cf in ipairs(oldContainer:GetChildren()) do
                        local lb = cf:FindFirstChildOfClass("TextLabel")
                        if lb then TweenService:Create(lb, TweenInfo.new(et), { TextTransparency = 1 }):Play() end
                    end
                end
                TweenService:Create(edge, TweenInfo.new(et, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(curSize.X.Scale, curSize.X.Offset, curSize.Y.Scale, curSize.Y.Offset),
                    Position = UDim2.new(curPos.X.Scale, curPos.X.Offset, curPos.Y.Scale, curPos.Y.Offset),
                }):Play()
                task.delay(et + 0.03, function()
                    if myGen ~= actionGen then return end
                    if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
                    islandTextContainer = createIslandText(title, Config.TitleColor, true)
                    actionBusy = false
                end)
            end
            actionEnd = endNow
            TweenService:Create(edge, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(curSize.X.Scale, curSize.X.Offset + dw, curSize.Y.Scale, curSize.Y.Offset + dh),
                Position = UDim2.new(curPos.X.Scale, curPos.X.Offset, curPos.Y.Scale, curPos.Y.Offset + dh / 2),
            }):Play()
            if oldContainer and oldContainer.Parent then
                for _, cf in ipairs(oldContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then TweenService:Create(lb, TweenInfo.new(0.2), { TextTransparency = 1 }):Play() end
                end
            end
            task.delay(0.24, function()
                if ended or not alive or myGen ~= actionGen then return end
                if oldContainer and oldContainer.Parent then oldContainer:Destroy() end
                islandTextContainer = createIslandText(text, Color3.new(1, 1, 1), true)
                islandTextContainer.Position = UDim2.new(
                    Config.IslandPosition.X.Scale,
                    Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2,
                    Config.IslandPosition.Y.Scale,
                    Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2 + dh / 2
                )
                flash(colLabels(islandTextContainer))
            end)
            task.delay(hold, function() endNow(false) end)
        end
    end
    win.GetWindowAction = function()
        return winOpen and "WindowOpen" or "WindowClose"
    end
    win.DynamicIslandAction = setmetatable({
        ChangeText = function(text)
            if type(text) ~= "string" or #text == 0 then return end
            title = text
            if not alive or expanded then return end
            setIslandText(text, Config.TitleColor)
        end,
        ShowNotify = function(t)
            runIslandAction(t)
        end,
    }, { __call = function(self) return self end })
    win.ShowNotify = function(self, t)
        runIslandAction(t)
    end
    Library._lastWin = win
    Library.DynamicIslandAction = win.DynamicIslandAction
    Library.GetWindowAction = function()
        return win:GetWindowAction()
    end
    Library.ShowNotify = function(t)
        runIslandAction(t)
    end
    return win
end

Library._demoWin = Library.CreateWindow({ _error = true })

return Library
