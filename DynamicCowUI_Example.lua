local Library = loadstring(game:HttpGet("https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local win = Library:CreateWindow({
    Title = "TrashHub复活版",
    Info = "Scripts来自WasKKalWe",
    Icon = "skull",
    IconFromURL = "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/icon.png",
    Folder = "TrashHub",
})
win:Add()
local baseTab = win:AddTab({ Title = "主页", Icon = "house" })
local baseSub = baseTab:AddSubTitle({ Title = "基础功能", Icon = "sliders-horizontal" })
baseSub:AddButton({
    Title = "重置数据",
    Icon = "rotate-ccw",
    OnClick = function()
        win:ShowNotify("数据已重置")
    end,
})
local autoPickup = baseSub:AddToggle({
    Title = "自动拾取",
    Icon = "hand",
    Default = true,
    ConfigKey = "AutoPickup",
})
print("自动拾取初始值:", autoPickup:GetValue())
autoPickup:Set(false)
print("自动拾取当前值:", autoPickup:GetValue())
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
    ThumbColor = Color3.fromRGB(120, 255, 160),
    TrackColor = Color3.fromRGB(60, 60, 70),
    Default = true,
    ConfigKey = "ShowHealth",
    Callback = function(v)
        Library.ShowNotify(v and "已显示血量" or "已隐藏血量")
    end,
})
local coordParagraph = baseSub:AddParagraph({
    Title = "玩家实时坐标",
    Icon = "map-pin",
    Info = "X: 0\nY: 0\nZ: 0",
})
coordParagraph:SetIcon("crosshair")
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
local battleTab = win:AddTab({ Title = "战斗", Icon = "swords" })
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
rangeSlider:SetValue(60)
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
    Multiple = true,
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
local setTab = win:AddTab({ Title = "设置", Icon = "settings" })
local setSub = setTab:AddSubTitle({ Title = "界面设置", Icon = "palette" })
setSub:AddParagraph({
    Title = "使用说明",
    Icon = "info",
    Info = "长按灵动岛展开面板\n点击右上角 X 收起面板\n左右拖动灵动岛有拉扯动画\n连点三次触发提示动画",
})
local line1 = setSub:AddLine()
line1:SetColor(Color3.fromRGB(120, 120, 255))
line1:SetThickness(2)
line1:SetInset(12)
setSub:AddLine(Color3.fromRGB(255, 120, 120))
setSub:AddLine({
    Color = Color3.fromRGB(90, 90, 100),
    Thickness = 1,
    Inset = 8,
})
setSub:AddButton({
    Title = "创建配置快照",
    Icon = "copy",
    OnClick = function()
        if win:MakeConfig("快照A") then
            win:ShowNotify("已创建 快照A.json")
        end
    end,
})
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
setSub:AddButton({
    Title = "把攻击范围改成 80",
    Icon = "sliders-horizontal",
    OnClick = function()
        win:EditConfig("默认配置", "AttackRange", 80)
        win:ShowNotify("AttackRange → 80")
    end,
})
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
        local action = win:GetWindowAction()
        win:ShowNotify("当前状态: " .. tostring(action))
    end,
})
setSub:AddButton({
    Title = "库级 SetWindowAction",
    Icon = "layers",
    OnClick = function()
        local nowOpen = win:GetWindowAction() == "WindowOpen"
        Library.SetWindowAction(not nowOpen)
    end,
})
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
