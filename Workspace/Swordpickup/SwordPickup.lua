local prompt = script.Parent:WaitForChild("ProximityPrompt")
local sword = game.ServerStorage:WaitForChild("Sword")

prompt.Triggered:Connect(function(player)
	if not player.Backpack:FindFirstChild("Sword") then
		local swordClone = sword:Clone()
		swordClone.Parent = player.Backpack
		print(player.Name.." plockade upp svärdet!")

		-- Spara direkt efter pickup
		local DataStoreService = game:GetService("DataStoreService")
		local swordStore = DataStoreService:GetDataStore("SwordInventory")

		local success, err = pcall(function()
			swordStore:SetAsync(player.UserId, true)
		end)

		if success then
			print("Svärd pickup sparad för: "..player.Name)
		else
			warn("Kunde inte spara svärd pickup för: "..player.Name.." Fel: "..err)
		end

		script.Parent:Destroy()
	end
end)
