-- ============================================================================
-- DynamicCowUI 完整示例
-- 外观参考 iPhoneOS 的灵动岛（Dynamic Island）
--
-- 本示例覆盖了库中「文档里没写全 / 示例里没演示过」的全部接口：
--   窗口级：Add / AddTab / MakeConfig / SaveConfig / LoadConfig / EditConfig
--           Error / ShowNotify / GetWindowAction / SetWindowAction / Unload
--   灵动岛：DynamicIslandAction.ChangeText / ChangeIconText / ShowNotify
--   控件：  AddButton / AddToggle / AddParagraph / AddLine / AddSlider / AddDropdown
--   控件返回值的方法：Set / GetValue / SetValue / SetInfo / SetSelected / SetColor ...
--   库级：  Library.ShowNotify / GetWindowAction / SetWindowAction
--           Library.IsLoaded / GetLoadedWindow / GetLoadedTitles / UnloadWindow
-- ============================================================================

local Library = loadstring(game:HttpGet("https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ---------------------------------------------------------------------------
-- 1. 创建窗口
--    同一个 Title 重复执行本脚本时不会重复创建：
--    第二次会直接拿到同一个窗口句柄，并让灵动岛闪一下「界面已加载」。
--    窗口被关闭（长按 X 或 win:Unload()）后loaded 状态自动清空，
--    此时再次执行脚本就能重新加载。
-- ---------------------------------------------------------------------------
local win = Library:CreateWindow({
    Title = "TrashHub复活版",
    Info = "Scripts来自WasKKalWe",
    Icon = "skull",
    IconFromURL = "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/icon.png",
    Folder = "TrashHub",
    -- 可选签名：
    -- AutoLoadConfig = true,  -- 启动时读回 Folder/Config.json 中已保存的值（默认 true）
    -- AutoSaveConfig = true,  -- 改动控件时自动写回同一份 Config.json（默认 true）
    --                           设为 false 则不自动落盘，需要时显式调用 win:SaveConfig()
    -- AllowDuplicate = false, -- 默认 false：同 Title 不重复加载
})

-- Add 用于把自定义内容挂到窗口上（table 描述或直接传 Instance）
win:Add()

-- ---------------------------------------------------------------------------
-- 2. 选项卡与子标题
-- ---------------------------------------------------------------------------
local baseTab = win:AddTab({ Title = "主页", Icon = "house" })
local baseSub = baseTab:AddSubTitle({ Title = "基础功能", Icon = "sliders-horizontal" })

-- ---------------------------------------------------------------------------
-- 3. 控件
-- ---------------------------------------------------------------------------

-- 3.1 Button
baseSub:AddButton({
    Title = "重置数据",
    Icon = "rotate-ccw",
    OnClick = function()
        win:ShowNotify("数据已重置")
    end,
})

-- 3.2 Toggle —— 返回值带 Set / GetValue
local autoPickup = baseSub:AddToggle({
    Title = "自动拾取",
    Icon = "hand",
    Default = true,
    ConfigKey = "AutoPickup",
})
print("自动拾取初始值:", autoPickup:GetValue())          -- true
autoPickup:Set(false)                                    -- 编程方式关闭，同样会落盘
print("自动拾取当前值:", autoPickup:GetValue())          -- false

baseSub:AddToggle({
    Title = "自动瞄准",
    Icon = "crosshair",
    Default = false,
    ConfigKey = "AutoAim",
    Callback = function(v)
        print("自动瞄准:", v)
    end,
})

baseSub:AddToggle({
    Title = "显示血量",
    Icon = "heart",
    IconColor = Color3.fromRGB(220, 80, 80),
    ThumbColor = Color3.fromRGB(120, 255, 160),   -- 滑块颜色
    TrackColor = Color3.fromRGB(60, 60, 70),      -- 轨道颜色
    Default = true,
    ConfigKey = "ShowHealth",
    Callback = function(v)
        Library.ShowNotify(v and "已显示血量" or "已隐藏血量")
    end,
})

-- 3.3 Paragraph —— 返回值带 SetTitle / SetInfo / SetIcon
local coordParagraph = baseTab:AddParagraph({
    Title = "玩家实时坐标",
    Icon = "map-pin",
    Info = "X: 0\nY: 0\nZ: 0",
})
coordParagraph:SetIcon("crosshair")                     -- 运行中换图标
coordParagraph:SetTitle("坐标 / 血量")

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

-- ---------------------------------------------------------------------------
-- 4.战斗选项卡：Slider 与 Dropdown
-- ---------------------------------------------------------------------------
local battleTab = win:AddTab({ Title = "战斗", Icon = "swords" })
local battleSub = battleTab:AddSubTitle({ Title = "战斗设置", Icon = "crosshair" })

local rangeSlider = battleSub:AddSlider({
    Title = "攻击范围",
    Default = 25,
    MinValue = 5,
    MaxValue = 100,
    Degree = 1,                                   -- 取整步长
    FillColor = Color3.fromRGB(255, 140, 90),
    ConfigKey = "AttackRange",
})
rangeSlider:SetValue(60)                                 -- 编程方式设值
print("攻击范围当前值:", rangeSlider:GetValue())

battleSub:AddSlider({
    Title = "攻击速度",
    MinValue = 1,
    MaxValue = 20,
    ConfigKey = "AttackSpeed",
})

local targetDropdown = battleSub:AddDropdown({
    Title = "目标选择",
    Value = { "最近敌人", "最低血量", "最高等级" },
    DefaultValue = "最近敌人",
    ConfigKey = "TargetMode",
})
targetDropdown:SetSelected("最高等级")
print("目标选择当前值:", targetDropdown:GetSelected())

battleSub:AddDropdown({
    Title = "技能顺序",
    Multiple = true,                             -- 多选模式
    Value = { "Q", "E", "R", "F" },
    DefaultValue = { "Q", "E" },
    ConfigKey = "SkillOrder",
})

battleSub:AddButton({
    Title = "开始战斗",
    Icon = "play",
    OnClick = function()
        win.DynamicIslandAction.ShowNotify("战斗已开始")
    end,
})

-- ---------------------------------------------------------------------------
-- 5. 设置选项卡：分隔线 / 配置管理 / 窗口开合
-- ---------------------------------------------------------------------------
local setTab = win:AddTab({ Title = "设置", Icon = "settings" })
local setSub = setTab:AddSubTitle({ Title = "界面设置", Icon = "palette" })

setSub:AddParagraph({
    Title = "使用说明",
    Icon = "info",
    Info = "长按灵动岛展开面板\n点击右上角 X 收起面板\n左右拖动灵动岛有拉扯动画\n连点三次触发提示动画",
})

-- AddLine：横向细分隔线，支持三种调用形式
local line1 = setSub:AddLine()-- 使用默认颜色与粗细
line1:SetColor(Color3.fromRGB(120, 120, 255))        -- 运行中改颜色
line1:SetThickness(2)
line1:SetInset(12)                                    -- 左右缩进

setSub:AddLine(Color3.fromRGB(255, 120, 120))          -- 只给颜色

setSub:AddLine({                                    -- 完整 table 形式
    Color = Color3.fromRGB(90, 90, 100),
    Thickness = 1,
    Inset = 8,
})

-- MakeConfig：把当前所有 ConfigKey 控件的值写成一份快照
setSub:AddButton({
    Title = "创建配置快照",
    Icon = "copy",
    OnClick = function()
        if win:MakeConfig("快照A") then
            win:ShowNotify("已创建 快照A.json")
        end
    end,
})

-- SaveConfig = MakeConfig 的别名
setSub:AddButton({
    Title = "保存配置",
    Icon = "save",
    OnClick = function()
        win:SaveConfig("默认配置")
        Library.ShowNotify("已保存到 默认配置.json")
    end,
})

setSub:AddButton({
    Title = "加载配置",
    Icon = "folder-open",
    OnClick = function()
        win:LoadConfig("默认配置")
        Library.ShowNotify("已加载 默认配置.json")
    end,
})

-- EditConfig：单独改某个键（会同步刷新对应控件）
setSub:AddButton({
    Title = "把攻击范围改成 80",
    Icon = "sliders-horizontal",
    OnClick = function()
        win:EditConfig("默认配置", "AttackRange", 80)
        win:ShowNotify("AttackRange → 80")
    end,
})

-- ---------------------------------------------------------------------------
-- 6. 灵动岛控制
-- ---------------------------------------------------------------------------

-- 6.1 SetWindowAction：以编程方式展开 / 收起面板（带动画）
--true = 展开，false = 收起。动画进行中调用会被拒绝（返回 false），稍后再试。
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

setSub:AddButton({
    Title = "查询当前状态",
    Icon = "info",
    OnClick = function()
        local action = win:GetWindowAction()   -- "WindowOpen" / "WindowClose"
        win:ShowNotify("当前状态: " .. tostring(action))
    end,
})

-- 6.2 库级等价接口（等价于上面三个窗口方法）
setSub:AddButton({
    Title = "库级 SetWindowAction",
    Icon = "layers",
    OnClick = function()
        local nowOpen = win:GetWindowAction() == "WindowOpen"
        Library.SetWindowAction(not nowOpen)
    end,
})

-- 6.3 图文胖岛 / 纯文字胖岛
setSub:AddButton({
    Title = "图文胖岛演示",
    Icon = "sparkles",
    OnClick = function()
        win.DynamicIslandAction:ChangeIconText("正在同步数据", "refresh-cw", Color3.fromRGB(80, 200, 255))
    end,
})

setSub:AddButton({
    Title = "纯文字胖岛",
    Icon = "type",
    OnClick = function()
        win.DynamicIslandAction:ChangeIconText("同步完成", nil, nil)
    end,
})

-- 6.4 ChangeText：改灵动岛收起态的标题文字（传空串恢复默认标题）
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

-- 6.5 错误演示：调用 win:Error 会走红色 X + 爆炸粒子 + 自动关闭
setSub:AddButton({
    Title = "触发错误动画",
    Icon = "alert-triangle",
    OnClick = function()
        win:Error("这是一个演示错误")
    end,
})

-- ---------------------------------------------------------------------------
-- 7. 同 Title 去重机制
--    重复执行本脚本时不会开出第二套灵动岛，下面几个接口可用于查询/卸载。
-- ---------------------------------------------------------------------------
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

-- ---------------------------------------------------------------------------
-- 8. 其它
-- ---------------------------------------------------------------------------
setSub:AddButton({
    Title = "检查更新",
    Icon = "download",
    OnClick = function()
        Library.ShowNotify("已是最新版本 v1.0.0")
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
