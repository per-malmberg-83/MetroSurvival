local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local InventoryItem = require(ReplicatedStorage.Scripts.InventoryItem)

-- Declaration

local Hotbar = {
	items = {},
	slots = {},
	numSlots = 2,
}

Hotbar.__index = Hotbar

-- Functions

function Hotbar.new(hotbarObject: Frame)
	-- null check
	if not hotbarObject then
		error("[CLIENT] Hotbar.new() - hotbarObject is nil")
		return
	end

	local self = setmetatable({}, Hotbar)

	self.hotbarObject = hotbarObject
	local slotScript = require(StarterPlayer.StarterPlayerScripts.SlotTemplate)
	for i = 1, self.numSlots do
		local slotTemplate = StarterPlayer.Templates.SlotTemplate:Clone()
		slotTemplate.Parent = self.hotbarObject
		self.slots[i] = slotScript.new(
			slotTemplate,
			nil, -- Placeholder icon
			0, -- Initial count
			i -- Slot key
		)
	end

	self.updateHotbarEvent = ReplicatedStorage.Events:WaitForChild("UpdateHotbarEvent")
	self.updateHotbarEvent.OnClientEvent:Connect(function(item)
		print("Received item for hotbar update: " .. tostring(item.type))
		self:addItem(item)
	end)

	return self
end

function Hotbar:addItem(item: InventoryItem)
	if not item or not item.type then
		error("Invalid item provided to Hotbar:addItem: " .. tostring(item))
		return
	end

	local wasFound = false
	for _, v in ipairs(self.items) do
		if v.type == item.type then
			v.count += 1
			wasFound = true
			break
		end
	end

	if not wasFound then
		table.insert(self.items, InventoryItem.new(item.type, item.count, item.icon))
	end

	self:updateGui()
end

function Hotbar:updateGui()
	for i, item in ipairs(self.items) do
		if item then
			self.slots[i]:setItem(item.icon, item.count, i)
		end
	end
end

return Hotbar
