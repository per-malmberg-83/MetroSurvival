local ServerStorage = game:GetService("ServerStorage")
local BatteryScript = require(ServerStorage.Scripts.Battery)

-- Declaration

local ItemSpawnerService = {}
ItemSpawnerService.__index = ItemSpawnerService

-- Functions

function ItemSpawnerService.new()
	local self = setmetatable({}, ItemSpawnerService)
	return self
end

function ItemSpawnerService:spawnItem(position)
	print("Spawning item at position:", position)
	local item = ServerStorage.Items.Battery:Clone()
	item.Position = position
	item.Parent = workspace

	local batteryScript = BatteryScript.new(item)
	batteryScript.Parent = item
	return item
end

return ItemSpawnerService
