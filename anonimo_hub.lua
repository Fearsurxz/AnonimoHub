--// 🔴 ANÓNIMO HUB | FLY + NOCLIP (SIN FLOTAR)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char, hrp, humanoid

local flying = false
local noclip = false
local speed = 80
local verticalSpeed = 50

-- ===== CARGAR PERSONAJE =====
local function loadChar()
	char = player.Character or player.CharacterAdded:Wait()
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
end
loadChar()
player.CharacterAdded:Connect(loadChar)

-- ===== ATTACHMENT =====
local att = Instance.new("Attachment", hrp)

local lv = Instance.new("LinearVelocity")
lv.Attachment0 = att
lv.MaxForce = math.huge
lv.RelativeTo = Enum.ActuatorRelativeTo.World
lv.Enabled = false
lv.Parent = hrp

local ao = Instance.new("AlignOrientation")
ao.Attachment0 = att
ao.MaxTorque = math.huge
ao.Responsiveness = 200
ao.Enabled = false
ao.Parent = hrp

-- ===== NOCLIP =====
RunService.Stepped:Connect(function()
	if noclip and char then
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- ===== FLY (SIN FLOTAR) =====
RunService.RenderStepped:Connect(function()
	if flying then
		local moveDir = humanoid.MoveDirection
		local cam = workspace.CurrentCamera

		-- 🔥 SOLO SUBE/BAJA SI USAS EL JOYSTICK
		local vertical = cam.CFrame.LookVector.Y * verticalSpeed * moveDir.Magnitude

		if moveDir.Magnitude > 0 then
			lv.VectorVelocity = Vector3.new(
				moveDir.X * speed,
				vertical,
				moveDir.Z * speed
			)
		else
			lv.VectorVelocity = Vector3.zero
		end

		ao.CFrame = cam.CFrame
	end
end)

-- ===== START / STOP FLY =====
local function startFly()
	flying = true
	lv.Enabled = true
	ao.Enabled = true
end

local function stopFly()
	flying = false
	lv.Enabled = false
	ao.Enabled = false
	lv.VectorVelocity = Vector3.zero
end

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,160)
frame.Position = UDim2.new(1,-220,0.5,-80)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Thickness = 2

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "🔴 ANÓNIMO HUB"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 13

-- ===== BOTÓN FLY =====
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.85,0,0,35)
flyBtn.Position = UDim2.new(0.075,0,0.32,0)
flyBtn.Text = "✈️ FLY : OFF"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 12
flyBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
flyBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", flyBtn).Color = Color3.fromRGB(255,0,0)

flyBtn.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
		flyBtn.Text = "✈️ FLY : OFF"
	else
		startFly()
		flyBtn.Text = "✈️ FLY : ON"
	end
end)

-- ===== BOTÓN NOCLIP =====
local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Size = UDim2.new(0.85,0,0,35)
noclipBtn.Position = UDim2.new(0.075,0,0.62,0)
noclipBtn.Text = "🚫 NOCLIP : OFF"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 12
noclipBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
noclipBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", noclipBtn).Color = Color3.fromRGB(255,0,0)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "🚫 NOCLIP : ON" or "🚫 NOCLIP : OFF"
end)
