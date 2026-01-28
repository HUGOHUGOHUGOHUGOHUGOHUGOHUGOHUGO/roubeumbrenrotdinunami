-- PLAYER
local player = game.Players.LocalPlayer

-- CONTROLE
local ativo = false

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "WavesGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.4, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.Text = "Waves Control"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Left

-- BOTÃO ATIVAR (CENTRALIZADO)
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.new(0, 200, 0, 42)
toggle.Position = UDim2.new(0.5, -100, 0, 60)
toggle.Text = "ATIVAR"
toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,12)

-- FECHAR
local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0,24,0,24)
close.Position = UDim2.new(1,-34,0,10)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,50,50)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
Instance.new("UICorner", close)

-- ================= FUNÇÃO =================
local function rodarWaves()
	task.spawn(function()
		while ativo do
			local waves = workspace:FindFirstChild("Waves")
			if waves then
				for _, obj in pairs(waves:GetChildren()) do
					obj:Destroy()
				end
				for _, obj in ipairs(waves:GetDescendants()) do
					if obj:IsA("BasePart") then
						obj.CanCollide = false
					end
				end
			end
			task.wait(1)
		end
	end)
end

-- ================= BOTÕES =================
toggle.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		toggle.Text = "DESATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(180,50,50)
		rodarWaves()
	else
		toggle.Text = "ATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
	end
end)

close.MouseButton1Click:Connect(function()
	ativo = false
	gui:Destroy()
end)
