local swordTemplate = workspace:WaitForChild("Sword") -- Tool eller modell

-- Om svärdet är en Tool i Workspace, annars hämta från ReplicatedStorage

local Players = game:GetService("Players")

-- När en spelare trycker på ProximityPrompt, kopiera tool till spelarens Backpack
local prompt = swordTemplate:FindFirstChildWhichIsA("ProximityPrompt")

prompt.Triggered:Connect(function(player)
	-- Kolla om spelaren redan har svärdet i Backpack eller Character
	if player.Backpack:FindFirstChild(swordTemplate.Name) or (player.Character and player.Character:FindFirstChild(swordTemplate.Name)) then
		-- Spelaren har redan svärdet, gör inget
		return
	end

	-- Kopiera svärdet till spelaren
	local swordClone = swordTemplate:Clone()
	swordClone.Parent = player.Backpack
end)
