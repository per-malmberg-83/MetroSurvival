local ServerStorage = game:GetService("ServerStorage")
local ITEM_CONFIGS = require(ServerStorage.Data.ItemConfigs)

-- Declaration

local ItemSpawnerService = {}
ItemSpawnerService.__index = ItemSpawnerService

-- Functions

function ItemSpawnerService.new()
	local self = setmetatable({}, ItemSpawnerService)
	return self
end

function ItemSpawnerService:spawnItem(position: Vector3)
	print("Spawning item at position:", position)

	local config = ITEM_CONFIGS.Battery

	local item = ServerStorage.Templates[config.type]:Clone()
	item.Position = position
	item.Parent = workspace

	local itemScript = require(ServerStorage.Scripts:FindFirstChild(config.script))
	local itemScriptInstance = itemScript.new(item)
	itemScriptInstance.Parent = item

	return item
end

return ItemSpawnerService
