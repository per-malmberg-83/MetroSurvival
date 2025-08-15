-- Declaration

export type Room = {
	roomConfig: table,
	getEntrances: (self: Room) -> { CFrame },
	getOppositeEntrance: (self: Room, CFrame) -> CFrame?,
	overlaps: (self: Room, Room) -> boolean,
	moveToEntrance: (self: Room, CFrame) -> (),
}

local Room = {}
Room.__index = Room

-- Functions

function Room.new(roomConfig: table): Room
	local self = setmetatable({}, Room)
	self.roomConfig = roomConfig
	return self
end

function Room:getEntrances()
	return self.roomConfig.entrances
end

function Room:getOppositeEntrance(entrance: CFrame): CFrame?
	for _, e in ipairs(self:getEntrances()) do
		if e.LookVector == -entrance.LookVector then
			return e
		end
	end
	return nil
end

function Room:overlaps(other: Room): boolean
	return not (
		self.roomConfig.x + self.roomConfig.width < other.roomConfig.x
		or self.roomConfig.x > other.roomConfig.x + other.roomConfig.width
		or self.roomConfig.y + self.roomConfig.depth < other.roomConfig.y
		or self.roomConfig.y > other.roomConfig.y + other.roomConfig.depth
	)
end

function Room:moveToEntrance(entrance: CFrame)
	-- Move the room to the specified entrance
	self.roomConfig.position = entrance.Position
end

return Room
