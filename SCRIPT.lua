local player = game.Players.LocalPlayer

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "WavesGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0, 120, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

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

-- BOTÃO ATIVAR (FIXO NO CENTRO)
local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0, 200, 0, 45)
button.Position = UDim2.new(0.5, -100, 0, 70)
button.Text = "ATIVAR"
button.BackgroundColor3 = Color3.fromRGB(0,170,0)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 15

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

-- FECHAR
local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -34, 0, 6)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,60,60)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 14

Instance.new("UICorner", close)

-- ================= LÓGICA =================
local ativo = false

local function loopWaves()
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

button.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		button.Text = "DESATIVAR"
		button.BackgroundColor3 = Color3.fromRGB(180,60,60)
		loopWaves()
	else
		button.Text = "ATIVAR"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)
	end
end)

close.MouseButton1Click:Connect(function()
	ativo = false
	gui:Destroy()
end)
