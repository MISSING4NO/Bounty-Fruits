local swordTemplate = workspace:WaitForChild("Sword") -- Tool eller modell

-- Om sv�rdet �r en Tool i Workspace, annars h�mta fr�n ReplicatedStorage

local Players = game:GetService("Players")

-- N�r en spelare trycker p� ProximityPrompt, kopiera tool till spelarens Backpack
local prompt = swordTemplate:FindFirstChildWhichIsA("ProximityPrompt")

prompt.Triggered:Connect(function(player)
	-- Kolla om spelaren redan har sv�rdet i Backpack eller Character
	if player.Backpack:FindFirstChild(swordTemplate.Name) or (player.Character and player.Character:FindFirstChild(swordTemplate.Name)) then
		-- Spelaren har redan sv�rdet, g�r inget
		return
	end

	-- Kopiera sv�rdet till spelaren
	local swordClone = swordTemplate:Clone()
	swordClone.Parent = player.Backpack
end)
