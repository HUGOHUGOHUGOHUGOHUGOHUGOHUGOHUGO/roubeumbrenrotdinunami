while true do
local waves = workspace:WaitForChild("Waves")

while true do
	for _, obj in pairs(waves:GetChildren()) do
		obj:Destroy()
	end
	task.wait(1) -- tempo entre as verificações
end
for _, obj in ipairs(workspace.Waves:GetDescendants()) do
	if obj:IsA("BasePart") then
		obj.CanCollide = false
	end
end
end
