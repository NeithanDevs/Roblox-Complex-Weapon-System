local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local camera = game.Workspace.CurrentCamera

local aimCF = CFrame.new()

local isAiming = false

local currentSwayAMT = -.3
local swayAMT = -.3
local aimSwayAMT = .2
local swayCF = CFrame.new()
local lastCameraCF = CFrame.new()

local framework = {
	inventory = {
		"M4A1";
		"M9";
		"Knife";
		"Frag";
	};
	
	module = nil;
	viewmodel = nil;
	currentSlot = 1;
	
}

function loadslot(Item)
	local viewmodelFolder = game.ReplicatedStorage.Viewmodels
	local moduleFolder = game.ReplicatedStorage.Modules
	
	for i,v in pairs(camera:GetChildren()) do
		if v:IsA("Model") then
			v:Destroy()
		end
	end
	
	if moduleFolder:FindFirstChild(Item) then
		framework.module = require(moduleFolder:FindFirstChild(Item))
		
		if viewmodelFolder:FindFirstChild(Item) then
			framework.viewmodel = viewmodelFolder:FindFirstChild(Item):Clone()
			framework.viewmodel.Parent = camera
		end
	end
end

RunService.RenderStepped:Connect(function()
	
	local rot = camera.CFrame:ToObjectSpace(lastCameraCF)
	local X,Y,Z = rot:ToOrientation()
	swayCF = swayCF:Lerp(CFrame.Angles(math.sin(X) * swayAMT, math.sin(Y) * swayAMT, 0), .1)
	lastCameraCF = camera.CFrame
	
	local humanoid = char:WaitForChild("Humanoid")
	
	if humanoid then
		local bobOffset = CFrame.new()
		
		if humanoid.MoveDirection.Magnitude > 0 then
			if humanoid.WalkSpeed == 16 then
				bobOffset = CFrame.new(math.cos(tick() * 5) * .1, -humanoid.CameraOffset.Y/10, - humanoid.CameraOffset.Z/10)
				
			elseif humanoid.WalkSpeed == 30 then
				bobOffset = CFrame.new(math.cos(tick()* 8) * .15, -humanoid.CameraOffset.Y/3, - humanoid.CameraOffset.Z/3)
			end
			
			
		else
			bobOffset = bobOffset:Lerp(CFrame.new(0, -humanoid.CameraOffset.Y/3, 0), .1)
		end
		

		for i, v in pairs(camera:GetChildren()) do
			if v:IsA("Model") then
				v:SetPrimaryPartCFrame(camera.CFrame *swayCF * aimCF * bobOffset )
			end
		end
	end
	
	if isAiming and framework.viewmodel ~= nil and framework.module.canAim then
		local offset = framework.viewmodel.AimPart.CFrame:ToObjectSpace(framework.viewmodel.PrimaryPart.CFrame)
		aimCF = aimCF:Lerp(offset, framework.module.aimSmooth)
		currentSwayAMT = aimSwayAMT
	else
		local offset = CFrame.new()
		aimCF = aimCF:Lerp(offset, framework.module.aimSmooth)
		currentSwayAMT = swayCF
	end
end)


loadslot(framework.inventory[1])

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.One then
		if framework.currentSlot ~= 1 then
			loadslot(framework.inventory[1])
			framework.currentSlot = 1
		end
	end
	
	if input.KeyCode == Enum.KeyCode.Two then
		if framework.currentSlot ~= 2 then
			loadslot(framework.inventory[2])
			framework.currentSlot = 2
		end
	end
	
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		
		isAiming = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isAiming = false
	end
end)
