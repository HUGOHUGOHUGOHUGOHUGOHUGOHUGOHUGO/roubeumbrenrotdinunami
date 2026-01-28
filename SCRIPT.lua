local player = game.Players.LocalPlayer

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 150)
frame.Position = UDim2.new(0, 150, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "Waves Control"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0, 200, 0, 45)
button.Position = UDim2.new(0.5, -100, 0, 60)
button.Text = "ATIVAR"
button.BackgroundColor3 = Color3.fromRGB(0,170,0)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 15

-- ===== LÓGICA =====
local ativo = false
local workspaceConn
local wavesConn

local function aplicar(waves)
	for _, obj in ipairs(waves:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CanCollide = false
			obj:Destroy()
		end
	end

	wavesConn = waves.DescendantAdded:Connect(function(obj)
		if obj:IsA("BasePart") then
			task.wait()
			obj.CanCollide = false
			obj:Destroy()
		end
	end)
end

local function ativar()
	local waves = workspace:FindFirstChild("Waves")
	if waves then
		aplicar(waves)
	end

	workspaceConn = workspace.ChildAdded:Connect(function(child)
		if child.Name == "Waves" then
			aplicar(child)
		end
	end)
end

local function desativar()
	if workspaceConn then workspaceConn:Disconnect() workspaceConn = nil end
	if wavesConn then wavesConn:Disconnect() wavesConn = nil end
end

-- 🔥 EVENTO CORRETO (NÃO BUGA)
button.Activated:Connect(function()
	ativo = not ativo

	if ativo then
		button.Text = "DESATIVAR"
		button.BackgroundColor3 = Color3.fromRGB(170,0,0)
		ativar()
	else
		button.Text = "ATIVAR"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)
		desativar()
	end
end)
