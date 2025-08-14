local Hotbar = {}

-- Declaration

Hotbar.__index = Hotbar

-- Functions

function Hotbar.new()
	local self = setmetatable({}, Hotbar)
	self.items = {}
	return self
end
