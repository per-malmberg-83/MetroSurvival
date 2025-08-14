local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerInventory = require(ServerScriptService.Players.PlayerInventory)

local PlayerDataService = {
	playerInventories = {},
}

function PlayerDataService:addItem(player, item)
	if not self.playerInventories[player.UserId] then
		self.playerInventories[player.UserId] = PlayerInventory.new()
	end
	self.playerInventories[player.UserId]:addItem(item)
end

function PlayerDataService:loadPlayerInventory(player)
	local inventory = self.playerInventories[player.UserId]
	if not inventory then
		local success, data = pcall(function()
			return DataStoreService:GetDataStore("PlayerInventory"):GetAsync(player.UserId)
		end)
		if success and data then
			inventory = PlayerInventory.new()
			for _, item in ipairs(data) do
				inventory:addItem(item)
			end
		end
	end
	if not inventory then
		inventory = PlayerInventory.new()
		self.playerInventories[player.UserId] = inventory
		-- store in data store
		local success, err = pcall(function()
			DataStoreService:GetDataStore("PlayerInventory"):SetAsync(player.UserId, inventory.items)
		end)
		if not success then
			warn("Failed to save player inventory:", err)
		end
	end
end

-- Events

Players.PlayerAdded:Connect(function(player)
	PlayerDataService:loadPlayerInventory(player)
end)
