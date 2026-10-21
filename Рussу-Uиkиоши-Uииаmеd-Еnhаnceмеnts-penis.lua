-- By ★彡 Рussу Uиkиоши 彡★
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MarketPlaceService = game:GetService("MarketplaceService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local targetParent = pcall(function() return CoreGui end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

task.spawn(function()
	local message = "★彡 Рussу Uиkиоши 彡★"
	pcall(function()
		if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			local generalChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
			if generalChannel then
				generalChannel:SendAsync(message)
			end
		else
			local defaultChatSystemChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			if defaultChatSystemChatEvents then
				local sayMessageRequest = defaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
				if sayMessageRequest then
					sayMessageRequest:FireServer(message, "All")
				end
			end
		end
	end)
end)

if targetParent:FindFirstChild("LimitedEditionUI") then
	targetParent:FindFirstChild("LimitedEditionUI"):Destroy()
end

local customFont = Font.fromId(12187369046)

local sg = Instance.new("ScreenGui")
sg.Name = "LimitedEditionUI"
sg.ResetOnSpawn = false
sg.Parent = targetParent

local HitboxEnabled = false
local SpeedEnabled = false
local SpinEnabled = false
local EspMM2Enabled = false
local AimbotEnabled = false
local Fps144Enabled = false
local InvisibleEnabled = false
local AutoJumpEnabled = false
local InfiniteJumpEnabled = false
local TracerEnabled = true
local LagToggleEnabled = false
local HitboxSize = 23
local SelectedPlayer = nil
local savedPosition = nil
local SpeedAmount = 1.35
local IsLagging = false

local function setMaxFPS(cap)
	pcall(function()
		if setfpscap then
			setfpscap(cap)
		elseif set_fps_cap then
			set_fps_cap(cap)
		end
	end)
end

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 680)
main.Position = UDim2.new(0.05, 0, 0.15, 0)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BackgroundTransparency = 0.05
main.Active = true
main.Draggable = true
main.ClipsDescendants = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 1.8
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local gradient = Instance.new("UIGradient", stroke)
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
})

local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 48, 0, 48)
minIcon.Position = main.Position
minIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
minIcon.Text = "H"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 22
minIcon.FontFace = customFont
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 12)

local minStroke = Instance.new("UIStroke", minIcon)
minStroke.Thickness = 1.5
minStroke.Color = Color3.fromRGB(255, 255, 255)

local lagTriggerBtn = Instance.new("TextButton", sg)
lagTriggerBtn.Name = "LagTriggerButton"
lagTriggerBtn.Size = UDim2.new(0, 110, 0, 42)
lagTriggerBtn.Position = UDim2.new(0.4, 0, 0.1, 0)
lagTriggerBtn.BackgroundColor3 = Color3.fromRGB(85, 103, 255)
lagTriggerBtn.Text = "LAG 0.12S"
lagTriggerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
lagTriggerBtn.TextSize = 13
lagTriggerBtn.FontFace = customFont
lagTriggerBtn.Visible = false
lagTriggerBtn.Active = true
lagTriggerBtn.Draggable = true
Instance.new("UICorner", lagTriggerBtn).CornerRadius = UDim.new(0, 10)

local lagTriggerStroke = Instance.new("UIStroke", lagTriggerBtn)
lagTriggerStroke.Thickness = 1.5
lagTriggerStroke.Color = Color3.fromRGB(255, 255, 255)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.Text = "Limited Edition"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.TextSize = 16
title.FontFace = customFont

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -38, 0, 7)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
minBtn.TextSize = 18
minBtn.FontFace = customFont
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, -32, 0, 1)
line.Position = UDim2.new(0, 16, 0, 42)
line.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
line.BorderSizePixel = 0

local function createButton(text, yPos, parent)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, -32, 0, 32)
	btn.Position = UDim2.new(0, 16, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(120, 120, 120)
	btn.TextSize = 12
	btn.FontFace = customFont
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	local bStroke = Instance.new("UIStroke", btn)
	bStroke.Thickness = 1.2
	bStroke.Color = Color3.fromRGB(50, 50, 50)
	return btn, bStroke
end

local toggleBtn, toggleStroke = createButton("HITBOX : OFF", 50, main)
local speedBtn, speedStroke = createButton("SPEED x3 : OFF", 88, main)
local spinBtn, spinStroke = createButton("XOAY 360 : OFF", 126, main)
local espBtn, espStroke = createButton("ESP : OFF", 164, main)
local aimBtn, aimStroke = createButton("AIMBOT : OFF", 202, main)
local fpsBtn, fpsStroke = createButton("144FPS : OFF", 240, main)
local invBtn, invStroke = createButton("TÀNG HÌNH : OFF", 278, main)
local jumpBtn, jumpStroke = createButton("AUTO NHẢY : OFF", 316, main)
local infJumpBtn, infJumpStroke = createButton("NHẢY VÔ HẠN : OFF", 354, main)
local tracerBtn, tracerStroke = createButton("TRACER 120FPS : ON", 392, main)
local lagBtn, lagStroke = createButton("LAG : OFF", 430, main)

tracerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tracerStroke.Color = Color3.fromRGB(255, 255, 255)

local itemBtn = Instance.new("TextButton", main)
itemBtn.Size = UDim2.new(1, -32, 0, 32)
itemBtn.Position = UDim2.new(0, 16, 0, 468)
itemBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
itemBtn.Text = "★彡 Рussу Uиkиоши 彡★"
itemBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
itemBtn.TextSize = 11
itemBtn.FontFace = customFont
Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 10)
local itemStroke = Instance.new("UIStroke", itemBtn)
itemStroke.Thickness = 1.2
itemStroke.Color = Color3.fromRGB(80, 80, 80)

local selectBtn = Instance.new("TextButton", main)
selectBtn.Size = UDim2.new(1, -32, 0, 32)
selectBtn.Position = UDim2.new(0, 16, 0, 506)
selectBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
selectBtn.Text = "Chọn người chơi"
selectBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
selectBtn.TextSize = 12
selectBtn.FontFace = customFont
Instance.new("UICorner", selectBtn).CornerRadius = UDim.new(0, 10)
local selectStroke = Instance.new("UIStroke", selectBtn)
selectStroke.Thickness = 1.2
selectStroke.Color = Color3.fromRGB(50, 50, 50)

local playerList = Instance.new("ScrollingFrame", main)
playerList.Size = UDim2.new(1, -32, 0, 100)
playerList.Position = UDim2.new(0, 16, 0, 544)
playerList.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 4
playerList.ZIndex = 5
Instance.new("UICorner", playerList).CornerRadius = UDim.new(0, 8)

local listLayout = Instance.new("UIListLayout", playerList)
listLayout.Padding = UDim.new(0, 4)

local tpBtn = Instance.new("TextButton", main)
tpBtn.Size = UDim2.new(1, -32, 0, 32)
tpBtn.Position = UDim2.new(0, 16, 0, 544)
tpBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.Text = "Dịch chuyển"
tpBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
tpBtn.TextSize = 13
tpBtn.FontFace = customFont
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 10)

local TracerLines = {}

local function createTracerLine()
	local line = Drawing.new("Line")
	line.Thickness = 1.8
	line.Color = Color3.fromRGB(255, 255, 255)
	line.Transparency = 1
	line.Visible = false
	return line
end

local bav = nil
local function updateSpin()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if SpinEnabled then
		if not bav or bav.Parent ~= hrp then
			if bav then bav:Destroy() end
			bav = Instance.new("BodyAngularVelocity")
			bav.Name = "UnknownSpin"
			bav.MaxTorque = Vector3.new(0, math.huge, 0)
			bav.AngularVelocity = Vector3.new(0, 44, 0)
			bav.Parent = hrp
		end
	else
		if bav then
			bav:Destroy()
			bav = nil
		end
		local oldBav = hrp:FindFirstChild("UnknownSpin")
		if oldBav then oldBav:Destroy() end
	end
end

-- Logic Nhảy Vô Hạn (Infinite Jump)
UserInputService.JumpRequest:Connect(function()
	if InfiniteJumpEnabled then
		local char = LocalPlayer.Character
		if char then
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end
end)

toggleBtn.MouseButton1Click:Connect(function()
	HitboxEnabled = not HitboxEnabled
	toggleBtn.Text = HitboxEnabled and "HITBOX : ON" or "HITBOX : OFF"
	toggleBtn.TextColor3 = HitboxEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	toggleStroke.Color = HitboxEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

speedBtn.MouseButton1Click:Connect(function()
	SpeedEnabled = not SpeedEnabled
	speedBtn.Text = SpeedEnabled and "SPEED x3 : ON" or "SPEED x3 : OFF"
	speedBtn.TextColor3 = SpeedEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	speedStroke.Color = SpeedEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

spinBtn.MouseButton1Click:Connect(function()
	SpinEnabled = not SpinEnabled
	spinBtn.Text = SpinEnabled and "XOAY 360 : ON" or "XOAY 360 : OFF"
	spinBtn.TextColor3 = SpinEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	spinStroke.Color = SpinEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
	updateSpin()
end)

espBtn.MouseButton1Click:Connect(function()
	EspMM2Enabled = not EspMM2Enabled
	espBtn.Text = EspMM2Enabled and "ESP : ON" or "ESP : OFF"
	espBtn.TextColor3 = EspMM2Enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	espStroke.Color = EspMM2Enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

aimBtn.MouseButton1Click:Connect(function()
	AimbotEnabled = not AimbotEnabled
	aimBtn.Text = AimbotEnabled and "AIMBOT : ON" or "AIMBOT : OFF"
	aimBtn.TextColor3 = AimbotEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	aimStroke.Color = AimbotEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

fpsBtn.MouseButton1Click:Connect(function()
	Fps144Enabled = not Fps144Enabled
	fpsBtn.Text = Fps144Enabled and "144FPS : ON" or "144FPS : OFF"
	fpsBtn.TextColor3 = Fps144Enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	fpsStroke.Color = Fps144Enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
	setMaxFPS(Fps144Enabled and 144 or 60)
end)

invBtn.MouseButton1Click:Connect(function()
	InvisibleEnabled = not InvisibleEnabled
	invBtn.Text = InvisibleEnabled and "TÀNG HÌNH : ON" or "TÀNG HÌNH : OFF"
	invBtn.TextColor3 = InvisibleEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	invStroke.Color = InvisibleEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
	
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local hrp = char.HumanoidRootPart
		if InvisibleEnabled then
			savedPosition = hrp.CFrame
		else
			if savedPosition then
				hrp.CFrame = savedPosition
			end
		end
	end
end)

jumpBtn.MouseButton1Click:Connect(function()
	AutoJumpEnabled = not AutoJumpEnabled
	jumpBtn.Text = AutoJumpEnabled and "AUTO NHẢY : ON" or "AUTO NHẢY : OFF"
	jumpBtn.TextColor3 = AutoJumpEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	jumpStroke.Color = AutoJumpEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

infJumpBtn.MouseButton1Click:Connect(function()
	InfiniteJumpEnabled = not InfiniteJumpEnabled
	infJumpBtn.Text = InfiniteJumpEnabled and "NHẢY VÔ HẠN : ON" or "NHẢY VÔ HẠN : OFF"
	infJumpBtn.TextColor3 = InfiniteJumpEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	infJumpStroke.Color = InfiniteJumpEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

tracerBtn.MouseButton1Click:Connect(function()
	TracerEnabled = not TracerEnabled
	tracerBtn.Text = TracerEnabled and "TRACER 120FPS : ON" or "TRACER 120FPS : OFF"
	tracerBtn.TextColor3 = TracerEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	tracerStroke.Color = TracerEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
end)

lagBtn.MouseButton1Click:Connect(function()
	LagToggleEnabled = not LagToggleEnabled
	lagBtn.Text = LagToggleEnabled and "LAG : ON" or "LAG : OFF"
	lagBtn.TextColor3 = LagToggleEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
	lagStroke.Color = LagToggleEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
	lagTriggerBtn.Visible = LagToggleEnabled
end)

lagTriggerBtn.MouseButton1Click:Connect(function()
	if IsLagging then return end
	IsLagging = true
	
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local humanoid = char and char:FindFirstChildOfClass("Humanoid")
	
	if root and humanoid then
		local frozenCFrame = root.CFrame
		local moveDir = humanoid.MoveDirection
		
		local startTime = os.clock()
		while os.clock() - startTime < 0.12 do
			root.CFrame = frozenCFrame
		end
		
		if moveDir.Magnitude > 0 then
			local moveSpeed = SpeedEnabled and (SpeedAmount * 60) or 20
			root.CFrame = frozenCFrame + (moveDir * (moveSpeed * 0.12))
		end
	end
	
	IsLagging = false
end)

itemBtn.MouseButton1Click:Connect(function()
	pcall(function()
		MarketPlaceService:PromptPurchase(LocalPlayer, 6880366374)
	end)
end)

local function getMM2Role(player)
	if not player.Character then return "Innocent", Color3.fromRGB(0, 255, 0) end
	
	if player.Character:FindFirstChild("Knife") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife")) then
		return "Murderer", Color3.fromRGB(255, 0, 0)
	elseif player.Character:FindFirstChild("Gun") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun")) then
		return "Sheriff", Color3.fromRGB(0, 120, 255)
	end
	
	return "Innocent", Color3.fromRGB(0, 255, 0)
end

local function updatePlayerList()
	for _, child in pairs(playerList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	local count = 0
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			count = count + 1
			local btn = Instance.new("TextButton", playerList)
			btn.Size = UDim2.new(1, -8, 0, 28)
			btn.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			btn.Text = player.DisplayName .. " (@" .. player.Name .. ")"
			btn.TextColor3 = Color3.fromRGB(220, 220, 220)
			btn.TextSize = 11
			btn.FontFace = customFont
			btn.ZIndex = 6
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
			
			btn.MouseButton1Click:Connect(function()
				SelectedPlayer = player
				selectBtn.Text = player.DisplayName
				playerList.Visible = false
				tpBtn.Position = UDim2.new(0, 16, 0, 544)
				main.Size = UDim2.new(0, 260, 0, 680)
			end)
		end
	end
	playerList.CanvasSize = UDim2.new(0, 0, 0, count * 32)
end

selectBtn.MouseButton1Click:Connect(function()
	playerList.Visible = not playerList.Visible
	if playerList.Visible then
		updatePlayerList()
		tpBtn.Position = UDim2.new(0, 16, 0, 650)
		main.Size = UDim2.new(0, 260, 0, 700)
	else
		tpBtn.Position = UDim2.new(0, 16, 0, 544)
		main.Size = UDim2.new(0, 260, 0, 680)
	end
end)

tpBtn.MouseButton1Click:Connect(function()
	if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
		end
	end
end)

minBtn.MouseButton1Click:Connect(function()
	minIcon.Position = main.Position
	main.Visible = false
	minIcon.Visible = true
end)

minIcon.MouseButton1Click:Connect(function()
	main.Position = minIcon.Position
	minIcon.Visible = false
	main.Visible = true
end)

RunService.RenderStepped:Connect(function()
	if LocalPlayer.Character and not IsLagging then
		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		
		if AutoJumpEnabled and humanoid then
			if humanoid.FloorMaterial ~= Enum.Material.Air then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end

		if SpeedEnabled and humanoid and root then
			local moveDir = humanoid.MoveDirection
			if moveDir.Magnitude > 0 then
				local raycastParams = RaycastParams.new()
				raycastParams.FilterType = Enum.RaycastFilterType.Exclude
				raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
				raycastParams.IgnoreWater = true
				
				local rayResult = Workspace:Raycast(root.Position, moveDir * 3.0, raycastParams)
				
				if not rayResult then
					root.CFrame = root.CFrame + (moveDir * SpeedAmount)
				else
					local slideDir = moveDir - rayResult.Normal * moveDir:Dot(rayResult.Normal)
					if slideDir.Magnitude > 0 then
						root.CFrame = root.CFrame + (slideDir.Unit * SpeedAmount)
					end
				end
			end
		end
		
		if root then
			if InvisibleEnabled then
				root.CFrame = CFrame.new(root.Position.X, 99999, root.Position.Z)
				root.Velocity = Vector3.new(0, 0, 0)
				root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end
		end
	end

	if Camera then
		Camera.FieldOfView = AimbotEnabled and 144 or 120
	end

	local closestTarget = nil
	local closestDist = math.huge
	local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if player.Character then
				local hrp = player.Character:FindFirstChild("HumanoidRootPart")
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				local head = player.Character:FindFirstChild("Head")
				
				if hrp and humanoid and humanoid.Health > 0 then
					if HitboxEnabled then
						hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						hrp.Color = Color3.fromRGB(255, 255, 255)
						hrp.Transparency = 0.5
						hrp.Material = Enum.Material.SmoothPlastic
						hrp.CanCollide = false
					else
						hrp.Size = Vector3.new(2, 2, 1)
						hrp.Transparency = 1
					end

					local role, roleColor = getMM2Role(player)
					local highlight = player.Character:FindFirstChild("UnknownESP")
					local billboard = head and head:FindFirstChild("UnknownTag")

					if EspMM2Enabled then
						if not highlight then
							highlight = Instance.new("Highlight")
							highlight.Name = "UnknownESP"
							highlight.Parent = player.Character
						end
						highlight.FillColor = roleColor
						highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						highlight.FillTransparency = 0.4

						if head then
							if not billboard then
								billboard = Instance.new("BillboardGui")
								billboard.Name = "UnknownTag"
								billboard.Size = UDim2.new(0, 150, 0, 30)
								billboard.StudsOffset = Vector3.new(0, 2.5, 0)
								billboard.AlwaysOnTop = true
								billboard.Parent = head

								local txt = Instance.new("TextLabel", billboard)
								txt.Name = "RoleLabel"
								txt.Size = UDim2.new(1, 0, 1, 0)
								txt.BackgroundTransparency = 1
								txt.TextSize = 13
								txt.FontFace = customFont
								txt.TextStrokeTransparency = 0
							end
							
							local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0)
							local roleText = role == "Murderer" and "🔪 SÁT NHÂN" or (role == "Sheriff" and "🔫 CẢNH SÁT" or "👤 DÂN THƯỜNG")
							
							billboard.RoleLabel.Text = player.DisplayName .. "\n[" .. roleText .. " - " .. dist .. "m]"
							billboard.RoleLabel.TextColor3 = roleColor
						end
					else
						if highlight then highlight:Destroy() end
						if billboard then billboard:Destroy() end
					end

					if not TracerLines[player] then
						TracerLines[player] = createTracerLine()
					end
					
					local tracer = TracerLines[player]
					local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
					
					if TracerEnabled and onScreen then
						tracer.From = screenCenter
						tracer.To = Vector2.new(screenPos.X, screenPos.Y)
						tracer.Color = roleColor
						tracer.Visible = true
					else
						tracer.Visible = false
					end

					if AimbotEnabled then
						if onScreen then
							local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
							if dist < closestDist then
								closestDist = dist
								closestTarget = hrp
							end
						end
					end
				else
					if TracerLines[player] then
						TracerLines[player].Visible = false
					end
				end
			end
		else
			if TracerLines[player] then
				TracerLines[player].Visible = false
			end
		end
	end

	if AimbotEnabled and closestTarget then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(closestTarget.Position.X, hrp.Position.Y, closestTarget.Position.Z))
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if TracerLines[player] then
		TracerLines[player]:Remove()
		TracerLines[player] = nil
	end
end)
