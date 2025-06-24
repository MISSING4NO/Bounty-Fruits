local DataStoreService = game:GetService("DataStoreService")
local swordStore = DataStoreService:GetDataStore("SwordInventory")

local swordName = "Sword" -- namnet p� ditt Tool i ServerStorage

game.Players.PlayerAdded:Connect(function(player)
	-- H�mta spelarens sparade inventory
	local success, hasSword = pcall(function()
		return swordStore:GetAsync(player.UserId)
	end)

	if success and hasSword then
		-- Ge sv�rdet om spelaren hade det sparat
		if hasSword == true then
			local sword = game.ServerStorage:FindFirstChild(swordName)
			if sword then
				local swordClone = sword:Clone()
				swordClone.Parent = player.Backpack
				print(player.Name.." fick sitt sparade sv�rd!")
			end
		end
	else
		warn("Kunde inte ladda inventory f�r: "..player.Name)
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	-- Spara om spelaren har sv�rdet i Backpack
	local hasSword = false
	if player.Backpack:FindFirstChild(swordName) then
		hasSword = true
	end

	-- Spara i DataStore
	local success, err = pcall(function()
		swordStore:SetAsync(player.UserId, hasSword)
	end)

	if success then
		print("Inventory sparat f�r: "..player.Name)
	else
		warn("Kunde inte spara inventory f�r: "..player.Name..". Fel: "..err)
	end
end)
