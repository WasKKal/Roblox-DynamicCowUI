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
    -- 多脚本销毁后新灵动岛「从圆形展开为胶囊」入场动画
    CircleGrowTime = 0.5,
    CircleHoldTime = 0.22,
    TitleText = "Dynamic Cow",
    TitleShrinkScale = 0.85,
    TitleShrinkTime = 0.6,
    FillTime = 0.5,
    LucideIcon = "check",
    LucideColor = Color3.fromRGB(0, 255, 120),
    LucideIconSize = 22,
    DefaultTitleIcon = "carton",

    TitleLoaderIcon = "loader-circle",

    TitleIconFailIcon = "carton",
    TitleLoaderSpinTime = 0.9,   
    TitleIconHandoffTime = 0.28, 
    DefaultTitleIconColor = Color3.new(1, 1, 1),
    RingThickness = 3,
    RingColor = Color3.fromRGB(0, 255, 120),
    RingSpeed = 120,
    BallSplitOffset = 50,
    BallSplitTime = 0.9,
    BallHoldTime = 1.5,
    IslandText = "DynamicCow",
    IslandTextColor = Color3.fromRGB(0, 255, 120),

    IslandTextChangeColor = Color3.fromRGB(0, 255, 120),
    IslandTextChangeTintTime = 0.18,
    IslandTextChangeRestoreTime = 0.45,
    IslandTextSize = 20,
    CJKFont = Enum.Font.GothamMedium,
    TitleLeftShift = 10,
    IslandTapScale = 1.06,
    TapExpandTime = 0.25,
    TapShrinkTime = 0.3,
    TapWindow = 0.8,
    HintText = "长按灵动岛以展开面板",
    HintTextSize = 17,
    HintExtendPad = 36,

    HintHoldTime = 1.5,

    HintClickCooldown = 2,
    HintRevealStep = 0.04,
    HintRevealTime = 0.3,
    HintSlideInDistance = 26,
    HintSlideOutDistance = 18,
    HintSlideTime = 0.35,

    IconTextHoldTime = 2,
    IconTextHeight = 52,
    IconTextIconSize = 34,
    IconTextTextSize = 17,
    IconTextGap = 12,
    IconTextPadX = 22,
    IconTextMinW = 220,
    IconTextGrowTime = 0.35,
    IconTextRestoreTime = 0.35,

    ToggleIslandHoldTime = 2,
    ToggleIslandGrowTime = 0.35,
    ToggleIslandRestoreTime = 0.35,
    ToggleIslandIconSize = 22,
    ToggleIslandTextSize = 16,
    ToggleIslandGap = 14,
    ToggleIslandPadX = 20,
    ToggleIslandMinW = 160,
    ToggleIslandRevealTime = 0.26,
    ToggleIslandFadeTime = 0.24,
    ToggleIslandStepTime = 0.055,

    ToggleIslandRestoreStepScale = 0.45,
    ToggleIslandOnColor = Color3.fromRGB(70, 160, 255),
    ToggleIslandOffColor = Color3.fromRGB(255, 96, 96),
    LongPressThreshold = 0.5,
    IslandDragThreshold = 8,
    IslandDragDamp = 0.55,
    IslandDragMax = 70,
    IslandDragFixed = 54,

    IslandDragStopDelay = 0.7,
    IslandDragHold = 4,
    PanelExpandTime = 0.55,
    PanelMargin = 20,
    BackdropDim = 0.4,
    IslandFinalTransparency = 0.4,
    ErrorText = "格式错误",
    ErrorTextColor = Color3.fromRGB(255, 80, 80),
    MultiErrorText = "出现多个错误 前往控制台",
    RedXColor = Color3.fromRGB(255, 60, 60),

    ParticleCount = 26,
    ParticleCountMin = 16,
    ParticleCountMax = 42,
    ParticleSize = 5,
    ParticleSizeVar = 3,
    ParticleSpeedMin = 150,
    ParticleSpeedMax = 420,
    ParticleUpBias = 90,
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

    TabSelFadeTime = 0.18,      
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
    ToggleRowHeight = 30,
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

    SwitchTitleMoveTime = 0.55,

    SwitchTitleScale = 0.42,

    SwitchBorderFadeTime = 0.18,

    SwitchFadeOutTime = 0.26,

    SwitchHoldTime = 1,

    SwitchLoaderFadeTime = 0.3,

    SwitchLoaderCorner = 16,

    SwitchLoadingText = "正在切换脚本",

 SwitchConfirmLoadingText = "正在载入脚本…",

    SwitchButtonIcon = "arrow-right-left",
    SwitchButtonSize = 20,
    SwitchButtonGap = 8,

    SwitchDialogW = 720,
    SwitchDialogH = 190,
    SwitchDialogTitle = "你要切换哪一个脚本？",

    SwitchDropdownH = 46,
    SwitchDropdownMaxH = 210,
    SwitchDropdownIcon = "chevron-right",
    SwitchDropdownItemH = 40,
    SwitchDropdownItemGap = 4,
    SwitchDropdownFill = Color3.fromRGB(38, 38, 48),
    SwitchDropdownActiveColor = Color3.fromRGB(96, 132, 255),
    SwitchDropdownTextColor = Color3.fromRGB(235, 235, 245),
    SwitchDropdownHoverColor = Color3.fromRGB(54, 54, 68),
    SwitchDropdownCorner = 18,
    SwitchDropdownListGap = 8,
    SwitchDropdownListInset = 10,
    SwitchDialogConfirmColor = Color3.fromRGB(96, 132, 255),
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
    ParagraphTitleDrop = 8,
    SliderRowHeight = 30,
    SliderTitleSize = 14,
    SliderTitleColor = Color3.new(1, 1, 1),
    SliderTitlePadX = 10,
    SliderTitleMinW = 40,
    SliderTitleGap = 10,
    SliderValueW = 44,
    SliderValueColor = Color3.fromRGB(190, 195, 210),
    SliderValueSize = 13,
    SliderTrackVPad = 9,
    SliderTrackColor = Color3.fromRGB(58, 58, 70),
    SliderTrackTransparency = 0.35,
    SliderTrackCorner = UDim.new(0, 8),
    SliderFillColor = Color3.fromRGB(120, 160, 255),

    SliderThumbColor = Color3.fromRGB(245, 245, 248),
    SliderThumbSize = 16,
    SliderAnimTime = 0.3,
    DropdownRowHeight = 32,

    LineRowHeight = 8,
    LineThickness = 1,
    LineColor = Color3.fromRGB(88, 88, 98),
    -- 默认分隔线内缩，使 AddLine() 默认线条与显式 Inset 线条长度一致，
    -- 避免出现默认满宽线条「长短不一」的观感
    LineInset = 12,
    DropdownTitleSize = 14,
    DropdownTitleColor = Color3.new(1, 1, 1),
    DropdownTitlePadX = 10,
    DropdownTitleMinW = 40,
    DropdownTitleGap = 10,
    DropdownCapsuleW = 120,
    DropdownCapsuleH = 26,
    DropdownCapsuleFill = Color3.fromRGB(38, 38, 48),
    DropdownCapsuleStroke = Color3.fromRGB(150, 150, 160),
    DropdownCapsuleStrokeThickness = 1,
    DropdownCapsuleTextColor = Color3.new(1, 1, 1),
    DropdownCapsuleTextSize = 13,
    DropdownCapsulePlaceholder = "未选择",
    DropdownMenuW = 200,
    DropdownMenuMaxH = 220,

    DropdownMenuCorner = 12,
    DropdownOptionH = 30,
    DropdownMenuPad = 6,
    DropdownMenuFill = Color3.fromRGB(24, 24, 30),
    DropdownMenuFillTransparency = 0.02,
    DropdownMenuStroke = Color3.fromRGB(150, 150, 160),
    DropdownMenuStrokeThickness = 1,
    DropdownOptionTextColor = Color3.fromRGB(230, 230, 235),
    DropdownOptionTextSize = 13,
    DropdownOptionHover = Color3.fromRGB(48, 48, 58),
    -- 选中指示器：银白静态渐变（不再用蓝色），并以独立 Frame 承载、缩小高度、加细边框
    DropdownOptionSelected = Color3.fromRGB(222, 230, 245),
    DropdownOptionSelGradA = Color3.fromRGB(250, 252, 255),
    DropdownOptionSelGradB = Color3.fromRGB(196, 206, 226),
    DropdownOptionSelStroke = Color3.fromRGB(236, 242, 252),
    DropdownOptionSelStrokeThickness = 1,
    DropdownOptionHiH = 22,
    DropdownOptionHiInset = 6,
    DropdownRevealTime = 0.22,
    DropdownOptionStagger = 0.05,
    DropdownCollapseTime = 0.2,

    DropdownMenuZ = 300,
    DropdownArrowSize = 12,
}

local Library = {}

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

local function ensureConfigFolder(folder)
    if type(folder) ~= "string" or #folder == 0 then return false end
    local base = "DynamicCowUI/Config"
    local path = base .. "/" .. folder
    pcall(function()
        if isfolder and not isfolder(base) then makefolder(base) end
        if isfolder and not isfolder(path) then makefolder(path) end
    end)
    return true
end

local CONFIG_FILE_NAME = "Config.json"

local function configFolderPath(folder)
    if type(folder) ~= "string" or #folder == 0 then return nil end
    return "DynamicCowUI/Config/" .. folder
end

local function configValuePath(folder)
    local dir = configFolderPath(folder)
    if not dir then return nil end
    return dir .. "/" .. CONFIG_FILE_NAME
end

local configCache = {}

local function readConfigTable(folder)
    local cached = configCache[folder]
    if cached then return cached end
    local data = {}
    local path = configValuePath(folder)
    if path and isfile and isfile(path) then
        local ok, content = pcall(readfile, path)
        if ok and content then
            local ok2, decoded = pcall(function() return game:GetService("HttpService"):JSONDecode(content) end)
            if ok2 and type(decoded) == "table" then data = decoded end
        end
    end
    configCache[folder] = data
    return data
end

local function writeConfigTable(folder, data)
    local path = configValuePath(folder)
    if not path then return false end
    configCache[folder] = data
    local ok, json = pcall(function() return game:GetService("HttpService"):JSONEncode(data) end)
    if not (ok and json) then return false end
    local dir = configFolderPath(folder)
    pcall(function()
        if isfolder and not isfolder("DynamicCowUI/Config") then makefolder("DynamicCowUI/Config") end
        if isfolder and not isfolder(dir) then makefolder(dir) end
        writefile(path, json)
    end)
    return true
end

local function loadConfigValue(folder, key)
    if type(folder) ~= "string" or #folder == 0 then return nil end
    if type(key) ~= "string" or #key == 0 then return nil end
    local data = readConfigTable(folder)
    local v = data[key]
    if v == nil then return nil end
    return v
end

local function saveConfigValue(folder, key, value)
    if type(folder) ~= "string" or #folder == 0 then return false end
    if type(key) ~= "string" or #key == 0 then return false end
    local data = readConfigTable(folder)
    data[key] = value
    return writeConfigTable(folder, data)
end

local function configFilePath(folder, name)
    local dir = configFolderPath(folder)
    if not dir then return nil end
    if type(name) ~= "string" or #name == 0 or name == "Config" then
        return dir .. "/" .. CONFIG_FILE_NAME
    end
    return dir .. "/" .. name .. ".json"
end

local function loadConfigFile(folder, name)
    local path = configFilePath(folder, name)
    if not path then return {} end
    if type(name) ~= "string" or #name == 0 or name == "Config" then
        local ok, data = pcall(readConfigTable, folder)
        if ok and type(data) == "table" then return data end
        return {}
    end
    if not (isfile and isfile(path)) then return {} end
    local ok, content = pcall(readfile, path)
    if not (ok and content) then return {} end
    local ok2, data = pcall(function() return game:GetService("HttpService"):JSONDecode(content) end)
    if ok2 and data and type(data) == "table" then return data end
    return {}
end

local function writeConfigFile(folder, name, data)
    if type(folder) ~= "string" or #folder == 0 then return false end
    if type(name) ~= "string" or #name == 0 or name == "Config" then
        return writeConfigTable(folder, data)
    end
    local path = configFilePath(folder, name)
    local ok, json = pcall(function() return game:GetService("HttpService"):JSONEncode(data) end)
    if not (ok and json) then return false end
    local dir = configFolderPath(folder)
    pcall(function()
        if isfolder and not isfolder("DynamicCowUI/Config") then makefolder("DynamicCowUI/Config") end
        if isfolder and not isfolder(dir) then makefolder(dir) end
        writefile(path, json)
    end)
    return true
end

local function _dcGetSharedHolder()
    if type(getgenv) == "function" then
        local ok, g = pcall(getgenv)
        if ok and type(g) == "table" then return g end
    end
    if type(shared) == "table" then return shared end
    return _G
end
local _dcSharedHolder = _dcGetSharedHolder()
if type(_dcSharedHolder) ~= "table" then _dcSharedHolder = _G end
if type(_dcSharedHolder.__DynamicCowUILoaded) ~= "table" then
    _dcSharedHolder.__DynamicCowUILoaded = { windows = {}, order = {} }
end
local loadedWindows = _dcSharedHolder.__DynamicCowUILoaded.windows
local loadedOrder = _dcSharedHolder.__DynamicCowUILoaded.order

local function registerLoadedWindow(title, win)
    if loadedWindows[title] then
        return false
    end
    loadedWindows[title] = win
    loadedOrder[#loadedOrder + 1] = title
    if win then
        win._loadedTitle = title
    end
    return true
end

local function unregisterLoadedWindow(title, win)

    if title == nil then return end
    if win ~= nil and loadedWindows[title] ~= nil and loadedWindows[title] ~= win then
        return
    end
    if loadedWindows[title] == nil then return end
    loadedWindows[title] = nil
    for i = #loadedOrder, 1, -1 do
        if loadedOrder[i] == title then
            table.remove(loadedOrder, i)
            break
        end
    end
end

local function shiftSelf(a, ...)
    if a == Library then
        local n = select("#", ...)
        if n == 0 then return nil end
        return (select(1, ...))
    end
    return a
end

function Library.CreateWindow(a, ...)
    local opts = shiftSelf(a, ...)
    opts = opts or {}
    if Library._demoWin and not Library._demoWin._added then
        pcall(function() Library._demoWin:_closeNow() end)
        Library._demoWin = nil
    end

    local isError = opts._error == true
    local errReason = isError and "CreateWindow 异常触发（缺失或未正常调用）" or nil
    local title = Config.TitleText
    local info = ""
    local iconName = Config.DefaultTitleIcon
    local iconFromURL = nil
    local iconColor = Config.DefaultTitleIconColor
    local iconColorSet = false
    local configFolder = nil
    local autoLoadConfig = true
    local autoSaveConfig = true
    local lenient = false
    local function rejectSignature(reason)
        if lenient then
            reportError(reason .. "（宽容模式：已忽略该项并使用默认值）")
        else
            isError = true
            errReason = reason
        end
    end
    if not isError then
        if type(opts) ~= "table" then
            isError = true
            errReason = "CreateWindow 入参不是 table（收到 " .. type(opts) .. "）"
        else
            if opts.Lenient ~= nil then
                if type(opts.Lenient) ~= "boolean" then
                    reportError("CreateWindow Lenient 非法（收到 " .. type(opts.Lenient) .. "），已忽略")
                else
                    lenient = opts.Lenient
                end
            end
            if opts.Title == nil then
                rejectSignature("CreateWindow 缺少签名 Title")
            elseif type(opts.Title) ~= "string" or #opts.Title == 0 then
                rejectSignature("CreateWindow Title 非法（收到 " .. type(opts.Title) .. "）")
            else
                title = opts.Title
            end
            if opts.Info == nil then
                rejectSignature("CreateWindow 缺少签名 Info")
            elseif type(opts.Info) ~= "string" then
                rejectSignature("CreateWindow Info 非法（收到 " .. type(opts.Info) .. "）")
            else
                info = opts.Info
            end
            if opts.IconFromURL ~= nil then
                if type(opts.IconFromURL) ~= "string" or #opts.IconFromURL == 0 then
                    rejectSignature("CreateWindow IconFromURL 非法（收到 " .. type(opts.IconFromURL) .. "）")
                    iconFromURL = nil
                elseif opts.Folder == nil or type(opts.Folder) ~= "string" or #opts.Folder == 0 then
                    rejectSignature("CreateWindow 设置 IconFromURL 时必须包含 Folder（图标将下载到该 Folder 下）")
                    iconFromURL = nil
                else
                    iconFromURL = opts.IconFromURL
                end
            end
            if opts.Icon ~= nil then
                if type(opts.Icon) ~= "string" then
                    rejectSignature("CreateWindow Icon 非法（收到 " .. type(opts.Icon) .. "）")
                else
                    iconName = opts.Icon
                end
            end
            if not iconFromURL and opts.IconFromURL == nil and opts.Icon == nil then
                rejectSignature("CreateWindow 缺少签名 Icon 或 IconFromURL（任意包含一个即可）")
            end
            if opts.IconColor ~= nil then
                if typeof(opts.IconColor) ~= "Color3" then
                    rejectSignature("CreateWindow IconColor 非法（收到 " .. (typeof(opts.IconColor) or type(opts.IconColor)) .. "）")
                else
                    iconColor = opts.IconColor
                    iconColorSet = true
                end
            end
            if opts.Folder ~= nil then
                if type(opts.Folder) ~= "string" or #opts.Folder == 0 then
                    reportError("CreateWindow Folder 非法（收到 " .. type(opts.Folder) .. "），已忽略")
                else
                    configFolder = opts.Folder
                end
            end
            if opts.AutoLoadConfig ~= nil then
                if type(opts.AutoLoadConfig) ~= "boolean" then
                    reportError("CreateWindow AutoLoadConfig 非法（收到 " .. type(opts.AutoLoadConfig) .. "），已忽略")
                else
                    autoLoadConfig = opts.AutoLoadConfig
                end
            end
        if opts.AutoSaveConfig ~= nil then
                if type(opts.AutoSaveConfig) ~= "boolean" then
                    reportError("CreateWindow AutoSaveConfig 非法（收到 " .. type(opts.AutoSaveConfig) .. "），已忽略")
                else
                    autoSaveConfig = opts.AutoSaveConfig
                end
            end
        end
    end
if isError then
title = Config.ErrorText
        if opts._error ~= true then reportError(errReason) end
    end

    local allowDuplicate = type(opts) == "table" and opts.AllowDuplicate == true
    if not allowDuplicate then
        local existing = loadedWindows[title]
        if existing ~= nil then
            if type(existing) == "table" and existing._isDormant then
                local okD, dormant = pcall(existing._isDormant, existing)
                if okD and dormant then
                    if existing._switchBack then
                        pcall(function() existing:_switchBack() end)
                    end
                    return existing
                end
            end
            reportError("检测到 Title「" .. tostring(title) .. "」的界面已加载，本次不再重复创建")
            if type(existing) == "table" and existing.GetWindowAction then
                pcall(function() existing:_flashLoadedHint() end)
            end
            return existing
        end
    end

    local switchingFrom = nil
    do
        for _, t in ipairs(loadedOrder) do
            if t ~= title and loadedWindows[t] ~= nil then
                local w = loadedWindows[t]
                local dormant = false
                if type(w) == "table" and w._isDormant then
                    local okD, v = pcall(w._isDormant, w)
                    dormant = okD and v == true
                end
                if not dormant then
                    switchingFrom = t
                    break
                end
            end
        end
        if switchingFrom ~= nil and type(opts) == "table" and opts.ForceEntryAnimation == true then
            switchingFrom = nil
        end
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

    local urlAssetCache = {}
    local function loadIconFromURL(url)
        if type(url) ~= "string" or #url == 0 then return nil end
        if urlAssetCache[url] then return urlAssetCache[url] end
        local result = nil
        local body = httpGet(url)
        if body and #body > 0 then
            local ext = "png"
            local m = url:lower():match("%.(png|jpg|jpeg|webp|gif)$")
            if m then ext = m end
            local dir = "DynamicCowUI/Config/" .. tostring(configFolder)
            local path = dir .. "/icon_from_url." .. ext
            pcall(function()
                if isfolder and not isfolder("DynamicCowUI/Config") then makefolder("DynamicCowUI/Config") end
                if isfolder and not isfolder(dir) then makefolder(dir) end
                writefile(path, body)
            end)
            if getcustomasset then
                local ok, id = pcall(getcustomasset, path)
                if ok and type(id) == "string" and #id > 0 then result = id end
            end
            if not result and getsynasset then
                local ok, id = pcall(getsynasset, path)
                if ok and type(id) == "string" and #id > 0 then result = id end
            end
        end
        urlAssetCache[url] = result or false
        return result
    end

    local function getLucideIcon(name)
        if type(name) ~= "string" or #name == 0 then return nil end
        local lucide = loadLucide()
        if not lucide then return nil end
        local ok, asset = pcall(lucide.GetAsset, name)
        if ok and asset and asset.Url then return asset end
        return nil
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
        ColorSequenceKeypoint.new(1, Color3.fromRGB(118, 118, 134)),
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

    if switchingFrom ~= nil then
        if backdrop and backdrop.Parent then backdrop:Destroy() end
        if titleFrame and titleFrame.Parent then titleFrame:Destroy() end
        stroke.Transparency = 1
        edge.AnchorPoint = Vector2.new(0.5, 0.5)
        edge.Position = UDim2.new(0.5, Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2, 0, Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2)
        edge.Size = Config.IslandSize
        corner.CornerRadius = Config.IslandCornerRadius
        fillCorner.CornerRadius = Config.IslandCornerRadius
        fillFrame.Size = UDim2.new(1, 0, 1, 0)
        fillFrame.BackgroundTransparency = 1
        silverStroke.Transparency = 1
    else
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
    end

    local alive = true
    local switchDormant = false
    local suppressHeaderEntrance = false
    local expandPanelRef = nil
    local restorePanelRef = nil
    local errText = Config.ErrorText

    local function safeCancel(handle)
        if handle then pcall(task.cancel, handle) end
    end

    local islandTextOverride = nil

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

    local function measureTextHeight(text, size, maxW)
        if type(text) ~= "string" or #text == 0 then return size end
        local lineH = size * 1.4
        local w = maxW or 200
        if w < 40 then w = 200 end
        local total = 0
        for line in (text .. "\n"):gmatch("(.-)\n") do
            local h = size
            local ok, sz = pcall(function()
                return game:GetService("TextService"):GetTextSize(line, size, Enum.Font.Gotham, Vector2.new(w, 100000))
            end)
            if ok and sz and sz.Y and sz.Y > 0 then h = sz.Y end
            local lines = math.max(1, math.floor(h / (size * 1.2) + 0.5))
            total = total + lines
        end
        if total < 1 then total = 1 end
        return total * lineH
    end

    local function paragraphHeight(p, availW)
        local titleH = Config.ParagraphTitleSize + Config.ParagraphTitlePad
        local infoW = availW
        if p.Icon ~= nil and p.Icon ~= "" then
            infoW = infoW - (Config.ParagraphIconSize + Config.ParagraphIconGap)
        end
        local infoH = measureTextHeight(p.Info or "", Config.ParagraphInfoSize, infoW)
        local h = math.ceil(Config.ParagraphTitleDrop + titleH + Config.ParagraphTextGap + infoH + 8)
        if h < Config.ParagraphRowHeight then h = Config.ParagraphRowHeight end
        return h
    end

    local function refreshParagraphHeight(pg)
        if not pg then return end
        if not (pg._frame and pg._frame.Parent) then return end
        local paraW = pg._paraW or 240
        local newH = paragraphHeight(pg, paraW)
        local oldH = pg._rowH or Config.ParagraphRowHeight
        pg._rowH = newH
        pg._frame.Size = UDim2.new(1, 0, 0, newH)
        if pg._infoLbl and pg._infoLbl.Parent then
            local iw = paraW
            if pg.Icon ~= nil and pg.Icon ~= "" then
                iw = iw - (Config.ParagraphIconSize + Config.ParagraphIconGap)
            end
            pg._infoLbl.Size = UDim2.new(1, 0, 0, measureTextHeight(pg.Info or "", Config.ParagraphInfoSize, iw))
        end
        if pg._bodyH and pg._body and pg._body.Parent then
            local bh = pg._bodyH + (newH - oldH)
            pg._bodyH = bh
            pg._body.Size = UDim2.new(1, 0, 0, bh)
            if pg._block and pg._block.Parent and not pg._collapsed then
                pg._block.Size = UDim2.new(1, 0, 0, (pg._headH or 0) + (pg._divGap or 0) + bh)
            end
        end
    end

    local function getViewportHeight()
        local ok, cam = pcall(function() return workspace and workspace.CurrentCamera end)
        if ok and cam and cam.ViewportSize and cam.ViewportSize.Y and cam.ViewportSize.Y > 0 then
            return cam.ViewportSize.Y
        end
        local h = screenGui and screenGui.AbsoluteSize and screenGui.AbsoluteSize.Y
        if h and h > 0 then return h end
        return 720
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

    local islandTextContainer = nil
    local function rebuildIslandChars(text, color)
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

    -- 渐绿动画代数：取消进行中的文字变化链，并立即恢复其残留的绿色字符，
    -- 避免快速连续 ChangeText / 收起面板时标题字符常驻绿色无法恢复
    local textChangeGen = 0
    local textChangeRestore = {}
    local function cancelTextChangeAnim()
        textChangeGen = textChangeGen + 1
        for _, r in ipairs(textChangeRestore) do
            if r.label and r.label.Parent then r.label.TextColor3 = r.target end
        end
        textChangeRestore = {}
    end
    local function setIslandText(text, color)
        cancelTextChangeAnim()
        rebuildIslandChars(text, color)
    end

    local function currentIslandChars()
        local arr = {}
        if not (islandTextContainer and islandTextContainer.Parent) then return arr end
        for _, cf in ipairs(islandTextContainer:GetChildren()) do
            if cf:IsA("Frame") then
                local lb = cf:FindFirstChildOfClass("TextLabel")
                if lb then arr[#arr + 1] = { frame = cf, label = lb, ch = lb.Text } end
            end
        end
        return arr
    end

    local function setIslandTextAnimated(newText, color)
        color = color or Config.TitleColor
        -- 取消上一条未完成的渐绿链（恢复其残留绿色字符），防止链条交叉导致常驻绿色
        cancelTextChangeAnim()
        local myGen = textChangeGen
        local oldChars = currentIslandChars()
        local newItems = {}
        for _, item in ipairs(parseColoredChars(newText, color)) do
            if item.ch ~= " " then newItems[#newItems + 1] = item end
        end

        if #oldChars == 0 or #newItems == 0 then
            rebuildIslandChars(newText, color)
            return
        end

        local on, nn = #oldChars, #newItems
        local p = 0
        while p < on and p < nn and oldChars[p + 1].ch == newItems[p + 1].ch do p = p + 1 end
        local s = 0
        while s < (on - p) and s < (nn - p) and oldChars[on - s].ch == newItems[nn - s].ch do s = s + 1 end
        if p == on and p == nn then return end
        local green = Config.IslandTextChangeColor
        local tint = Config.IslandTextChangeTintTime
        local restore = Config.IslandTextChangeRestoreTime

        for i = p + 1, on - s do
            local lb = oldChars[i] and oldChars[i].label
            if lb and lb.Parent then
                TweenService:Create(lb, TweenInfo.new(tint, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextColor3 = green }):Play()
            end
        end

        task.delay(tint, function()
            if not alive then return end
            if myGen ~= textChangeGen then return end
            if not (islandTextContainer and islandTextContainer.Parent) then return end
            rebuildIslandChars(newText, color)
            local nowChars = currentIslandChars()
            for i = p + 1, nn - s do
                local lb = nowChars[i] and nowChars[i].label
                if lb and lb.Parent then
                    lb.TextColor3 = green
                    local target = newItems[i] and newItems[i].color or color
                    textChangeRestore[#textChangeRestore + 1] = { label = lb, target = target }
                    TweenService:Create(lb, TweenInfo.new(restore, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextColor3 = target }):Play()
                end
            end
            -- 兜底：恢复补间结束后若字符仍停留绿色（补间被竞争取消），强制设回目标色
            task.delay(restore + 0.15, function()
                if myGen ~= textChangeGen then return end
                for i = p + 1, nn - s do
                    local lb = nowChars[i] and nowChars[i].label
                    if lb and lb.Parent and lb.TextColor3 == green then
                        lb.TextColor3 = (newItems[i] and newItems[i].color) or color
                    end
                end
            end)
        end)
    end

    local expanded = false
    local winOpen = false
    local shutdown = false
    local ready = false
    local actionEnd = nil

    local iconTextPlayer = nil

    local lastToggleInfo = nil

    local toggleAnimContainer = nil
    local toggleAnimBusy = false
    local toggleAnimGen = 0

    -- 取消进行中的 toggle 状态显示动画：销毁容器、置忙标志，
    -- 并递增代数使动画内所有已排期的 task.delay 回调失效（防止与展开面板打架）
    local function cancelToggleAnim()
        toggleAnimGen = toggleAnimGen + 1
        if toggleAnimContainer and toggleAnimContainer.Parent then toggleAnimContainer:Destroy() end
        toggleAnimContainer = nil
        toggleAnimBusy = false
    end

    local actionBusy = false
    local win = { _tabs = {}, _activeTab = 0, _rebuildTabs = nil }
    win._configFolder = configFolder
    win._autoLoadConfig = autoLoadConfig
    win._autoSaveConfig = autoSaveConfig

    win._cfgSave = function(self, key, value)
        if not self._autoSaveConfig then return false end
        if not self._configFolder or type(key) ~= "string" or #key == 0 then return false end
        return saveConfigValue(self._configFolder, key, value)
    end
    win._cfgIndex = {}
    if win._configFolder then ensureConfigFolder(win._configFolder) end
    local titleIcon = nil
    local loaderSpinTween = nil
    local infoLabel = nil
    local brandLbl = nil
    local openDropdownClose = nil
    local titleGen = 0
    local titleTweens = {}
    local function cancelTitleTweens()
        for _, tw in ipairs(titleTweens) do
            pcall(function() tw:Cancel() end)
        end
        titleTweens = {}
    end

    local chromeTweens = {}
    local function cancelChromeTweens()
        for _, tw in ipairs(chromeTweens) do
            pcall(function() tw:Cancel() end)
        end
        chromeTweens = {}
    end
    local function chromeTween(inst, ti, props)
        if not inst then return nil end
        local tw = TweenService:Create(inst, ti, props)
        chromeTweens[#chromeTweens + 1] = tw
        tw:Play()
        return tw
    end

    local function clearBrand()
        if brandLbl and brandLbl.Parent then
            pcall(function() brandLbl:Destroy() end)
        end
        brandLbl = nil
    end

    local edgeAnimConn = nil
    local edgeBusyUntil = 0

    local edgeTweens = {}
    local function trackEdgeTween(tw)
        edgeTweens[#edgeTweens + 1] = tw
        tw.Completed:Connect(function()
            for i = #edgeTweens, 1, -1 do
                if edgeTweens[i] == tw then table.remove(edgeTweens, i) break end
            end
        end)
        return tw
    end
    local function cancelEdgeTweens()
        for i = #edgeTweens, 1, -1 do
            local tw = edgeTweens[i]
            edgeTweens[i] = nil
            if tw then pcall(function() tw:Cancel() end) end
        end
    end

    local function edgeTween(info, props)
        cancelEdgeTweens()
        local busyUntil = os.clock() + (info and info.Time or 0)
        if busyUntil > edgeBusyUntil then edgeBusyUntil = busyUntil end
        local tw = TweenService:Create(edge, info, props)
        trackEdgeTween(tw)
        tw:Play()
        return tw
    end
    local function animateEdge(targetSize, targetPos, dur, over, onDone)
        if edgeAnimConn then pcall(function() edgeAnimConn:Disconnect() end) edgeAnimConn = nil end

        cancelEdgeTweens()
        edgeBusyUntil = os.clock() + (dur or 0)
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
                if edgeAnimConn == conn then edgeAnimConn = nil end
                edge.Size = targetSize
                edge.Position = targetPos
                if onDone then onDone() end
            end
        end)
        edgeAnimConn = conn
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

        local pMin = math.max(1, Config.ParticleCountMin or Config.ParticleCount)
        local pMax = math.max(pMin, Config.ParticleCountMax or Config.ParticleCount)
        local count = math.random(pMin, pMax)
        for _ = 1, count do
            local p = Instance.new("Frame")
            p.Name = "IslandParticle"

            local psize = Config.ParticleSize
            if Config.ParticleSizeVar and Config.ParticleSizeVar > 0 then
                psize = Config.ParticleSize + math.random(-Config.ParticleSizeVar, Config.ParticleSizeVar)
                if psize < 1 then psize = 1 end
            end
            p.Size = UDim2.fromOffset(psize, psize)
            p.BackgroundColor3 = Color3.new(1, 1, 1)
            p.BorderSizePixel = 0
            p.AnchorPoint = Vector2.new(0.5, 0.5)
            local px = cx + (math.random() * 2 - 1) * iw / 2
            local py = cy + (math.random() * 2 - 1) * ih / 2
            p.Position = UDim2.new(0, px, 0, py)
            p.Parent = screenGui

            local ang = math.random() * math.pi * 2
            local smin = Config.ParticleSpeedMin or 140
            local smax = Config.ParticleSpeedMax or 360
            if smax < smin then smax = smin end
            local spd = smin + math.random() * (smax - smin)
            parts[#parts + 1] = {
                f = p,
                vx = math.cos(ang) * spd,
                vy = math.sin(ang) * spd - (Config.ParticleUpBias or 0),
            }
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
                            islandTextContainer = createIslandText(errText, Config.ErrorTextColor, true)
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
                                unregisterLoadedWindow(title, win)
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
                                islandTextContainer = createIslandText(islandTextOverride or title, Config.TitleColor, true)
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

    local errorSeqBusy = false
    local function playErrorSequence(customText)
        if errorSeqBusy then
            errText = Config.MultiErrorText
            return
        end
        errorSeqBusy = true
        errText = (type(customText) == "string" and #customText > 0) and customText or Config.ErrorText
        expanded = false
        winOpen = false
        flowSpeed = 0
        if backdrop and backdrop.Parent then backdrop:Destroy() end

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

        task.delay(fadeDur, function()
            if not alive then return end
            edge.AnchorPoint = Vector2.new(0.5, 0.5)
            edgeTween(TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = Config.IslandSize, Position = UDim2.new(0.5, Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2, 0, Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2) })
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
            islandTextContainer = createIslandText(errText, Config.ErrorTextColor)
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
                unregisterLoadedWindow(title, win)
                -- 恰好有一个其它脚本仍在运行时：销毁后由它以「圆形→胶囊」动画接管灵动岛
                local survivor = nil
                local survivorCount = 0
                for _, t in ipairs(loadedOrder) do
                    if t ~= title and loadedWindows[t] ~= nil then
                        survivor = loadedWindows[t]
                        survivorCount = survivorCount + 1
                    end
                end
                if screenGui and screenGui.Parent then screenGui:Destroy() end
                if survivorCount == 1 and survivor and type(survivor) == "table"
                   and survivor._restoreFromDestroy then
                    task.delay(0.05, function()
                        pcall(function() survivor:_restoreFromDestroy() end)
                    end)
                end
            end)
        end)
    end

    local runIslandEntrySetup = nil
    local buildSwitchButton = nil
    local showSwitchConfirm = nil

    local playSwitchSequenceRef = nil
    local switchToTarget = nil

    local expandForSwitchRef = nil
    local autoExpandForSwitch = function()
        if expandForSwitchRef then expandForSwitchRef() end
    end

        runIslandEntrySetup = function(afterSetup)
            if backdrop and backdrop.Parent then backdrop:Destroy() end
            islandTextContainer = createIslandText(Config.IslandText, Config.IslandTextColor)

        if not switchingFrom then
            task.spawn(function() splitBall(isError) end)
        else
            ready = true
        end
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
            local dragSizeTween = nil

            local function tweenEdgeSize(size, dur)
                if dragSizeTween then pcall(function() dragSizeTween:Cancel() end) dragSizeTween = nil end
                dragSizeTween = edgeTween(TweenInfo.new(dur, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = size })
                return dragSizeTween
            end
            local tapCount = 0
            local tapWindowTmr = nil
            local hintActive = false
            local hintContainer = nil
            local hintTmr = nil
            local hintBaseSize = nil
            local hintBaseAnchor = nil
            local hintBasePos = nil

            local hintCooldownUntil = 0
            local hintCooldownTmr = nil
            local islandRest = UDim2.new(0.5, Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2, 0, Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2)

            local function safeCancelTimer(handle)
                if not handle then return end
                pcall(task.cancel, handle)
            end

            local function startHintClickCooldown()
                safeCancelTimer(hintCooldownTmr)
                hintCooldownUntil = os.clock() + Config.HintClickCooldown
                hintCooldownTmr = task.delay(Config.HintClickCooldown, function()
                    hintCooldownTmr = nil
                    hintCooldownUntil = 0
                end)
            end
            local function inHintClickCooldown()
                return hintCooldownUntil > 0 and os.clock() < hintCooldownUntil
            end
            local function clearHint(skipRestore)
                safeCancelTimer(tapWindowTmr) tapWindowTmr = nil
                safeCancelTimer(hintTmr) hintTmr = nil
                if hintContainer and hintContainer.Parent then hintContainer:Destroy() end
                hintContainer = nil

                local baseSize = hintBaseSize
                local baseAnchor = hintBaseAnchor
                local basePos = hintBasePos
                if not skipRestore and hintActive and edge and edge.Parent and baseSize and not expanded then
                    local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                    local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2

                    edgeTween(TweenInfo.new(Config.HintSlideTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = baseSize,
                        Position = UDim2.new(0.5, cx, 0, cy),
                    })
                    task.delay(Config.HintSlideTime, function()
                        if not edge or not edge.Parent then return end
                        edgeTween(TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Position = UDim2.new(0.5, cx, 0, cy),
                        })
                        task.delay(0.16, function()
                            if not edge or not edge.Parent then return end
                            if baseAnchor then edge.AnchorPoint = baseAnchor end
                            if basePos then edge.Position = basePos end

                            hintActive = false

                            startHintClickCooldown()
                        end)
                    end)
                else
                    hintActive = false
                end
                hintBaseSize = nil
                hintBaseAnchor = nil
                hintBasePos = nil
                if not skipRestore and islandTextContainer and islandTextContainer.Parent then
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do
                        local lb = cf:FindFirstChildOfClass("TextLabel")
                        if lb then TweenService:Create(lb, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
                    end
                end
            end
            local function playHintAnimation()
                if hintActive or expanded or not alive or not ready then return end
                if os.clock() < edgeBusyUntil then return end
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
                local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
                edge.AnchorPoint = Vector2.new(0.5, 0.5)
                edge.Position = UDim2.new(0.5, cx, 0, cy - Config.HintSlideInDistance)
                local txt = Config.HintText
                local tsize = Config.HintTextSize
                local tw = measureTextWidth(txt, tsize) + Config.HintExtendPad
                local baseW = Config.IslandSize.X.Offset
                local targetW = math.max(baseW + 80, tw)
                edgeTween(TweenInfo.new(Config.HintSlideTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, targetW, 0, Config.IslandSize.Y.Offset),
                    Position = UDim2.new(0.5, cx, 0, cy),
                })
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
                safeCancelTimer(hintTmr)
                hintTmr = task.delay(Config.HintHoldTime, function()
                    hintTmr = nil
                    if hintActive then clearHint() end
                end)
            end
            local function registerIslandTap()
                if hintActive or expanded or not alive or not ready then return end

                if inHintClickCooldown() then return end
                tapCount = tapCount + 1
                if tapWindowTmr then safeCancel(tapWindowTmr) end
                tapWindowTmr = task.delay(Config.TapWindow, function()
                    tapCount = 0
                    tapWindowTmr = nil
                end)
                if tapCount >= 3 then
                    tapCount = 0
                    if tapWindowTmr then safeCancel(tapWindowTmr) tapWindowTmr = nil end
                    playHintAnimation()
                end
            end
            local function resetIslandDrag()
                if dragStopTmr then safeCancel(dragStopTmr) dragStopTmr = nil end
                if dragRestoreTmr then safeCancel(dragRestoreTmr) dragRestoreTmr = nil end
                if dragging and dragBaseSize and not expanded then
                    tweenEdgeSize(dragBaseSize, 0.3)
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
                        if longPress then safeCancel(longPress) longPress = nil end
                    else
                        return
                    end
                end
                if dx < 0 then dx = 0 end
                if dragging and dragRestoreTmr then safeCancel(dragRestoreTmr) dragRestoreTmr = nil end
                local extra = math.min(dx * Config.IslandDragDamp, Config.IslandDragMax)
                if dragBaseSize then
                    edge.Size = UDim2.new(dragBaseSize.X.Scale, dragBaseSize.X.Offset + extra, dragBaseSize.Y.Scale, dragBaseSize.Y.Offset)
                end
                if dragStopTmr then safeCancel(dragStopTmr) end
                dragStopTmr = task.delay(Config.IslandDragStopDelay, function()
                    dragStopTmr = nil
                    if dragging and holding and not expanded and dragBaseSize then
                        tweenEdgeSize(UDim2.new(dragBaseSize.X.Scale, dragBaseSize.X.Offset + math.min(Config.IslandDragFixed, Config.IslandDragMax), dragBaseSize.Y.Scale, dragBaseSize.Y.Offset), 0.18)
                        if dragRestoreTmr then safeCancel(dragRestoreTmr) end
                        dragRestoreTmr = task.delay(Config.IslandDragHold, function()
                            dragRestoreTmr = nil
                            resetIslandDrag()
                        end)
                    end
                end)
            end)
local closeBtn = nil

            local switchBtn = nil

            local closeDialog = nil
            local tabListContainer = nil
            local tabContentContainer = nil
            local tabContentBase = nil
            local tabContentW = nil
            local headerDivider = nil
            local tabSeparator = nil
            local tabEmptyLabel = nil
            local tabContentEmpty = nil
            local tabContentNoCtrl = nil
            local tabSubtitleList = nil
            local function destroyTabUI()
                if openDropdownClose then openDropdownClose() end
                if tabListContainer then tabListContainer:Destroy() tabListContainer = nil end
                if tabContentContainer then tabContentContainer:Destroy() tabContentContainer = nil end
                if headerDivider then headerDivider:Destroy() headerDivider = nil end
                if tabSeparator then tabSeparator:Destroy() tabSeparator = nil end
                if tabEmptyLabel then tabEmptyLabel:Destroy() tabEmptyLabel = nil end
                tabContentEmpty = nil
                tabContentNoCtrl = nil
                tabSubtitleList = nil
                tabContentBase = nil
                tabContentW = nil
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
                    if win._autoLoadConfig and tg.ConfigKey and win._configFolder then
                        local sv = loadConfigValue(win._configFolder, tg.ConfigKey)
                        if sv ~= nil then tg.Value = (sv == true) end
                    end
                    local row = Instance.new("TextButton")
                    row.Name = "SubToggle"
                    row.Size = UDim2.new(1, 0, 0, Config.ToggleRowHeight)
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
                    local function apply(animate)
                        local on = tg.Value
                        local targetX = on and (trackW - pad - thumbS) or pad
                        if animate then
                            TweenService:Create(thumb, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0, targetX, 0.5, 0),
                            }):Play()
                            TweenService:Create(track, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                BackgroundColor3 = on and Config.ToggleOnColor or (tg.TrackColor or Config.ToggleTrackColor),
                            }):Play()
                        else
                            thumb.Position = UDim2.new(0, targetX, 0.5, 0)
                            track.BackgroundColor3 = on and Config.ToggleOnColor or (tg.TrackColor or Config.ToggleTrackColor)
                        end
                    end
                    apply(false)
                    row.MouseButton1Click:Connect(function()
                        if shutdown then return end
                        tg.Value = not tg.Value
                        apply(true)

                        lastToggleInfo = {
                            Title = tg.Title or "Toggle",
                            Icon = tg.Icon,
                            IconColor = tg.IconColor,
                            Value = tg.Value,
                        }
                        if tg.ConfigKey then win._cfgSave(win, tg.ConfigKey, tg.Value) end
                        if typeof(tg.Callback) == "function" then
                            local okC, errC = pcall(tg.Callback, tg.Value, tg)
                            if not okC then reportError("AddToggle Callback 报错: " .. tostring(errC)) end
                        end
                    end)
                    return row
                end
                local function makeParagraph(p, order, rowH)
                    local frame = Instance.new("Frame")
                    frame.Name = "SubParagraph"
                    frame.BackgroundColor3 = p.BackColor or Config.ParagraphBackColor
                    frame.BackgroundTransparency = Config.ParagraphBackTransparency
                    frame.Size = UDim2.new(1, 0, 0, rowH or Config.ParagraphRowHeight)
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
                    vl.VerticalAlignment = Enum.VerticalAlignment.Top
                    vl.SortOrder = Enum.SortOrder.LayoutOrder
                    vl.Padding = UDim.new(0, Config.ParagraphTextGap)
                    vl.Parent = txt
                    local txtPad = Instance.new("UIPadding")
                    txtPad.PaddingTop = UDim.new(0, Config.ParagraphTitleDrop)
                    txtPad.Parent = txt
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
                    local infoW = math.max(40, (p._paraW or 240)
                        - (hasIco and (Config.ParagraphIconSize + Config.ParagraphIconGap) or 0))
                    local infoH = measureTextHeight(p.Info or "", Config.ParagraphInfoSize, infoW)
                    local infoLbl = Instance.new("TextLabel")
                    infoLbl.Name = "ParaInfo"
                    infoLbl.BackgroundTransparency = 1
                    infoLbl.Size = UDim2.new(1, 0, 0, infoH)
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

                local function makeLine(ln, order)
                    local rowH = Config.LineRowHeight
                    local frame = Instance.new("Frame")
                    frame.Name = "SubLine"
                    frame.BackgroundTransparency = 1
                    frame.Size = UDim2.new(1, 0, 0, rowH)
                    frame.LayoutOrder = order
                    frame.ZIndex = 3
                    local inset = ln.Inset or Config.LineInset
                    local bar = Instance.new("Frame")
                    bar.Name = "LineBar"
                    bar.BackgroundColor3 = ln.Color or Config.LineColor
                    bar.BorderSizePixel = 0
                    bar.Size = UDim2.new(1, -(inset * 2), 0, ln.Thickness or Config.LineThickness)
                    bar.Position = UDim2.new(0, inset, 0.5, 0)
                    bar.AnchorPoint = Vector2.new(0, 0.5)
                    bar.ZIndex = 3
                    bar.Parent = frame

                    ln._bar = bar
                    ln._row = frame
                    return frame
                end
                local function makeSlider(sl, order)
                    if win._autoLoadConfig and sl.ConfigKey and win._configFolder then
                        local sv = loadConfigValue(win._configFolder, sl.ConfigKey)
                        if sv ~= nil and type(sv) == "number" then sl.Value = sv end
                    end
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
                    local valueW = Config.SliderValueW
                    local valueLbl = Instance.new("TextLabel")
                    valueLbl.Name = "SliderValue"
                    valueLbl.BackgroundTransparency = 1
                    valueLbl.Size = UDim2.new(0, valueW, 1, 0)
                    valueLbl.Position = UDim2.new(0, titleW + 2, 0, 0)
                    valueLbl.Text = ""
                    valueLbl.TextColor3 = Config.SliderValueColor
                    valueLbl.TextSize = Config.SliderValueSize
                    valueLbl.Font = Enum.Font.Gotham
                    valueLbl.TextXAlignment = Enum.TextXAlignment.Center
                    valueLbl.TextYAlignment = Enum.TextYAlignment.Center
                    valueLbl.ZIndex = 3
                    valueLbl.Parent = frame
                    local trackX = titleW + 2 + valueW + Config.SliderTitleGap
                    local track = Instance.new("Frame")
                    track.Name = "SliderTrack"
                    track.BackgroundColor3 = Config.SliderTrackColor
                    track.BackgroundTransparency = Config.SliderTrackTransparency
                    track.Size = UDim2.new(1, -trackX, 1, -Config.SliderTrackVPad * 2)
                    track.Position = UDim2.new(0, trackX, 0, Config.SliderTrackVPad)
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
                    local function formatVal(v)
                        local deg = sl.Degree or 0
                        if deg >= 1 then return tostring(math.floor(v + 0.5)) end
                        local decimals = 0
                        if deg > 0 then
                            local t = deg
                            while t < 0.999 and decimals < 6 do
                                t = t * 10
                                decimals = decimals + 1
                            end
                        end
                        if decimals <= 0 then return tostring(math.floor(v + 0.5)) end
                        return string.format("%." .. decimals .. "f", v)
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
                        if sl._valueLbl and sl._valueLbl.Parent then
                            sl._valueLbl.Text = formatVal(sl.Value)
                        end
                    end
                    sl._applyFrac = function(f, animate)
                        f = clampFrac(f)
                        sl.Value = snapVal(sl.MinValue + f * getRange())
                        sl._refresh(animate)
                        if sl.ConfigKey then win._cfgSave(win, sl.ConfigKey, sl.Value) end
                        if type(sl.OnChanged) == "function" then

                            local okC, errC = pcall(sl.OnChanged, sl.Value, sl)
                            if not okC then reportError("AddSlider OnChanged 报错: " .. tostring(errC)) end
                        end
                    end
                    sl.Value = sl.Value or sl.MinValue
                    sl._frame = frame
                    sl._track = track
                    sl._fill = fill
                    sl._titleLbl = titleLbl
                    sl._valueLbl = valueLbl
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
                    return frame
                end
                local function makeDropdown(d, order)
                    d.Multiple = d.Multiple and true or false
                    if win._autoLoadConfig and d.ConfigKey and win._configFolder then
                        local sv = loadConfigValue(win._configFolder, d.ConfigKey)
                        if sv ~= nil then d.Selected = sv end
                    end
                    if not d.Multiple then
                        d.Selected = (type(d.Selected) == "string" and d.Selected) or nil
                    else
                        if type(d.Selected) ~= "table" then d.Selected = {} end
                    end
                    local function isSelected(name)
                        if d.Multiple then
                            for _, s in ipairs(d.Selected) do if s == name then return true end end
                            return false
                        end
                        return d.Selected == name
                    end
                    local function truncateToWidth(text, maxW)
                        if text == "" then return text end
                        if measureTextWidth(text, Config.DropdownCapsuleTextSize) <= maxW then return text end
                        local chars = {}
                        for _, cp in utf8.codes(text) do chars[#chars + 1] = utf8.char(cp) end
                        local out = ""
                        for i = 1, #chars do
                            local cand = out .. chars[i]
                            if measureTextWidth(cand .. "…", Config.DropdownCapsuleTextSize) > maxW then
                                return out .. "…"
                            end
                            out = cand
                        end
                        return out .. "…"
                    end
                    local function capsuleText()
                        local maxW = Config.DropdownCapsuleW - Config.DropdownMenuPad * 2 - 6
                        if d.Multiple then
                            local n = #d.Selected
                            if n == 0 then return Config.DropdownCapsulePlaceholder end
                            local joined = table.concat(d.Selected, ", ")
                            if measureTextWidth(joined, Config.DropdownCapsuleTextSize) > maxW then
                                return "已选择" .. n .. "个"
                            end
                            return joined
                        end
                        if not d.Selected then return Config.DropdownCapsulePlaceholder end
                        return truncateToWidth(d.Selected, maxW)
                    end
                    local function refreshCapsule()
                        if d._label and d._label.Parent then d._label.Text = capsuleText() end
                    end
                    local function saveSel()
                        if d.ConfigKey then win._cfgSave(win, d.ConfigKey, d.Selected) end
                    end
                    local function refreshHighlights()
                        if not d._menuScroll then return end
                        for _, ob in ipairs(d._menuScroll:GetChildren()) do
                            if ob:IsA("TextButton") and ob.Name == "DdOption" then
                                local hi = ob:FindFirstChild("DdSelHi")
                                if hi then
                                    hi.BackgroundTransparency = isSelected(ob:GetAttribute("OptName")) and 0 or 1
                                end
                            end
                        end
                    end
                    local function applySelection(name)
                        if d.Multiple then
                            local idx = 0
                            for i, s in ipairs(d.Selected) do if s == name then idx = i break end end
                            if idx > 0 then table.remove(d.Selected, idx) else d.Selected[#d.Selected + 1] = name end
                        else
                            d.Selected = name
                        end
                        refreshCapsule()
                        saveSel()
                        refreshHighlights()
                        if type(d.OnChanged) == "function" then
                            local okC, errC = pcall(d.OnChanged, d.Selected, d)
                            if not okC then reportError("AddDropdown OnChanged 报错: " .. tostring(errC)) end
                        end
                        if not d.Multiple and d._closeMenu then d._closeMenu(true) end
                    end

                    local frame = Instance.new("Frame")
                    frame.Name = "SubDropdown"
                    frame.BackgroundTransparency = 1
                    frame.Size = UDim2.new(1, 0, 0, Config.DropdownRowHeight)
                    frame.LayoutOrder = order
                    frame.ZIndex = 3
                    local titleW = measureTextWidth(d.Title or "", Config.DropdownTitleSize) + Config.DropdownTitlePadX
                    if titleW < Config.DropdownTitleMinW then titleW = Config.DropdownTitleMinW end
                    local titleLbl = Instance.new("TextLabel")
                    titleLbl.Name = "DdTitle"
                    titleLbl.BackgroundTransparency = 1
                    titleLbl.Size = UDim2.new(0, titleW, 1, 0)
                    titleLbl.Position = UDim2.new(0, 0, 0, 0)
                    titleLbl.Text = d.Title or ""
                    titleLbl.TextColor3 = Config.DropdownTitleColor
                    titleLbl.TextSize = Config.DropdownTitleSize
                    titleLbl.Font = Enum.Font.GothamBold
                    titleLbl.RichText = true
                    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
                    titleLbl.TextYAlignment = Enum.TextYAlignment.Center
                    titleLbl.ZIndex = 3
                    titleLbl.Parent = frame

                    local capsule = Instance.new("TextButton")
                    capsule.Name = "DdCapsule"
                    capsule.AutoButtonColor = false
                    capsule.AnchorPoint = Vector2.new(1, 0.5)
                    capsule.Position = UDim2.new(1, 0, 0.5, 0)
                    capsule.Size = UDim2.new(0, Config.DropdownCapsuleW, 0, Config.DropdownCapsuleH)
                    capsule.BackgroundColor3 = Config.DropdownCapsuleFill
                    capsule.Text = ""
                    capsule.ZIndex = 3
                    capsule.Parent = frame
                    local capCorner = Instance.new("UICorner")
                    capCorner.CornerRadius = UDim.new(0.5, 0)
                    capCorner.Parent = capsule
                    local capStroke = Instance.new("UIStroke")
                    capStroke.Color = Config.DropdownCapsuleStroke
                    capStroke.Thickness = Config.DropdownCapsuleStrokeThickness
                    capStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    capStroke.Parent = capsule
                    local label = Instance.new("TextLabel")
                    label.Name = "DdLabel"
                    label.BackgroundTransparency = 1
                    label.AnchorPoint = Vector2.new(0, 0.5)
                    label.Position = UDim2.new(0, Config.DropdownMenuPad + 4, 0.5, 0)
                    label.Size = UDim2.new(1, -(Config.DropdownMenuPad * 2 + 8), 1, 0)
                    label.Font = Enum.Font.Gotham
                    label.TextColor3 = Config.DropdownCapsuleTextColor
                    label.TextSize = Config.DropdownCapsuleTextSize
                    label.TextXAlignment = Enum.TextXAlignment.Left
                    label.TextYAlignment = Enum.TextYAlignment.Center
                    label.TextTruncate = Enum.TextTruncate.AtEnd
                    label.ZIndex = 4
                    label.Parent = capsule

                        local menuOpen = false
                        local menuFrame = nil
                        local menuStroke = nil
                    local outsideConn = nil

                    local function closeMenu(animate)
                        if not menuOpen then return end
                        menuOpen = false
                        if outsideConn then outsideConn:Disconnect() outsideConn = nil end
                        if openDropdownClose == closeMenu then openDropdownClose = nil end
                        d._closeMenu = nil
                        if d._menuScroll then d._menuScroll = nil end
                        local mf = menuFrame
                        menuFrame = nil
                        if mf and mf.Parent then
                            if animate then
                                for _, ob in ipairs(mf:GetDescendants()) do
                                    if ob:IsA("TextButton") and ob.Name == "DdOption" then
                                        TweenService:Create(ob, TweenInfo.new(Config.DropdownCollapseTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { TextTransparency = 1, BackgroundTransparency = 1 }):Play()
                                        local hi = ob:FindFirstChild("DdSelHi")
                                        if hi then TweenService:Create(hi, TweenInfo.new(Config.DropdownCollapseTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play() end
                                    end
                                end
                                TweenService:Create(mf, TweenInfo.new(Config.DropdownCollapseTime, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()
                                if menuStroke then TweenService:Create(menuStroke, TweenInfo.new(Config.DropdownCollapseTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Transparency = 1 }):Play() end
                                task.delay(Config.DropdownCollapseTime + 0.05, function()
                                    if mf and mf.Parent then mf:Destroy() end
                                end)
                            else
                                mf:Destroy()
                            end
                        end
                    end

                    local function openMenu()
                        if menuOpen then return end
                        if openDropdownClose then openDropdownClose() end
                        local optList = d.Options or {}
                        local count = #optList
                        if count == 0 then return end
                        local as = capsule.AbsoluteSize
                        local ap = capsule.AbsolutePosition
                        local scrH = getViewportHeight()
                        local contentH = count * Config.DropdownOptionH + Config.DropdownMenuPad * 2
                        local edgeGap = Config.DropdownMenuPad + 4
                        local capTop = ap.Y
                        local capBottom = ap.Y + as.Y
                        local belowSpace = scrH - capBottom - edgeGap
                        local aboveSpace = capTop - edgeGap
                        local openUp = (contentH > belowSpace) and (aboveSpace > belowSpace)
                        local minH = Config.DropdownOptionH + Config.DropdownMenuPad * 2
                        local avail = openUp and aboveSpace or belowSpace
                        if avail < minH then avail = minH end
                        local targetH = math.min(contentH, Config.DropdownMenuMaxH, avail)
                        local needScroll = contentH > targetH
                        local expandW = math.max(Config.DropdownMenuW, as.X)
                        local endX = ap.X + as.X - expandW
                        local endY = openUp and (capTop - targetH) or capBottom

                        menuOpen = true
                        local mf = Instance.new("Frame")
                        mf.Name = "DdMenu"
                        mf.BackgroundColor3 = Config.DropdownMenuFill
                        mf.BackgroundTransparency = 1
                        mf.BorderSizePixel = 0
                        mf.Size = UDim2.fromOffset(expandW, targetH)
                        mf.Position = UDim2.fromOffset(endX, endY)
                        mf.ClipsDescendants = true
                        mf.ZIndex = Config.DropdownMenuZ
                        mf.Parent = screenGui                        local mc = Instance.new("UICorner")
                        mc.CornerRadius = UDim.new(0, Config.DropdownMenuCorner)
                        mc.Parent = mf
                        local mstroke = Instance.new("UIStroke")
                        mstroke.Color = Config.DropdownMenuStroke
                        mstroke.Thickness = Config.DropdownMenuStrokeThickness
                        mstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        mstroke.Parent = mf
                        menuFrame = mf
                        menuStroke = mstroke

                        local container
                        if needScroll then
                            local sc = Instance.new("ScrollingFrame")
                            sc.Name = "DdScroll"
                            sc.BackgroundTransparency = 1
                            sc.BorderSizePixel = 0
                            sc.Size = UDim2.new(1, 0, 1, 0)
                            sc.CanvasSize = UDim2.new(0, 0, 0, contentH)
                            sc.ScrollingDirection = Enum.ScrollingDirection.Y
                            sc.ScrollBarThickness = 3
                            -- 子级 ZIndex 必须高于父级(mf=DropdownMenuZ)，否则会被菜单自身背景盖住
                            sc.ZIndex = Config.DropdownMenuZ + 1
                            sc.Parent = mf
                            container = sc
                        else
                            container = mf
                        end
                        local list = Instance.new("UIListLayout")
                        list.FillDirection = Enum.FillDirection.Vertical
                        list.SortOrder = Enum.SortOrder.LayoutOrder
                        list.Padding = UDim.new(0, 0)
                        list.Parent = container
                        local pad = Instance.new("UIPadding")
                        pad.PaddingTop = UDim.new(0, Config.DropdownMenuPad)
                        pad.PaddingBottom = UDim.new(0, Config.DropdownMenuPad)
                        pad.PaddingLeft = UDim.new(0, Config.DropdownMenuPad)
                        pad.PaddingRight = UDim.new(0, Config.DropdownMenuPad)
                        pad.Parent = container
                        d._menuScroll = container
                        for i, opt in ipairs(optList) do
                            local ob = Instance.new("TextButton")
                            ob.Name = "DdOption"
                            ob.Size = UDim2.new(1, 0, 0, Config.DropdownOptionH)
                            ob.BackgroundColor3 = Config.DropdownMenuFill
                            ob.BackgroundTransparency = 1
                            ob.TextTransparency = 1
                            ob.Text = opt
                            ob.TextColor3 = Config.DropdownOptionTextColor
                            ob.TextSize = Config.DropdownOptionTextSize
                            ob.Font = Enum.Font.Gotham
                            ob.TextXAlignment = Enum.TextXAlignment.Center
                            ob.AutoButtonColor = false
                            ob.LayoutOrder = i
                            -- 子级 ZIndex 必须高于父级(mf=DropdownMenuZ)，否则条目被菜单背景蒙版覆盖
                            ob.ZIndex = Config.DropdownMenuZ + 2
                            ob:SetAttribute("OptName", opt)
                            ob.Parent = container
                            local obCorner = Instance.new("UICorner")
                            obCorner.CornerRadius = UDim.new(0, 5)
                            obCorner.Parent = ob
                            -- 选中指示器：独立 Frame，高度小于整行、上下留白缩小，银白静态渐变 + 细边框
                            local hl = Instance.new("Frame")
                            hl.Name = "DdSelHi"
                            hl.BackgroundColor3 = Config.DropdownOptionSelected
                            -- 半透明：银白渐变仅作底色提示，浅色条目文字可透出，不被遮挡
                            hl.BackgroundTransparency = isSelected(opt) and 0.82 or 1
                            hl.Size = UDim2.new(1, -Config.DropdownOptionHiInset * 2, 0, Config.DropdownOptionHiH)
                            hl.Position = UDim2.new(0, Config.DropdownOptionHiInset, 0.5, 0)
                            hl.AnchorPoint = Vector2.new(0, 0.5)
                            hl.ZIndex = Config.DropdownMenuZ + 3
                            hl.Parent = ob
                            local hlCorner = Instance.new("UICorner")
                            hlCorner.CornerRadius = UDim.new(0, 6)
                            hlCorner.Parent = hl
                            local hlGrad = Instance.new("UIGradient")
                            hlGrad.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Config.DropdownOptionSelGradA),
                                ColorSequenceKeypoint.new(1, Config.DropdownOptionSelGradB),
                            })
                            hlGrad.Rotation = 90
                            hlGrad.Parent = hl
                            local hlStroke = Instance.new("UIStroke")
                            hlStroke.Color = Config.DropdownOptionSelStroke
                            hlStroke.Thickness = Config.DropdownOptionSelStrokeThickness
                            hlStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                            hlStroke.Parent = hl
                            ob.MouseButton1Click:Connect(function()
                                applySelection(opt)
                            end)
                            ob.MouseEnter:Connect(function()
                                TweenService:Create(ob, TweenInfo.new(0.1), { BackgroundColor3 = Config.DropdownOptionHover }):Play()
                            end)
                            ob.MouseLeave:Connect(function()
                                TweenService:Create(ob, TweenInfo.new(0.1), { BackgroundColor3 = Config.DropdownMenuFill }):Play()
                            end)
                        end
                        d._closeMenu = closeMenu
                        openDropdownClose = closeMenu

                        TweenService:Create(mf, TweenInfo.new(Config.DropdownRevealTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = Config.DropdownMenuFillTransparency }):Play()
                        for i, ob in ipairs(container:GetChildren()) do
                            if ob:IsA("TextButton") and ob.Name == "DdOption" then
                                task.delay(Config.DropdownRevealTime + (i - 1) * Config.DropdownOptionStagger, function()
                                    if not menuOpen or not ob.Parent then return end
                                    TweenService:Create(ob, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
                                end)
                            end
                        end

                        outsideConn = UserInputService.InputBegan:Connect(function(input)
                            if not menuOpen then return end
                            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                            local p = input.Position
                            if p then
                                local cp, cs = mf.AbsolutePosition, mf.AbsoluteSize
                                if p.X >= cp.X and p.X <= cp.X + cs.X and p.Y >= cp.Y and p.Y <= cp.Y + cs.Y then return end
                            end
                            closeMenu(true)
                        end)
                    end

                    capsule.MouseButton1Click:Connect(function()
                        if menuOpen then
                            closeMenu(true)
                        else
                            openMenu()
                        end
                    end)
                    d._refreshCapsule = refreshCapsule
                    d._frame = frame
                    d._capsule = capsule
                    d._label = label
                    d._titleLbl = titleLbl
                    refreshCapsule()
                    return frame
                end
                for _, st in ipairs(tab._subtitles) do
                    local ordered = {}
                    local function collectSeq(arr, kind)
                        for _, c in ipairs(arr or {}) do
                            ordered[#ordered + 1] = { kind = kind, ctrl = c, seq = c._seq or 0 }
                        end
                    end
                    collectSeq(st._buttons, "button")
                    collectSeq(st._toggles, "toggle")
                    collectSeq(st._paragraphs, "paragraph")
                    collectSeq(st._sliders, "slider")
                    collectSeq(st._dropdowns, "dropdown")
                    collectSeq(st._lines, "line")
                    table.sort(ordered, function(a, b)
                        if a.seq == b.seq then return a.kind < b.kind end
                        return a.seq < b.seq
                    end)
                    -- 段落测量宽度：优先使用 buildTabUI 创建容器时算好的 tabContentW，
                    -- 避免新建实例当帧 AbsoluteSize 未布局完成（真实环境为 0）导致
                    -- Info 按极窄宽度测量、高度算错而向下偏移；兜底路径与旧版一致
                    local paraW
                    if tabContentW then
                        paraW = math.max(60, tabContentW
                            - Config.SubTitleBodyPadX * 2 - Config.ParagraphBackPad * 2)
                    else
                        paraW = math.max(60, (tabContentContainer and tabContentContainer.AbsoluteSize.X or 0)
                            - Config.SubTitleBodyPadX * 2 - Config.ParagraphBackPad * 2)
                    end
                    local itemH = {}
                    for i, e in ipairs(ordered) do
                        if e.kind == "paragraph" then
                            itemH[i] = paragraphHeight(e.ctrl, paraW)
                        elseif e.kind == "slider" then
                            itemH[i] = Config.SliderRowHeight
                        elseif e.kind == "dropdown" then
                            itemH[i] = Config.DropdownRowHeight
                        elseif e.kind == "line" then
                            itemH[i] = Config.LineRowHeight
                        else
                            itemH[i] = Config.ButtonHeight
                        end
                    end
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
                        for i, e in ipairs(ordered) do
                            if e.kind == "button" then
                                makeButton(e.ctrl, i).Parent = body
                            elseif e.kind == "toggle" then
                                makeToggle(e.ctrl, i).Parent = body
                            elseif e.kind == "paragraph" then
                                local pg = e.ctrl
                                pg._rowH = itemH[i]
                                pg._paraW = paraW
                                pg._block = block
                                pg._body = body
                                pg._bodyH = contentH
                                pg._headH = headH
                                pg._divGap = divGap
                                pg._collapsed = st.collapsed
                                makeParagraph(pg, i, itemH[i]).Parent = body
                            elseif e.kind == "slider" then
                                makeSlider(e.ctrl, i).Parent = body
                            elseif e.kind == "dropdown" then
                                makeDropdown(e.ctrl, i).Parent = body
                            elseif e.kind == "line" then
                                makeLine(e.ctrl, i).Parent = body
                            end
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

                        if sel then
                            local selStroke = sel:FindFirstChildOfClass("UIStroke")
                            if active then
                                local first = not sel.Visible
                                if first then
                                    sel.Position = UDim2.new(0, 0, 0, 0)
                                    sel.BackgroundTransparency = 1
                                    if selStroke then selStroke.Transparency = 1 end
                                end
                                sel.Visible = true
                                sel.ZIndex = 2
                                TweenService:Create(sel, TweenInfo.new(
                                    Config.TabSelFadeTime,
                                    Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                                ), {
                                    BackgroundTransparency = Config.TabSelFillTransparency,
                                }):Play()
                                if selStroke then TweenService:Create(selStroke, TweenInfo.new(
                                    Config.TabSelFadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                                ), { Transparency = 0 }):Play() end
                            else
                                if sel.Visible then

                                    local tw = TweenService:Create(sel, TweenInfo.new(
                                        Config.TabSelFadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                                    ), {
                                        BackgroundTransparency = 1,
                                    })
                                    tw:Play()
                                    if selStroke then TweenService:Create(selStroke, TweenInfo.new(
                                        Config.TabSelFadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                                    ), { Transparency = 1 }):Play() end
                                    tw.Completed:Connect(function(state)
                                        if state == Enum.PlaybackState.Completed
                                            and sel.Parent
                                            and win._activeTab ~= idx then
                                            sel.Visible = false
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end

            local playToggleStateAnimation = nil

            local function collapsePanel(skipToggleAnim)
                if not expanded then return end
                titleGen = titleGen + 1
                cancelTitleTweens()
                suppressHeaderEntrance = false
                if actionEnd then actionEnd() end
                local ll = islandTextContainer and islandTextContainer:FindFirstChildOfClass("UIListLayout")
                if ll then ll.HorizontalAlignment = Enum.HorizontalAlignment.Center end
                local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
                -- 统一为中心锚点语义后再补间：进入收起时 edge 可能正处于中心锚点语义
                -- （toggle/图文胖岛恢复中、拖拽后），若直接把左上语义的 IslandPosition
                -- 当作补间目标，锚点与目标语义错配会让整个收起动画向左上偏移
                local sw0 = screenGui.AbsoluteSize.X
                local sh0 = screenGui.AbsoluteSize.Y
                local es0 = edge.Size
                local ep0 = edge.Position
                local ea0 = edge.AnchorPoint
                local evw = es0.X.Offset + es0.X.Scale * sw0
                local evh = es0.Y.Offset + es0.Y.Scale * sh0
                local evcx = ep0.X.Scale * sw0 + ep0.X.Offset + evw * (0.5 - ea0.X)
                local evcy = ep0.Y.Scale * sh0 + ep0.Y.Offset + evh * (0.5 - ea0.Y)
                edge.AnchorPoint = Vector2.new(0.5, 0.5)
                edge.Position = UDim2.new(0.5, evcx - sw0 * 0.5, 0, evcy)
                local collapseFinished = false

                animateEdge(Config.IslandSize, UDim2.new(0.5, cx, 0, cy), Config.PanelExpandTime, Config.PanelBounce, function()
                    edge.AnchorPoint = Vector2.new(0.5, 0.5)
                    edge.Position = UDim2.new(0.5, cx, 0, cy)
                    winOpen = false
                    collapseFinished = true
                end)
                TweenService:Create(islandTextContainer, TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = UDim2.new(Config.IslandPosition.X.Scale, cx, Config.IslandPosition.Y.Scale, cy),
                }):Play()
                for _, cf in ipairs(islandTextContainer:GetChildren()) do local lb = cf:FindFirstChildOfClass("TextLabel") if lb then lb.TextTransparency = 0 end end
                if closeBtn then
                    local cb = closeBtn
                    closeBtn = nil
                    TweenService:Create(cb, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
                    cb.Active = false
                    task.delay(Config.FadeInTime + 0.05, function() if cb and cb.Parent then cb:Destroy() end end)
                end
                if loaderSpinTween then pcall(function() loaderSpinTween:Cancel() end) loaderSpinTween = nil end
                if titleIcon then titleIcon:Destroy() titleIcon = nil end
                if switchBtn then
                    local sb = switchBtn
                    switchBtn = nil
                    TweenService:Create(sb, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
                    sb.Active = false
                    task.delay(Config.FadeInTime + 0.05, function() if sb and sb.Parent then sb:Destroy() end end)
                end
                if infoLabel then infoLabel:Destroy() infoLabel = nil end
                clearBrand()
                destroyTabUI()
                win._rebuildTabs = nil
                expanded = false

                -- 收起态应保持真实脚本标题（白色），不要回退到绿色默认占位 "DynamicCow"
                -- （绿色 DynamicCow 仅用于初始/错误占位，其余状态均以真实标题显示）
                setIslandText(islandTextOverride or title, Config.TitleColor)
                interacting = false

                if skipToggleAnim then
                    lastToggleInfo = nil
                elseif playToggleStateAnimation then

                    task.spawn(function()
                        local waited = 0
                        while not collapseFinished and alive and waited < 2 do
                            task.wait(0.02)
                            waited = waited + 0.02
                        end
                        if not alive or shutdown then lastToggleInfo = nil return end
                        -- 收起完成后若用户已重新展开面板，则放弃 toggle 状态动画，
                        -- 避免其把展开中的面板拽成 toggle 胖岛造成错位
                        if expanded then lastToggleInfo = nil return end
                        playToggleStateAnimation()
                    end)
                end
            end

            local lastPanelLayout = nil

            local function buildTabUI(layout)
    local titlePad = layout.titlePad
                            local blockH = layout.blockH
                            local m = layout.m
                            local top = layout.top
                            local sh = layout.sh
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
                            if suppressHeaderEntrance then div.BackgroundTransparency = 1 end
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
                                if suppressHeaderEntrance then sep.BackgroundTransparency = 1 end
                                local contentX = titlePad + listW + Config.TabAreaGap
                                -- 内容区宽度按布局算式推导，不依赖 AbsoluteSize：
                                -- 真实环境中新建实例当帧 AbsoluteSize 尚未布局完成（为 0），
                                -- 会使段落 Info 按极窄宽度测量导致向下偏移
                                local edgeW = screenGui.AbsoluteSize.X
                                local layM = (lastPanelLayout and lastPanelLayout.m) or Config.PanelMargin
                                tabContentW = math.max(60, (edgeW - layM * 2) - (contentX + titlePad))
                                local contentFrame = Instance.new("CanvasGroup")
                                contentFrame.Name = "TabContent"
                                contentFrame.BackgroundTransparency = 1
                                contentFrame.Position = UDim2.new(0, contentX, 0, listTop)

                                contentFrame.Size = UDim2.new(1, -(contentX + titlePad), 1, -listTop)
                                contentFrame.ClipsDescendants = true
                                contentFrame.ZIndex = 2
                                contentFrame.Parent = contentRoot
                                tabContentContainer = contentFrame
                                tabContentBase = contentFrame.Position
                                if suppressHeaderEntrance then contentFrame.GroupTransparency = 1 end
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
                                local subListPad = Instance.new("UIPadding")
                                subListPad.PaddingRight = UDim.new(0, Config.ContentScrollBarThickness + 2)
                                subListPad.Parent = subList
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
                                        if not expanded or suppressHeaderEntrance then return end
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
                                -- 构建后若尚未选中任何页且存在选项卡，自动选中第一页：
                                -- 避免切换脚本（自动展开）后停在「请先选中一个页面」空状态，
                                -- 与 loader 淡出过程重叠显示
                                if win._activeTab == 0 and #win._tabs > 0 then
                                    win._activeTab = 1
                                    updateTabsHighlight()
                                    updateContentArea()
                                    animateContentIn()
                                else
                                    updateTabsHighlight()
                                    updateContentArea()
                                end
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
                                lbl.TextTransparency = 1
                                lbl.Parent = contentRoot
                                tabEmptyLabel = lbl
                                task.delay(Config.PanelExpandTime, function()
                                    if not expanded or suppressHeaderEntrance then return end
                                    if lbl and lbl.Parent then TweenService:Create(lbl, TweenInfo.new(Config.TabFadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
                                end)
                            end
            end

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

            local function buildCloseButton(onHoldConfirm)
                        if closeBtn and closeBtn.Parent then closeBtn:Destroy() end
                        closeBtn = nil
                        local btn = Instance.new("ImageButton")
                        btn.Name = "PanelClose"
                        btn.Size = UDim2.new(0, 20, 0, 20)
                        btn.Position = UDim2.new(1, -26, 0, 6)
                        btn.BackgroundTransparency = 1
                        btn.ScaleType = Enum.ScaleType.Fit
                        btn.ImageColor3 = Color3.new(1, 1, 1)
                        btn.ImageTransparency = 1
                        btn.Parent = contentRoot
                        TweenService:Create(btn, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play()
                        local closeHold = nil

                        local pressGen = 0
                        btn.InputBegan:Connect(function(bi)
                            if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
                                if shutdown then return end

                                if not expanded or closeDialog or btn.Parent == nil then return end
                                pressGen = pressGen + 1
                                local myGen = pressGen
                                TweenService:Create(btn, TweenInfo.new(Config.CloseHoldTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageColor3 = Config.RedXColor }):Play()
                                if closeHold then safeCancel(closeHold) end
                                closeHold = task.delay(Config.CloseHoldTime, function()
                                    closeHold = nil

                                    if myGen ~= pressGen then return end
                                    if not expanded or closeDialog then return end
                                    if onHoldConfirm then onHoldConfirm() end
                                end)
                            end
                        end)
                        btn.InputEnded:Connect(function(bi)
                            if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
                                TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageColor3 = Color3.new(1, 1, 1) }):Play()
                                if closeHold then
                                    safeCancel(closeHold)
                                    closeHold = nil

                                    if expanded and not closeDialog then
                                        pressGen = pressGen + 1
                                        collapsePanel()
                                    end
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
            end

local function buildHeaderDecor()
  if not lastPanelLayout then return end
                if titleIcon then titleIcon:Destroy() end
                local iconS = Config.TitleIconSize
                local iconGap = Config.TitleIconGap
                local titleH = (islandTextContainer and islandTextContainer.Parent) and islandTextContainer.AbsoluteSize.Y or Config.TitleIconSize
                local infoH = Config.InfoBoxHeight
                local vGap = Config.InfoTopGap
                local blockH = (info ~= "") and (titleH + vGap + infoH) or titleH
                local top = lastPanelLayout.top
                local titlePad = lastPanelLayout.titlePad
                local m = lastPanelLayout.m
                local blockTop = top + titlePad
                local blockCY = blockTop + blockH / 2
                local iconLeft = m + titlePad + Config.TitleIconNudgeX
                local contentLeftX = iconLeft + iconS + iconGap
                local infoTop = blockTop + titleH + vGap - Config.InfoRise
                if loaderSpinTween then pcall(function() loaderSpinTween:Cancel() end) loaderSpinTween = nil end
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
                if iconFromURL then
                    ic.ScaleType = Enum.ScaleType.Crop
                    if not iconColorSet then ic.ImageColor3 = Color3.new(1, 1, 1) end
                end
                task.spawn(function()

                    if suppressHeaderEntrance then return end

                    local handoff = Config.TitleIconHandoffTime

                    local function setFinal(img, rectOff, rectSize, tintWithIconColor)
                        if loaderSpinTween then pcall(function() loaderSpinTween:Cancel() end) loaderSpinTween = nil end
                        if not (ic and ic.Parent) then return end

                        ic.Rotation = 0
                        ic.Image = img
                        if rectOff then ic.ImageRectOffset = rectOff ic.ImageRectSize = rectSize end

                        if tintWithIconColor then ic.ImageColor3 = iconColor end
                        TweenService:Create(ic, TweenInfo.new(handoff, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 0,
                        }):Play()
                    end

                    local function setFinalAfterExpand(img, rectOff, rectSize, tintWithIconColor)
                        task.delay(Config.PanelExpandTime, function()
                            setFinal(img, rectOff, rectSize, tintWithIconColor)
                        end)
                    end

                    if iconFromURL then

                        if not (ic and ic.Parent) then return end
                        local loaderAsset = getLucideIcon(Config.TitleLoaderIcon)
                        if loaderAsset then
                            ic.Image = loaderAsset.Url
                            if loaderAsset.ImageRectOffset then
                                ic.ImageRectOffset = loaderAsset.ImageRectOffset
                                ic.ImageRectSize = loaderAsset.ImageRectSize
                            end
                        end
                        ic.ImageTransparency = 0

                        if loaderSpinTween then pcall(function() loaderSpinTween:Cancel() end) end
                        loaderSpinTween = TweenService:Create(ic, TweenInfo.new(
                            Config.TitleLoaderSpinTime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut,
                            -1, false
                        ), { Rotation = 360 })
                        loaderSpinTween:Play()

                        local assetId = loadIconFromURL(iconFromURL)
                        if not (ic and ic.Parent) then return end
                        if assetId then

                            ic.Rotation = 0
                            TweenService:Create(ic, TweenInfo.new(handoff * 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                ImageTransparency = 1,
                            }):Play()
                            task.delay(handoff * 0.5, function() setFinalAfterExpand(assetId) end)
                        else

                            local failAsset = getLucideIcon(Config.TitleIconFailIcon)
                            if failAsset then
                                ic.Rotation = 0
                                TweenService:Create(ic, TweenInfo.new(handoff * 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    ImageTransparency = 1,
                                }):Play()
                                task.delay(handoff * 0.5, function()
                                    setFinalAfterExpand(failAsset.Url, failAsset.ImageRectOffset, failAsset.ImageRectSize, true)
                                end)
                            else
                                ic.Rotation = 0
                                ic.ImageColor3 = iconColor
                                ic.ImageTransparency = 0
                            end
                        end
                        return
                    end

                    local asset = getLucideIcon(iconName)
                    if asset then
                        setFinalAfterExpand(asset.Url, asset.ImageRectOffset, asset.ImageRectSize, true)
                    else
                        ic.ImageTransparency = 0
                    end
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
            end

        local function otherLoadedTitles()
            local out = {}
            for _, t in ipairs(loadedOrder) do
                if t ~= title and loadedWindows[t] ~= nil then
                    out[#out + 1] = t
                end
            end
            return out
        end

        local function buildSwitchButtonImpl()
            if switchBtn and switchBtn.Parent then switchBtn:Destroy() end
            switchBtn = nil
            if not lastPanelLayout then return end
            local sz = Config.SwitchButtonSize
            local b = Instance.new("ImageButton")
            b.Name = "PanelSwitch"
            b.Size = UDim2.fromOffset(sz, sz)
            b.Position = UDim2.new(1, -26 - sz - Config.SwitchButtonGap, 0, 6)
            b.BackgroundTransparency = 1
            b.ScaleType = Enum.ScaleType.Fit
            b.ImageColor3 = Color3.new(1, 1, 1)
            b.ImageTransparency = 1
            b.ZIndex = 3
            b.Parent = contentRoot
            local others = otherLoadedTitles()
            local enabled = #others > 0
            b.Active = enabled
            b.Interactable = enabled
            if not enabled then b.ImageColor3 = Color3.new(0.45, 0.45, 0.5) end
            task.spawn(function()
                local a = getLucideIcon(Config.SwitchButtonIcon)
                if not (a and b.Parent) then return end
                b.Image = a.Url
                if a.ImageRectOffset then
                    b.ImageRectOffset = a.ImageRectOffset
                    b.ImageRectSize = a.ImageRectSize
                end
            end)
            b.MouseButton1Click:Connect(function()
                if shutdown then return end
                if not expanded or closeDialog then return end
                if #otherLoadedTitles() == 0 then
                    reportError("没有其它已加载的脚本可切换")
                    return
                end
                if showSwitchConfirm then showSwitchConfirm() end
            end)
            TweenService:Create(b, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = enabled and 0 or 0.55,
            }):Play()
            switchBtn = b
        end

        local function buildSwitchConfirmImpl()
            if closeDialog or shutdown then return end
            if not expanded then return end
            setHeaderVisible(false)
            if switchBtn then TweenService:Create(switchBtn, TweenInfo.new(0.22), { ImageTransparency = 1 }):Play() end
            if closeBtn then TweenService:Create(closeBtn, TweenInfo.new(0.22), { ImageTransparency = 1 }):Play() end
            destroyTabUI()

            local sw = screenGui.AbsoluteSize.X
            local sh = screenGui.AbsoluteSize.Y
            local dlg = Instance.new("Frame")
            dlg.Name = "SwitchDialog"
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

            local pad = Config.CloseDialogPad
            local txt = Instance.new("TextLabel")
            txt.Name = "SwitchDialogTitle"
            txt.BackgroundTransparency = 1
            txt.AnchorPoint = Vector2.new(0.5, 0)
            txt.Position = UDim2.new(0.5, 0, 0, pad)
            txt.Size = UDim2.new(1, -pad * 2, 0, 0)
            txt.AutomaticSize = Enum.AutomaticSize.Y
            txt.Text = Config.SwitchDialogTitle
            txt.TextColor3 = Config.CloseDialogTextColor
            txt.TextSize = Config.CloseDialogTextSize
            txt.Font = Enum.Font.Gotham
            txt.TextWrapped = true
            txt.ZIndex = 71
            txt.Parent = dlg

            local ddW = Config.SwitchDialogW - pad * 2
            local ddH = Config.SwitchDropdownH
            local ddY = pad + 30
            local itemH = Config.SwitchDropdownItemH
            local itemGap = Config.SwitchDropdownItemGap
            local listGap = Config.SwitchDropdownListGap
            local listInset = Config.SwitchDropdownListInset

            local box = Instance.new("TextButton")
            box.Name = "SwitchDropdown"
            box.Size = UDim2.new(0, ddW, 0, ddH)
            box.Position = UDim2.new(0.5, 0, 0, ddY)
            box.AnchorPoint = Vector2.new(0.5, 0)
            box.BackgroundColor3 = Config.SwitchDropdownFill
            box.BorderSizePixel = 0
            box.Text = ""
            box.AutoButtonColor = false
            box.ClipsDescendants = true
            box.ZIndex = 72
            box.Parent = dlg
            local boxCorner = Instance.new("UICorner")
            boxCorner.CornerRadius = UDim.new(0.5, 0)
            boxCorner.Parent = box

            local chev = Instance.new("ImageLabel")
            chev.Name = "SwitchDropdownChevron"
            chev.Size = UDim2.fromOffset(18, 18)
            chev.Position = UDim2.new(1, -20, 0, ddH / 2)
            chev.AnchorPoint = Vector2.new(0.5, 0.5)
            chev.BackgroundTransparency = 1
            chev.ImageColor3 = Config.SwitchDropdownTextColor
            chev.ScaleType = Enum.ScaleType.Fit
            chev.ZIndex = 73
            chev.Parent = box
            task.spawn(function()
                local a = getLucideIcon(Config.SwitchDropdownIcon)
                if not (a and chev.Parent) then return end
                chev.Image = a.Url
                if a.ImageRectOffset then
                    chev.ImageRectOffset = a.ImageRectOffset
                    chev.ImageRectSize = a.ImageRectSize
                end
            end)

            local selected = nil
            local selLabel = Instance.new("TextLabel")
            selLabel.Name = "SwitchDropdownLabel"
            selLabel.BackgroundTransparency = 1
            selLabel.Size = UDim2.new(1, -56, 0, ddH)
            selLabel.Position = UDim2.new(0, 18, 0, 0)
            selLabel.TextColor3 = Config.SwitchDropdownTextColor
            selLabel.TextSize = 16
            selLabel.Font = Enum.Font.Gotham
            selLabel.TextXAlignment = Enum.TextXAlignment.Left
            selLabel.TextYAlignment = Enum.TextYAlignment.Center
            selLabel.TextWrapped = false
            selLabel.TextTruncate = Enum.TextTruncate.AtEnd
            selLabel.ZIndex = 73
            selLabel.Parent = box

            local items = otherLoadedTitles()
            local listOpen = false
            local listFrame = nil
            local closeDropdown = nil

            local function openDropdown()
                if listOpen then return end
                if #items == 0 then
                    reportError("没有其它已加载的脚本可切换")
                    return
                end
                listOpen = true
                local contentH = #items * (itemH + itemGap) - itemGap
                local viewH = math.min(contentH, Config.SwitchDropdownMaxH)
                local barsH = Config.CloseDialogBtnH
                local needH = ddY + ddH + listGap + viewH + listGap + 10 + barsH + pad
                local dlgH = math.min(needH, sh - 40)
                if dlgH < needH then
                    viewH = math.max(itemH, dlgH - (ddY + ddH + listGap + listGap + 10 + barsH + pad))
                end
                local boxH = ddH + listGap + viewH + listGap

                listFrame = Instance.new("ScrollingFrame")
                listFrame.Name = "SwitchDropdownList"
                listFrame.BackgroundTransparency = 1
                listFrame.BorderSizePixel = 0
                listFrame.Position = UDim2.new(0, listInset, 0, ddH + listGap)
                listFrame.Size = UDim2.new(1, -listInset * 2, 0, viewH)
                listFrame.ClipsDescendants = true
                listFrame.CanvasSize = UDim2.new(0, 0, 0, contentH)
                listFrame.ScrollBarThickness = 3
                listFrame.ScrollBarImageColor3 = Config.SwitchDropdownTextColor
                listFrame.ScrollBarImageTransparency = 0.55
                listFrame.ZIndex = 73
                listFrame.Parent = box
                local lay = Instance.new("UIListLayout")
                lay.SortOrder = Enum.SortOrder.LayoutOrder
                lay.FillDirection = Enum.FillDirection.Vertical
                lay.HorizontalAlignment = Enum.HorizontalAlignment.Left
                lay.VerticalAlignment = Enum.VerticalAlignment.Top
                lay.Padding = UDim.new(0, itemGap)
                lay.Parent = listFrame
                for i, t in ipairs(items) do
                    local it = Instance.new("TextButton")
                    it.Name = "SwitchDropdownItem"
                    it.Size = UDim2.new(1, -6, 0, itemH)
                    local isSel = (selected == t)
                    it.BackgroundColor3 = isSel and Color3.new(1, 1, 1) or Config.SwitchDropdownFill
                    it.BorderSizePixel = 0
                    it.Text = ""
                    it.AutoButtonColor = false
                    it.LayoutOrder = i
                    it.ZIndex = 74
                    it.Parent = listFrame
                    if isSel then
                        local ig = Instance.new("UIGradient")
                        ig.Rotation = 90
                        ig.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 192)),
                        })
                        ig.Parent = it
                    end
                    local ic2 = Instance.new("UICorner")
                    ic2.CornerRadius = UDim.new(0, 10)
                    ic2.Parent = it
                    local lb = Instance.new("TextLabel")
                    lb.BackgroundTransparency = 1
                    lb.Size = UDim2.new(1, -28, 1, 0)
                    lb.Position = UDim2.new(0, 14, 0, 0)
                    lb.Text = t
                    lb.TextColor3 = isSel and Color3.fromRGB(30, 30, 38) or Config.SwitchDropdownTextColor
                    lb.TextSize = 15
                    lb.Font = Enum.Font.Gotham
                    lb.TextXAlignment = Enum.TextXAlignment.Left
                    lb.TextYAlignment = Enum.TextYAlignment.Center
                    lb.TextTruncate = Enum.TextTruncate.AtEnd
                    lb.ZIndex = 75
                    lb.Parent = it
                    it.MouseEnter:Connect(function()
                        if selected ~= t then
                            TweenService:Create(it, TweenInfo.new(0.12), { BackgroundColor3 = Config.SwitchDropdownHoverColor }):Play()
                        end
                    end)
                    it.MouseLeave:Connect(function()
                        if selected ~= t then
                            TweenService:Create(it, TweenInfo.new(0.12), { BackgroundColor3 = Config.SwitchDropdownFill }):Play()
                        end
                    end)
                    it.MouseButton1Click:Connect(function()
                        selected = t
                        selLabel.Text = t
                        closeDropdown()
                    end)
                end
                animateEdge(UDim2.new(0, Config.SwitchDialogW, 0, dlgH),
                    UDim2.new(0, (sw - Config.SwitchDialogW) / 2, 0, (sh - dlgH) / 2), 0.28)
                TweenService:Create(box, TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, ddW, 0, boxH),
                }):Play()
                TweenService:Create(boxCorner, TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    CornerRadius = UDim.new(0, Config.SwitchDropdownCorner),
                }):Play()
                TweenService:Create(chev, TweenInfo.new(0.24, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Rotation = 90,
                }):Play()
            end

            closeDropdown = function(restoreDialog)
                if not listOpen then return end
                listOpen = false
                if listFrame and listFrame.Parent then listFrame:Destroy() end
                listFrame = nil
                if restoreDialog ~= false then
                    animateEdge(UDim2.new(0, Config.SwitchDialogW, 0, Config.SwitchDialogH),
                        UDim2.new(0, (sw - Config.SwitchDialogW) / 2, 0, (sh - Config.SwitchDialogH) / 2), 0.26)
                end
                TweenService:Create(box, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, ddW, 0, ddH),
                }):Play()
                TweenService:Create(boxCorner, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    CornerRadius = UDim.new(0.5, 0),
                }):Play()
                TweenService:Create(chev, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Rotation = 0,
                }):Play()
            end

            box.MouseButton1Click:Connect(function()
                if listOpen then
                    closeDropdown()
                else
                    openDropdown()
                end
            end)
            if #items > 0 then
                selected = items[1]
                selLabel.Text = selected
            end

            local bars = Instance.new("Frame")
            bars.BackgroundTransparency = 1
            bars.AnchorPoint = Vector2.new(0.5, 1)
            bars.Position = UDim2.new(0.5, 0, 1, -pad)
            bars.Size = UDim2.new(1, -pad * 2, 0, Config.CloseDialogBtnH)
            bars.ZIndex = 71
            bars.Parent = dlg
            local bl = Instance.new("UIListLayout")
            bl.FillDirection = Enum.FillDirection.Horizontal
            bl.HorizontalAlignment = Enum.HorizontalAlignment.Center
            bl.VerticalAlignment = Enum.VerticalAlignment.Center
            bl.SortOrder = Enum.SortOrder.LayoutOrder
            bl.Padding = UDim.new(0, Config.CloseDialogBtnGap)
            bl.Parent = bars

            local function closeListAndRestore()
                closeDropdown(false)
                if dlg and dlg.Parent then dlg:Destroy() end
                if closeDialog == dlg then closeDialog = nil end
                setHeaderVisible(true)
                if switchBtn then
                    TweenService:Create(switchBtn, TweenInfo.new(0.24), { ImageTransparency = 0 }):Play()
                    switchBtn.Active = true
                end
                if lastPanelLayout then buildTabUI(lastPanelLayout) end
                animateEdge(UDim2.new(0, sw - lastPanelLayout.m * 2, 0, sh - lastPanelLayout.top - lastPanelLayout.m),
                    UDim2.new(0, lastPanelLayout.m, 0, lastPanelLayout.top), Config.PanelExpandTime)
                -- 回到面板态：圆角同步恢复为灵动岛圆角
                local pcTi = TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                if corner then TweenService:Create(corner, pcTi, { CornerRadius = Config.IslandCornerRadius }):Play() end
                if fillCorner then TweenService:Create(fillCorner, pcTi, { CornerRadius = Config.IslandCornerRadius }):Play() end
            end

            local cancelB = makePill("取消", Config.CloseCancelColor)
            cancelB.LayoutOrder = 1
            cancelB.Parent = bars
            cancelB.MouseButton1Click:Connect(function()
                if closeDialog ~= dlg then return end
                closeListAndRestore()
            end)

            local dlgInset = Config.BorderThickness
            dlg.Size = UDim2.new(1, -dlgInset * 2, 1, -dlgInset * 2)
            dlg.Position = UDim2.new(0, dlgInset, 0, dlgInset)
            -- 对话框期间隐藏 fillFrame，避免与 dlg 黑色背景叠加且边缘超出银白边框
            if fillFrame and fillFrame.Parent then fillFrame.BackgroundTransparency = 1 end
            local function restoreDialogBg()
                if fillFrame and fillFrame.Parent then
                    chromeTween(fillFrame, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        BackgroundTransparency = Config.IslandFinalTransparency,
                    })
                end
            end
            local function fadeOutDialog(onDone)
                local fti = TweenInfo.new(Config.SwitchFadeOutTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                for _, node in ipairs(dlg:GetDescendants()) do
                    if node:IsA("TextLabel") or node:IsA("TextButton") then
                        TweenService:Create(node, fti, { TextTransparency = 1 }):Play()
                    end
                    if node:IsA("ImageLabel") then
                        TweenService:Create(node, fti, { ImageTransparency = 1 }):Play()
                    end
                    if node:IsA("GuiObject") then
                        TweenService:Create(node, fti, { BackgroundTransparency = 1 }):Play()
                    end
                end
                TweenService:Create(dlg, fti, { BackgroundTransparency = 1 }):Play()
                task.delay(Config.SwitchFadeOutTime + 0.05, function()
                    if dlg and dlg.Parent then dlg:Destroy() end
                    if onDone then onDone() end
                end)
            end
            local function expandEdgeBackToPanel()
                local sw2 = screenGui.AbsoluteSize.X
                local sh2 = screenGui.AbsoluteSize.Y
                local m2 = Config.PanelMargin
                local top2 = Config.IslandPosition.Y.Offset + Config.PanelDrop
                cancelEdgeTweens()
                edge.AnchorPoint = Vector2.new(0, 0)
                -- 注意：edge 此时仍是「对话框」尺寸，切勿在此把 Position 设为 IslandPosition
                -- （那是灵动岛居中位置）。否则全尺寸面板会以岛位置为左上角、瞬间向右下偏移，
                -- 再由 animateEdge 滑回正确位置，表现为「窗口向右上角偏移」。
                -- 直接由 animateEdge 从对话框态平滑放大回面板态即可。
                animateEdge(UDim2.new(0, sw2 - m2 * 2, 0, sh2 - top2 - m2), UDim2.new(0, m2, 0, top2), Config.PanelExpandTime)
                lastPanelLayout = { titlePad = Config.HeaderPad, blockH = (lastPanelLayout and lastPanelLayout.blockH) or 0, m = m2, top = top2, sh = sh2 }
                -- 对话框展开回面板态：圆角恢复为灵动岛圆角
                local pcTi = TweenInfo.new(Config.PanelExpandTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                if corner then TweenService:Create(corner, pcTi, { CornerRadius = Config.IslandCornerRadius }):Play() end
                if fillCorner then TweenService:Create(fillCorner, pcTi, { CornerRadius = Config.IslandCornerRadius }):Play() end
            end

            local okBtn = makePill("确认", Config.SwitchDialogConfirmColor)
            okBtn.BackgroundColor3 = Color3.new(1, 1, 1)
            okBtn.TextColor3 = Color3.fromRGB(30, 30, 38)
            local okGrad = Instance.new("UIGradient")
            okGrad.Rotation = 90
            okGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 192)),
            })
            okGrad.Parent = okBtn
            okBtn.LayoutOrder = 2
            okBtn.Parent = bars
            okBtn.MouseButton1Click:Connect(function()
                if closeDialog ~= dlg then return end
                if selected == nil then
                    reportError("请先在下拉菜单中选择要切换到的脚本")
                    return
                end
                if listOpen then closeDropdown(false) end
                if closeDialog ~= dlg then return end
                closeDialog = nil
                switchToTarget = selected
                -- ① 封盘：置 busy 防止展开期交互；同时隐藏切换按钮
                if switchBtn then switchBtn.Active = false end

                -- ② 对话框（下拉/标题/按钮）同步渐隐，同时边框展开回面板态
                expanded = true
                titleGen = titleGen + 1
                islandScale.Scale = 1
                setHeaderVisible(false)
                expandEdgeBackToPanel()
                task.delay(Config.PanelExpandTime, function() winOpen = true end)

                -- ③ 渐隐完成 → 保持内容隐藏（suppressHeaderEntrance），交棒给 playSwitchSequence
                --    playSwitchSequence 内部：建 loader → 播 loader → playPanelContentEntrance
                --    （其内部 buildTabUI/buildHeaderDecor/buildCloseButton/buildSwitchButton + 揭开入场）
                fadeOutDialog(function()
                    if not alive or shutdown then return end
                    suppressHeaderEntrance = true
                    restoreDialogBg()
                    if playSwitchSequenceRef then playSwitchSequenceRef(Config.SwitchConfirmLoadingText) end
                    -- ④ loader + 入场动画结束后，若目标窗口存在则交棒切换
                    local seqTotal = Config.SwitchFadeOutTime + Config.SwitchHoldTime + Config.SwitchLoaderFadeTime
                    task.delay(seqTotal + 0.05, function()
                        local t = switchToTarget
                        switchToTarget = nil
                        if not t then return end
                        local target = nil
                        pcall(function() target = Library.GetLoadedWindow(t) end)
                        if target and type(target) == "table" and target._switchBack then
                            pcall(function() target:_switchBack() end)
                        end
                    end)
                end)
            end)

            closeDialog = dlg
            animateEdge(UDim2.new(0, Config.SwitchDialogW, 0, Config.SwitchDialogH),
                UDim2.new(0, (sw - Config.SwitchDialogW) / 2, 0, (sh - Config.SwitchDialogH) / 2), 0.35)
            -- 对话框态：边框圆角与填充圆角同步到对话框圆角，
            -- 避免 dlg 黑色圆角超出方形银白边框（问题：黑背景边缘越过银白边框）
            local dcTi = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            if corner then TweenService:Create(corner, dcTi, { CornerRadius = Config.CloseDialogCorner }):Play() end
            if fillCorner then TweenService:Create(fillCorner, dcTi, { CornerRadius = Config.CloseDialogCorner }):Play() end
        end
        buildSwitchButton = buildSwitchButtonImpl
        showSwitchConfirm = buildSwitchConfirmImpl

            local iconTextBusy = false
            local iconTextHc = nil
            local function clearIconTextHc(fade)
                iconTextBusy = false
                local hcOld = iconTextHc
                iconTextHc = nil
                if hcOld and hcOld.Parent then
                    if fade then
                        for _, ch in ipairs(hcOld:GetDescendants()) do
                            if ch:IsA("ImageLabel") then
                                TweenService:Create(ch, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
                            elseif ch:IsA("TextLabel") then
                                TweenService:Create(ch, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
                            end
                        end
                        task.delay(Config.FadeInTime + 0.05, function() if hcOld and hcOld.Parent then hcOld:Destroy() end end)
                    else
                        hcOld:Destroy()
                    end
                end
            end
            local function playIconTextAnimation(text, iconName, iconColor)
                if not alive or not ready or shutdown then return end
                if iconTextBusy then return end
                if not text or #text == 0 then return end
                if iconName ~= nil and type(iconName) ~= "string" then return end
                iconTextBusy = true
                local wasExpanded = expanded

                if hintActive then clearHint(true) end
                if actionBusy and actionEnd then actionEnd(true) end

                if toggleAnimBusy then cancelToggleAnim() end

                local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2

                -- 切换/自动展开加载期间（suppressHeaderEntrance 为真）不应因图文动画
                -- 额外收起面板：否则再执行新脚本时，刚展开的面板会被 ShowNotify/
                -- 入场提示动画里的 collapsePanel 再次收起，表现为「额外的面板收起」
                if wasExpanded and not suppressHeaderEntrance then
                    collapsePanel(true)
                    task.wait(Config.PanelExpandTime * 0.5)

                    if not alive or shutdown then
                        iconTextBusy = false
                        return
                    end
                end
                expanded = false
                winOpen = false
                interacting = false

                local iconSize = Config.IconTextIconSize
                local textSize = Config.IconTextTextSize
                local tw = measureTextWidth(text, textSize)
                local iconW = iconName and iconSize or 0
                local contentW = iconW + (iconW > 0 and Config.IconTextGap or 0) + tw
                local targetW = math.max(Config.IconTextMinW, contentW + Config.IconTextPadX * 2)

                local fatH = Config.IconTextHeight
                local hc = Instance.new("Frame")
                hc.Name = "IslandIconTextContainer"
                hc.Size = UDim2.new(1, 0, 1, 0)
                hc.BackgroundTransparency = 1
                hc.BorderSizePixel = 0
                hc.ClipsDescendants = true
                hc.ZIndex = 56
                hc.Parent = edge
                iconTextHc = hc

                if islandTextContainer and islandTextContainer.Parent then
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do
                        local lb = cf:FindFirstChildOfClass("TextLabel")
                        if lb then TweenService:Create(lb, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                    end
                end
                local iconLbl = nil
                if iconName and iconName ~= "" then
                    local iconHolder = Instance.new("Frame")
                    iconHolder.Name = "IconTextIconHolder"
                    iconHolder.BackgroundTransparency = 1
                    iconHolder.BorderSizePixel = 0
                    iconHolder.AnchorPoint = Vector2.new(0, 0.5)
                    iconHolder.Position = UDim2.new(0, Config.IconTextPadX, 0.5, 0)
                    iconHolder.Size = UDim2.fromOffset(iconSize, iconSize)
                    iconHolder.ZIndex = 57
                    iconHolder.Parent = hc
                    iconLbl = Instance.new("ImageLabel")
                    iconLbl.Name = "IconTextIcon"
                    iconLbl.BackgroundTransparency = 1
                    iconLbl.Size = UDim2.new(1, 0, 1, 0)
                    iconLbl.ImageColor3 = iconColor or Config.SubTitleColor
                    iconLbl.ImageTransparency = 1
                    iconLbl.ScaleType = Enum.ScaleType.Fit
                    iconLbl.ZIndex = 58
                    iconLbl.Parent = iconHolder
                    task.spawn(function()
                        local lucide = loadLucide()
                        if not lucide then return end
                        local okA, asset = pcall(lucide.GetAsset, iconName)
                        if okA and asset and asset.Url then
                            if not iconLbl or not iconLbl.Parent then return end
                            iconLbl.Image = asset.Url
                            if asset.ImageRectOffset then iconLbl.ImageRectOffset = asset.ImageRectOffset iconLbl.ImageRectSize = asset.ImageRectSize end
                            TweenService:Create(iconLbl, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play()
                        end
                    end)
                end
                local txtLbl = Instance.new("TextLabel")
                txtLbl.Name = "IconTextLabel"
                txtLbl.BackgroundTransparency = 1
                if iconLbl then
                    txtLbl.AnchorPoint = Vector2.new(1, 0.5)
                    txtLbl.Position = UDim2.new(1, -Config.IconTextPadX, 0.5, 0)
                    txtLbl.TextXAlignment = Enum.TextXAlignment.Right
                else
                    txtLbl.AnchorPoint = Vector2.new(0.5, 0.5)
                    txtLbl.Position = UDim2.new(0.5, 0, 0.5, 0)
                    txtLbl.TextXAlignment = Enum.TextXAlignment.Center
                end
                txtLbl.Size = UDim2.fromOffset(tw, fatH)
                txtLbl.Text = text
                txtLbl.TextColor3 = Config.TitleColor
                txtLbl.TextTransparency = 1
                txtLbl.TextSize = textSize
                txtLbl.Font = Enum.Font.GothamBold
                txtLbl.RichText = true
                txtLbl.TextYAlignment = Enum.TextYAlignment.Center
                txtLbl.ZIndex = 57
                txtLbl.Parent = hc
                task.delay(0.12, function()
                    if txtLbl and txtLbl.Parent then
                        TweenService:Create(txtLbl, TweenInfo.new(0.26, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
                    end
                end)

                edge.AnchorPoint = Vector2.new(0.5, 0.5)
                edge.Position = islandRest
                local fatTopY = cy - Config.IslandSize.Y.Offset / 2
                animateEdge(
                    UDim2.new(0, targetW, 0, fatH),
                    UDim2.new(0.5, cx, 0, fatTopY + fatH / 2),
                    Config.IconTextGrowTime,
                    0
                )
                TweenService:Create(corner, TweenInfo.new(Config.IconTextGrowTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    CornerRadius = UDim.new(0, fatH / 2),
                }):Play()
                TweenService:Create(fillCorner, TweenInfo.new(Config.IconTextGrowTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    CornerRadius = UDim.new(0, fatH / 2),
                }):Play()
                edgeBusyUntil = os.clock() + Config.IconTextGrowTime + Config.IconTextHoldTime + Config.IconTextRestoreTime + 0.35

                task.delay(Config.IconTextHoldTime, function()

                    iconTextBusy = false
                    if not alive or shutdown then
                        if hc and hc.Parent then hc:Destroy() end
                        iconTextHc = nil
                        return
                    end
                    if hc and hc.Parent then hc:Destroy() end
                    iconTextHc = nil
                    if expanded then
                        return
                    end

                    animateEdge(Config.IslandSize, islandRest, Config.IconTextRestoreTime, 0)
                    TweenService:Create(corner, TweenInfo.new(Config.IconTextRestoreTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        CornerRadius = Config.IslandCornerRadius,
                    }):Play()
                    TweenService:Create(fillCorner, TweenInfo.new(Config.IconTextRestoreTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        CornerRadius = Config.IslandCornerRadius,
                    }):Play()

                    setIslandText(islandTextOverride or title, Config.TitleColor)
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do
                        local lb = cf:FindFirstChildOfClass("TextLabel")
                        if lb then TweenService:Create(lb, TweenInfo.new(Config.IconTextRestoreTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() end
                    end

                    if wasExpanded then
                        task.delay(Config.IconTextGrowTime, function()

                            if not alive or shutdown then return end
                            if expanded then

                                if lastPanelLayout then
                                    buildTabUI(lastPanelLayout)
                                    buildCloseButton(function() showCloseConfirm() end)
                                    if buildSwitchButton then buildSwitchButton() end
                                    buildHeaderDecor()
                                end
                                return
                            end
                            if expandPanelRef then expandPanelRef() end
                        end)
                    end
                end)
            end

            iconTextPlayer = playIconTextAnimation

            local function buildCharLabel(ch, color, size)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 0, 1, 0)
                frame.AutomaticSize = Enum.AutomaticSize.X
                frame.BackgroundTransparency = 1
                frame.BorderSizePixel = 0
                local lb = Instance.new("TextLabel")
                lb.Size = UDim2.new(1, 0, 1, 0)
                lb.BackgroundTransparency = 1
                lb.Text = ch
                lb.TextColor3 = color
                lb.TextTransparency = 1
                lb.TextSize = size
                lb.Font = charFont(ch)
                lb.TextXAlignment = Enum.TextXAlignment.Center
                lb.TextYAlignment = Enum.TextYAlignment.Center
                lb.Parent = frame
                return frame, lb
            end

            playToggleStateAnimation = function()
                if not alive or not ready or shutdown then lastToggleInfo = nil return end
                if toggleAnimBusy or iconTextBusy or hintActive then lastToggleInfo = nil return end
                local info = lastToggleInfo
                if not info then return end

                lastToggleInfo = nil
                local on = info.Value == true
                local stateColor = on and Config.ToggleIslandOnColor or Config.ToggleIslandOffColor
                local stateText = on and "已开启" or "已关闭"
                local titleText = info.Title or "Toggle"

                local function addToggleSpacer(parent, order, w)
                    local sp = Instance.new("Frame")
                    sp.Name = "ToggleStateSpacer"
                    sp.BackgroundTransparency = 1
                    sp.BorderSizePixel = 0
                    sp.Size = UDim2.new(0, w, 1, 0)
                    sp.LayoutOrder = order
                    sp.ZIndex = 56
                    sp.Parent = parent
                end

                toggleAnimBusy = true
                toggleAnimGen = toggleAnimGen + 1
                local myGen = toggleAnimGen
                local function stale() return myGen ~= toggleAnimGen or not alive or shutdown end

                if actionBusy and actionEnd then actionEnd(true) end

                local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2

                local iconSize = Config.ToggleIslandIconSize
                local textSize = Config.ToggleIslandTextSize
                local iconW = (info.Icon and info.Icon ~= "") and iconSize or 0
                local gap = Config.ToggleIslandGap
                local titleW = measureTextWidth(titleText, textSize)
                local stateW = measureTextWidth(stateText, textSize)
                local inner = iconW + (iconW > 0 and gap or 0) + titleW + gap + stateW
                local targetW = math.max(Config.ToggleIslandMinW, inner + Config.ToggleIslandPadX * 2)

                edge.AnchorPoint = Vector2.new(0.5, 0.5)
                edge.Position = islandRest
                animateEdge(
                    UDim2.new(0, targetW, 0, Config.IslandSize.Y.Offset),
                    UDim2.new(0.5, cx, 0, cy),
                    Config.ToggleIslandGrowTime,
                    0
                )
                edgeBusyUntil = os.clock() + Config.ToggleIslandGrowTime + Config.ToggleIslandHoldTime + Config.ToggleIslandRestoreTime + 1.5

                if islandTextContainer and islandTextContainer.Parent then
                    for _, cf in ipairs(islandTextContainer:GetChildren()) do
                        local lb = cf:FindFirstChildOfClass("TextLabel")
                        if lb then TweenService:Create(lb, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
                    end
                end

                local hc = Instance.new("Frame")
                hc.Name = "IslandToggleContainer"
                hc.Size = UDim2.new(1, 0, 1, 0)
                hc.BackgroundTransparency = 1
                hc.BorderSizePixel = 0
                hc.ClipsDescendants = true
                hc.ZIndex = 56
                hc.Parent = edge
                toggleAnimContainer = hc
                local hl = Instance.new("UIListLayout")
                hl.FillDirection = Enum.FillDirection.Horizontal

                hl.HorizontalAlignment = Enum.HorizontalAlignment.Center
                hl.VerticalAlignment = Enum.VerticalAlignment.Center
                hl.SortOrder = Enum.SortOrder.LayoutOrder

                hl.Padding = UDim.new(0, 0)
                hl.Parent = hc

                local bothPad = Instance.new("UIPadding")
                bothPad.PaddingLeft = UDim.new(0, Config.ToggleIslandPadX)
                bothPad.PaddingRight = UDim.new(0, Config.ToggleIslandPadX)
                bothPad.Parent = hc

                local step = Config.ToggleIslandStepTime
                local revealT = Config.ToggleIslandRevealTime
                local fadeT = Config.ToggleIslandFadeTime

                local revealList, fadeList = {}, {}

                if iconW > 0 then
                    local iconImg, iconRectOff, iconRectSize = nil, nil, nil
                    if iconW > 0 then
                        task.spawn(function()
                            local lucide = loadLucide()
                            if not lucide then return end
                            local okA, asset = pcall(lucide.GetAsset, info.Icon)
                            if okA and asset and asset.Url then
                                iconImg = asset.Url
                                iconRectOff = asset.ImageRectOffset
                                iconRectSize = asset.ImageRectSize
                            end
                        end)
                    end

                    local ic = Instance.new("ImageLabel")
                    ic.Name = "ToggleStateIcon"
                    ic.BackgroundTransparency = 1
                    ic.Size = UDim2.fromOffset(iconSize, iconSize)
                    ic.ImageColor3 = stateColor
                    ic.ImageTransparency = 1
                    ic.ScaleType = Enum.ScaleType.Fit
                    ic.LayoutOrder = 1
                    ic.ZIndex = 57
                    ic.Parent = hc
                    if iconImg then
                        ic.Image = iconImg
                        if iconRectOff then ic.ImageRectOffset = iconRectOff ic.ImageRectSize = iconRectSize end
                    end

                    table.insert(revealList, { obj = ic, dist = 0, waitImg = true })
                    table.insert(fadeList, { obj = ic, dist = 0 })

                    addToggleSpacer(hc, 1.5, gap)
                end

                do
                    local titleItems = {}
                    for _, item in ipairs(parseColoredChars(titleText, Config.TitleColor)) do
                        if item.ch ~= " " then titleItems[#titleItems + 1] = item end
                    end
                    local n = #titleItems
                    for i, item in ipairs(titleItems) do
                        local frame, lb = buildCharLabel(item.ch, Config.TitleColor, textSize)
                        frame.LayoutOrder = 2
                        frame.ZIndex = 57
                        frame.Parent = hc
                        local dist = math.abs(i - (n + 1) / 2)
                        table.insert(revealList, { obj = lb, dist = dist })
                        table.insert(fadeList, { obj = lb, dist = dist })
                    end

                    addToggleSpacer(hc, 2.5, gap)
                end

                do
                    local stateItems = {}
                    for _, item in ipairs(parseColoredChars(stateText, stateColor)) do
                        if item.ch ~= " " then stateItems[#stateItems + 1] = item end
                    end
                    local n = #stateItems
                    for i, item in ipairs(stateItems) do
                        local frame, lb = buildCharLabel(item.ch, stateColor, textSize)
                        frame.LayoutOrder = 3
                        frame.ZIndex = 57
                        frame.Parent = hc
                        local dist = math.abs(i - (n + 1) / 2)
                        table.insert(revealList, { obj = lb, dist = dist })
                        table.insert(fadeList, { obj = lb, dist = dist })
                    end
                end

                for _, e in ipairs(revealList) do
                    local isText = e.obj:IsA("TextLabel")
                    local md = math.max(e.dist, 0.001)
                    task.delay(md * step, function()
                        if stale() then return end
                        if not e.obj or not e.obj.Parent then return end
                        if e.waitImg then

                            local waited = 0
                            while e.obj.Parent and e.obj.Image == "" and waited < 0.8 do
                                task.wait(0.05)
                                waited = waited + 0.05
                            end
                            if not e.obj or not e.obj.Parent then return end
                            if e.obj.Image == "" then return end
                        end
                        if isText then
                            TweenService:Create(e.obj, TweenInfo.new(revealT, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
                        else
                            TweenService:Create(e.obj, TweenInfo.new(0.26, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play()
                        end
                    end)
                end

                task.delay(Config.ToggleIslandHoldTime, function()
                    if stale() then return end

                    local rStep = step * (Config.ToggleIslandRestoreStepScale or 1)
                    if hc and hc.Parent then

                        for _, e in ipairs(fadeList) do
                            if not e.obj or not e.obj.Parent then return end
                            local isText = e.obj:IsA("TextLabel")
                            local md = math.max(e.dist, 0.001)
                            task.delay(md * rStep, function()
                                if stale() then return end
                                if not e.obj or not e.obj.Parent then return end
                                if isText then
                                    TweenService:Create(e.obj, TweenInfo.new(fadeT, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
                                else
                                    TweenService:Create(e.obj, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
                                end
                            end)
                        end
                    end

                    animateEdge(Config.IslandSize, islandRest, Config.ToggleIslandRestoreTime, 0)

                    local totalFade = #fadeList * rStep + fadeT + 0.1
                    task.delay(totalFade, function()
                        if stale() then return end
                        if hc and hc.Parent then hc:Destroy() end

                        setIslandText(islandTextOverride or title, Config.TitleColor)
                        if islandTextContainer and islandTextContainer.Parent then

                            local restoreChars = {}
                            for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                local lb = cf:FindFirstChildOfClass("TextLabel")
                                if lb then
                                    lb.TextTransparency = 1
                                    restoreChars[#restoreChars + 1] = lb
                                end
                            end
                            local rc = #restoreChars
                            for i, lb in ipairs(restoreChars) do
                                local dist = math.abs(i - (rc + 1) / 2)
                                task.delay(dist * rStep, function()
                                    if stale() then return end
                                    if not lb or not lb.Parent then return end
                                    TweenService:Create(lb, TweenInfo.new(revealT, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
                                end)
                            end

                            task.delay(rc * rStep + revealT, function()
                                if stale() then return end
                                if toggleAnimBusy and toggleAnimContainer == hc then
                                    toggleAnimBusy = false
                                    toggleAnimContainer = nil
                                end
                            end)
                        else
                            if toggleAnimBusy and toggleAnimContainer == hc then
                                toggleAnimBusy = false
                                toggleAnimContainer = nil
                            end
                        end
                    end)
                end)
            end

            edge.InputBegan:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                if not ready then return end
                if interacting then return end
                if expanded then return end
                interacting = true
                holding = true
                dragStartX = input.Position.X

                if dragSizeTween then pcall(function() dragSizeTween:Cancel() end) dragSizeTween = nil end
                dragBaseSize = hintActive and edge.Size or Config.IslandSize
                dragging = false
                TweenService:Create(islandScale, TweenInfo.new(Config.TapExpandTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = Config.IslandTapScale }):Play()
                longPress = task.delay(Config.LongPressThreshold, function()
                        if holding then

if hintActive then clearHint(true) end

                    cancelEdgeTweens()
                    resetIslandDrag()
                    if dragSizeTween then pcall(function() dragSizeTween:Cancel() end) dragSizeTween = nil end
                    edge.AnchorPoint = Vector2.new(0.5, 0.5)
                    edge.Position = islandRest
                    edge.Size = Config.IslandSize

                    if toggleAnimBusy then cancelToggleAnim() end
                            if actionBusy and actionEnd then actionEnd(true) end
                            if iconTextBusy then clearIconTextHc(true) end
                            expanded = true
                            titleGen = titleGen + 1
                            local myTitleGen = titleGen
                            islandScale.Scale = 1

                        if islandTextContainer and islandTextContainer.Parent then
                            setIslandText(title, Config.TitleColor)
                            for _, cf in ipairs(islandTextContainer:GetChildren()) do
                                local lb = cf:FindFirstChildOfClass("TextLabel")
                                if lb then lb.TextTransparency = 1 end
                            end
                        end
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
                        local titleH = islandTextContainer.AbsoluteSize.Y
                        local infoH = Config.InfoBoxHeight
                        local vGap = Config.InfoTopGap
                        local blockH = (info ~= "") and (titleH + vGap + infoH) or titleH
                        local blockTop = top + titlePad
                        local blockCY = blockTop + blockH / 2
                        local iconLeft = m + titlePad + Config.TitleIconNudgeX
                        local contentLeftX = iconLeft + iconS + iconGap
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

                            local tipX = contentLeftX + islandTextContainer.AbsoluteSize.X / 2
                            local slide = 40
                            islandTextContainer.Position = UDim2.new(0, tipX + slide, 0, titleTargetY)
                            TweenService:Create(islandTextContainer, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0, tipX, 0, titleTargetY),
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
                        lastPanelLayout = { titlePad = titlePad, blockH = blockH, m = m, top = top, sh = sh }
                        win._rebuildTabs = function() buildTabUI(lastPanelLayout) end
                        buildHeaderDecor()
                        buildTabUI(lastPanelLayout)
                        buildCloseButton(function() showCloseConfirm() end)
                        if buildSwitchButton then buildSwitchButton() end

                        local function runCloseSequence()
                            shutdown = true
                            if closeBtn then closeBtn:Destroy() closeBtn = nil end
                            if loaderSpinTween then pcall(function() loaderSpinTween:Cancel() end) loaderSpinTween = nil end
                if titleIcon then titleIcon:Destroy() titleIcon = nil end
                            if infoLabel then infoLabel:Destroy() infoLabel = nil end
                            clearBrand()
                            destroyTabUI()
                            local cx2 = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
                            local cy2 = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2

                            if islandTextContainer and islandTextContainer.Parent then
                                TweenService:Create(islandTextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Position = UDim2.new(Config.IslandPosition.X.Scale, cx2, Config.IslandPosition.Y.Scale, cy2),
                                }):Play()
                            end

                            animateEdge(Config.IslandSize, Config.IslandPosition, 0.45, 0, function()
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
                                        unregisterLoadedWindow(title, win)
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
                                buildTabUI(lastPanelLayout)
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

local windowActionUntil = 0

local function doExpandPanel()
    if not alive or shutdown or switchDormant or not ready then return false end
    if expanded then return false end
    if hintActive then clearHint(true) end
    if actionBusy and actionEnd then actionEnd(true) end
    if toggleAnimBusy then cancelToggleAnim() end
    if iconTextBusy or (iconTextHc and iconTextHc.Parent) then
        clearIconTextHc(true)
    end

    cancelEdgeTweens()
    resetIslandDrag()
    edge.AnchorPoint = Vector2.new(0.5, 0.5)
    edge.Position = islandRest
    edge.Size = Config.IslandSize

    expanded = true
    titleGen = titleGen + 1
    local myTitleGen = titleGen
    islandScale.Scale = 1

    -- 兜底恢复面板填充背景，避免此前 _switchAway 等把 fillFrame 设为全透明后，
    -- 切换/展开时背景不显示（切换过程背景消失）
    if fillFrame and fillFrame.Parent then
        fillFrame.BackgroundTransparency = Config.IslandFinalTransparency
    end

    if islandTextContainer and islandTextContainer.Parent then
        setIslandText(title, Config.TitleColor)
        for _, cf in ipairs(islandTextContainer:GetChildren()) do
            local lb = cf:FindFirstChildOfClass("TextLabel")
            if lb then lb.TextTransparency = 1 end
        end
    end
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
    local titleH = islandTextContainer and islandTextContainer.Parent
        and islandTextContainer.AbsoluteSize.Y or Config.TitleIconSize
    local infoH = Config.InfoBoxHeight
    local vGap = Config.InfoTopGap
    local blockH = (info ~= "") and (titleH + vGap + infoH) or titleH
    local blockTop = top + titlePad
    local iconLeft = m + titlePad + Config.TitleIconNudgeX
    local contentLeftX = iconLeft + iconS + iconGap
    local titleTargetY = blockTop + titleH / 2 + Config.TitleDrop
    local infoTop = blockTop + titleH + vGap - Config.InfoRise
    win._infoY = infoTop
    local listLayout = islandTextContainer
        and islandTextContainer:FindFirstChildOfClass("UIListLayout")
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
        if suppressHeaderEntrance then return end
        if listLayout then listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left end
        local tipX = contentLeftX + islandTextContainer.AbsoluteSize.X / 2
        islandTextContainer.Position = UDim2.new(0, tipX + 40, 0, titleTargetY)
        TweenService:Create(islandTextContainer, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, tipX, 0, titleTargetY),
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

    lastPanelLayout = { titlePad = titlePad, blockH = blockH, m = m, top = top, sh = sh }
    win._rebuildTabs = function() buildTabUI(lastPanelLayout) end
    buildHeaderDecor()
    buildTabUI(lastPanelLayout)
        -- 切换/加载脚本路径（suppressHeaderEntrance 为真）下，doExpandPanel 由
        -- expandForSwitchRef 调用：buildTabUI 已自动选中首页，但内容应在「加载动画」
        -- 播放期间保持隐藏，待 playPanelContentEntrance 揭开，避免加载动画与面板内
        -- 全部 UI 元素同时出现
        if suppressHeaderEntrance and tabContentContainer and tabContentContainer.Parent then
            tabContentContainer.GroupTransparency = 1
        end
    buildCloseButton(function() if showCloseConfirm then showCloseConfirm() end end)
    if buildSwitchButton then buildSwitchButton() end
    return true
end

local function doCollapsePanel()
    if not alive or shutdown then return false end
 if not expanded then return false end
    collapsePanel()
    return true
end

win.SetWindowAction = function(self, open)
    if self ~= nil and type(self) == "table" and self ~= win and self.SetWindowAction == nil then
        open = self
    end
    if type(open) ~= "boolean" then
        reportError("SetWindowAction 参数必须是 boolean（true 展开 / false 收起），已忽略")
        return false
    end
    if not alive or shutdown then return false end
    if not ready then return false end
    if switchDormant then
        if open then
            task.spawn(function() win:_switchBack() end)
            return true
        end
        return false
    end
    if windowActionUntil > 0 and os.clock() < windowActionUntil then
        reportError("SetWindowAction 忽略：面板动画进行中，请稍后再试")
        return false
    end
    local ok
    if open then
        ok = doExpandPanel()
    else
        ok = doCollapsePanel()
    end
    if not ok then return false end

    local dur = open
        and (Config.PanelExpandTime + 0.1)
        or (Config.PanelExpandTime + 0.1)
    windowActionUntil = os.clock() + dur
    return true
end

    local function applyTabSelection(idx)
        if not idx then return false end
        win._activeTab = idx
        updateTabsHighlight()
        updateContentArea()
        animateContentIn()
        return true
    end

    local function findTabIndexByTitle(PageTitle)
        for i, tab in ipairs(win._tabs) do
            if tab.Title == PageTitle then return i end
        end
        return nil
    end

    win.GotoPage = function(self, PageName)
        if type(PageName) ~= "string" or #PageName == 0 then
            reportError("GotoPage 参数 PageName 必须是非空字符串")
            return false
        end
        if not alive or shutdown then return false end
        if switchDormant then
            task.spawn(function() win:_switchBack() end)
            return true
        end
        if not ready then return false end
        local idx = findTabIndexByTitle(PageName)
        if not idx then
            reportError("GotoPage 未找到标题为「" .. PageName .. "」的选项卡")
            return false
        end
        if not expanded then
            if not doExpandPanel() then return false end
            task.delay(Config.PanelExpandTime + Config.FadeInTime + 0.1, function()
                if not alive or shutdown or switchDormant then return end
                applyTabSelection(idx)
            end)
            return true
        end
        return applyTabSelection(idx)
    end

    local gotoCtrlLabels = {
        BtnText = true, TglText = true, ParaTitle = true, SliderTitle = true, DdTitle = true,
    }

    local function findControlLocation(FunctionName)
        for ti, tab in ipairs(win._tabs) do
            local subs = tab._subtitles or {}
            for _, st in ipairs(subs) do
                local lists = { st._buttons, st._toggles, st._paragraphs, st._sliders, st._dropdowns }
                for _, list in ipairs(lists) do
                    for _, ctrl in ipairs(list or {}) do
                        if ctrl.Title == FunctionName then return ti, st end
                    end
                end
            end
        end
        return nil
    end

    local function flashCtrlTitle(lbl)
        if not lbl or not lbl.Parent then return end
        local orig = lbl.TextColor3
        local inT = TweenInfo.new(0.06, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local outT = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local function pulse(remain)
            if not lbl or not lbl.Parent then return end
            TweenService:Create(lbl, inT, { TextColor3 = Config.RedXColor }):Play()
            task.delay(0.2, function()
                if not lbl or not lbl.Parent then return end
                TweenService:Create(lbl, outT, { TextColor3 = orig }):Play()
                if remain > 1 then task.delay(0.14, function() pulse(remain - 1) end) end
            end)
        end
        pulse(2)
    end

    local function locateCtrlAndFlash(FunctionName, st)
        if not tabSubtitleList or not tabSubtitleList.Parent then return end
        local target = nil
        for _, d in ipairs(tabSubtitleList:GetDescendants()) do
            if d:IsA("TextLabel") and gotoCtrlLabels[d.Name] and d.Text == FunctionName then
                target = d
                break
            end
        end
        if not target then return end
        local block = target:FindFirstAncestor("SubBlock")
        local didExpand = false
        if st and st.collapsed and block and block.Parent then
            st.collapsed = false
            didExpand = true
            local body = block:FindFirstChild("SubBody")
            if body then
                local fullH = body.Position.Y.Offset + body.Size.Y.Offset
                TweenService:Create(block, TweenInfo.new(Config.SubTitleCollapseTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, fullH),
                }):Play()
            end
            local arrow = block:FindFirstChild("SubArrow")
            if arrow then
                TweenService:Create(arrow, TweenInfo.new(Config.SubTitleCollapseTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
            end
        end
        if didExpand then task.wait(Config.SubTitleCollapseTime + 0.05) end
        if not target.Parent then return end
        local scroll = tabContentContainer and tabContentContainer:FindFirstChild("TabScroll")
        local content = scroll and scroll:FindFirstChild("TabSubtitleList")
        if scroll and content then
            local viewH = scroll.AbsoluteSize.Y
            if viewH > 0 then
                local maxY = math.max(0, math.max(scroll.CanvasSize.Y.Offset, content.AbsoluteSize.Y) - viewH)
                local targetY = math.clamp(target.AbsolutePosition.Y - scroll.AbsolutePosition.Y - viewH * 0.35, 0, maxY)
                TweenService:Create(scroll, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    CanvasPosition = Vector2.new(0, targetY),
                }):Play()
            end
        end
        task.delay(0.4, function() flashCtrlTitle(target) end)
    end

    local function afterContentSettled(fn)
        task.spawn(function()
            task.wait(Config.PageAnimTime + 0.05)
            RunService.Heartbeat:Wait()
            RunService.Heartbeat:Wait()
            if not alive or shutdown then return end
            pcall(fn)
        end)
    end

    win.GotoFunction = function(self, FunctionName)
        if type(FunctionName) ~= "string" or #FunctionName == 0 then
            reportError("GotoFunction 参数 FunctionName 必须是非空字符串")
            return false
        end
        if not alive or shutdown then return false end
        if switchDormant then
            task.spawn(function() win:_switchBack() end)
            return true
        end
        if not ready then return false end
        local ti, st = findControlLocation(FunctionName)
        if not ti then
            reportError("GotoFunction 未找到标题为「" .. FunctionName .. "」的控件")
            return false
        end
        if not expanded then
            if not doExpandPanel() then return false end
            task.delay(Config.PanelExpandTime + Config.FadeInTime + 0.1, function()
                if not alive or shutdown or switchDormant then return end
                if applyTabSelection(ti) then
                    afterContentSettled(function() locateCtrlAndFlash(FunctionName, st) end)
                end
            end)
            return true
        end
        if applyTabSelection(ti) then
            afterContentSettled(function() locateCtrlAndFlash(FunctionName, st) end)
        end
        return true
    end
            edge.InputEnded:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                if not interacting then return end
                holding = false
                local wasDragging = dragging
                if longPress then safeCancel(longPress) longPress = nil end
                resetIslandDrag()
                if expanded then
                    interacting = false
                else
                    TweenService:Create(islandScale, TweenInfo.new(Config.TapShrinkTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = 1 }):Play()
                    if hintActive then
                        clearHint()
                    elseif not wasDragging then

                        registerIslandTap()
                    end
                    interacting = false
                end
            end)

local function makeSwitchLoader(text)
       local box = Instance.new("Frame")
        box.Name = "SwitchLoaderBox"
        -- 覆盖整个内容区的不透明深色遮罩：避免切换时旧控件从透明背景透出，
        -- 让 loader 表现为干净的加载态而非叠在旧控件之上
        box.BackgroundColor3 = Color3.new(0, 0, 0)
        box.BackgroundTransparency = 0
        box.AnchorPoint = Vector2.new(0.5, 0.5)
        box.Size = UDim2.new(1, 0, 1, 0)
        box.Position = UDim2.new(0.5, 0, 0.5, 0)
        box.ZIndex = 75
        box.Parent = contentRoot
        -- 蒙版需与面板同圆角，否则黑底矩形会露出面板圆角之外
        local boxCorner = Instance.new("UICorner")
        boxCorner.CornerRadius = UDim.new(0, Config.SwitchLoaderCorner)
        boxCorner.Parent = box

    local ic = Instance.new("ImageLabel")
        ic.Name = "SwitchLoaderIcon"
        ic.AnchorPoint = Vector2.new(0.5, 0.5)
        ic.Size = UDim2.fromOffset(46, 46)
        ic.Position = UDim2.new(0.5, 0, 0.5, -20)
        ic.BackgroundTransparency = 1
        ic.ImageColor3 = Color3.new(1, 1, 1)
        ic.ImageTransparency = 0
        ic.ScaleType = Enum.ScaleType.Fit
        ic.ZIndex = 76
        ic.Parent = box
        local spin = nil
        local asset = getLucideIcon(Config.TitleLoaderIcon)
        if asset then
 ic.Image = asset.Url
  if asset.ImageRectOffset then
   ic.ImageRectOffset = asset.ImageRectOffset
        ic.ImageRectSize = asset.ImageRectSize
     end
   end
        spin = TweenService:Create(ic, TweenInfo.new(
            Config.TitleLoaderSpinTime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false
        ), { Rotation = 360 })
        spin:Play()

        local lbl = Instance.new("TextLabel")
        lbl.Name = "SwitchLoaderText"
        lbl.AnchorPoint = Vector2.new(0.5, 0)
        lbl.Size = UDim2.new(1, 0, 0, 26)
        lbl.Position = UDim2.new(0.5, 0, 0.5, 14)
        lbl.BackgroundTransparency = 1
        lbl.Text = tostring(text or "")
        lbl.TextColor3 = Config.SwitchDropdownTextColor
        lbl.TextSize = 17
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Center
      lbl.TextYAlignment = Enum.TextYAlignment.Center
        lbl.TextTransparency = 0
  lbl.ZIndex = 76
        lbl.Parent = box

        return box, ic, lbl, spin
    end

    local function fadeAllPanelItems(t, dur)
        dur = dur or Config.SwitchFadeOutTime
        local ti = TweenInfo.new(dur, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        if islandTextContainer and islandTextContainer.Parent then
        for _, cf in ipairs(islandTextContainer:GetChildren()) do
    local lb = cf:FindFirstChildOfClass("TextLabel")
    if lb then TweenService:Create(lb, ti, { TextTransparency = t }):Play() end
       end
    end
     if titleIcon then TweenService:Create(titleIcon, ti, { ImageTransparency = t }):Play() end
  if infoLabel then TweenService:Create(infoLabel, ti, { TextTransparency = t }):Play() end
        if closeBtn then
            TweenService:Create(closeBtn, ti, { ImageTransparency = t }):Play()
   closeBtn.Active = (t == 0)
     end
        if switchBtn then
  TweenService:Create(switchBtn, ti, { ImageTransparency = t }):Play()
      switchBtn.Active = (t == 0)
        end
   if headerDivider then
TweenService:Create(headerDivider, ti, { BackgroundTransparency = t }):Play()
        end
  if tabSeparator then
            TweenService:Create(tabSeparator, ti, { BackgroundTransparency = t }):Play()
        end
  if tabListContainer then
            TweenService:Create(tabListContainer, ti, { BackgroundTransparency = t }):Play()
        end
        if tabContentContainer then
            TweenService:Create(tabContentContainer, ti, { GroupTransparency = t }):Play()
end
  if tabEmptyLabel then
 TweenService:Create(tabEmptyLabel, ti, { TextTransparency = t }):Play()
      end
        if tabListContainer then
            for _, row in ipairs(tabListContainer:GetChildren()) do
                if row:IsA("TextButton") then
                    local sel = row:FindFirstChild("TabSel")
                    if sel then
                        for _, st in ipairs(sel:GetChildren()) do
                            if st:IsA("UIStroke") then TweenService:Create(st, ti, { Transparency = t }):Play() end
                        end
                    end
                end
            end
        end
    end

    local function playPanelContentEntrance()
        if not alive or shutdown or not expanded then return end
        suppressHeaderEntrance = false
        if lastPanelLayout then
   buildTabUI(lastPanelLayout)
buildHeaderDecor()
       buildCloseButton(function() if showCloseConfirm then showCloseConfirm() end end)
     buildSwitchButton()
      end
        local myGen = titleGen
        cancelTitleTweens()
        local listLayout = islandTextContainer and islandTextContainer.Parent
       and islandTextContainer:FindFirstChildOfClass("UIListLayout")
        task.delay(Config.FadeInTime, function()
if not expanded or myGen ~= titleGen then return end
          if listLayout then listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left end
            if islandTextContainer and islandTextContainer.Parent then
   local lx = (win._titleLeftX or 0) + islandTextContainer.AbsoluteSize.X / 2
   local ly = win._titleY or 0
    islandTextContainer.Position = UDim2.new(0, lx + 40, 0, ly)
     TweenService:Create(islandTextContainer, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
      Position = UDim2.new(0, lx, 0, ly),
         }):Play()
        for _, cf in ipairs(islandTextContainer:GetChildren()) do
    local lb = cf:FindFirstChildOfClass("TextLabel")
         if lb then
     local tw = TweenService:Create(lb, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 })
     table.insert(titleTweens, tw)
    tw:Play()
       end
   end
     end
      task.delay(Config.InfoEnterDelay, function()
      if not expanded or myGen ~= titleGen then return end
    if infoLabel and infoLabel.Parent then
   local ix = win._titleLeftX or 0
     local iy = win._infoY or (((lastPanelLayout and lastPanelLayout.top or 0)
              + (lastPanelLayout and lastPanelLayout.titlePad or 0)
     + (lastPanelLayout and lastPanelLayout.blockH or 0))
     - Config.InfoBoxHeight - Config.InfoRise)
    -- 关键：显式设置入场起点（右侧偏移 + 全透明），
    -- 否则切换后 infoLabel 会卡在重建时的初始位置，表现为文字右偏移
    infoLabel.TextTransparency = 1
    infoLabel.Position = UDim2.new(0, ix + 40, 0, iy)
    TweenService:Create(infoLabel, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
  Position = UDim2.new(0, ix, 0, iy),
        TextTransparency = 0,
        }):Play()
      end
     end)
        end)
    end

    local function playSwitchSequence(loadingText)
        if not alive or shutdown or switchDormant then return end
        if not expanded then return end

        fadeAllPanelItems(1)
    task.delay(Config.SwitchFadeOutTime, function()
     if not alive or shutdown or switchDormant or not expanded then
            if islandTextContainer and islandTextContainer.Parent then
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then lb.TextTransparency = 0 end
                end
            end
            return
        end

      local box, ic, lbl, spin = makeSwitchLoader(loadingText or Config.SwitchLoadingText)
      box.Parent = contentRoot
        ic.Rotation = 0
            TweenService:Create(ic, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Rotation = 360 }):Play()

       task.delay(Config.SwitchHoldTime, function()
      if not alive or shutdown or not expanded then
        if spin then pcall(function() spin:Cancel() end) end
       if box and box.Parent then box:Destroy() end
       if islandTextContainer and islandTextContainer.Parent then
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then lb.TextTransparency = 0 end
                end
            end
          return
   end

      -- 在 loader 仍不透明时，先把新内容 build + 揭开到 loader 之下，
      -- 这样 loader 淡出时背后已是完整新界面，避免「加载结束空一帧 / 旧 UI 闪现」
      playPanelContentEntrance()

      if ic then TweenService:Create(ic, TweenInfo.new(Config.SwitchLoaderFadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play() end
if lbl then TweenService:Create(lbl, TweenInfo.new(Config.SwitchLoaderFadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() end
if box then TweenService:Create(box, TweenInfo.new(Config.SwitchLoaderFadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play() end
                if spin then task.delay(Config.SwitchLoaderFadeTime, function() pcall(function() spin:Cancel() end) end) end
            task.delay(Config.SwitchLoaderFadeTime, function()
   if not alive or shutdown then return end
         if box and box.Parent then box:Destroy() end
       if not expanded then
            if islandTextContainer and islandTextContainer.Parent then
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then lb.TextTransparency = 0 end
                end
            end
            return
        end
         end)
       end)
        end)
    end

    playSwitchSequenceRef = playSwitchSequence

    expandForSwitchRef = function()
        if not alive or shutdown then return end
        task.wait(0.05)
        suppressHeaderEntrance = true
        if not doExpandPanel() then
            suppressHeaderEntrance = false
            return
        end

        task.delay(Config.PanelExpandTime + Config.FadeInTime + Config.InfoEnterDelay, function()
            playSwitchSequence(Config.SwitchLoadingText)
        end)
    end

    expandPanelRef = doExpandPanel
    restorePanelRef = function()
        if not alive or shutdown or not expanded then return end
        if closeDialog and closeDialog.Parent then closeDialog:Destroy() end
        closeDialog = nil
        titleGen = titleGen + 1
        suppressHeaderEntrance = false
        islandScale.Scale = 1
        local sw2 = screenGui.AbsoluteSize.X
        local sh2 = screenGui.AbsoluteSize.Y
        local m2 = Config.PanelMargin
        local top2 = Config.IslandPosition.Y.Offset + Config.PanelDrop
        cancelEdgeTweens()
        cancelChromeTweens()
        if fillFrame and fillFrame.Parent then
            chromeTween(fillFrame, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = Config.IslandFinalTransparency,
            })
        end
        chromeTween(silverStroke, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = Config.TargetTransparency,
        })
        -- 确保白色扫光边框回到隐藏态：扫光结束本应自动复位，此处兜底，
        -- 避免切换/恢复后残留白色描边或边框整体不可见（切换过程边框消失）
        if stroke then stroke.Transparency = 1 end
        edge.AnchorPoint = Vector2.new(0, 0)
        edge.Position = UDim2.new(0, m2, 0, top2)
        edge.Size = UDim2.new(0, sw2 - m2 * 2, 0, sh2 - top2 - m2)
        -- 切回时把标题重设为真实脚本标题，避免停留在默认折叠态「DynamicCow」绿色文案
        setIslandText(title, Config.TitleColor)
        setHeaderVisible(true)
        winOpen = true
        -- 由 playPanelContentEntrance 统一负责重建面板 + 播放标题/Info 左移渐显入场动画，
        -- 避免 Info 卡在重建后的初始位置（表现为文字右偏移）
        playPanelContentEntrance()
    end

      if afterSetup then task.spawn(afterSetup) end
end

    task.delay(Config.ShrinkDelay, function()
        flowSpeed = Config.FlowSpeed
        gradient.Color = rainbowColors

        if switchingFrom ~= nil then
            local oldWin = loadedWindows[switchingFrom]
            if oldWin and type(oldWin) == "table" and oldWin._switchAway then
                pcall(function() oldWin:_switchAway(Config.SwitchTitleMoveTime) end)
            end
            local fi = Config.FadeInTime
            TweenService:Create(fillFrame, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = Config.IslandFinalTransparency,
            }):Play()
            TweenService:Create(silverStroke, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = Config.TargetTransparency,
            }):Play()
            local function startSwitchEntry()
                if not alive or switchDormant then return end
                if not runIslandEntrySetup then return end
                runIslandEntrySetup(function()
                    if switchDormant then return end
                    if islandTextContainer and islandTextContainer.Parent then
                        setIslandText(title, Config.TitleColor)
                        for _, cf in ipairs(islandTextContainer:GetChildren()) do
                            local lb = cf:FindFirstChildOfClass("TextLabel")
                            if lb then lb.TextTransparency = 1 end
                        end
                        for _, cf in ipairs(islandTextContainer:GetChildren()) do
                            local lb = cf:FindFirstChildOfClass("TextLabel")
                            if lb then
                                TweenService:Create(lb, TweenInfo.new(fi, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
                            end
                        end
                    end
                    task.delay(fi + 0.15, function()
                        if not alive or switchDormant then return end
                        if autoExpandForSwitch then autoExpandForSwitch() end
                    end)
                end)
            end
            task.delay(fi * 0.6, function()
                if not alive then return end
                if switchDormant then
                    while alive and switchDormant do
                        task.wait(0.2)
                    end
                end
                startSwitchEntry()
            end)
            return
        end

        local shrinkTween = edgeTween(TweenInfo.new(
            Config.ShrinkTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
        ), {
            Size = Config.IslandSize,
            Position = Config.IslandPosition,
        })
        TweenService:Create(corner, TweenInfo.new(
            Config.ShrinkTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out
        ), {
            CornerRadius = Config.IslandCornerRadius,
        }):Play()
        TweenService:Create(fillCorner, TweenInfo.new(
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
                if runIslandEntrySetup then runIslandEntrySetup() end
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
                _dropdowns = {},
                _lines = {},
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
                bt._seq = (self3._seq or 0) + 1
                self3._seq = bt._seq
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
                    if topts.ConfigKey ~= nil and (type(topts.ConfigKey) ~= "string" or #topts.ConfigKey == 0) then error("AddToggle ConfigKey 非法") end
                end)
                if not ok4 then
                    reportError("AddToggle 异常: " .. tostring(em4))
                    win:Error()
                    return nil
                end
                if topts.ConfigKey ~= nil and not win._configFolder then
                    reportError("AddToggle 异常: 设置了 ConfigKey 但未在 CreateWindow 设置 Folder")
                    win:Error("缺少Folder Config保存失败")
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
                    ConfigKey = topts.ConfigKey,
                }
                tg.Set = function(self4, v)
                    self4.Value = v and true or false
                    if self4.ConfigKey then win._cfgSave(win, self4.ConfigKey, self4.Value) end
                    if win._rebuildTabs then win._rebuildTabs() end
                end
                tg.GetValue = function(self4)
                    return self4.Value
                end
                if tg.ConfigKey then
                    tg._cfgGet = function(self4) return self4.Value end
                    tg._cfgSet = function(self4, v) self4:Set(v == true) end
                    win._cfgIndex[tg.ConfigKey] = tg
                end
                tg._seq = (self3._seq or 0) + 1
                self3._seq = tg._seq
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
                    refreshParagraphHeight(self4)
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
                pg._seq = (self3._seq or 0) + 1
                self3._seq = pg._seq
                table.insert(self3._paragraphs, pg)
                if win._rebuildTabs then win._rebuildTabs() end
                return pg
            end

            st.AddLine = function(self3, a, b)
                local lopts = {}
                if typeof(a) == "Color3" then
                    lopts.Color = a
                elseif type(a) == "table" then
                    lopts = a
                elseif a ~= nil then
                    reportError("AddLine 异常:第一个参数应为 Color3 或 table")
                    win:Error()
                    return nil
                end
                local okL, emL = pcall(function()
                    if type(lopts) ~= "table" then error("AddLine 入参不是 table") end
                    if lopts.Color ~= nil and typeof(lopts.Color) ~= "Color3" then error("AddLine Color 非法") end
                    if lopts.Thickness ~= nil and type(lopts.Thickness) ~= "number" then error("AddLine Thickness 非法") end
                    if lopts.Inset ~= nil and type(lopts.Inset) ~= "number" then error("AddLine Inset 非法") end
                end)
                if not okL then
                    reportError("AddLine 异常: " .. tostring(emL))
                    win:Error()
                    return nil
                end
                local ln = {
                    Color = lopts.Color,
                    Thickness = lopts.Thickness,
                    Inset = lopts.Inset,
                }

                ln.SetColor = function(self5, v)
                    if typeof(v) == "Color3" then
                        self5.Color = v
                        if self5._bar and self5._bar.Parent then self5._bar.BackgroundColor3 = v end
                    end
                end
                ln.SetThickness = function(self5, v)
                    if type(v) == "number" and v >= 0 then
                        self5.Thickness = v
                        if self5._bar and self5._bar.Parent then
                            self5._bar.Size = UDim2.new(1, -((self5.Inset or Config.LineInset) * 2), 0, v)
                        end
                    end
                end
                ln.SetInset = function(self5, v)
                    if type(v) == "number" and v >= 0 then
                        self5.Inset = v
                        if self5._bar and self5._bar.Parent then
                            self5._bar.Size = UDim2.new(1, -(v * 2), 0, self5.Thickness or Config.LineThickness)
                            self5._bar.Position = UDim2.new(0, v, 0.5, 0)
                        end
                    end
                end

                ln.Destroy = function(self5)
                    if self5._bar and self5._bar.Parent then self5._bar:Destroy() end
                    if self5._row and self5._row.Parent then self5._row:Destroy() end
                    if self3._lines then
                        for i, v in ipairs(self3._lines) do
                            if v == self5 then
                                table.remove(self3._lines, i)
                                break
                            end
                        end
                    end
                    if win._rebuildTabs then win._rebuildTabs() end
                end
                ln._seq = (self3._seq or 0) + 1
                self3._seq = ln._seq
                table.insert(self3._lines, ln)
                if win._rebuildTabs then win._rebuildTabs() end
                return ln
            end
            st.AddSlider = function(self3, a, b, c, d, e, f)
                local sopts
                if type(a) == "table" then
                    sopts = a
                else
                    sopts = { Title = a, Degree = b, MinValue = c, MaxValue = d, FillColor = e, Default = f }
                end
                sopts = sopts or {}
                local ok5, em5 = pcall(function()
                    if type(sopts) ~= "table" then error("AddSlider 入参不是 table") end
                    if sopts.Title == nil or type(sopts.Title) ~= "string" or #sopts.Title == 0 then error("AddSlider Title 非法") end
                    if sopts.Degree ~= nil and type(sopts.Degree) ~= "number" then error("AddSlider Degree 非法") end
                    if sopts.MinValue == nil or type(sopts.MinValue) ~= "number" then error("AddSlider MinValue 非法") end
                    if sopts.MaxValue == nil or type(sopts.MaxValue) ~= "number" then error("AddSlider MaxValue 非法") end
                    if sopts.MinValue >= sopts.MaxValue then error("AddSlider MinValue 必须小于 MaxValue") end
                    if sopts.FillColor ~= nil and typeof(sopts.FillColor) ~= "Color3" then error("AddSlider FillColor 非法") end
                    if sopts.Value ~= nil and type(sopts.Value) ~= "number" then error("AddSlider Value 非法") end
                    if sopts.Default ~= nil and type(sopts.Default) ~= "number" then error("AddSlider Default 非法") end
                    if sopts.ConfigKey ~= nil and (type(sopts.ConfigKey) ~= "string" or #sopts.ConfigKey == 0) then error("AddSlider ConfigKey 非法") end
                end)
                if not ok5 then
                    reportError("AddSlider 异常: " .. tostring(em5))
                    win:Error()
                    return nil
                end
                if sopts.ConfigKey ~= nil and not win._configFolder then
                    reportError("AddSlider 异常: 设置了 ConfigKey 但未在 CreateWindow 设置 Folder")
                    win:Error("缺少Folder Config保存失败")
                    return nil
                end
                local sl = {
                    Title = sopts.Title,
                    Degree = sopts.Degree or 1,
                    MinValue = sopts.MinValue,
                    MaxValue = sopts.MaxValue,
                    FillColor = sopts.FillColor,
                    Value = nil,
                    OnChanged = sopts.OnChanged,
                    ConfigKey = sopts.ConfigKey,
                }
                local initV = sopts.Default
                if initV == nil then initV = sopts.Value end
                if initV == nil then initV = (sl.MinValue + sl.MaxValue) / 2 end
                if sl.Degree > 0 then
                    initV = sl.MinValue + math.floor((initV - sl.MinValue) / sl.Degree + 0.5) * sl.Degree
                end
                if initV < sl.MinValue then initV = sl.MinValue elseif initV > sl.MaxValue then initV = sl.MaxValue end
                sl.Value = initV
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
                    if self4.ConfigKey then win._cfgSave(win, self4.ConfigKey, self4.Value) end
                    if type(self4.OnChanged) == "function" then
                        local okC, errC = pcall(self4.OnChanged, self4.Value, self4)
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
                        if self4._valueLbl and self4._valueLbl.Parent then
                            self4._valueLbl.Position = UDim2.new(0, tw + 2, 0, 0)
                        end
                        if self4._track and self4._track.Parent then
                            local trackX = tw + 2 + Config.SliderValueW + Config.SliderTitleGap
                            self4._track.Position = UDim2.new(0, trackX, 0, Config.SliderTrackVPad)
                            self4._track.Size = UDim2.new(1, -trackX, 1, -Config.SliderTrackVPad * 2)
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
                if sl.ConfigKey then
                    sl._cfgGet = function(self4) return self4.Value end
                    sl._cfgSet = function(self4, v) self4:SetValue(v) end
                    win._cfgIndex[sl.ConfigKey] = sl
                end
                sl._seq = (self3._seq or 0) + 1
                self3._seq = sl._seq
                table.insert(self3._sliders, sl)
                if win._rebuildTabs then win._rebuildTabs() end
                return sl
            end
            st.AddDropdown = function(self3, a, b, c, d2, e)
                local dopts
                if type(a) == "table" then
                    dopts = a
                else
                    dopts = { Title = a, Multiple = b, Value = c, DefaultValue = d2, ConfigKey = e }
                end
                dopts = dopts or {}
                local okD, emD = pcall(function()
                    if type(dopts) ~= "table" then error("AddDropdown 入参不是 table") end
                    if dopts.Title == nil or type(dopts.Title) ~= "string" or #dopts.Title == 0 then error("AddDropdown Title 非法") end
                    if dopts.Multiple ~= nil and type(dopts.Multiple) ~= "boolean" then error("AddDropdown Multiple 非法") end
                    if type(dopts.Value) ~= "table" then error("AddDropdown Value 必须是条目数组") end
                    if dopts.DefaultValue ~= nil and type(dopts.DefaultValue) ~= "string" and type(dopts.DefaultValue) ~= "table" then error("AddDropdown DefaultValue 非法") end
                    if dopts.ConfigKey ~= nil and (type(dopts.ConfigKey) ~= "string" or #dopts.ConfigKey == 0) then error("AddDropdown ConfigKey 非法") end
                end)
                if not okD then
                    reportError("AddDropdown 异常: " .. tostring(emD))
                    win:Error()
                    return nil
                end
                if dopts.ConfigKey ~= nil and not win._configFolder then
                    reportError("AddDropdown 异常: 设置了 ConfigKey 但未在 CreateWindow 设置 Folder")
                    win:Error("缺少Folder Config保存失败")
                    return nil
                end
                local options = {}
                for _, v in ipairs(dopts.Value) do
                    if type(v) == "string" then options[#options + 1] = v end
                end
                local dd = {
                    Title = dopts.Title,
                    Multiple = dopts.Multiple == true,
                    Options = options,
                    Selected = dopts.DefaultValue,
                    ConfigKey = dopts.ConfigKey,
                    OnChanged = dopts.OnChanged,
                }
                dd.GetSelected = function(self4) return self4.Selected end
                dd.GetValue = function(self4) return self4.Selected end
                dd.SetSelected = function(self4, v)
                    if self4.Multiple then
                        self4.Selected = (type(v) == "table") and v or {}
                    else
                        self4.Selected = (type(v) == "string" and v) or nil
                    end
                    if self4._refreshCapsule then self4._refreshCapsule() end
                    if self4.ConfigKey then win._cfgSave(win, self4.ConfigKey, self4.Selected) end
                    if self4._menuScroll then
                        for _, ob in ipairs(self4._menuScroll:GetChildren()) do
                            if ob:IsA("TextButton") then
                                local on
                                if self4.Multiple then
                                    on = false
                                    for _, s in ipairs(self4.Selected) do if s == ob:GetAttribute("OptName") then on = true break end end
                                else
                                    on = (self4.Selected == ob:GetAttribute("OptName"))
                                end
                                local hi = ob:FindFirstChild("DdSelHi")
                                if hi then
                                    hi.BackgroundTransparency = on and 0 or 1
                                else
                                    ob.BackgroundColor3 = on and Config.DropdownOptionSelected or Config.DropdownMenuFill
                                end
                            end
                        end
                    end
                    if type(self4.OnChanged) == "function" then
                        local okC, errC = pcall(self4.OnChanged, self4.Selected, self4)
                        if not okC then reportError("AddDropdown OnChanged 报错: " .. tostring(errC)) end
                    end
                end
                dd.SetOptions = function(self4, list)
                    if type(list) == "table" then
                        self4.Options = {}
                        for _, v in ipairs(list) do if type(v) == "string" then self4.Options[#self4.Options + 1] = v end end
                        if self4._refreshCapsule then self4._refreshCapsule() end
                    end
                end
                dd.SetTitle = function(self4, v)
                    self4.Title = v and tostring(v) or ""
                    if self4._titleLbl and self4._titleLbl.Parent then self4._titleLbl.Text = self4.Title end
                end
                if dd.ConfigKey then
                    dd._cfgGet = function(self4) return self4.Selected end
                    dd._cfgSet = function(self4, v) self4:SetSelected(v) end
                    win._cfgIndex[dd.ConfigKey] = dd
                end
                dd._seq = (self3._seq or 0) + 1
                self3._seq = dd._seq
                table.insert(self3._dropdowns, dd)
                if win._rebuildTabs then win._rebuildTabs() end
                return dd
            end
            table.insert(self2._subtitles, st)
            if win._rebuildTabs then win._rebuildTabs() end
            return st
        end
        table.insert(self._tabs, tab)
        if self._rebuildTabs then self._rebuildTabs() end
        return tab
    end

    local function normCfgName(name)
        name = tostring(name or "")
        name = name:gsub("%.json$", "")
        if #name == 0 then name = "Config" end
        return name
    end
    win.MakeConfig = function(self, name)
        name = normCfgName(name)
        if not self._configFolder or #name == 0 then
            reportError("MakeConfig 需要先设置 CreateWindow 的 Folder 并传入有效名称")
            return false
        end
        local data = {}
        for key, ctrl in pairs(self._cfgIndex) do
            if ctrl._cfgGet then
                local ok, v = pcall(ctrl._cfgGet, ctrl)
                if ok then data[key] = v end
            end
        end
        return writeConfigFile(self._configFolder, name, data)
    end
    win.SaveConfig = win.MakeConfig
    win.LoadConfig = function(self, name)
        name = normCfgName(name)
        if not self._configFolder or #name == 0 then
            reportError("LoadConfig 需要先设置 CreateWindow 的 Folder 并传入有效名称")
            return false
        end
        local data = loadConfigFile(self._configFolder, name)
        if next(data) == nil then
            reportError("LoadConfig 未找到配置或配置为空: " .. name)
            return false
        end
        for key, v in pairs(data) do
            local ctrl = self._cfgIndex[key]
            if ctrl and ctrl._cfgSet then pcall(ctrl._cfgSet, ctrl, v) end
        end
        return true
    end
    win.EditConfig = function(self, name, key, value)
        name = normCfgName(name)
        if not self._configFolder or #name == 0 then
            reportError("EditConfig 需要先设置 CreateWindow 的 Folder 并传入有效名称")
            return false
        end
        local data = loadConfigFile(self._configFolder, name)
        data[key] = value
        local ok = writeConfigFile(self._configFolder, name, data)
        if ok then
            local ctrl = self._cfgIndex[key]
            if ctrl and ctrl._cfgSet then pcall(ctrl._cfgSet, ctrl, value) end
        end
        return ok
    end
    win.Error = function(self, customText)
        if not alive then return end
        reportError((type(customText) == "string" and #customText > 0) and customText or Config.ErrorText)
        task.spawn(playErrorSequence, customText)
    end
win._closeNow = function(self)
        alive = false

        unregisterLoadedWindow(self and self._loadedTitle or nil, self)
        if self.ScreenGui and self.ScreenGui.Parent then
            pcall(function() self.ScreenGui:Destroy() end)
        end
    end

    win._isDormant = function()
        return switchDormant
    end

    win._switchAway = function(self, dur)
        if not alive or switchDormant then return end
        switchDormant = true
        if edgeAnimConn then pcall(function() edgeAnimConn:Disconnect() end) edgeAnimConn = nil end
        cancelEdgeTweens()
        local d = (type(dur) == "number" and dur > 0) and dur or Config.SwitchTitleMoveTime
        local ti = TweenInfo.new(d, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        if contentRoot and contentRoot.Parent then
            TweenService:Create(contentRoot, ti, { GroupTransparency = 1 }):Play()
        end
        if islandTextContainer and islandTextContainer.Parent then
            for _, cf in ipairs(islandTextContainer:GetChildren()) do
                local lb = cf:FindFirstChildOfClass("TextLabel")
                if lb then TweenService:Create(lb, ti, { TextTransparency = 1 }):Play() end
            end
        end
        if titleFrame and titleFrame.Parent then
            for _, node in ipairs(titleFrame:GetDescendants()) do
                if node:IsA("TextLabel") then
                    TweenService:Create(node, ti, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
                end
            end
        end
        if fillFrame and fillFrame.Parent then
            chromeTween(fillFrame, ti, { BackgroundTransparency = 1 })
        end
        chromeTween(stroke, ti, { Transparency = 1 })
        chromeTween(silverStroke, ti, { Transparency = 1 })
        edge.Active = false
        task.delay(d + 0.05, function()
            if screenGui and screenGui.Parent then screenGui.Enabled = false end
        end)
    end

    local function fadeOutOtherWindows(d)
        for _, t in ipairs(loadedOrder) do
            if t ~= title then
                local w = loadedWindows[t]
                if w and type(w) == "table" and w._switchAway then
                    pcall(function() w:_switchAway(d) end)
                end
            end
        end
    end

    -- 多脚本销毁动画：另一脚本销毁后，本窗口从被隐藏状态恢复，
    -- 新灵动岛从原位置渐显，同时由「圆形」展开为「胶囊」
    win._restoreFromDestroy = function(self)
        if not alive or shutdown then return false end
        switchDormant = false
        if screenGui then screenGui.Enabled = true end
        edge.Active = true
        cancelEdgeTweens()
        cancelChromeTweens()

        local cy = Config.IslandPosition.Y.Offset + Config.IslandSize.Y.Offset / 2
        local cx = Config.IslandPosition.X.Offset + Config.IslandSize.X.Offset / 2
        local h = Config.IslandSize.Y.Offset

        -- 起始：圆形（宽=高，圆角=半径），位于灵动岛中心，完全透明
        local circleD = h
        edge.AnchorPoint = Vector2.new(0.5, 0.5)
        edge.Size = UDim2.new(0, circleD, 0, circleD)
        edge.Position = UDim2.new(0.5, cx, 0, cy)
        corner.CornerRadius = UDim.new(0, circleD / 2)
        fillCorner.CornerRadius = UDim.new(0, circleD / 2)
        fillFrame.Size = UDim2.new(1, 0, 1, 0)
        fillFrame.BackgroundTransparency = 1
        if contentRoot and contentRoot.Parent then contentRoot.GroupTransparency = 1 end
        if stroke then stroke.Transparency = 1 end
        if silverStroke then silverStroke.Transparency = 1 end

        local growT = Config.CircleGrowTime
        local ti = TweenInfo.new(growT, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tiSine = TweenInfo.new(growT, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

        -- 记录：由圆形展开为胶囊的尺寸目标（宽=岛宽，高=岛高）
        local circleTarget = UDim2.new(0, Config.IslandSize.X.Offset, 0, Config.IslandSize.Y.Offset)
        local circlePos = UDim2.new(0, Config.IslandPosition.X.Offset, 0, Config.IslandPosition.Y.Offset)

        -- 渐显填充与银白边框
        TweenService:Create(fillFrame, tiSine, { BackgroundTransparency = Config.IslandFinalTransparency }):Play()
        TweenService:Create(silverStroke, tiSine, { Transparency = Config.TargetTransparency }):Play()
        TweenService:Create(contentRoot, tiSine, { GroupTransparency = 0 }):Play()

        task.delay(Config.CircleHoldTime, function()
            if not alive then return end
            -- 圆形 → 胶囊：宽度展开 + 圆角回到灵动岛圆角
            edge.AnchorPoint = Vector2.new(0, 0)
            TweenService:Create(edge, ti, {
                Size = circleTarget,
                Position = circlePos,
            }):Play()
            TweenService:Create(corner, ti, { CornerRadius = Config.IslandCornerRadius }):Play()
            TweenService:Create(fillCorner, ti, { CornerRadius = Config.IslandCornerRadius }):Play()
        end)

        -- 入场完成后重建文字与可选面板
        task.delay(Config.CircleHoldTime + growT, function()
            if not alive then return end
            if islandTextContainer and islandTextContainer.Parent then
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then lb.TextTransparency = 1 end
                end
                for _, cf in ipairs(islandTextContainer:GetChildren()) do
                    local lb = cf:FindFirstChildOfClass("TextLabel")
                    if lb then
                        TweenService:Create(lb, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
                    end
                end
            end
        end)
        return true
    end

    win._switchBack = function(self)
        if not alive or shutdown or not switchDormant then return false end
        local d = Config.SwitchTitleMoveTime
        if not ready then
            fadeOutOtherWindows(d)
            cancelChromeTweens()
            switchDormant = false
            if screenGui then screenGui.Enabled = true end
            edge.Active = true
            if contentRoot and contentRoot.Parent then contentRoot.GroupTransparency = 0 end
            if stroke then stroke.Transparency = 1 end
            if fillFrame and fillFrame.Parent then
                chromeTween(fillFrame, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    BackgroundTransparency = Config.IslandFinalTransparency,
                })
            end
            chromeTween(silverStroke, TweenInfo.new(Config.FadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = Config.TargetTransparency,
            })
            return true
        end
        fadeOutOtherWindows(d)
        task.delay(d + 0.05, function()
            if not alive or shutdown or not switchDormant then return end
            cancelChromeTweens()
            switchDormant = false
            if screenGui then screenGui.Enabled = true end
            edge.Active = true
            if contentRoot and contentRoot.Parent then contentRoot.GroupTransparency = 0 end
            -- 切换脚本直接以展开模式恢复：移除「先收起为灵动岛、再展开」的中间态，
            -- 避免切换完成瞬间面板回退为收起态（此时边框与背景都会消失）
            expanded = true
            if restorePanelRef then pcall(restorePanelRef) end
            return
        end)
        return true
    end

    local actionGen = 0
    local function runIslandAction(text, deferTry)
        if not alive or switchDormant then return end
        if type(text) ~= "string" or #text == 0 then
            reportError("ShowNotify 需要非空字符串")
            return
        end
        if not expanded and os.clock() < edgeBusyUntil and (deferTry or 0) < 12 then
            task.spawn(function()
                local waited = 0
                while alive and not shutdown and not expanded and os.clock() < edgeBusyUntil and waited < 6 do
                    task.wait(0.03)
                    waited = waited + 0.03
                end
                if alive and not shutdown then runIslandAction(text, (deferTry or 0) + 1) end
            end)
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
                if myGen == actionGen then
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
                if not edgeAnimConn then
                    edgeTween(TweenInfo.new(et, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = UDim2.new(curSize.X.Scale, curSize.X.Offset, curSize.Y.Scale, curSize.Y.Offset),
                        Position = UDim2.new(curPos.X.Scale, curPos.X.Offset, curPos.Y.Scale, curPos.Y.Offset),
                    })
                end
                task.delay(et + 0.03, function()
                    if myGen ~= actionGen then return end
                    if expanded then
                        actionBusy = false
                        return
                    end
                    if islandTextContainer and islandTextContainer.Parent then islandTextContainer:Destroy() end
                    islandTextContainer = createIslandText(islandTextOverride or title, Config.TitleColor, true)
                    actionBusy = false
                end)
            end
            actionEnd = endNow
            edgeTween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(curSize.X.Scale, curSize.X.Offset + dw, curSize.Y.Scale, curSize.Y.Offset + dh),
                Position = UDim2.new(curPos.X.Scale, curPos.X.Offset, curPos.Y.Scale, curPos.Y.Offset + dh / 2),
            })
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

    local function resolveTextArg(a, b)
        if type(a) == "string" then return a end
        if type(b) == "string" then return b end
        return nil
    end
    win.DynamicIslandAction = setmetatable({
        ChangeText = function(a, b)
            local text = resolveTextArg(a, b)

            if text == nil or #text == 0 then
                islandTextOverride = nil
            else
                islandTextOverride = text
            end
            if not alive or expanded then return end

            setIslandTextAnimated(islandTextOverride or title, Config.TitleColor)
        end,
        ShowNotify = function(a, b)
            if a == win.DynamicIslandAction then a = b end
            runIslandAction(resolveTextArg(a, b))
        end,

        ChangeIconText = function(a, b, c, d)
            if a == win.DynamicIslandAction then
                a, b, c, d = b, c, d, nil
            end
            local text, icon, iconColor
            if type(a) == "string" then
                text, icon, iconColor = a, b, c
            else
                text, icon, iconColor = b, c, d
            end
            if type(text) ~= "string" or #text == 0 then return end
            if icon ~= nil and type(icon) ~= "string" then return end
            if icon ~= nil and #icon == 0 then icon = nil end
            if iconColor ~= nil and typeof(iconColor) ~= "Color3" then return end
            if not iconTextPlayer then return end
            iconTextPlayer(text, icon, iconColor)
        end,
    }, { __call = function(self) return self end })
    win.ShowNotify = function(a, b)
        if a == win then a = b end
        runIslandAction(resolveTextArg(a, b))
    end

    win._flashLoadedHint = function()
        runIslandAction("界面已加载")
    end

    win.Unload = function(self)
        local t = self and self._loadedTitle or nil
        if self and type(self) == "table" and self._closeNow then
            pcall(function() self:_closeNow() end)
        end
        unregisterLoadedWindow(t, self)
        return true
    end

    registerLoadedWindow(title, win)

    Library._lastWin = win
    Library.DynamicIslandAction = win.DynamicIslandAction
    Library.GetWindowAction = function()
 return win:GetWindowAction()
    end
    Library.SetWindowAction = function(a, b)
        if a == Library then return win:SetWindowAction(b) end
        if type(a) == "boolean" then return win:SetWindowAction(a) end
        return win:SetWindowAction(a, b)
    end
    Library.ShowNotify = function(a, b)
        if a == Library then a = b end
        runIslandAction(resolveTextArg(a, b))
    end
    return win
end

Library._demoWin = Library.CreateWindow({ _error = true })

function Library.GetLoadedWindow(title)
    if type(title) ~= "string" or #title == 0 then return nil end
    local w = loadedWindows[title]
    if w ~= nil and type(w) == "table" and w._loadedTitle == nil then

        loadedWindows[title] = nil
        return nil
    end
    return w
end

function Library.IsLoaded(title)
    return Library.GetLoadedWindow(title) ~= nil
end

function Library.UnloadWindow(title)
    local w = Library.GetLoadedWindow(title)
    if w == nil then return false end
    pcall(function() w:_closeNow() end)
    unregisterLoadedWindow(title, w)
    return true
end

function Library.GetLoadedTitles()
    local out = {}
    for i, t in ipairs(loadedOrder) do
        if loadedWindows[t] ~= nil then out[#out + 1] = t end
    end
    return out
end

return Library
