local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MarketPlaceService = game:GetService("MarketplaceService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local targetParent = pcall(function() return CoreGui end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

task.spawn(function()
	local message = "Chan bố mày đi lol"
	local message = "By Đinh Thái Hòa"
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
main.Size = UDim2.new(0, 270, 0, 660)
main.Position = UDim2.new(0.05, 0, 0.15, 0)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
main.BackgroundTransparency = 0.08
main.Active = true
main.Draggable = true
main.ClipsDescendants = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 1.8
stroke.Color = Color3.fromRGB(85, 103, 255)
local gradient = Instance.new("UIGradient", stroke)
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 103, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})

local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 48, 0, 48)
minIcon.Position = main.Position
minIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
minIcon.Text = "Đ"
minIcon.TextColor3 = Color3.fromRGB(85, 103, 255)
minIcon.TextSize = 24
minIcon.FontFace = customFont
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 14)

local minStroke = Instance.new("UIStroke", minIcon)
minStroke.Thickness = 1.8
minStroke.Color = Color3.fromRGB(85, 103, 255)

local lagTriggerBtn = Instance.new("TextButton", sg)
lagTriggerBtn.Name = "LagTriggerButton"
lagTriggerBtn.Size = UDim2.new(0, 110, 0, 42)
lagTriggerBtn.Position = UDim2.new(0.4, 0, 0.1, 0)
lagTriggerBtn.BackgroundColor3 = Color3.fromRGB(85, 103, 255)
lagTriggerBtn.Text = "LAG 0.5S"
lagTriggerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
lagTriggerBtn.TextSize = 13
lagTriggerBtn.FontFace = customFont
lagTriggerBtn.Visible = false
lagTriggerBtn.Active = true
lagTriggerBtn.Draggable = true
Instance.new("UICorner", lagTriggerBtn).CornerRadius = UDim.new(0, 12)

local lagTriggerStroke = Instance.new("UIStroke", lagTriggerBtn)
lagTriggerStroke.Thickness = 1.5
lagTriggerStroke.Color = Color3.fromRGB(255, 255, 255)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.Text = "Định Thái Hoà Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.TextSize = 16
title.FontFace = customFont

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -40, 0, 8)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
minBtn.TextSize = 18
minBtn.FontFace = customFont
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, -32, 0, 1)
line.Position = UDim2.new(0, 16, 0, 46)
line.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
line.BorderSizePixel = 0

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, 0, 1, -56)
container.Position = UDim2.new(0, 0, 0, 52)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 540)
container.ScrollBarThickness = 4
container.ScrollBarImageColor3 = Color3.fromRGB(85, 103, 255)

local layout = Instance.new("UIListLayout", container)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)

local function createButton(text, order)
	local btn = Instance.new("TextButton", container)
	btn.Size = UDim2.new(1, -32, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(150, 150, 170)
	btn.TextSize = 12
	btn.FontFace = customFont
	btn.LayoutOrder = order
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	local bStroke = Instance.new("UIStroke", btn)
	bStroke.Thickness = 1.2
	bStroke.Color = Color3.fromRGB(45, 45, 60)
	return btn, bStroke
end

local toggleBtn, toggleStroke = createButton("HITBOX 23x23 : OFF", 1)
local speedBtn, speedStroke = createButton("SPEED x3 (EVADE) : OFF", 2)
local spinBtn, spinStroke = createButton("XOAY 360 : OFF", 3)
local espBtn, espStroke = createButton("ESP MM2 : OFF", 4)
local aimBtn, aimStroke = createButton("AIMBOT : OFF", 5)
local fpsBtn, fpsStroke = createButton("144FPS : OFF", 6)
local invBtn, invStroke = createButton("TÀNG HÌNH : OFF", 7)
local jumpBtn, jumpStroke = createButton("AUTO NHẢY : OFF", 8)
local tracerBtn, tracerStroke = createButton("TRACER 120FPS : ON", 9)
local lagBtn, lagStroke = createButton("LAG : OFF", 10)

tracerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tracerStroke.Color = Color3.fromRGB(85, 103, 255)

local itemBtn = Instance.new("TextButton", container)
itemBtn.Size = UDim2.new(1, -32, 0, 36)
itemBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
itemBtn.Text = "LẤY VẬT PHẨM (6880366374)"
itemBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
itemBtn.TextSize = 11
itemBtn.FontFace = customFont
itemBtn.LayoutOrder = 11
Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 10)
local itemStroke = Instance.new("UIStroke", itemBtn)
itemStroke.Thickness = 1.2
itemStroke.Color = Color3.fromRGB(85, 103, 255)

local selectBtn = Instance.new("TextButton", container)
selectBtn.Size = UDim2.new(1, -32, 0, 36)
selectBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
selectBtn.Text = "Chọn người chơi..."
selectBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
selectBtn.TextSize = 12
selectBtn.FontFace = customFont
selectBtn.LayoutOrder = 12
Instance.new("UICorner", selectBtn).CornerRadius = UDim.new(0, 10)
local selectStroke = Instance.new("UIStroke", selectBtn)
selectStroke.Thickness = 1.2
selectStroke.Color = Color3.fromRGB(45, 45, 60)

local playerList = Instance.new("ScrollingFrame", container)
playerList.Size = UDim2.new(1, -32, 0, 110)
playerList.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 4
playerList.LayoutOrder = 13
Instance.new("UICorner", playerList).CornerRadius = UDim.new(0, 8)

local listLayout = Instance.new("UIListLayout", playerList)
listLayout.Padding = UDim.new(0, 4)

local tpBtn = Instance.new("TextButton", container)
tpBtn.Size = UDim2.new(1, -32, 0, 36)
tpBtn.BackgroundColor3 = Color3.fromRGB(85, 103, 255)
tpBtn.Text = "TELEPORT"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 13
tpBtn.FontFace = customFont
tpBtn.LayoutOrder = 14
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 10)

local TracerLines = {}

local function createTracerLine()
	local line = Drawing.new("Line")
	line.Thickness = 1.8
	line.Color = Color3.fromRGB(85, 103, 255)
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

local function updateToggleVisual(btn, stroke, state, textOn, textOff)
	btn.Text = state and textOn or textOff
	btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 170)
	btn.BackgroundColor3 = state and Color3.fromRGB(85, 103, 255) or Color3.fromRGB(20, 20, 28)
	stroke.Color = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(45, 45, 60)
end

toggleBtn.MouseButton1Click:Connect(function()
	HitboxEnabled = not HitboxEnabled
	updateToggleVisual(toggleBtn, toggleStroke, HitboxEnabled, "HITBOX 23x23 : ON", "HITBOX 23x23 : OFF")
end)

speedBtn.MouseButton1Click:Connect(function()
	SpeedEnabled = not SpeedEnabled
	updateToggleVisual(speedBtn, speedStroke, SpeedEnabled, "SPEED x3 (EVADE) : ON", "SPEED x3 (EVADE) : OFF")
end)

spinBtn.MouseButton1Click:Connect(function()
	SpinEnabled = not SpinEnabled
	updateToggleVisual(spinBtn, spinStroke, SpinEnabled, "XOAY 360 : ON", "XOAY 360 : OFF")
	updateSpin()
end)

espBtn.MouseButton1Click:Connect(function()
	EspMM2Enabled = not EspMM2Enabled
	updateToggleVisual(espBtn, espStroke, EspMM2Enabled, "ESP MM2 : ON", "ESP MM2 : OFF")
end)

aimBtn.MouseButton1Click:Connect(function()
	AimbotEnabled = not AimbotEnabled
	updateToggleVisual(aimBtn, aimStroke, AimbotEnabled, "AIMBOT : ON", "AIMBOT : OFF")
end)

fpsBtn.MouseButton1Click:Connect(function()
	Fps144Enabled = not Fps144Enabled
	updateToggleVisual(fpsBtn, fpsStroke, Fps144Enabled, "144FPS : ON", "144FPS : OFF")
	setMaxFPS(Fps144Enabled and 144 or 60)
end)

invBtn.MouseButton1Click:Connect(function()
	InvisibleEnabled = not InvisibleEnabled
	updateToggleVisual(invBtn, invStroke, InvisibleEnabled, "TÀNG HÌNH : ON", "TÀNG HÌNH : OFF")
	
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
	updateToggleVisual(jumpBtn, jumpStroke, AutoJumpEnabled, "AUTO NHẢY : ON", "AUTO NHẢY : OFF")
end)

tracerBtn.MouseButton1Click:Connect(function()
	TracerEnabled = not TracerEnabled
	updateToggleVisual(tracerBtn, tracerStroke, TracerEnabled, "TRACER 120FPS : ON", "TRACER 120FPS : OFF")
end)

lagBtn.MouseButton1Click:Connect(function()
	LagToggleEnabled = not LagToggleEnabled
	updateToggleVisual(lagBtn, lagStroke, LagToggleEnabled, "LAG : ON", "LAG : OFF")
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
		while os.clock() - startTime < 0.5 do
			root.CFrame = frozenCFrame
		end
		
		if moveDir.Magnitude > 0 then
			local moveSpeed = SpeedEnabled and (SpeedAmount * 60) or 20
			root.CFrame = frozenCFrame + (moveDir * (moveSpeed * 0.5))
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
		return "Murderer", Color3.fromRGB(255, 50, 50)
	elseif player.Character:FindFirstChild("Gun") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun")) then
		return "Sheriff", Color3.fromRGB(50, 150, 255)
	end
	
	return "Innocent", Color3.fromRGB(50, 255, 100)
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
			btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
			btn.Text = player.DisplayName .. " (@" .. player.Name .. ")"
			btn.TextColor3 = Color3.fromRGB(220, 220, 240)
			btn.TextSize = 11
			btn.FontFace = customFont
			btn.ZIndex = 6
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
			
			btn.MouseButton1Click:Connect(function()
				SelectedPlayer = player
				selectBtn.Text = player.DisplayName
				playerList.Visible = false
				container.CanvasSize = UDim2.new(0, 0, 0, 540)
			end)
		end
	end
	playerList.CanvasSize = UDim2.new(0, 0, 0, count * 32)
end

selectBtn.MouseButton1Click:Connect(function()
	playerList.Visible = not playerList.Visible
	if playerList.Visible then
		updatePlayerList()
		container.CanvasSize = UDim2.new(0, 0, 0, 660)
	else
		container.CanvasSize = UDim2.new(0, 0, 0, 540)
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
