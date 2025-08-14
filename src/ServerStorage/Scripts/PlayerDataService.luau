local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local InventoryItem = require(ReplicatedStorage.Scripts.InventoryItem)
local PlayerInventory = require(ServerStorage.Scripts.PlayerInventory)

-- Declaration

local PlayerDataService = {}
PlayerDataService.__index = PlayerDataService

function PlayerDataService.new()
	local self = setmetatable({}, PlayerDataService)
	self.playerInventories = {}
	self.updatePlayerHotbar = ReplicatedStorage.Events:WaitForChild("UpdateHotbarEvent")
	Players.PlayerAdded:Connect(function(player)
		self:loadPlayerInventory(player)
	end)
	return self
end

-- Functions

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

function PlayerDataService:addInventoryItem(player, item)
	print("Trying to add item " .. tostring(item.type) .. " to player " .. player.Name)
	if not item or not item.type then
		error("Invalid item provided to PlayerDataService:addItem: " .. tostring(item))
		return
	end
	if not self.playerInventories[player.UserId] then
		print("Creating new inventory for player " .. player.Name)
		self.playerInventories[player.UserId] = PlayerInventory.new()
	end
	local inventoryItem = InventoryItem.new(item.type, 1, item.icon)
	self.playerInventories[player.UserId]:addItem(inventoryItem)
	print(
		"[SERVER] Firing remote event UpdateHotbarEvent for player "
			.. player.Name
			.. " with item: "
			.. tostring(inventoryItem.type)
	)
	self.updatePlayerHotbar:FireClient(player, inventoryItem:serialize())
end

return PlayerDataService
