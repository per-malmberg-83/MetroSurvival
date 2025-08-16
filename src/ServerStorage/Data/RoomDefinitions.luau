local ROOM_DEFINITIONS = {
	{
		name = "SubwayPlatform",
		width = 10,
		depth = 5,
		entrances = {
			CFrame.lookAt(Vector3.new(0, 0, 20), Vector3.new(0, 0, 1)),
		},
	},
	{
		name = "RoomOne",
		width = 5,
		depth = 5,
		entrances = {
			CFrame.lookAt(Vector3.new(0, 0, -20), Vector3.new(0, 0, -1)),
		},
	},
}

return ROOM_DEFINITIONS
