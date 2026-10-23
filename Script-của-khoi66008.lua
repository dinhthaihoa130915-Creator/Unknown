-- Đinh Thái Hòa
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Dọn dẹp menu cũ nếu đã chạy trước đó
if CoreGui:FindFirstChild("CompactReportMenu") then
    CoreGui.CompactReportMenu:Destroy()
end

-- Khởi tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CompactReportMenu"
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- Khung chính của Menu (Tối ưu nhỏ gọn: rộng 300px, cao 380px)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 380)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(50, 50, 65)
mainStroke.Thickness = 1.2
mainStroke.Parent = mainFrame

-- Thanh tiêu đề
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 38)
topBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar

local fixCorner = Instance.new("Frame")
fixCorner.Size = UDim2.new(1, 0, 0, 8)
fixCorner.Position = UDim2.new(0, 0, 1, -8)
fixCorner.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
fixCorner.BorderSizePixel = 0
fixCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🛡️ REPORT PANEL (COMPACT)"
title.TextColor3 = Color3.fromRGB(240, 240, 245)
title.TextSize = 11
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Nút điều khiển (Ẩn/Hiện & Đóng)
local controlHolder = Instance.new("Frame")
controlHolder.Size = UDim2.new(0, 60, 0, 26)
controlHolder.Position = UDim2.new(1, -65, 0.5, -13)
controlHolder.BackgroundTransparency = 1
controlHolder.Parent = topBar

local ctrlLayout = Instance.new("UIListLayout")
ctrlLayout.FillDirection = Enum.FillDirection.Horizontal
ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
ctrlLayout.SortOrder = Enum.SortOrder.LayoutOrder
ctrlLayout.Padding = UDim.new(0, 4)
ctrlLayout.Parent = controlHolder

-- 1. Nút Thu gọn (-)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Text = "-"
minimizeBtn.TextSize = 13
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = controlHolder

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimizeBtn

-- 2. Nút Đóng (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.BackgroundColor3 = Color3.fromRGB(210, 45, 45)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "X"
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = controlHolder

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ScrollingFrame nhỏ gọn
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 0, 240)
scroll.Position = UDim2.new(0, 8, 0, 44)
scroll.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 3
scroll.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 6)
scrollCorner.Parent = scroll

local uiList = Instance.new("UIListLayout")
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 4)
uiList.Parent = scroll

-- Khung hiển thị thông báo bên dưới
local statusBox = Instance.new("Frame")
statusBox.Size = UDim2.new(1, -16, 0, 80)
statusBox.Position = UDim2.new(0, 8, 0, 290)
statusBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
statusBox.BorderSizePixel = 0
statusBox.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusBox

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -12, 1, 0)
statusLabel.Position = UDim2.new(0, 6, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(170, 170, 190)
statusLabel.Text = "💡 Click any feature to copy detailed English report text instantly."
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextWrapped = true
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusBox

-- Logic Thu gọn Menu
local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        scroll.Visible = false
        statusBox.Visible = false
        mainFrame.Size = UDim2.new(0, 300, 0, 38)
        minimizeBtn.Text = "+"
    else
        scroll.Visible = true
        statusBox.Visible = true
        mainFrame.Size = UDim2.new(0, 300, 0, 380)
        minimizeBtn.Text = "-"
    end
end)

-- MỞ RỘNG TÍNH NĂNG (9 danh mục báo cáo chi tiết)
local categories = {
    {
        Name = "🕊️ Fly / Infinite Jump (Hack bay)",
        Color = Color3.fromRGB(35, 35, 50),
        Text = "🚨 DETAILED REPORT - FLY EXPLOIT: I am formally reporting an active exploiter in this lobby who is utilizing unauthorized third-party flight scripts to bypass map boundaries and float mid-air. This disrupts the gameplay balance completely. Please review the server log data and take strict action."
    },
    {
        Name = "🌪️ Physics Fling Exploit (Quăng ném)",
        Color = Color3.fromRGB(50, 35, 40),
        Text = "🚨 DETAILED REPORT - FLING EXPLOIT: An exploiter in this server is abusing custom physics scripts to collision-fling and violently throw other players around the map. This causes severe gameplay disruption and server lag. Immediate moderation review and account restriction are required."
    },
    {
        Name = "⚡ Speed & Teleport (Hack tốc độ)",
        Color = Color3.fromRGB(35, 48, 38),
        Text = "🚨 DETAILED REPORT - SPEED & TELEPORT: I would like to report an individual who is blatantly running speed hacks and instant teleportation scripts in this match. They are instantly moving between objectives at impossible velocities, creating an unfair environment for legitimate participants."
    },
    {
        Name = "🎯 Aimbot / Wallhack / ESP (Tool ngắm bắn)",
        Color = Color3.fromRGB(48, 42, 32),
        Text = "🚨 DETAILED REPORT - AIMBOT / ESP: A player in this server is utilizing automated aimlock (aimbot) and wallhack/ESP scripts to track and eliminate opponents through solid walls and impossible angles. Please inspect their recent kill logs and input telemetry."
    },
    {
        Name = "🤖 Auto-Farm Botting (Bot treo máy)",
        Color = Color3.fromRGB(32, 45, 50),
        Text = "🚨 DETAILED REPORT - AUTOMATED FARMING: This user is running automated macro/scripting software to continuously farm currency and items without human interaction. This automated botting behavior ruins the server economy and violates the Roblox Terms of Service."
    },
    {
        Name = "🧱 Noclip / Wall Phase (Đi xuyên tường)",
        Color = Color3.fromRGB(40, 32, 48),
        Text = "🚨 DETAILED REPORT - NOCLIP EXPLOIT: I am reporting an individual who is abusing noclip scripts to walk directly through solid walls, barriers, and locked structures. This allows them to bypass game objectives unfairly and exploit safe zones."
    },
    {
        Name = "💬 Chat Spam & Botting (Spam chat)",
        Color = Color3.fromRGB(48, 48, 30),
        Text = "🚨 DETAILED REPORT - CHAT SPAM: A user in this game session is continuously flooding the main chat log with repetitive messages, massive text blocks, and automated scam/bot links, rendering regular communication impossible for everyone."
    },
    {
        Name = "🤬 Toxic & Bypass Filter (Nói bậy / Lách từ)",
        Color = Color3.fromRGB(50, 30, 35),
        Text = "🚨 DETAILED REPORT - TOXIC LANGUAGE: I am reporting a player who is actively bypassing the Roblox chat filter to send highly inappropriate, offensive slurs, and severe toxic insults toward other players. Please evaluate the chat logs and issue an immediate penalty."
    },
    {
        Name = "💻 General Scripting (Khai thác lỗ hổng)",
        Color = Color3.fromRGB(38, 38, 52),
        Text = "🚨 DETAILED REPORT - GENERAL EXPLOITING: This is a request to investigate an individual executing custom Luau scripts to manipulate core game mechanics and gain unfair advantages in this server. Thorough server log inspection is strongly advised."
    }
}

-- Tạo danh sách các nút bấm
for _, cat in ipairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 34)
    btn.BackgroundColor3 = cat.Color
    btn.TextColor3 = Color3.fromRGB(240, 240, 250)
    btn.Text = "  " .. cat.Name
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = scroll

    local btnC = Instance.new("UICorner")
    btnC.CornerRadius = UDim.new(0, 5)
    btnC.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = cat.Color
    end)

    btn.MouseButton1Click:Connect(function()
        local success = pcall(function()
            setclipboard(cat.Text)
        end)

        if success then
            statusLabel.Text = "✅ COPIED:\n" .. string.sub(cat.Text, 1, 85) .. "..."
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        else
            statusLabel.Text = "⚠️ Error: Executor does not support setclipboard!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

scroll.CanvasSize = UDim2.new(0, 0, 0, #categories * 38)

print("--> Compact Multi-Feature Report Menu loaded!")
