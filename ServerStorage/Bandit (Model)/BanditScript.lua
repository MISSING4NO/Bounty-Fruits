local npc = script.Parent
local humanoid = npc:WaitForChild("Humanoid")

humanoid.Died:Connect(function()
	local tag = humanoid:FindFirstChild("creator")
	if tag and tag.Value and tag.Value:IsA("Player") then
		local player = tag.Value
		if player:FindFirstChild("leaderstats") then
			player.leaderstats.Bounty.Value += 25 -- 25 bounty f�r NPC kill
			print(player.Name.." fick 25 bounty fr�n NPC.")
		end
	end
end)
