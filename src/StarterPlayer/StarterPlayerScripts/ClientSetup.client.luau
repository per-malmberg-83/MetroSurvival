local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

print("Setting up client")

local player = Players.LocalPlayer
local hotbar = player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("Hotbar")

print("Setting up hotbar " .. tostring(hotbar))

local hotbarScript = StarterPlayer.StarterPlayerScripts.Hotbar:Clone()
hotbarScript.Parent = hotbar
