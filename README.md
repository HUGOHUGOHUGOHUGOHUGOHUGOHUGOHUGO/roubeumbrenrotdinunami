-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local waves = workspace:WaitForChild("Waves")

-- CONTROLE
local ativo = false
local loopTask

-- FUNÇÃO PRINCIPAL
local function iniciar()
	loopTask = task.spawn(function()
		while ativo do
			for _, obj in pairs(waves:GetChildren()) do
				obj:Destroy()
			end

			for _, obj in ipairs(waves:GetDescendants()) do
				if obj:IsA("BasePart") then
					obj.CanCollide = false
				end
			end

			task.wait(1)
		end
	end)
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 150)
frame.Position = UDim2.new(0.4, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- TÍTULO
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -60, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "Waves Control"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Left

-- BOTÃO ATIVAR
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0, 200, 0, 40)
toggle.Position = UDim2.new(0.5, -100, 0, 60)
toggle.Text = "ATIVAR"
toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14

Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

toggle.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		toggle.Text = "DESATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
		iniciar()
	else
		toggle.Text = "ATIVAR"
		toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	end
end)

-- FECHAR
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 14

Instance.new("UICorner", close)

close.MouseButton1Click:Connect(function()
	ativo = false
	gui:Destroy()
end)

-- MINIMIZAR
local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 25, 0, 25)
minimize.Position = UDim2.new(1, -60, 0, 5)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18

Instance.new("UICorner", minimize)

local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized

	if minimized then
		frame.Size = UDim2.new(0, 260, 0, 40)
	else
		frame.Size = UDim2.new(0, 260, 0, 150)
	end
end)
