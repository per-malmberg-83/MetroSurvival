-- Declaration

local InventoryItem = {}
InventoryItem.__index = InventoryItem

-- Functions

function InventoryItem.new(type, count, icon)
	-- nil check
	assert(type and count and icon, "Invalid arguments provided to InventoryItem.new")

	local self = setmetatable({}, InventoryItem)
	self.type = type
	self.count = count
	self.icon = icon

	return self
end

function InventoryItem:serialize()
	return {
		type = self.type,
		count = self.count,
		icon = self.icon,
	}
end

return InventoryItem
