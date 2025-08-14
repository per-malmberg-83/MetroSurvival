local PlayerInventory = {}

-- Declaration

PlayerInventory.__index = PlayerInventory

-- Functions

function PlayerInventory.new()
	local self = setmetatable({}, PlayerInventory)
	self.items = {}
	return self
end

function PlayerInventory:addItem(item)
	table.insert(self.items, item)
end

function PlayerInventory:removeItem(item)
	for i, v in ipairs(self.items) do
		if v == item then
			table.remove(self.items, i)
			break
		end
	end
end

return PlayerInventory
