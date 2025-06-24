local npcTemplate = game.ServerStorage:WaitForChild("Bandit")
local spawnLocation = workspace:WaitForChild("BanditSpawn")
local respawnTime = 5

local function spawnNPC()
	local newNPC = npcTemplate:Clone()
	newNPC.Parent = workspace

	-- Flytta NPC:n ovanpå spawn-delen
	local spawnCFrame = spawnLocation.CFrame + Vector3.new(0, spawnLocation.Size.Y/2 + 5, 0) -- 3 studs ovanför plattformen
	newNPC:SetPrimaryPartCFrame(spawnCFrame)

	-- Respawn logik
	local humanoid = newNPC:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		wait(respawnTime)
		spawnNPC()
		newNPC:Destroy()
	end)
end

spawnNPC()
