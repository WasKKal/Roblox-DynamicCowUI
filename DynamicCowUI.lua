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
    TabActiveColor = Color3.fromRGB(255, 255, 255),
    TabInactiveColor = Color3.fromRGB(150, 152, 162),
    TabStagger = 0.06,
    TabFadeIn = 0.25,
    ContentEmptyIconSize = 48,
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
    local win = { _tabs = {}, _activeTab = 0, _rebuildTabs = nil }

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
                local function destroyTabUI()
                    if tabListContainer then tabListContainer:Destroy() tabListContainer = nil end
                    if tabContentContainer then tabContentContainer:Destroy() tabContentContainer = nil end
                    if headerDivider then headerDivider:Destroy() headerDivider = nil end
                    if tabSeparator then tabSeparator:Destroy() tabSeparator = nil end
                    if tabEmptyLabel then tabEmptyLabel:Destroy() tabEmptyLabel = nil end
                    tabContentEmpty = nil
                end
                local function updateContentArea()
                    if tabContentEmpty then tabContentEmpty.Visible = (win._activeTab == 0) end
                end
                local function updateTabsHighlight()
                    if not tabListContainer then return end
                    for _, row in ipairs(tabListContainer:GetChildren()) do
                        if row:IsA("TextButton") then
                            local idx = row.LayoutOrder
                            local active = (win._activeTab == idx)
                            local nl = row:FindFirstChildOfClass("TextLabel")
                            local ic2 = row:FindFirstChildOfClass("ImageLabel")
                            if nl then TweenService:Create(nl, TweenInfo.new(0.15), { TextColor3 = active and Config.TabActiveColor or Config.TabInactiveColor }):Play() end
                            if ic2 then
                                local td = win._tabs[idx]
                                local base = (td and td.IconColor) or Config.TabInactiveColor
                                TweenService:Create(ic2, TweenInfo.new(0.15), { ImageColor3 = active and Config.TabActiveColor or base }):Play()
                            end
                        end
                    end
                end

                local function collapsePanel()
                    if not expanded then return end
                    local ll = islandTextContainer and islandTextContainer:FindFirstChildOfClass("UIListLayout")
                    if ll then ll.HorizontalAlignment = Enum.HorizontalAlignment.Center end
                    local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                    local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
                    local shrinkBack = TweenService:Create(edge, TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
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
                            TweenService:Create(edge, TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(0, sw - m * 2, 0, sh - top - m),
                                Position = UDim2.new(0, m, 0, top),
                            }):Play()
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
                                if infoLabel and infoLabel.Parent then
                                    TweenService:Create(infoLabel, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                        Position = UDim2.new(0, contentLeftX, 0, infoTop),
                                        TextTransparency = 0,
                                    }):Play()
                                end
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
                                    local emptyGroup = Instance.new("Frame")
                                    emptyGroup.Name = "TabContentEmpty"
                                    emptyGroup.BackgroundTransparency = 1
                                    emptyGroup.AnchorPoint = Vector2.new(0.5, 0.5)
                                    emptyGroup.Position = UDim2.new(0.5, 0, 0.5, 0)
                                    emptyGroup.Size = UDim2.fromOffset(220, 130)
                                    emptyGroup.ZIndex = 3
                                    emptyGroup.Parent = contentFrame
                                    tabContentEmpty = emptyGroup
                                    local eIcon = Instance.new("ImageLabel")
                                    eIcon.Name = "EmptyIcon"
                                    eIcon.Size = UDim2.fromOffset(Config.ContentEmptyIconSize, Config.ContentEmptyIconSize)
                                    eIcon.AnchorPoint = Vector2.new(0.5, 0)
                                    eIcon.Position = UDim2.new(0.5, 0, 0, 0)
                                    eIcon.BackgroundTransparency = 1
                                    eIcon.ImageColor3 = Config.TabInactiveColor
                                    eIcon.ScaleType = Enum.ScaleType.Fit
                                    eIcon.ZIndex = 3
                                    eIcon.Parent = emptyGroup
                                    local eText = Instance.new("TextLabel")
                                    eText.Name = "EmptyText"
                                    eText.AnchorPoint = Vector2.new(0.5, 0)
                                    eText.Position = UDim2.new(0.5, 0, 0, Config.ContentEmptyIconSize + 14)
                                    eText.Size = UDim2.new(1, 0, 0, 24)
                                    eText.BackgroundTransparency = 1
                                    eText.Text = "请先选中一个页面"
                                    eText.TextColor3 = Config.TabInactiveColor
                                    eText.TextSize = Config.TabTextSize
                                    eText.Font = Enum.Font.Gotham
                                    eText.TextXAlignment = Enum.TextXAlignment.Center
                                    eText.TextYAlignment = Enum.TextYAlignment.Center
                                    eText.ZIndex = 3
                                    eText.Parent = emptyGroup
                                    task.spawn(function()
                                        local lucide = loadLucide()
                                        if lucide then
                                            local okE, asset = pcall(lucide.GetAsset, "mouse-pointer-click")
                                            if okE and asset and asset.Url then
                                                eIcon.Image = asset.Url
                                                if asset.ImageRectOffset then eIcon.ImageRectOffset = asset.ImageRectOffset eIcon.ImageRectSize = asset.ImageRectSize end
                                            end
                                        end
                                    end)
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
                                        local hasIcon = (tab.Icon ~= nil and tab.Icon ~= "")
                                        local ticon = nil
                                        if hasIcon then
                                            ticon = Instance.new("ImageLabel")
                                            ticon.Size = UDim2.fromOffset(Config.TabIconSize, Config.TabIconSize)
                                            ticon.Position = UDim2.new(0, 0, 0.5, 0)
                                            ticon.AnchorPoint = Vector2.new(0, 0.5)
                                            ticon.BackgroundTransparency = 1
                                            ticon.ImageColor3 = tab.IconColor or Config.TabInactiveColor
                                            ticon.ImageTransparency = 1
                                            ticon.ZIndex = 3
                                            ticon.Parent = row
                                        end
                                        local tname = Instance.new("TextLabel")
                                        tname.BackgroundTransparency = 1
                                        tname.Text = tab.Title
                                        tname.TextColor3 = Config.TabInactiveColor
                                        tname.TextSize = Config.TabTextSize
                                        tname.Font = Enum.Font.Gotham
                                        tname.TextYAlignment = Enum.TextYAlignment.Center
                                        tname.TextTransparency = 1
                                        tname.ZIndex = 3
                                        if hasIcon then
                                            tname.Size = UDim2.new(1, -(Config.TabIconSize + Config.TabTextGap), 1, 0)
                                            tname.Position = UDim2.new(0, Config.TabIconSize + Config.TabTextGap, 0, 0)
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
        }
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
    return win
end

Library._demoWin = Library.CreateWindow({ _error = true })

return Library
