local PlayerInventory = {}

-- Declaration

export type PlayerInventory = {
	player: LocalPlayer,
	items: { Battery },
}

PlayerInventory.__index = PlayerInventory

-- Functions

function PlayerInventory.new(player: LocalPlayer)
	local self = setmetatable({}, PlayerInventory)
	self.player = player
	self.items = {}
	return self
end

function PlayerInventory:addItem(item: Battery)
	print("Adding item to inventory: " .. tostring(item))
	if not item or not item.type then
		error("Invalid item provided to PlayerInventory:addItem: " .. tostring(item))
		return
	end
	table.insert(self.items, item)
end

function PlayerInventory:removeItem(item: Battery)
	for i, v in ipairs(self.items) do
		if v == item then
			table.remove(self.items, i)
			break
		end
	end
	error("Item not found in inventory: " .. tostring(item))
end

function PlayerInventory:serialize(): table
	local serializedItems = {}
	for _, item in ipairs(self.items) do
		table.insert(serializedItems, item:serialize())
	end
	return {
		player = self.player,
		items = serializedItems,
	}
end

return PlayerInventory
