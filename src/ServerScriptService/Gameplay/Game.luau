local ItemSpawnerService = require(script.Parent.ItemSpawnerService)

-- Declaration
local Game = {}
Game.__index = Game

-- Functions

function Game.new()
	local self = setmetatable({}, Game)
	self.itemSpawner = ItemSpawnerService.new()
	return self
end

function Game:start()
	print("Starting game!")
	self.itemSpawner:spawnItem(Vector3.new(5, 10, 0))
end

return Game
