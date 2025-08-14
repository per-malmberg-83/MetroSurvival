local InventoryItem = {}
InventoryItem.__index = InventoryItem

function InventoryItem.new(type, count)
	local self = setmetatable({}, InventoryItem)
	self.type = type
	self.count = count
	return self
end

function InventoryItem:serialize()
	return {
		type = self.type,
		part = self.part,
	}
end

return InventoryItem
