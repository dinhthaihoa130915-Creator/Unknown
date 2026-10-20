-- Đinh Thái Hòa
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Trạng thái tính năng
local autoShootEnabled = false
local autoSlashEnabled = false
local espEnabled = false
local infJumpEnabled = false
local speedEnabled = false
local hitboxEnabled = false
local freezeEnabled = false

local originalSizes = {}
local currentHitboxSize = 6
local menuVisible = true

-- ==================== 2. TẠO GUI MENU CHÍNH ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MMDScriptGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 400)
MainFrame.Position = UDim2.new(0.5, -100, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 8)
UICornerTitle.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Text = "MMD Script" -- [ĐÃ ĐỔI TÊN]
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.SourceSansBold
TitleText.BackgroundTransparency = 1
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Position = UDim2.new(1, -32, 0, 2)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = TitleBar

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 6)
UICornerMin.Parent = MinimizeButton

-- Hàm hỗ trợ tạo Button
local function CreateButton(name, text, posY, color)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 180, 0, 38)
	btn.Position = UDim2.new(0.5, -90, 0, posY)
	btn.Text = text
	btn.BackgroundColor3 = color or Color3.fromRGB(200, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 13
	btn.Font = Enum.Font.SourceSansBold
	btn.Parent = MainFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	return btn
end

-- Tạo các nút bấm
local ShootButton = CreateButton("ShootButton", "Auto Shoot: OFF", 42)
local SlashButton = CreateButton("SlashButton", "Auto Slash: OFF", 86)
local EspButton = CreateButton("EspButton", "ESP (Wallhack): OFF", 130)
local InfJumpButton = CreateButton("InfJumpButton", "Infinite Jump: OFF", 174)
local SpeedButton = CreateButton("SpeedButton", "Speed CFrame: OFF", 218)
local HitboxButton = CreateButton("HitboxButton", "Hitbox Expander: OFF", 262, Color3.fromRGB(200, 120, 0))

local HitboxSizeBox = Instance.new("TextBox")
HitboxSizeBox.Name = "HitboxSizeBox"
HitboxSizeBox.Size = UDim2.new(0, 180, 0, 38)
HitboxSizeBox.Position = UDim2.new(0.5, -90, 0, 306)
HitboxSizeBox.Text = "6"
HitboxSizeBox.PlaceholderText = "Nhập size (VD: 6, 15...)"
HitboxSizeBox.BackgroundColor3 = Color3.fromRGB(120, 50, 200)
HitboxSizeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxSizeBox.TextSize = 13
HitboxSizeBox.Font = Enum.Font.SourceSansBold
HitboxSizeBox.ClearTextOnFocus = false
HitboxSizeBox.Parent = MainFrame

local cornerBox = Instance.new("UICorner")
cornerBox.CornerRadius = UDim.new(0, 6)
cornerBox.Parent = HitboxSizeBox

local ServerHopButton = CreateButton("ServerHopButton", "Server Hop", 350, Color3.fromRGB(50, 100, 200))

-- Nút Freeze riêng biệt
local FreezeGui = Instance.new("ScreenGui")
FreezeGui.Name = "FreezeButtonGui"
FreezeGui.Parent = PlayerGui
FreezeGui.ResetOnSpawn = false

local FreezeFloatingBtn = Instance.new("TextButton")
FreezeFloatingBtn.Name = "FreezeFloatingBtn"
FreezeFloatingBtn.Size = UDim2.new(0, 100, 0, 40)
FreezeFloatingBtn.Position = UDim2.new(0.8, 0, 0.15, 0)
FreezeFloatingBtn.Text = "Freeze: OFF"
FreezeFloatingBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FreezeFloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeFloatingBtn.TextSize = 12
FreezeFloatingBtn.Font = Enum.Font.SourceSansBold
FreezeFloatingBtn.Active = true
FreezeFloatingBtn.Draggable = true
FreezeFloatingBtn.Parent = FreezeGui

local UICornerFreeze = Instance.new("UICorner")
UICornerFreeze.CornerRadius = UDim.new(0, 6)
UICornerFreeze.Parent = FreezeFloatingBtn

-- ==================== 3. SỰ KIỆN NÚT BẤM (BUTTON EVENTS) ====================
MinimizeButton.MouseButton1Click:Connect(function()
	menuVisible = not menuVisible
	MinimizeButton.Text = menuVisible and "-" or "+"
	for _, child in ipairs(MainFrame:GetChildren()) do
		if child ~= TitleBar and child:IsA("GuiObject") then
			child.Visible = menuVisible
		end
	end
	MainFrame.Size = menuVisible and UDim2.new(0, 200, 0, 400) or UDim2.new(0, 200, 0, 32)
end)

ShootButton.MouseButton1Click:Connect(function()
	autoShootEnabled = not autoShootEnabled
	ShootButton.Text = autoShootEnabled and "Auto Shoot: ON" or "Auto Shoot: OFF"
	ShootButton.BackgroundColor3 = autoShootEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

SlashButton.MouseButton1Click:Connect(function()
	autoSlashEnabled = not autoSlashEnabled
	SlashButton.Text = autoSlashEnabled and "Auto Slash: ON" or "Auto Slash: OFF"
	SlashButton.BackgroundColor3 = autoSlashEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

EspButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	EspButton.Text = espEnabled and "ESP (Wallhack): ON" or "ESP (Wallhack): OFF"
	EspButton.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	if not espEnabled then
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("EspHighlight") then
				player.Character.EspHighlight:Destroy()
			end
		end
	end
end)

InfJumpButton.MouseButton1Click:Connect(function()
	infJumpEnabled = not infJumpEnabled
	InfJumpButton.Text = infJumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
	InfJumpButton.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

SpeedButton.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled
	SpeedButton.Text = speedEnabled and "Speed CFrame: ON" or "Speed CFrame: OFF"
	SpeedButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

HitboxButton.MouseButton1Click:Connect(function()
	hitboxEnabled = not hitboxEnabled
	HitboxButton.Text = hitboxEnabled and "Hitbox Expander: ON" or "Hitbox Expander: OFF"
	HitboxButton.BackgroundColor3 = hitboxEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 120, 0)
	
	if not hitboxEnabled then
		for player, size in pairs(originalSizes) do
			if player and player.Character then
				local hrp = player.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.Size = size
					hrp.Transparency = 1
				end
			end
		end
		originalSizes = {}
	end
end)

HitboxSizeBox.FocusLost:Connect(function()
	local num = tonumber(HitboxSizeBox.Text)
	if num and num > 0 then
		currentHitboxSize = num
		HitboxSizeBox.Text = tostring(num)
	else
		HitboxSizeBox.Text = tostring(currentHitboxSize)
	end
end)

ServerHopButton.MouseButton1Click:Connect(function()
	ServerHopButton.Text = "Hopping..."
	pcall(function()
		local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
		for _, server in ipairs(servers.data or {}) do
			if server.playing < server.maxPlayers and server.id ~= game.JobId then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
				return
			end
		end
	end)
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

FreezeFloatingBtn.MouseButton1Click:Connect(function()
	freezeEnabled = not freezeEnabled
	FreezeFloatingBtn.Text = freezeEnabled and "Freeze: ON" or "Freeze: OFF"
	FreezeFloatingBtn.BackgroundColor3 = freezeEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	
	if not freezeEnabled then
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character then
				local hrp = player.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.Anchored = false
				end
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	originalSizes[player] = nil
end)

-- ==================== 4. HÀM HỖ TRỢ VÀ TÍNH NĂNG ====================
local function IsTeammate(player)
	if player == LocalPlayer then return true end
	local char = player.Character
	if not char then return false end
	
	for _, child in ipairs(char:GetChildren()) do
		if child:IsA("Highlight") and child.Name ~= "EspHighlight" then
			return true
		end
	end
	return false
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local function IsVisible(targetPart, targetCharacter)
	local origin = Camera.CFrame.Position
	local targetPos = targetPart.Position
	
	raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetCharacter}
	
	local result = workspace:Raycast(origin, targetPos - origin, raycastParams)
	return result == nil
end

local function GetBestTarget()
	local bestTarget = nil
	local shortestDist = math.huge
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and not IsTeammate(player) then
			local character = player.Character
			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
				
				if humanoid and humanoid.Health > 0 and rootPart then
					if IsVisible(rootPart, character) then
						local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
						if dist < shortestDist then
							shortestDist = dist
							bestTarget = { Position = rootPart.Position, Part = rootPart }
						end
					end
				end
			end
		end
	end
	
	return bestTarget
end

-- ==================== 5. VÒNG LẶP CHẠY TÍNH NĂNG (LOOPS) ====================

-- ESP Loop
task.spawn(function()
	while true do
		if espEnabled then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character then
					local character = player.Character
					local highlight = character:FindFirstChild("EspHighlight")
					if not highlight then
						highlight = Instance.new("Highlight")
						highlight.Name = "EspHighlight"
						highlight.Adornee = character
						highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						highlight.FillTransparency = 0.5
						highlight.OutlineTransparency = 0
						highlight.Parent = character
					end
					
					if IsTeammate(player) then
						highlight.FillColor = Color3.fromRGB(0, 150, 255)
					else
						highlight.FillColor = Color3.fromRGB(255, 0, 0)
					end
				end
			end
		end
		task.wait(1.5)
	end
end)

-- Infinite Jump Event
UserInputService.JumpRequest:Connect(function()
	if infJumpEnabled then
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end
end)

-- Speed CFrame Loop
RunService.Heartbeat:Connect(function()
	if speedEnabled then
		local character = LocalPlayer.Character
		if character then
			local rootPart = character:FindFirstChild("HumanoidRootPart")
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if rootPart and humanoid and humanoid.MoveDirection.Magnitude > 0 then
				rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * 0.7)
			end
		end
	end
end)

-- Hitbox Expander Loop
task.spawn(function()
	while true do
		if hitboxEnabled then
			local targetSize = Vector3.new(currentHitboxSize, currentHitboxSize, currentHitboxSize)
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and not IsTeammate(player) then
					local character = player.Character
					if character then
						local humanoid = character:FindFirstChildOfClass("Humanoid")
						local hrp = character:FindFirstChild("HumanoidRootPart")
						
						if humanoid and humanoid.Health > 0 and hrp then
							if not originalSizes[player] then
								originalSizes[player] = hrp.Size
							end
							hrp.Size = targetSize
							hrp.Transparency = 0.6
							hrp.CanCollide = false
						else
							if originalSizes[player] and hrp then
								hrp.Size = originalSizes[player]
								hrp.Transparency = 1
							end
							originalSizes[player] = nil
						end
					end
				end
			end
		end
		task.wait(0.5)
	end
end)

-- Freeze Enemy Loop
task.spawn(function()
	while true do
		if freezeEnabled then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and not IsTeammate(player) then
					local character = player.Character
					if character then
						local humanoid = character:FindFirstChildOfClass("Humanoid")
						local hrp = character:FindFirstChild("HumanoidRootPart")
						if humanoid and humanoid.Health > 0 and hrp then
							hrp.Anchored = true
							hrp.Velocity = Vector3.new(0, 0, 0)
						end
					end
				end
			end
		end
		task.wait(0.2)
	end
end)

-- Auto Shoot Loop
task.spawn(function()
	while true do
		if autoShootEnabled then
			pcall(function()
				local enemy = GetBestTarget()
				if enemy then
					local args = {
						Vector3.new(enemy.Position.X, enemy.Position.Y, enemy.Position.Z),
						enemy.Part
					}
					local character = LocalPlayer.Character
					if character then
						local currentTool = character:FindFirstChildOfClass("Tool")
						if currentTool then
							local finalRemote = currentTool:FindFirstChild("ShootStart", true) or currentTool:FindFirstChildOfClass("RemoteEvent")
							if finalRemote and finalRemote:IsA("RemoteEvent") then
								finalRemote:FireServer(unpack(args))
							end
						end
					end
				end
			end)
		end
		task.wait()
	end
end)

-- Auto Slash Loop
task.spawn(function()
	while true do
		if autoSlashEnabled then
			pcall(function()
				local character = LocalPlayer.Character
				if character then
					local currentTool = character:FindFirstChildOfClass("Tool")
					if currentTool then
						local knifeServer = currentTool:FindFirstChild("KnifeServer")
						if knifeServer then
							local slashStart = knifeServer:FindFirstChild("SlashStart")
							if slashStart and slashStart:IsA("RemoteEvent") then
								slashStart:FireServer()
							end
						end
					end
				end
			end)
		end
		task.wait()
	end
end)

print("MMD Script tải thành công!")
