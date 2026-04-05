local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local char = script.Parent
local humanoid = char:WaitForChild("Humanoid")

local camera = game.Workspace.Camera

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		if humanoid then
			humanoid.WalkSpeed = 30
		end
	end
end)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		humanoid.WalkSpeed = 16
	end
end)

runService.RenderStepped:Connect(function()
	if humanoid then
		if humanoid.MoveDirection.Magnitude > 0 then
			local headBobY = math.sin(tick() * 7) * .2
			
			if humanoid.WalkSpeed == 16 then
				headBobY = math.sin(tick() * 7) * .2
			elseif humanoid.WalkSpeed == 30 then
				headBobY = math.sin(tick() * 18) * .3
			end
			
			local bob = Vector3.new(0, headBobY, 0)
			
			humanoid.CameraOffset = humanoid.CameraOffset:Lerp(bob, .1)
			
		else
			humanoid.CameraOffset = humanoid.CameraOffset:Lerp(Vector3.new(), .1)
		end
	end
end)
