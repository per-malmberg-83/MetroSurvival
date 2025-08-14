local ServerStorage = game:GetService("ServerStorage")
local ItemSpawnerService = require(ServerStorage.Scripts.ItemSpawnerService)

-- Declaration

local Game = {}
Game.__index = Game

-- Functions

function Game.new()
	print("Creating new game instance")
	local self = setmetatable({}, Game)
	self.itemSpawner = ItemSpawnerService.new()
	return self
end

function Game:start()
	print("Starting game!")
	self.itemSpawner:spawnItem(Vector3.new(5, 10, 0))
end

-- Logic

local gameInstance = Game.new()
gameInstance:start()
