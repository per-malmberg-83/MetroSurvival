-- Declaration

local Battery = {}
Battery.__index = Battery

-- Functions

function Battery.new(part)
	print("creating battery")

	local self = setmetatable({}, Battery)
	self.part = part

	self.clickDetector = part:FindFirstChild("ClickDetector")
	if not self.clickDetector then
		error("No ClickDetector found on part: " .. tostring(part))
		return nil
	end
	self.clickDetector.MouseClick:Connect(function(player)
		self:pickUp(player)
	end)

	return self
end

function Battery:pickUp(player)
	print("battery clicked by " .. player.Name)
end

return Battery
