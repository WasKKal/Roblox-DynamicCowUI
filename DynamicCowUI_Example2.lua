local Library = loadstring(game:HttpGet("https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local win = Library:CreateWindow({
    Title = "CowTools 工具箱",
    Info = "第二份脚本 · 与示例1共存",
    Icon = "wrench",
    IconFromURL = "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/icon.png",
    Folder = "CowTools",
    AutoLoadConfig = true,
    AutoSaveConfig = true,
})

local toolTab = win:AddTab({ Title = "工具", Icon = "hammer" })
local toolSub = toolTab:AddSubTitle({ Title = "常用动作", Icon = "zap" })

toolSub:AddButton({
    Title = "回到出生点",
    Icon = "flag",
    OnClick = function()
        local char = LocalPlayer and LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(0, 10, 0)
            win:ShowNotify("已传送回原点")
        end
    end,
})

toolSub:AddButton({
    Title = "打印当前坐标",
    Icon = "map-pin",
    OnClick = function()
        local char = LocalPlayer and LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            print("坐标:", hrp.Position)
            win.DynamicIslandAction:ChangeIconText("坐标已打印", "map-pin", Color3.fromRGB(120, 220, 160))
        end
    end,
})

local speedToggle = toolSub:AddToggle({
    Title = "加速移动",
    Icon = "gauge",
    ThumbColor = Color3.fromRGB(255, 200, 90),
    TrackColor = Color3.fromRGB(55, 55, 66),
    Default = false,
    ConfigKey = "SpeedBoost",
    Callback = function(v)
        local char = LocalPlayer and LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = v and 48 or 16
        end
    end,
})

local jumpSlider = toolSub:AddSlider({
    Title = "跳跃高度",
    Default = 50,
    MinValue = 0,
    MaxValue = 200,
    Degree = 5,
    FillColor = Color3.fromRGB(120, 200, 255),
    ConfigKey = "JumpPower",
})

jumpSlider:SetValue(75)
print("跳跃高度:", jumpSlider:GetValue())

toolSub:AddLine(Color3.fromRGB(110, 110, 130))

local gravityDropdown = toolSub:AddDropdown({
    Title = "重力模式",
    Value = { "正常", "月球", "失重" },
    DefaultValue = "正常",
    ConfigKey = "GravityMode",
    Callback = function(v)
        local g = 196.2
        if v == "月球" then g = 32.2 end
        if v == "失重" then g = 0 end
        Workspace.Gravity = g
    end,
})

print("重力模式:", gravityDropdown:GetSelected())

local visualTab = win:AddTab({ Title = "视觉", Icon = "eye" })
local visualSub = visualTab:AddSubTitle({ Title = "画面调整", Icon = "sun" })

local fovSlider = visualSub:AddSlider({
    Title = "视野 FOV",
    Default = 70,
    MinValue = 40,
    MaxValue = 120,
    Degree = 1,
    ConfigKey = "CameraFov",
    Callback = function(v)
        Workspace.CurrentCamera.FieldOfView = v
    end,
})

visualSub:AddToggle({
    Title = "移除雾效",
    Icon = "cloud-off",
    Default = true,
    ConfigKey = "NoFog",
})

visualSub:AddParagraph({
    Title = "实时信息",
    Icon = "activity",
    Info = "等待数据…",
})

local infoParagraph = visualSub:AddParagraph({
    Title = "运行状态",
    Icon = "cpu",
    Info = "初始化中",
})

RunService.RenderStepped:Connect(function()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    infoParagraph:SetInfo(string.format(
        "FOV: %d\n加速: %s\n重力: %s",
        math.floor(cam.FieldOfView),
        speedToggle:GetValue() and "开" or "关",
        tostring(gravityDropdown:GetSelected())
    ))
end)

visualSub:AddLine({ Color = Color3.fromRGB(80, 90, 120), Thickness = 2, Inset = 16 })

visualSub:AddButton({
    Title = "应用视觉设置",
    Icon = "check",
    OnClick = function()
        win:SaveConfig("视觉预设")
        win:ShowNotify("已保存 视觉预设.json")
    end,
})

local aboutTab = win:AddTab({ Title = "关于", Icon = "info" })
local aboutSub = aboutTab:AddSubTitle({ Title = "脚本切换", Icon = "arrow-right-left" })

aboutSub:AddParagraph({
    Title = "这是什么",
    Icon = "help-circle",
    Info = "本脚本与 DynamicCowUI_Example.lua 使用不同的 Title，\n"
        .. "因此后加载的那个会走「脚本切换」接管入场动画，\n"
        .. "并自动展开面板、显示旋转 loader。\n\n"
        .. "展开面板后，收起按钮左侧会出现 arrow-right-left 按钮，\n"
        .. "点击即可在已载入的脚本之间切换。",
})

aboutSub:AddButton({
    Title = "列出已载入的脚本",
    Icon = "list",
    OnClick = function()
        local titles = Library.GetLoadedTitles()
        print("已载入:", table.concat(titles, " | "))
        win:ShowNotify("共 " .. #titles .. " 个脚本")
    end,
})

aboutSub:AddButton({
    Title = "切回示例1",
    Icon = "arrow-right-left",
    OnClick = function()
        local other = nil
        for _, t in ipairs(Library.GetLoadedTitles()) do
            if t ~= "CowTools 工具箱" then
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

aboutSub:AddButton({
    Title = "展开 / 收起本面板",
    Icon = "chevrons-up-down",
    OnClick = function()
        local open = win:GetWindowAction() == "WindowOpen"
        win:SetWindowAction(not open)
    end,
})

aboutSub:AddButton({
    Title = "改灵动岛文字",
    Icon = "type",
    OnClick = function()
        win.DynamicIslandAction:ChangeIconText("CowTools 已就绪", "wrench", Color3.fromRGB(255, 190, 90))
    end,
})

aboutSub:AddButton({
    Title = "卸载本脚本",
    Icon = "power",
    OnClick = function()
        win:Unload()
    end,
})

task.spawn(function()
    local shown = false
    while not shown do
        task.wait(2)
        if win:GetWindowAction() == "WindowOpen" then
            shown = true
            win:ShowNotify("CowTools 已加载")
        end
    end
end)
