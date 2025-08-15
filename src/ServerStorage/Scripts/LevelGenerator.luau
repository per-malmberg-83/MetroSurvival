local ServerStorage = game:GetService("ServerStorage")
local Room = require(ServerStorage.Scripts.Room)
local RoomDefinitions = require(ServerStorage.Data.RoomDefinitions)

-- Declaration

export type LevelGenerator = {
	generateLevel: (self: LevelGenerator) -> (),
	rooms: { Room },
	entrances: { CFrame },
	generateRoom: (self: LevelGenerator, roomConfig: table) -> Room,
}

local LevelGenerator = {}
LevelGenerator.__index = LevelGenerator

-- Functions

function LevelGenerator.new()
	local self = setmetatable({}, LevelGenerator)
	self.rooms = {}
	self.entrances = {}
	return self
end

function LevelGenerator:generateLevel()
	-- start with the platform
	local platformDefinition = RoomDefinitions[1]
	local platform = self:generateRoom(platformDefinition)
	table.insert(self.rooms, platform)
	table.insert(self.entrances, platform:getEntrances())

	-- select a random entrance
	local randomEntrance = self.entrances[math.random(#self.entrances)]
	print("Selected entrance:", randomEntrance)

	-- select random room definition (skip first since it's the platform)
	local roomDefinition = RoomDefinitions[math.random(2, #RoomDefinitions)]
	local room = self:generateRoom(roomDefinition)
	print("Generated room:", room)

	-- get an entrance in the room in opposite direction
	local oppositeEntrance = room:getOppositeEntrance(randomEntrance)
	if not oppositeEntrance then
		print("No opposite entrance found for room:", room)
		return
	end

	-- move the room to line up with the opposite entrance
	room:moveToEntrance(oppositeEntrance)

	-- check that room doesn't overlap with existing rooms
	for _, existingRoom in ipairs(self.rooms) do
		if room:overlaps(existingRoom) then
			print("Room overlaps with existing room:", existingRoom)
			return
		end
	end

	-- add the new rooms entrances to the list
	for _, entrance in ipairs(room:getEntrances()) do
		table.insert(self.entrances, entrance)
	end

	-- remove the used entrances from the list
	table.remove(self.entrances, table.find(self.entrances, randomEntrance))
	table.remove(self.entrances, table.find(self.entrances, oppositeEntrance))

	-- add the new room to the list of rooms
	table.insert(self.rooms, room)
end

function LevelGenerator:generateRoom(roomConfig: table): Room
	local room = Room.new(roomConfig)
	return room
end

return LevelGenerator
