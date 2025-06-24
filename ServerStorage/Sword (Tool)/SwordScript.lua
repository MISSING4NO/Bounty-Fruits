local tool = script.Parent
local damage = 25
local range = 5
local cooldown = 0.3
local canAttack = true

tool.Activated:Connect(function()
	if not canAttack then return end
	canAttack = false

	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	local humanoid = character:FindFirstChild("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if humanoid and rootPart then
		for _, potentialTarget in pairs(workspace:GetDescendants()) do
			if potentialTarget:IsA("Model") and potentialTarget ~= character then
				local enemyHumanoid = potentialTarget:FindFirstChild("Humanoid")
				local enemyRoot = potentialTarget:FindFirstChild("HumanoidRootPart")

				if enemyHumanoid and enemyRoot and enemyHumanoid.Health > 0 then
					local distance = (rootPart.Position - enemyRoot.Position).Magnitude
					if distance <= range then
						enemyHumanoid:TakeDamage(damage)
						print("Träffade: "..potentialTarget.Name)

						-- Lägg till creator-tag för Bounty-systemet
						if player then
							local tag = Instance.new("ObjectValue")
							tag.Name = "creator"
							tag.Value = player
							tag.Parent = enemyHumanoid
							game:GetService("Debris"):AddItem(tag, 2)
						end

						-- Träffeffekt
						local effect = Instance.new("Part")
						effect.Shape = Enum.PartType.Ball
						effect.Material = Enum.Material.Neon
						effect.Color = Color3.new(1, 0, 0)
						effect.Size = Vector3.new(0.5, 0.5, 0.5)
						effect.CFrame = enemyRoot.CFrame
						effect.Anchored = true
						effect.CanCollide = false
						effect.Parent = workspace

						game:GetService("Debris"):AddItem(effect, 0.5)
					end
				end
			end
		end
	end

	wait(cooldown)
	canAttack = true
end)
