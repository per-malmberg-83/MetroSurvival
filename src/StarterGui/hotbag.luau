local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryItem = require(ReplicatedStorage.Scripts.InventoryItem)
local Hotbar = {}

-- Declaration

Hotbar.__index = Hotbar

-- Functions

function Hotbar.new()
	print("[CLIENT] Creating new Hotbar instance")
	local self = setmetatable({}, Hotbar)
	self.items = {}

	self.updateHotbarEvent = ReplicatedStorage.Events:WaitForChild("UpdateHotbarEvent")
	self.updateHotbarEvent.OnClientEvent:Connect(function(item)
		print("Received item for hotbar update: " .. tostring(item.type))
		self:addItem(item)
	end)

	return self
end

function Hotbar:addItem(item)
	print("[CLIENT] Adding item to hotbar: " .. tostring(item))
	if not item or not item.type then
		error("Invalid item provided to Hotbar:addItem: " .. tostring(item))
		return
	end

	local wasFound = false
	for _, v in ipairs(self.items) do
		if v.type == item.type then
			v.count += 1
			wasFound = true
			print("Increased " .. v.type .. " count to " .. v.count)
			break
		end
	end

	if not wasFound then
		print(
			"[CLIENT] Adding new item to hotbar: "
				.. tostring(item.type)
				.. " with count: "
				.. tostring(item.count)
				.. " and icon "
				.. item.icon
		)
		table.insert(self.items, InventoryItem.new(item.type, item.count, item.icon))
	end
end

Hotbar.new()
