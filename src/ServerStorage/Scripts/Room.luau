local ServerStorage = game:GetService("ServerStorage")

-- Declaration

export type Room = {
	roomConfig: table,
	model: Model,
	getEntrances: (self: Room) -> { CFrame },
	getOppositeEntrance: (self: Room, CFrame) -> CFrame?,
	overlaps: (self: Room, Room) -> boolean,
	moveToEntrance: (self: Room, CFrame) -> (),
	getPosition: (self: Room) -> Vector3,
	getRoomConfig: (self: Room) -> table,
	setPosition: (self: Room, Vector3) -> (),
}

local Room = {}
Room.__index = Room

-- Functions

function Room.new(roomConfig: table): Room
	local self = setmetatable({}, Room)
	self.model = ServerStorage.Templates:FindFirstChild(roomConfig.name):Clone()
	self.model.Parent = workspace
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

function Room:getRoomConfig(): table
	return self.roomConfig
end

function Room:overlaps(other: Room): boolean
	-- use the model's position and width and depth from roomConfig
	local position = self:getPosition()
	local otherPosition = other:getPosition()
	local otherRoomConfig = other:getRoomConfig()

	return not (
		position.X + self.roomConfig.width < otherPosition.X
		or position.X > otherPosition.X + otherRoomConfig.width
		or position.Z + self.roomConfig.depth < otherPosition.Z
		or position.Z > otherPosition.Z + otherRoomConfig.depth
	)
end

function Room:moveToEntrance(myEntrance: CFrame, entrance: CFrame)
	-- Move the room to the specified entrance
	if not myEntrance or not entrance then
		error("Entrance's cannot be nil")
	end

	local delta = entrance.Position - myEntrance.Position

	self:setPosition(self.getPosition() + delta)
end

function Room:getPosition(): Vector3
	return self.model:GetBoundingBox().Position
end

function Room:setPosition(position: Vector3)
	self.model:PivotTo(CFrame.new(position))
end

return Room
