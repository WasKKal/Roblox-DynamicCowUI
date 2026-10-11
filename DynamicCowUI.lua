local svc = {
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
}

local RunService = svc.RunService
local TweenService = svc.TweenService

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
    TitleLeftShift = 10,
    IslandTapScale = 1.06,
    TapExpandTime = 0.25,
    TapShrinkTime = 0.3,
    TapCooldown = 0.2,
    LongPressThreshold = 0.5,
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
    PanelEaseStyle = Enum.EasingStyle.Back,
    InfoEnterDelay = 0.1,
    BorderSweepFade = 0.3,
    ContentEmptyIcon = "mouse-pointer-click",
    ContentEmptyText = "请先选中一个页面",
    ContentNoCtrlIcon = "ghost",
    ContentNoCtrlText = "这里还没有控件",
    TabSelFill = Color3.fromRGB(34, 34, 42),
    TabSelFillTransparency = 0.15,
    TabSelStroke = Color3.new(1, 1, 1),
    TabSelStrokeThickness = 1,
    TabSelCorner = UDim.new(0, 8),
    SubTitleRowHeight = 30,
    SubTitleIconSize = 20,
    SubTitleTextSize = 16,
    SubTitleArrowSize = 18,
    SubTitleArrowRotate = 90,
    SubTitleColor = Color3.new(1, 1, 1),
    SubTitleBodyHeight = 48,
    SubTitleBodyFill = Color3.fromRGB(28, 28, 34),
    SubTitleBodyFillTransparency = 0.35,
    SubTitleDividerGap = 10,
    SubTitleBlockGap = 10,
    SubTitleCollapseTime = 0.3,
    SubTitleBodyPadY = 8,
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
    ActionHoldTime = 3,
    ActionExtendW = 40,
    ActionExtendH = 12,
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
        reportError(errReason)
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
                charLabel.Font = Enum.Font.FredokaOne
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

    local expanded = false
    local islandTextContainer = nil
    local alive = true
    local ready = false
    local win = { _tabs = {}, _activeTab = 0, _rebuildTabs = nil }

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
        local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
        local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
        flowSpeed = 0
        if backdrop and backdrop.Parent then backdrop:Destroy() end
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

        task.delay(0.6, function()
            spawnRedXBall()
        end)

        task.delay(0.6 + Config.BallHoldTime + 0.95, function()
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
                local closeBtn = nil
                local titleIcon = nil
                local infoLabel = nil
                local tabListContainer = nil
                local tabContentContainer = nil
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
                            if not bt then return end
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
                    for _, st in ipairs(tab._subtitles) do
                        local btns = st._buttons or {}
                        local contentH
                        if #btns > 0 then
                            contentH = Config.SubTitleBodyPadY * 2 + #btns * Config.ButtonHeight + (#btns - 1) * Config.ButtonGap
                        else
                            contentH = Config.SubTitleBodyHeight
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
                        body.BackgroundTransparency = (#btns > 0) and 1 or Config.SubTitleBodyFillTransparency
                        body.BorderSizePixel = 0
                        body.ZIndex = 1
                        body.Parent = block
                        local bc = Instance.new("UICorner")
                        bc.CornerRadius = UDim.new(0, 6)
                        bc.Parent = body
                        if #btns > 0 then
                            local bl = Instance.new("UIListLayout")
                            bl.FillDirection = Enum.FillDirection.Vertical
                            bl.SortOrder = Enum.SortOrder.LayoutOrder
                            bl.Padding = UDim.new(0, Config.ButtonGap)
                            bl.Parent = body
                            local bp = Instance.new("UIPadding")
                            bp.PaddingTop = UDim.new(0, Config.SubTitleBodyPadY)
                            bp.PaddingBottom = UDim.new(0, Config.SubTitleBodyPadY)
                            bp.Parent = body
                            for bi, bt in ipairs(btns) do
                                makeButton(bt, bi).Parent = body
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
                    local ll = islandTextContainer and islandTextContainer:FindFirstChildOfClass("UIListLayout")
                    if ll then ll.HorizontalAlignment = Enum.HorizontalAlignment.Center end
                    local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                    local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
                    local shrinkBack = TweenService:Create(edge, TweenInfo.new(Config.PanelExpandTime, Config.PanelEaseStyle, Enum.EasingDirection.Out), {
                        Size = Config.IslandSize,
                        Position = Config.IslandPosition,
                    })
                    shrinkBack:Play()
                    shrinkBack.Completed:Connect(function()
                        edge.AnchorPoint = Vector2.new(0.5, 0.5)
                        edge.Position = UDim2.new(0.5, cx, 0, cy)
                    end)
                    TweenService:Create(islandTextContainer, TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Position = UDim2.new(Config.IslandPosition.X.Scale, cx, Config.IslandPosition.Y.Scale, cy),
                    }):Play()
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do local lb = cf:FindFirstChildOfClass("TextLabel") if lb then lb.TextTransparency = 0 end end
                    if closeBtn then closeBtn:Destroy() closeBtn = nil end
                    if titleIcon then titleIcon:Destroy() titleIcon = nil end
                    if infoLabel then infoLabel:Destroy() infoLabel = nil end
                    destroyTabUI()
                    win._rebuildTabs = nil
                    expanded = false
                    interacting = false
                end

                edge.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                    if not ready then return end
                    if interacting then return end
                    if expanded then return end
                    interacting = true
                    holding = true
                    TweenService:Create(islandScale, TweenInfo.new(Config.TapExpandTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = Config.IslandTapScale }):Play()
                    longPress = task.delay(Config.LongPressThreshold, function()
                        if holding then
                            expanded = true
                            islandScale.Scale = 1
                            edge.AnchorPoint = Vector2.new(0, 0)
                            edge.Position = Config.IslandPosition
                            local sw = screenGui.AbsoluteSize.X
                            local sh = screenGui.AbsoluteSize.Y
                            local m = Config.PanelMargin
                            local top = Config.IslandPosition.Y.Offset
                            TweenService:Create(edge, TweenInfo.new(Config.PanelExpandTime, Config.PanelEaseStyle, Enum.EasingDirection.Out), {
                                Size = UDim2.new(0, sw - m * 2, 0, sh - top - m),
                                Position = UDim2.new(0, m, 0, top),
                            }):Play()
                            playBorderSweep()
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
                            local titleTargetY = blockTop + titleH / 2
                            local infoTop = blockTop + titleH + vGap
                            local listLayout = islandTextContainer:FindFirstChildOfClass("UIListLayout")
                            local function fadeTitleLabels(t)
                                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                    local lb = cf:FindFirstChildOfClass("TextLabel")
                                    if lb then TweenService:Create(lb, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = t }):Play() end
                                end
                            end
                            fadeTitleLabels(1)
                            task.delay(Config.FadeInTime, function()
                                if not expanded then return end
                                if listLayout then listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left end
                                local slide = 40
                                islandTextContainer.Position = UDim2.new(0, titleTargetX + slide, 0, titleTargetY)
                                TweenService:Create(islandTextContainer, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    Position = UDim2.new(0, titleTargetX, 0, titleTargetY),
                                }):Play()
                                fadeTitleLabels(0)
                                task.delay(Config.InfoEnterDelay, function()
                                    if not expanded then return end
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
                                div.Parent = edge
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
                                    listFrame.Parent = edge
                                    tabListContainer = listFrame
                                    local sep = Instance.new("Frame")
                                    sep.Name = "TabSeparator"
                                    sep.Size = UDim2.new(0, 1, 1, -(listTop + m))
                                    sep.Position = UDim2.new(0, titlePad + listW + Config.TabAreaGap / 2, 0, listTop)
                                    sep.BackgroundColor3 = Config.DividerColor
                                    sep.BorderSizePixel = 0
                                    sep.ZIndex = 2
                                    sep.Parent = edge
                                    tabSeparator = sep
                                    local contentX = titlePad + listW + Config.TabAreaGap
                                    local contentFrame = Instance.new("Frame")
                                    contentFrame.Name = "TabContent"
                                    contentFrame.BackgroundTransparency = 1
                                    contentFrame.Position = UDim2.new(0, contentX, 0, listTop)
                                    contentFrame.Size = UDim2.new(1, -(contentX + titlePad), 1, -(listTop + m))
                                    contentFrame.ClipsDescendants = true
                                    contentFrame.ZIndex = 2
                                    contentFrame.Parent = edge
                                    tabContentContainer = contentFrame
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
                                    local subList = Instance.new("Frame")
                                    subList.Name = "TabSubtitleList"
                                    subList.BackgroundTransparency = 1
                                    subList.Size = UDim2.new(1, 0, 1, 0)
                                    subList.ZIndex = 2
                                    subList.Parent = contentFrame
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
                                            tname.Size = UDim2.new(1, 0, 1, 0)
                                            tname.Position = UDim2.new(0, 0, 0, 0)
                                            tname.TextXAlignment = Enum.TextXAlignment.Center
                                        end
                                        tname.Parent = row
                                        task.delay(Config.PanelExpandTime + (i - 1) * Config.TabStagger, function()
                                            if not expanded then return end
                                            if ticon and ticon.Parent then TweenService:Create(ticon, TweenInfo.new(Config.TabFadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play() end
                                            if tname and tname.Parent then TweenService:Create(tname, TweenInfo.new(Config.TabFadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
                                        end)
                                        row.MouseButton1Click:Connect(function()
                                            win._activeTab = i
                                            updateTabsHighlight()
                                            updateContentArea()
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
                                    lbl.Parent = edge
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
                            btn.Parent = edge
                            btn.InputBegan:Connect(function(bi)
                                if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
                                    collapsePanel()
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
                        end
                    end)
                end)
                edge.InputEnded:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                    if not interacting then return end
                    holding = false
                    if longPress then task.cancel(longPress) longPress = nil end
                    if expanded then
                        task.delay(Config.TapShrinkTime + Config.TapCooldown, function()
                            interacting = false
                        end)
                    else
                        TweenService:Create(islandScale, TweenInfo.new(Config.TapShrinkTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = 1 }):Play()
                        task.delay(Config.TapShrinkTime + Config.TapCooldown, function()
                            interacting = false
                        end)
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
    local function runIslandAction(text)
        if actionBusy or not alive then return end
        if type(text) ~= "string" or #text == 0 then
            reportError("DynamicIslandAction.ChangeText 需要非空字符串")
            return
        end
        actionBusy = true
        local hold = Config.ActionHoldTime
        local function flash(labels)
            task.delay(0.3, function()
                if not alive then return end
                for _, lb in ipairs(labels) do
                    if lb and lb.Parent then TweenService:Create(lb, TweenInfo.new(0.12), { TextColor3 = Config.IslandTextColor }):Play() end
                end
                task.delay(0.16, function()
                    if not alive then return end
                    for _, lb in ipairs(labels) do
                        if lb and lb.Parent then TweenService:Create(lb, TweenInfo.new(0.12), { TextColor3 = Color3.new(1, 1, 1) }):Play() end
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
            local cy = Config.IslandPosition.Y.Scale * screenGui.AbsoluteSize.Y + Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
            local cap = Instance.new("Frame")
            cap.Name = "IslandActionCapsule"
            cap.BackgroundTransparency = 1
            cap.AnchorPoint = Vector2.new(0.5, 0.5)
            cap.Position = UDim2.new(0.5, 0, 0, cy)
            cap.Size = UDim2.new(0, 0, 0, Config.IslandSize.Y.Offset)
            cap.AutomaticSize = Enum.AutomaticSize.X
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
            local cpad = Instance.new("UIPadding")
            cpad.PaddingLeft = UDim.new(0, 18)
            cpad.PaddingRight = UDim.new(0, 18)
            cpad.Parent = cap
            local clbl = Instance.new("TextLabel")
            clbl.BackgroundTransparency = 1
            clbl.Size = UDim2.new(0, 0, 1, 0)
            clbl.AutomaticSize = Enum.AutomaticSize.X
            clbl.Text = text
            clbl.TextColor3 = Color3.new(1, 1, 1)
            clbl.TextSize = Config.IslandTextSize
            clbl.Font = Enum.Font.FredokaOne
            clbl.TextTransparency = 1
            clbl.ZIndex = 60
            clbl.Parent = cap
            TweenService:Create(cs, TweenInfo.new(0.25), { Transparency = 0 }):Play()
            TweenService:Create(clbl, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
            flash({ clbl })
            task.delay(hold, function()
                if not alive then actionBusy = false return end
                if cs and cs.Parent then TweenService:Create(cs, TweenInfo.new(0.3), { Transparency = 1 }):Play() end
                if clbl and clbl.Parent then TweenService:Create(clbl, TweenInfo.new(0.3), { TextTransparency = 1 }):Play() end
                task.delay(0.32, function() if cap and cap.Parent then cap:Destroy() end end)
                if islandTextContainer and islandTextContainer.Parent then
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do
                        local lb = cf:FindFirstChildOfClass("TextLabel")
                        if lb then TweenService:Create(lb, TweenInfo.new(0.3), { TextTransparency = 0 }):Play() end
                    end
                end
                actionBusy = false
            end)
        else
            local dw = Config.ActionExtendW
            local dh = Config.ActionExtendH
            local curSize = edge.Size
            local curPos = edge.Position
            local oldContainer = islandTextContainer
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
                if not alive then actionBusy = false return end
                if oldContainer and oldContainer.Parent then oldContainer:Destroy() end
                islandTextContainer = createIslandText(text, Color3.new(1, 1, 1), true)
                islandTextContainer.Position = UDim2.new(
                    Config.IslandPosition.X.Scale,
                    Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2,
                    Config.IslandPosition.Y.Scale,
                    Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2 + dh / 2
                )
                flash(colLabels(islandTextContainer))
                task.delay(hold, function()
                    if not alive then actionBusy = false return end
                    if islandTextContainer and islandTextContainer.Parent then
                        for _, cf in ipairs(islandTextContainer:GetChildren()) do
                            local lb = cf:FindFirstChildOfClass("TextLabel")
                            if lb then TweenService:Create(lb, TweenInfo.new(0.3), { TextTransparency = 1 }):Play() end
                        end
                    end
                    TweenService:Create(edge, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = UDim2.new(curSize.X.Scale, curSize.X.Offset, curSize.Y.Scale, curSize.Y.Offset),
                        Position = UDim2.new(curPos.X.Scale, curPos.X.Offset, curPos.Y.Scale, curPos.Y.Offset),
                    }):Play()
                    task.delay(0.32, function()
                        if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
                        islandTextContainer = createIslandText(title, Config.TitleColor, true)
                        actionBusy = false
                    end)
                end)
            end)
        end
    end
    win.DynamicIslandAction = setmetatable({
        ChangeText = function(t)
            runIslandAction(t)
        end,
    }, { __call = function(self) return self end })
    Library._lastWin = win
    Library.DynamicIslandAction = win.DynamicIslandAction
    return win
end

Library._demoWin = Library.CreateWindow({ _error = true })

return Library
