-- Script (Servidor)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local evento = ReplicatedStorage:WaitForChild("EventoExemplo")

evento.OnServerEvent:Connect(function(player, acao)
	if acao == "RemoteEvent" then
		print(player.Name .. " ativou o script no servidor")
		
		-- EXEMPLO: deixar imortal
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.MaxHealth = math.huge
			player.Character.Humanoid.Health = math.huge
		end
	end
end)


-- carregar biblioteca 
local Fluent = loadstring(game:HttpGet(
    "https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

-- notificação
Fluent:Notify({
    Title = "Executado",
    Content = "Anti-Waves carregado"
})

-- janela
local Window = Fluent:CreateWindow({
    Title = "Steal a brenrot Hub" .. Fluent.Version,
    TabWidth = 160,
    Size = UDim2.fromOffset(420, 260),
    Theme = "Dark"
})

-- aba única
local Tab = Window:AddTab({ Title = "Anti-Waves" })

-- ===============================
-- 🔥 LÓGICA ANTI-WAVES
-- ===============================

local ativo = false
local workspaceConn
local wavesConn

local function limpar()
    if workspaceConn then
        workspaceConn:Disconnect()
        workspaceConn = nil
    end
    if wavesConn then
        wavesConn:Disconnect()
        wavesConn = nil
    end
end

local function processarWaves(waves)
    -- remove o que já existe
    for _, obj in ipairs(waves:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CanCollide = false
            obj:Destroy()
        end
    end

    -- remove o que nascer depois
    wavesConn = waves.DescendantAdded:Connect(function(obj)
        if obj:IsA("BasePart") then
            task.wait()
            obj.CanCollide = false
            obj:Destroy()
        end
    end)
end

local function ativar()
    local w = workspace:FindFirstChild("Waves")
    if w then
        processarWaves(w)
    end

    workspaceConn = workspace.ChildAdded:Connect(function(child)
        if child.Name == "Waves" then
            processarWaves(child)
        end
    end)
end

local function desativar()
    limpar()
end

-- ===============================
-- 🔘 TOGGLE ÚNICO
-- ===============================
Tab:AddToggle("antiwaves", {
    Title = "Anti-Waves",
    Description = "Remove Waves e tira colisão",
    Default = false,
    Callback = function(state)
        ativo = state
        if state then
            ativar()
            Fluent:Notify({
                Title = "Anti-Waves",
                Content = "Ligado"
            })
        else
            desativar()
            Fluent:Notify({
                Title = "Anti-Waves",
                Content = "Desligado"
            })
        end
    end
})
