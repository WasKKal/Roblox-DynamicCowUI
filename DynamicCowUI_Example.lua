￼-- 请跳转110行 这里是本地缓存UI库与版本更新的代码区域
-- 此版本仍为 Preview(1.0.0)
-- 有任何问题 请加QQ群反馈 938419587

local CacheDir = "DynamicCowUI/Cache"
local CachePath = CacheDir .. "/DynamicCowUI.lua"
local CloudUrl = "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"
-- 务必使用此CDN链接

local function ensureDir(path)
    if type(makefolder) ~= "function" then return end
    if type(isfolder) == "function" then
        local ok, exists = pcall(isfolder, path)
        if ok and exists then return end
    end
    pcall(makefolder, path)
end

local function readCache()
    if type(isfile) ~= "function" or type(readfile) ~= "function" then return nil end
    local ok, exists = pcall(isfile, CachePath)
    if not ok or not exists then return nil end
    local ok2, content = pcall(readfile, CachePath)
    if ok2 and type(content) == "string" and #content > 0 then return content end
    return nil
end

local function writeCache(content)
    if type(writefile) ~= "function" then return false end
    ensureDir("DynamicCowUI")
    ensureDir(CacheDir)
    local ok = pcall(writefile, CachePath, content)
    return ok and true or false
end

local function fetchCloud()
    local ok, res = pcall(function() return game:HttpGet(CloudUrl) end)
    if ok and type(res) == "string" and #res > 0 then return res end
    return nil
end

local function parseVersion(src)
    if type(src) ~= "string" then return nil end
    local a, b, c = string.match(src, 'DynamicCowUIVersion%s*=%s*"(%d+)%.(%d+)%.(%d+)"')
    if not a then return nil end
    return { tonumber(a), tonumber(b), tonumber(c) }
end

local function versionLess(v1, v2)
    if v1[1] ~= v2[1] then return v1[1] < v2[1] end
    if v1[2] ~= v2[2] then return v1[2] < v2[2] end
    return v1[3] < v2[3]
end

local function firstScriptCheck()
    if type(getgenv) ~= "function" then return true end
    local ok, genv = pcall(getgenv)
    if not ok or type(genv) ~= "table" then return true end
    if genv.__DcuiCloudChecked then return false end
    genv.__DcuiCloudChecked = true
    return true
end

local libSrc = readCache()
local updatedVer = nil
if libSrc then
    if firstScriptCheck() then
        local cloudSrc = fetchCloud()
        local cloudVer = parseVersion(cloudSrc)
        if cloudSrc and cloudVer then
            local cacheVer = parseVersion(libSrc)
            if not cacheVer or versionLess(cacheVer, cloudVer) then
                writeCache(cloudSrc)
                libSrc = cloudSrc
                updatedVer = cloudVer
            end
        end
    end
else
    if firstScriptCheck() then
        local cloudSrc = fetchCloud()
        if cloudSrc then
            writeCache(cloudSrc)
            libSrc = cloudSrc
        end
    end
end

local function loadFrom(src)
    if type(src) ~= "string" or #src == 0 then return nil end
    local ok, chunk = pcall(loadstring, src)
    if not ok or not chunk then return nil end
    local ok2, result = pcall(chunk)
    if ok2 and type(result) == "table" then return result end
    return nil
end

local Library = loadFrom(libSrc)
if not Library then
    Library = loadstring(game:HttpGet("https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"))() -- 务必使用此CDN链接
end
if not Library then
    error("[DynamicCowUI] 加载失败：本地缓存不可用且云端下载失败")
end
if updatedVer then
    Library:ShowNotify("DynamicCowUI 已更新至 v" .. table.concat(updatedVer, "."))
end

-- 以上为DynamicCowUI本地缓存和检查版本号模块 可以让用户更快的加载你的脚本 如果你不需要 可以删除它们(需要保留CloudUrl变量)

-- 所有图标名称 均为Lucide图标
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local win = Library:CreateWindow({
    Title = "TrashHub复活版",  -- 灵动岛/面板标题
    Info = "Scripts来自WasKKalWe",  -- 标题下方文字
    Icon = "skull", -- 包含IconFromURL时 该图标不会显示
    IconFromURL = "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/icon.png", -- 你可以选择性移除这个
    Folder = "TrashHub", -- 配置文件夹名称 务必添加它
    AutoLoadConfig = true, -- 控制是否自动加载配置
    AutoSaveConfig = true, -- 控制是否自动保存配置
})

win:Add()

local baseTab = win:AddTab({ Title = "主页", Icon = "house" }) -- 创建选项卡
local baseSub = baseTab:AddSubTitle({ Title = "基础功能", Icon = "sliders-horizontal" }) -- 在主页选项卡内创建小标题

-- 在小标题下添加按钮 用于功能折叠
baseSub:AddButton({
    Title = "重置数据", -- 按钮名称
    Icon = "rotate-ccw",  -- 图标
    OnClick = function()
        win:ShowNotify("数据已重置") --插入你的功能
    end,
})

-- 创建开关
local autoPickup = baseSub:AddToggle({
    Title = "自动拾取",  -- toggle的标题
    Icon = "hand",  -- toggle内的图标
    Default = true,  -- 默认的开关状态
    ConfigKey = "AutoPickup", -- 用于储存配置
})
print("自动拾取初始值:", autoPickup:GetValue())
autoPickup:Set(false)  -- 控制开关的启用/关闭状态
print("自动拾取当前值:", autoPickup:GetValue())

-- 另一个开关
baseSub:AddToggle({
    Title = "自动瞄准",
    Icon = "crosshair",
    Default = false,
    ConfigKey = "AutoAim",
    Callback = function(v)
        print("自动瞄准:", v)
    end,
})

-- 也是一个开关 但它的颜色不同
baseSub:AddToggle({
    Title = "显示血量",
    Icon = "heart",
    IconColor = Color3.fromRGB(220, 80, 80), -- 图标颜色
    ThumbColor = Color3.fromRGB(120, 255, 160),-- 白色圆球颜色
    TrackColor = Color3.fromRGB(60, 60, 70), -- toggle背景颜色
    Default = true,
    ConfigKey = "ShowHealth",
    Callback = function(v)
        Library.ShowNotify(v and "已显示血量" or "已隐藏血量")
    end,
})

-- 一个段落控件 用于显示公告等信息
local coordParagraph = baseSub:AddParagraph({
    Title = "玩家实时坐标",
    Icon = "map-pin",
    Info = "X: 0\nY: 0\nZ: 0",
})

coordParagraph:SetIcon("crosshair") -- 改变段落的图标
coordParagraph:SetTitle("坐标 / 血量") -- 改变段落的标题

-- 这段代码用于实时更新段落 作为参考
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer and LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local p = hrp.Position
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hp = hum and math.floor(hum.Health) or 0
        coordParagraph:SetInfo(string.format(
            "X: %.1f\nY: %.1f\nZ: %.1f\n血量: %d",
            p.X, p.Y, p.Z, hp
        ))
    end
end)

-- 另一个选项卡
local battleTab = win:AddTab({ Title = "战斗", Icon = "swords" })

-- 另一个小标题
local battleSub = battleTab:AddSubTitle({ Title = "战斗设置", Icon = "crosshair" })
local rangeSlider = battleSub:AddSlider({
    Title = "攻击范围",
    Default = 25,
    MinValue = 5,
    MaxValue = 100,
    Degree = 1,
    FillColor = Color3.fromRGB(255, 140, 90),
    ConfigKey = "AttackRange",
})

rangeSlider:SetValue(60) -- 设置Slider的当前值

print("攻击范围当前值:", rangeSlider:GetValue())--演示获取Slider的值

-- 又一个Slider
battleSub:AddSlider({
    Title = "攻击速度",
    MinValue = 1,
    MaxValue = 20,
    ConfigKey = "AttackSpeed",
})

-- 一个下拉菜单
local targetDropdown = battleSub:AddDropdown({
    Title = "目标选择", --标题
    Value = { "最近敌人", "最低血量", "最高等级" }, --包含条目
    DefaultValue = "最近敌人",  -- 默认选中
    ConfigKey = "TargetMode",
})

targetDropdown:SetSelected("最高等级") -- 设定选中条目

print("目标选择当前值:", targetDropdown:GetSelected())--演示获取下拉菜单条目值

-- 一个可多选的下拉菜单
battleSub:AddDropdown({
    Title = "技能顺序",
    Multiple = true, --控制多选
    Value = { "Q", "E", "R", "F" },
    DefaultValue = { "Q", "E" }, --默认选中条目
    ConfigKey = "SkillOrder",
})

-- 又一个按钮
battleSub:AddButton({
    Title = "开始战斗",
    Icon = "play",
    OnClick = function()
        win.DynamicIslandAction.ShowNotify("战斗已开始") --控制Dync通知
    end,
})

local setTab = win:AddTab({ Title = "设置", Icon = "settings" })
local setSub = setTab:AddSubTitle({ Title = "界面设置", Icon = "palette" })

-- 另一个段落 这个控件高度会跟随文字改变
setSub:AddParagraph({
    Title = "使用说明",
    Icon = "info",
    Info = "长按灵动岛展开面板\n点击右上角 X 收起面板\n长按右上角X关闭脚本\n左右拖动灵动岛有拉扯动画\n连点三次触发提示动画",
})

-- 这里创建了3根线 可用于分隔功能
local line1 = setSub:AddLine()
line1:SetColor(Color3.fromRGB(120, 120, 255)) --改变上一条线的颜色
line1:SetThickness(2) -- 线厚度
line1:SetInset(12) -- 设置插入

--另一条线
setSub:AddLine(Color3.fromRGB(255, 120, 120))
--包含完整参数的线
setSub:AddLine({
    Color = Color3.fromRGB(90, 90, 100),
    Thickness = 1,
    Inset = 12,
})

setSub:AddParagraph({
    Title = "分隔线说明",
    Icon = "minus",
    Info = "上方演示了AddLine函数",
})

-- 一个颜色选择器
local themePicker = setSub:AddColorPicker({
    Title = "主题颜色",
    DefaultColor = Color3.fromRGB(255, 140, 90), --默认颜色
    ConfigKey = "ThemeColor", --颜色选择器的配置键
    Callback = function(c)
        print("主题颜色已更改:", math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
    end,
})

print("主题颜色初始值:", math.floor(themePicker:GetColor().R * 255), math.floor(themePicker:GetColor().G * 255), math.floor(themePicker:GetColor().B * 255))
themePicker:SetColor(Color3.fromRGB(80, 200, 255))
print("主题颜色当前值:", math.floor(themePicker:GetColor().R * 255), math.floor(themePicker:GetColor().G * 255), math.floor(themePicker:GetColor().B * 255))

-- 一个默认颜色选择器
setSub:AddColorPicker({
    Title = "无配置键颜色",
    DefaultColor = Color3.fromRGB(120, 255, 160),
})

-- 另一个长段落
setSub:AddParagraph({
    Title = "选色器说明",
    Icon = "palette",
    Info = "上方演示了AddColorPicker函数\n点击右侧色块打开选色面板\n可拖动色相条与明暗方块\n确认后自动保存到配置",
})

-- 这个按钮演示了改变ColorPicker颜色方法
setSub:AddButton({
    Title = "随机主题颜色",
    Icon = "shuffle",
    OnClick = function()
       themePicker:SetColor(Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
        win:ShowNotify("主题颜色已随机更改")
    end,
})

-- 创建配置 MakeConfig(自定义ConfigKey状态 储存为json)
setSub:AddButton({
    Title = "把两个功能自定义写入配置",
    Icon = "database",
    OnClick = function()
        win:MakeConfig("默认配置", { AttackRange = 80, AutoAim = false }) -- 此处写入了两个Config状态
        win:ShowNotify("已写入 默认配置.json")
    end,
})

-- 按当前脚本内状态 保存为配置
setSub:AddButton({
    Title = "保存配置",
    Icon = "save",
    OnClick = function()
        win:SaveConfig("默认配置")
        Library.ShowNotify("已保存到 默认配置.json")
    end,
})

-- 从本地加载"默认配置.json"
setSub:AddButton({
    Title = "加载配置",
    Icon = "folder-open",
    OnClick = function()
        win:LoadConfig("默认配置")
        Library.ShowNotify("已加载 默认配置.json")
    end,
})

-- 从本地配置文件中 修改一个ConfigKey的值
setSub:AddButton({
    Title = "把攻击范围改成 80",
    Icon = "sliders-horizontal",
    OnClick = function()
        win:EditConfig("默认配置", "AttackRange", 80)
        win:ShowNotify("AttackRange → 80")
    end,
})

-- 控制面板展开
setSub:AddButton({
    Title = "展开面板",
    Icon = "chevron-up",
    OnClick = function()
        if win:SetWindowAction(true) then
            win:ShowNotify("已展开")
        else
            win:ShowNotify("忙碌中，未执行")
        end
    end,
})

--控制收起
setSub:AddButton({
    Title = "收起面板",
    Icon = "chevron-down",
    OnClick = function()
        if win:SetWindowAction(false) then
            win:ShowNotify("已收起")
        else
            win:ShowNotify("忙碌中，未执行")
        end
    end,
})

-- 获取面板状态
setSub:AddButton({
    Title = "查询当前状态",
    Icon = "info",
    OnClick = function()
        local action = win:GetWindowAction()
        win:ShowNotify("当前状态: " .. tostring(action))
    end,
})

-- 跳转其他页面
setSub:AddButton({
    Title = "跳转到主页",
    Icon = "navigation",
    OnClick = function()
        if win:GotoPage("主页") then
            win:ShowNotify("已跳转到 主页")
        else
            win:ShowNotify("未找到 主页 选项卡")
        end
    end,
})

-- 跳转某功能 按Title查找
setSub:AddButton({
    Title = "定位攻击范围滑块",
    Icon = "crosshair",
    OnClick = function()
        if win:GotoFunction("攻击范围") then
            win:ShowNotify("已定位到 攻击范围")
        else
            win:ShowNotify("未找到 攻击范围 控件")
        end
    end,
})

-- 直接设置窗口状态
setSub:AddButton({
    Title = "库级 SetWindowAction",
    Icon = "layers",
    OnClick = function()
        local nowOpen = win:GetWindowAction() == "WindowOpen"
        Library.SetWindowAction(not nowOpen)
    end,
})

-- 控制灵动岛变胖动画(带图标)
setSub:AddButton({
    Title = "图文胖岛演示",
    Icon = "sparkles",
    OnClick = function()
        win.DynamicIslandAction:ChangeIconText("正在同步数据", "refresh-cw", Color3.fromRGB(80, 200, 255))
    end,
})

-- 另一种显示信息的动画 仅文字
setSub:AddButton({
    Title = "纯文字胖岛",
    Icon = "type",
    OnClick = function()
        win.DynamicIslandAction:ChangeIconText("同步完成", nil, nil)
    end,
})

--下面懒得写了 用鼻孔都能看懂 自己理解吧
setSub:AddButton({
    Title = "改灵动岛标题",
    Icon = "pencil",
    OnClick = function()
        win.DynamicIslandAction:ChangeText("Hello 灵动岛")
    end,
})

setSub:AddButton({
    Title = "恢复默认标题",
    Icon = "undo-2",
    OnClick = function()
        win.DynamicIslandAction:ChangeText("")
    end,
})
setSub:AddButton({
    Title = "触发错误动画",
    Icon = "alert-triangle",
    OnClick = function()
        win:Error("这是一个演示错误")
    end,
})
setSub:AddButton({
    Title = "查询是否已加载",
    Icon = "list-checks",
    OnClick = function()
        local loaded = Library.IsLoaded("TrashHub复活版")
        local titles = Library.GetLoadedTitles()
        win:ShowNotify(loaded and "已加载" or "未加载")
        print("当前已加载的 Title:", table.concat(titles, ", "))
    end,
})
setSub:AddButton({
    Title = "卸载并清空 loaded 状态",
    Icon = "trash-2",
    OnClick = function()
        if Library.UnloadWindow("TrashHub复活版") then
            print("已卸载，loaded 状态已清空，可重新执行脚本加载")
        end
    end,
})
-- 检查更新 你应该用不到它
setSub:AddButton({
    Title = "检查更新",
    Icon = "download",
    OnClick = function()
        local cloudSrc = fetchCloud()
        if not cloudSrc then
            Library.ShowNotify("检查更新失败：无法连接云端")
            return
        end
        local cloudVer = parseVersion(cloudSrc)
        if not cloudVer then
            Library.ShowNotify("检查更新失败：云端版本无法解析")
            return
        end
        local curVer = parseVersionStr(Library.Version)
        if not curVer then
            Library.ShowNotify("检查更新失败：本地版本无法解析")
            return
        end
        if versionLess(curVer, cloudVer) then
            if writeCache(cloudSrc) then
                Library.ShowNotify("发现新版本 v" .. table.concat(cloudVer, ".") .. "，缓存已更新")
            else
                Library.ShowNotify("发现新版本 v" .. table.concat(cloudVer, ".") .. "，缓存写入失败")
            end
        else
            Library.ShowNotify("已是最新版本 v" .. table.concat(curVer, "."))
        end
    end,
})

local playerCountRunning = false
baseSub:AddToggle({
    Title = "灵动岛显示玩家数量",
    Icon = "users",
    Default = false,
    ConfigKey = "IslandPlayerCount",
    Callback = function(v)
        playerCountRunning = v
        if not v then
            win.DynamicIslandAction:ChangeText("")
        end
    end,
})
task.spawn(function()
    while true do
        task.wait(1)
        if playerCountRunning then
            win.DynamicIslandAction:ChangeText("玩家数量: " .. #Players:GetPlayers() .. "个")
        end
    end
end)


--[[
下方演示了切换到其他脚本方法
按名称与自己检查 切换到其他名称与自身不一致的脚本
(请你自己改为指定名称切换)

Tab:AddButton({
    Title = "切换其他脚本",
    Icon = "arrow-right-left",
    OnClick = function()
        local other = nil
        for _, t in ipairs(Library.GetLoadedTitles()) do
            if t ~= "TrashHub复活版" then
                other = t
                break
            end
        end
        if other then
            local w = Library.GetLoadedWindow(other)
            if w then
                w:SetWindowAction(true)
                win:ShowNotify("已切到 " .. other)
                return
            end
        end
        win:ShowNotify("没有其它已载入的脚本")
    end,
})
]]
