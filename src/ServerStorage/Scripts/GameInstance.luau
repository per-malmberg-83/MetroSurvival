local ServerStorage = game:GetService("ServerStorage")
local ItemSpawnerService = require(ServerStorage.Scripts.ItemSpawnerService)
local PlayerDataService = require(ServerStorage.Scripts.PlayerDataService)
local LevelGenerator = require(ServerStorage.Scripts.LevelGenerator)

-- Declaration

local GameInstance = {}
GameInstance.__index = GameInstance

-- Functions

function GameInstance.new()
	print("Creating new game instance")
	local self = setmetatable({}, GameInstance)
	self.itemSpawner = ItemSpawnerService.new()
	self.playerDataService = PlayerDataService.new()
	return self
end

function GameInstance:start()
	print("Starting game!")

	self.levelGenerator = LevelGenerator.new()
	self.levelGenerator:generateLevel()

	self.itemSpawner:spawnItem(Vector3.new(5, 10, 0))
end

function GameInstance:addInventoryItem(player: Player, item: Battery)
	print("Adding item " .. tostring(item.type) .. " to player " .. player.Name)
	self.playerDataService:addInventoryItem(player, item)
end

-- Logic

--Return a singleton of GameInstance
local gameInstance = GameInstance.new()
return gameInstance
