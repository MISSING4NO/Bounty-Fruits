local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerBountyLevelData")

local MAX_LEVEL = 1000

local function bountyForLevel(level)
	return math.floor(100 * (level ^ 1.5))
end

local function getLevelFromBounty(bounty)
	for lvl = 1, MAX_LEVEL do
		if bounty < bountyForLevel(lvl) then
			return lvl - 1 > 0 and lvl - 1 or 1
		end
	end
	return MAX_LEVEL
end

local function updateLevel(player)
	local bounty = player.leaderstats.Bounty.Value
	local levelValue = player.leaderstats.Level

	local newLevel = getLevelFromBounty(bounty)
	if newLevel > MAX_LEVEL then
		newLevel = MAX_LEVEL
	end

	levelValue.Value = newLevel
end

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local bounty = Instance.new("IntValue")
	bounty.Name = "Bounty"
	bounty.Value = 0
	bounty.Parent = leaderstats

	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Value = 0
	level.Parent = leaderstats

	-- Load saved data
	local success, data = pcall(function()
		return playerDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		if type(data) == "table" then
			bounty.Value = data.Bounty or 0
			level.Value = data.Level or 1
		end
	end

	bounty.Changed:Connect(function()
		updateLevel(player)
	end)

	updateLevel(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	local bounty = player.leaderstats and player.leaderstats:FindFirstChild("Bounty")
	local level = player.leaderstats and player.leaderstats:FindFirstChild("Level")

	if bounty and level then
		local dataToSave = {
			Bounty = bounty.Value,
			Level = level.Value,
		}
		pcall(function()
			playerDataStore:SetAsync(player.UserId, dataToSave)
		end)
	end
end)
