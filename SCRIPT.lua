-- =========================
-- VARIÁVEIS
-- =========================
local player = game.Players.LocalPlayer
local antiWaves = false
local antiThread = nil
local selectedTarget = nil
local andando = false

-- =========================
-- GUI
-- =========================
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 300)
Frame.Position = UDim2.new(0.5, -150, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Anti Waves + Walk TP 2x"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- =========================
-- BOTÃO ANTI WAVES
-- =========================
local AntiBtn = Instance.new("TextButton", Frame)
AntiBtn.Size = UDim2.new(0.8,0,0,40)
AntiBtn.Position = UDim2.new(0.1,0,0,50)
AntiBtn.Text = "ATIVAR ANTI WAVES"
AntiBtn.Font = Enum.Font.GothamBold
AntiBtn.TextSize = 14
AntiBtn.TextColor3 = Color3.new(1,1,1)
AntiBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
Instance.new("UICorner", AntiBtn)

-- =========================
-- LISTA WORKSPACE
-- =========================
local List = Instance.new("ScrollingFrame", Frame)
List.Size = UDim2.new(0.8,0,0,120)
List.Position = UDim2.new(0.1,0,0,100)
List.CanvasSize = UDim2.new(0,0,0,0)
List.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", List)

local layout = Instance.new("UIListLayout", List)
layout.Padding = UDim.new(0,6)

-- =========================
-- BOTÃO ANDAR
-- =========================
local TPBtn = Instance.new("TextButton", Frame)
TPBtn.Size = UDim2.new(0.8,0,0,40)
TPBtn.Position = UDim2.new(0.1,0,1,-50)
TPBtn.Text = "ANDAR ATÉ O LOCAL (2x)"
TPBtn.Font = Enum.Font.GothamBold
TPBtn.TextSize = 14
TPBtn.TextColor3 = Color3.new(1,1,1)
TPBtn.BackgroundColor3 = Color3.fromRGB(0,140,200)
Instance.new("UICorner", TPBtn)

-- =========================
-- ANTI WAVES (SEU SCRIPT)
-- =========================
local function startAntiWaves()
	if antiThread then return end
	antiThread = task.spawn(function()
		local waves = workspace:WaitForChild("Waves")
		while antiWaves do
			for _, obj in pairs(waves:GetChildren()) do
				pcall(function() obj:Destroy() end)
			end
			for _, obj in ipairs(waves:GetDescendants()) do
				if obj:IsA("BasePart") then
					obj.CanCollide = false
				end
			end
			task.wait(1)
		end
		antiThread = nil
	end)
end

AntiBtn.MouseButton1Click:Connect(function()
	antiWaves = not antiWaves
	AntiBtn.Text = antiWaves and "DESATIVAR ANTI WAVES" or "ATIVAR ANTI WAVES"
	AntiBtn.BackgroundColor3 = antiWaves and Color3.fromRGB(0,170,80) or Color3.fromRGB(70,70,70)
	if antiWaves then startAntiWaves() end
end)

-- =========================
-- LISTAR WORKSPACE
-- =========================
local function refreshList()
	for _, v in ipairs(List:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end

	for _, obj in ipairs(workspace:GetChildren()) do
		if obj:IsA("Model") or obj:IsA("BasePart") or obj:IsA("Folder") then
			local b = Instance.new("TextButton", List)
			b.Size = UDim2.new(1,-10,0,30)
			b.Text = obj.Name
			b.Font = Enum.Font.Gotham
			b.TextSize = 13
			b.TextColor3 = Color3.new(1,1,1)
			b.BackgroundColor3 = Color3.fromRGB(60,60,60)
			Instance.new("UICorner", b)

			b.MouseButton1Click:Connect(function()
				selectedTarget = obj
				for _, x in ipairs(List:GetChildren()) do
					if x:IsA("TextButton") then
						x.BackgroundColor3 = Color3.fromRGB(60,60,60)
					end
				end
				b.BackgroundColor3 = Color3.fromRGB(0,120,200)
			end)
		end
	end

	task.wait()
	List.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end

refreshList()

-- =========================
-- ANDAR ATÉ O LOCAL (2X SPEED)
-- =========================
local function andarAte(pos)
	if andando then return end
	andando = true

	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")

	local velocidadeOriginal = humanoid.WalkSpeed
	humanoid.WalkSpeed = velocidadeOriginal * 2

	while (hrp.Position - pos).Magnitude > 6 do
		humanoid:MoveTo(pos)
		humanoid.MoveToFinished:Wait()
	end

	humanoid.WalkSpeed = velocidadeOriginal
	andando = false
end

TPBtn.MouseButton1Click:Connect(function()
	if not selectedTarget then return end

	local pos =
		selectedTarget:IsA("Model")
		and selectedTarget:GetPivot().Position
		or selectedTarget.Position

	andarAte(pos)
end)
