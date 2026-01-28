local player = game.Players.LocalPlayer

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Parent = gui
button.Size = UDim2.new(0, 220, 0, 50)
button.Position = UDim2.new(0, 100, 0, 100)
button.Text = "ATIVAR WAVES"
button.BackgroundColor3 = Color3.fromRGB(0,170,0)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.ZIndex = 10
button.AutoButtonColor = true

-- ===== CONTROLE =====
local ativo = false
local conns = {}

local function limparConns()
	for _, c in ipairs(conns) do
		c:Disconnect()
	end
	conns = {}
end

local function processar(waves)
	for _, v in ipairs(waves:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v:Destroy()
		end
	end

	table.insert(conns, waves.DescendantAdded:Connect(function(obj)
		if obj:IsA("BasePart") then
			task.wait()
			obj.CanCollide = false
			obj:Destroy()
		end
	end))
end

local function ativar()
	print("ATIVADO")
	local w = workspace:FindFirstChild("Waves")
	if w then
		processar(w)
	end

	table.insert(conns, workspace.ChildAdded:Connect(function(child)
		if child.Name == "Waves" then
			processar(child)
		end
	end))
end

local function desativar()
	print("DESATIVADO")
	limparConns()
end

-- 🔥 BOTÃO (100% FUNCIONAL)
button.Activated:Connect(function()
	ativo = not ativo

	if ativo then
		button.Text = "DESATIVAR WAVES"
		button.BackgroundColor3 = Color3.fromRGB(170,0,0)
		ativar()
	else
		button.Text = "ATIVAR WAVES"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)
		desativar()
	end
end)
