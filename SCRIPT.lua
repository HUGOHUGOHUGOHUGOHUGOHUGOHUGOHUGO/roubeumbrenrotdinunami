-- FORÇA CRIAR GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TestGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- FRAME
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.4, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.Active = true
frame.Draggable = true

-- BOTÃO
local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 0, 40)
button.Text = "ATIVAR"
button.BackgroundColor3 = Color3.fromRGB(0,170,0)
button.TextColor3 = Color3.new(1,1,1)

-- LÓGICA
local ativo = false

button.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		button.Text = "DESATIVAR"
		button.BackgroundColor3 = Color3.fromRGB(170,0,0)

		task.spawn(function()
			while ativo do
				local waves = workspace:FindFirstChild("Waves")
				if waves then
					for _, v in pairs(waves:GetChildren()) do
						v:Destroy()
					end
				end
				task.wait(1)
			end
		end)
	else
		button.Text = "ATIVAR"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)
	end
end)
