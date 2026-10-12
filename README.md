# DynamicCowUI

**DynamicCowUI** 是一个面向 Roblox 的灵动岛风格动画 UI 库，整体外观参考 **iPhoneOS 的 Dynamic Island（灵动岛）**。

整个界面由屏幕顶部的一枚「灵动岛」承载：长按展开为完整面板，轻点做反馈动画，左右拖动可拉扯位移。目标不是再造一套标准 Roblox 面板，而是让脚本菜单拥有接近原生 iOS 的交互质感与视觉语言。

> 单文件、零依赖（除可选的 Lucide 图标资源）、`loadstring` 即可运行。

---

## ✨ 特性

- **🏝 灵动岛交互模型** —— 长按展开、单击反馈、左右拖动拉扯阻尼，全部基于 `TweenService` 补间驱动
- **🎬 图标 / 标题过场动画** —— 图标切换、标题渐变、面板展开错帧进场
- **🧩 完整控件集** —— 选项卡、分区、按钮、开关、滑条、下拉、段落、分隔线
- **💾 配置持久化** —— 所有带 `ConfigKey` 的控件自动读写同一份 `Config.json`，支持显式读写与单项编辑
- **🌈 Lucide 图标体系** —— 全部内置图标来自 Lucide，支持自定义名称与染色
- **🖼 远程图标** —— `IconFromURL` 下载期间显示旋转 loader，失败自动回退 `carton`
- **🎛 可主题化** —— 顶��� `Config` 表集中管理配色、尺寸、时长、缓动
- **🛡 防御式入参校验** —— 控件签名逐项校验，非法入参走错误动画而非静默崩溃

---

## 📦 安装

本库为**单文件分发**，无需包管理器。把 `DynamicCowUI.lua` 放进你的项目中，或直接远程引入：

```lua
local Library = loadstring(game:HttpGet(
    "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"
))()
```

> 建议加一层缓存，避免每次启动重复下载：
> ```lua
> local LIB_URL = "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"
> if not isfile("DynamicCowUI.lua") then
>     writefile("DynamicCowUI.lua", game:HttpGet(LIB_URL))
> end
> local Library = loadstring(readfile("DynamicCowUI.lua"))()
> ```

---

## 🚀 快速开始

```lua
local Library = loadstring(game:HttpGet(
    "https://ghfast.top/https://raw.githubusercontent.com/WasKKal/Roblox-DynamicCowUI/main/DynamicCowUI.lua"
))()

-- ① 创建窗口
local win = Library:CreateWindow({
    Title = "我的脚本面板",
    Info = "Powered by DynamicCowUI",
    Icon = "skull",
    IconFromURL = "https://example.com/icon.png",  -- 可选，优先级高于 Icon
    Folder = "MyScript",                          -- 配置保存目录（启用 ConfigKey 时必填）
    AutoLoadConfig = true,                        -- 启动时读回已保存的值（默认 true）
    AutoSaveConfig = true,                        -- 控件改动自动落盘（默认 true）
})

-- ② 添加选项卡与分区
local tab = win:AddTab({ Title = "主页", Icon = "house" })
local sub = tab:AddSubTitle({ Title = "基础功能", Icon = "sliders-horizontal" })

-- ③ 添加控件
sub:AddButton({
    Title = "重置数据",
    Icon = "rotate-ccw",
    OnClick = function()
        win:ShowNotify("数据已重置")
    end,
})

sub:AddToggle({
    Title = "自动拾取",
    Icon = "hand",
    Default = true,
    ConfigKey = "AutoPickup",   -- 绑定配置键，自动保存 / 恢复
})

sub:AddSlider({
    Title = "速度",
    Icon = "gauge",
    MinValue = 0,
    MaxValue = 100,
    Default = 50,
    ConfigKey = "Speed",
})

sub:AddDropdown({
    Title = "模式",
    Icon = "list",
    Value = { "简单", "普通", "困难" },
    DefaultValue = "普通",
    ConfigKey = "Mode",
})
```

完整示例见仓库中的 [`DynamicCowUI_Example.lua`](./DynamicCowUI_Example.lua)。

---

## 🖱 灵动岛操作

| 操作 | 效果 |
|------|------|
| **长按** 灵动岛 | 展开为完整面板（阈值 `Config.LongPressThreshold`，默认 0.5s） |
| **单击** 灵动岛 | 触发点击反馈（连点三次触发提示动画，演示用法） |
| **左右拖动** | 灵动岛跟手位移，带阻尼与回弹 |
| **悬停 / 点击图标** | 图标与标题执行过场动画 |

---

## 📖 API

### `Library:CreateWindow(opts)`

| 字段 | 类型 | 说明 |
|------|------|------|
| `Title` | `string` | 窗口标题（灵动岛收起时显示） |
| `Info` | `string` | 副标题，显示于标题下方 |
| `Icon` | `string` | Lucide 图标名，如 `"skull"` |
| `IconFromURL` | `string` | 远程图标 URL，**优先级高于 `Icon`**；下载期间显示旋转 loader，失败回退 `carton` |
| `Folder` | `string` | 配置保存目录名（使用 `ConfigKey` 时必填） |
| `AutoLoadConfig` | `boolean` | 启动时读回配置，默认 `true` |
| `AutoSaveConfig` | `boolean` | 控件改动自动落盘，默认 `true`；设为 `false` 需显式调用 `win:SaveConfig()` |

### 窗口方法

| 方法 | 说明 |
|------|------|
| `win:AddTab({ Title, Icon })` | 新建选项卡，返回 tab 对象 |
| `win:ShowNotify(text)` | 在灵动岛上播放一段提示动画 |
| `win:GetWindowAction()` | 返回 `"WindowOpen"` / `"WindowClose"` |
| `win:SaveConfig([name])` | 将当前控件值写入配置（无参时写入 `Config.json`） |
| `win:LoadConfig([name])` | 从配置读回并写回控件 |
| `win:EditConfig(name, key, value)` | 读取 → 改单项 → 写回 → 同步控件 |
| `win:Error([text])` | 主动触发错误动画 |

### 分区控件

均挂载于 `tab:AddSubTitle()` 返回的对象上。

| 方法 | 关键字段 |
|------|----------|
| `AddButton({ Title, Icon, OnClick })` | — |
| `AddToggle({ Title, Icon, Default, IconColor, ThumbColor, TrackColor, ConfigKey, Callback })` | 开关 |
| `AddSlider({ Title, Degree, MinValue, MaxValue, FillColor, Default, Value, ConfigKey })` | 滑条 |
| `AddDropdown({ Title, Multiple, Value, DefaultValue, ConfigKey })` | 下拉，`Value` 为条目数组 |
| `AddParagraph({ Title, Desc, Image, ImageSize, ImageColor })` | 段落 |
| `AddLine()` | 横向细分隔线 |

### 灵动岛信息位

```lua
-- 改变收起态灵动岛显示的文字
Library.DynamicIslandAction:ChangeText("自定义文字")

-- 图文胖岛：文字 + 图标 + 配色
Library.DynamicIslandAction:ChangeIconText("加载完成", "check", Color3.fromRGB(0, 255, 120))
```

---

## 💾 配置持久化

所有带 `ConfigKey` 的控件会自动保存到 `Folder/Config.json`（**单文件合并存储**，不再是每个键一个 json）。

```lua
-- 读取（启动时自动执行，取决于 AutoLoadConfig）
win:LoadConfig()

-- 写入（AutoSaveConfig = false 时需显式调用）
win:SaveConfig()

-- 独立配置档
win:SaveConfig("preset1")
win:LoadConfig("preset1")
```

---

## 🎨 主题定制

所有外观与动效参数集中在库内`Config` 表顶部，按需修改即可：

```lua
Config.IslandSize        -- 灵动岛尺寸
Config.IslandPosition    -- 灵动岛位置
Config.IslandCornerRadius -- 圆角
Config.PanelExpandTime   -- 面板展开时长
Config.LongPressThreshold -- 长按阈值
Config.DefaultTitleIcon  -- 默认标题图标
Config.TitleLoaderIcon   -- 加载中旋转图标
Config.TitleIconFailIcon -- 图标加载失败兜底
```

---

## 🗂 项目结构

```
Roblox-DynamicCowUI/
├── DynamicCowUI.lua          # 主库（单文件，包含全部逻辑）
├── DynamicCowUI_Example.lua# 完整用法示例
├── icon.png                  # 示例图标
├── LICENSE                   # 自定义 MIT 开源协议
└── README.md
```

---

## ❓ 常见问题

**Q：图标不显示？**
A：确认 `Icon` 为有效的 Lucide 图标名。远程图标需确保 URL 可访问，加载失败会自动回退 `carton`。

**Q：面板无法展开？**
A：需**长按**（默认 0.5s）灵动岛，轻点不会展开。连点三次会触发提示动画，此后有 2 秒点击冷却（长按不受影响）。

**Q：`ConfigKey` 报「缺少 Folder」？**
A：`ConfigKey` 依赖 `CreateWindow` 的 `Folder` 字段，需先设置。

**Q：会覆盖其他脚本的配置吗？**
A：配置按 `Folder` 名隔离，建议每个脚本使用独立的 `Folder`。

---

## 📄 许可证

本项目采用**自定义 MIT 开源协议**，非标准 MIT。

**Copyright (c) 2026 WasKKalWe / 蛙QwQ**

- ✅ 保留作者身份（WasKKalWe / 蛙QwQ）的前提下，允许二次分发、二次改造、学习交流、私人持有等一切**非商业用途**
- ✅ 允许二次改造后**闭源分发**，但仍须保留作者署名与本许可声明
- ❌ **绝对不允许任何形式的商用**（销售、付费分发、嵌入商业产品 / 服务等）

完整条款见仓库根目录 [`LICENSE`](./LICENSE)。