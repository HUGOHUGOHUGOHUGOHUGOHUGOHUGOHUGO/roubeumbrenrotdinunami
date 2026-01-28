local player = game.Players.LocalPlayer

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "WavesGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0, 150, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ZIndex = 1

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Waves Control"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.ZIndex = 2

-- BOTÃO (ZINDEX ALTO)
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.new(0, 200, 0, 45)
toggle.Position = UDim2.new(0.5, -100, 0, 60)
toggle.Text = "ATIVAR"
toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 15
toggle.ZIndex = 3

Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

-- ================= LÓGICA =================
local ativo = false
local conexao

local function ativar()
	local waves = workspace:FindFirstChild("Waves")
	if not waves then return end

	for _, obj in ipairs(waves:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CanCollide = false
		end
	end

	conexao = waves.DescendantAdded:Connect(function(obj)
		if obj:IsA("BasePart") then
			task.wait()
			obj.CanCollide = false
		end
	end)
end

local function desativar()
	if conexao then
		conexao:Disconnect()
		conexao = nil
	end
end

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
