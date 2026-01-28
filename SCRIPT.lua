-- ================= PLAYER =================
local player = game.Players.LocalPlayer

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "WavesGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 280, 0, 170)
frame.Position = UDim2.new(0, 150, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Waves Control"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Left

-- BOTÃO
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.new(0, 220, 0, 45)
toggle.Position = UDim2.new(0.5, -110, 0, 70)
toggle.Text = "ATIVAR"
toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 15
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

-- ================= LÓGICA =================
local ativo = false
local wavesFolder
local wavesAddedConn
local descendantConn

local function limparConexoes()
	if wavesAddedConn then
		wavesAddedConn:Disconnect()
		wavesAddedConn = nil
	end
	if descendantConn then
		descendantConn:Disconnect()
		descendantConn = nil
	end
end

local function aplicarWaves(waves)
	-- remove colisão + deleta existentes
	for _, obj in ipairs(waves:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CanCollide = false
			obj:Destroy()
		end
	end

	-- pega tudo que nascer depois
	descendantConn = waves.DescendantAdded:Connect(function(obj)
		if obj:IsA("BasePart") then
			task.wait()
			obj.CanCollide = false
			obj:Destroy()
		end
	end)
end

local function ativar()
	-- se já existir
	local waves = workspace:FindFirstChild("Waves")
	if waves then
		aplicarWaves(waves)
	end

	-- se aparecer ou recriar
	wavesAddedConn = workspace.ChildAdded:Connect(function(child)
		if child.Name == "Waves" then
			aplicarWaves(child)
		end
	end)
end

local function desativar()
	limparConexoes()
end

-- ================= BOTÃO =================
toggle.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		toggle.Text = "DESATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
		ativar()
	else
		toggle.Text = "ATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
		desativar()
	end
end)
