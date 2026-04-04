local rs = game:GetService("ReplicatedStorage")

local WeaponConfig = require(rs:WaitForChild("WeaponConfig"))
local ShootRemote = rs:WaitForChild("Shoot")

ShootRemote.OnServerEvent:Connect(function(player, origin, direction)
	local config = WeaponConfig.AK47

	
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {player.Character}
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist

	local result = workspace:Raycast(origin, direction * config.Range, rayParams)

	if result then
		local hitPart = result.Instance
		local character = hitPart:FindFirstAncestorOfClass("Model")

		if character and character:FindFirstChild("Humanoid") then
			character.Humanoid:TakeDamage(config.Damage)
		end
	end
end)
