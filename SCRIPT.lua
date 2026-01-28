-- ================= PLAYER =================
local player = game.Players.LocalPlayer

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "WavesGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 300, 0, 190)
frame.Position = UDim2.new(0, 120, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(22,22,22)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "Waves Control"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Left

-- BOTÃO ATIVAR
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.new(0, 220, 0, 46)
toggle.Position = UDim2.new(0.5, -110, 0, 70)
toggle.Text = "ATIVAR"
toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 15
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

-- FECHAR
local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -36, 0, 6)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,60,60)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
Instance.new("UICorner", close)

-- ================= LÓGICA =================
local ativo = false
local connections = {}

local function limparConexoes()
	for _, c in ipairs(connections) do
		if c then c:Disconnect() end
	end
	table.clear(connections)
end

local function ativarWaves()
	local waves = workspace:FindFirstChild("Waves")
	if not waves then return end

	-- Remove colisão dos existentes
	for _, obj in ipairs(waves:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CanCollide = false
		end
	end

	-- Remove colisão dos novos
	table.insert(connections, waves.DescendantAdded:Connect(function(obj)
		if obj:IsA("BasePart") then
			task.wait()
			obj.CanCollide = false
		end
	end))
end

local function desativarWaves()
	limparConexoes()
end

-- ================= BOTÕES =================
toggle.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		toggle.Text = "DESATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(180,60,60)
		ativarWaves()
	else
		toggle.Text = "ATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
		desativarWaves()
	end
end)

close.MouseButton1Click:Connect(function()
	ativo = false
	limparConexoes()
	gui:Destroy()
end)
