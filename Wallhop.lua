--Obf by @dinhgiaphat1309
local _G,_P,_W,_U,_R = game, game:GetService("Players"), game:GetService("Workspace"), game:GetService("UserInputService"), game:GetService("RunService")
local _LP = _P.LocalPlayer
local _PG = _LP:WaitForChild("PlayerGui")

local _SG = Instance.new("ScreenGui")
_SG.Parent = _PG
_SG.ResetOnSpawn = false

local _F = Instance.new("Frame")
_F.Parent = _SG
_F.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
_F.BackgroundTransparency = 0.1
_F.Size = UDim2.new(0, 240, 0, 90)
_F.Position = UDim2.new(0.5, -120, 0.5, -45)
_F.Active = true
_F.Draggable = true

local _C = Instance.new("UICorner")
_C.CornerRadius = UDim.new(0, 14)
_C.Parent = _F

local _S = Instance.new("UIStroke")
_S.Parent = _F
_S.Color = Color3.fromRGB(85, 103, 255)
_S.Thickness = 1.5

local _FT = Font.new("rbxassetid://12187369046")

local _TL = Instance.new("TextLabel")
_TL.Parent = _F
_TL.BackgroundTransparency = 1
_TL.Size = UDim2.new(1, 0, 0, 28)
_TL.Position = UDim2.new(0, 0, 0, 8)
_TL.Text = "⚡ WALLHOP V2"
_TL.TextColor3 = Color3.fromRGB(220, 224, 255)
_TL.TextSize = 13
_TL.FontFace = _FT

local _TB = Instance.new("TextButton")
_TB.Parent = _F
_TB.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
_TB.Size = UDim2.new(1, -24, 0, 36)
_TB.Position = UDim2.new(0, 12, 0, 42)
_TB.Text = ""
_TB.AutoButtonColor = false

local _TC = Instance.new("UICorner")
_TC.CornerRadius = UDim.new(0, 8)
_TC.Parent = _TB

local _TT = Instance.new("TextLabel")
_TT.Parent = _TB
_TT.BackgroundTransparency = 1
_TT.Size = UDim2.new(1, -50, 1, 0)
_TT.Position = UDim2.new(0, 12, 0, 0)
_TT.Text = "Enable WallHop"
_TT.TextColor3 = Color3.fromRGB(200, 200, 220)
_TT.TextSize = 12
_TT.FontFace = _FT
_TT.TextXAlignment = Enum.TextXAlignment.Left

local _ST = Instance.new("Frame")
_ST.Parent = _TB
_ST.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
_ST.Size = UDim2.new(0, 38, 0, 20)
_ST.Position = UDim2.new(1, -46, 0.5, -10)

local _SKC = Instance.new("UICorner")
_SKC.CornerRadius = UDim.new(1, 0)
_SKC.Parent = _ST

local _SK = Instance.new("Frame")
_SK.Parent = _ST
_SK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_SK.Size = UDim2.new(0, 16, 0, 16)
_SK.Position = UDim2.new(0, 2, 0.5, -8)

local _SKKC = Instance.new("UICorner")
_SKKC.CornerRadius = UDim.new(1, 0)
_SKKC.Parent = _SK

local _Tog = false
local _IE = true
local _RP = RaycastParams.new()
_RP.FilterType = Enum.RaycastFilterType.Blacklist

local function _GWR()
    local _Ch = _LP.Character
    if not _Ch then return nil end
    local _HRP = _Ch:FindFirstChild("HumanoidRootPart")
    if not _HRP then return nil end
    _RP.FilterDescendantsInstances = {_Ch}
    local _Dirs = {
        _HRP.CFrame.LookVector,
        -_HRP.CFrame.LookVector,
        _HRP.CFrame.RightVector,
        -_HRP.CFrame.RightVector
    }
    local _Dist = 2
    local _CHit = nil
    local _MinD = _Dist + 1
    for _, _Dir in pairs(_Dirs) do
        local _Ray = _W:Raycast(_HRP.Position, _Dir * _Dist, _RP)
        if _Ray and _Ray.Instance then
            if _Ray.Distance < _MinD then
                _MinD = _Ray.Distance
                _CHit = _Ray
            end
        end
    end
    return _CHit
end

_TB.MouseButton1Click:Connect(function()
    _Tog = not _Tog
    if _Tog then
        _ST.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        _SK:TweenPosition(UDim2.new(1, -18, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
    else
        _ST.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        _SK:TweenPosition(UDim2.new(0, 2, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
    end
end)

_U.JumpRequest:Connect(function()
    if not _Tog or not _IE then return end
    local _Ch = _LP.Character
    local _Hum = _Ch and _Ch:FindFirstChildOfClass("Humanoid")
    local _HRP = _Ch and _Ch:FindFirstChild("HumanoidRootPart")
    local _Cam = _W.CurrentCamera
    if not (_Hum and _HRP and _Cam) then return end
    local _WRes = _GWR()
    if _WRes then
        _IE = false
        local _WN = _WRes.Normal
        local _HWN = Vector3.new(_WN.X, 0, _WN.Z).Unit
        if _HWN.Magnitude < 0.1 then
            _HWN = (_HRP.CFrame.LookVector * Vector3.new(1,0,1)).Unit
            if _HWN.Magnitude < 0.1 then _HWN = Vector3.new(0,0,-1) end
        end
        local _BDAW = _HWN
        local _CL = _Cam.CFrame.LookVector
        local _HCL = Vector3.new(_CL.X, 0, _CL.Z).Unit
        if _HCL.Magnitude < 0.1 then _HCL = _BDAW end
        local _MIA = math.rad(40)
        local _Dot = math.clamp(_BDAW:Dot(_HCL), -1, 1)
        local _AB = math.acos(_Dot)
        local _Cr = _BDAW:Cross(_HCL)
        local _RS = math.sign(_Cr.Y)
        if _RS == 0 then _AB = 0 end
        local _AIA = math.min(_AB, _MIA)
        local _AR = CFrame.Angles(0, _AIA * _RS, 0)
        local _ITL = _AR * _BDAW
        _HRP.CFrame = CFrame.lookAt(_HRP.Position, _HRP.Position + _ITL)
        _R.Heartbeat:Wait()
        local _DJ = false
        if _Hum and _Hum:GetState() ~= Enum.HumanoidStateType.Dead then
            _Hum:ChangeState(Enum.HumanoidStateType.Jumping)
            _DJ = true
        end
        if _DJ then
            local _DTW = -_BDAW
            _HRP.CFrame = CFrame.lookAt(_HRP.Position, _HRP.Position + _DTW)
        end
        task.wait(0.15)
        _IE = true
    end
end)
