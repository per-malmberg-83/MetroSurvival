local SlotTemplate = {}

function SlotTemplate.new(slotTemplateObject: Frame, icon: string, count: number, key: string)
	-- null check
	if not slotTemplateObject then
		error("[CLIENT] SlotTemplate.new() - slotTemplateObject is nil")
		return
	end

	local self = setmetatable({}, { __index = SlotTemplate })
	self.slotTemplateObject = slotTemplateObject
	self.icon = icon
	self.count = count
	self.key = key

	local numberLabel = slotTemplateObject:WaitForChild("NumberLabel")
	numberLabel.Text = tostring(count)
	local imageLabel = slotTemplateObject:WaitForChild("ImageLabel")
	if icon then
		imageLabel.Image = icon
	else
		imageLabel.Visible = false
		numberLabel.Visible = false
	end

	local keyLabel = slotTemplateObject:WaitForChild("KeyLabel")
	keyLabel.Text = tostring(key)

	return self
end

function SlotTemplate:setItem(icon: string, count: number, key: string)
	-- null check on parameters
	if not icon or not count or not key then
		error("[CLIENT] SlotTemplate:setItem() - invalid parameters")
		return
	end

	print("Setting item in slot: " .. tostring(self.key))
	local imageLabel = self.slotTemplateObject:WaitForChild("ImageLabel")
	local numberLabel = self.slotTemplateObject:WaitForChild("NumberLabel")
	local keyLabel = self.slotTemplateObject:WaitForChild("KeyLabel")

	imageLabel.Image = icon
	imageLabel.Visible = true
	numberLabel.Text = tostring(count)
	numberLabel.Visible = count
	keyLabel.Text = tostring(key)
end

function SlotTemplate:UpdateCount(newCount: number)
	local numberLabel = self.slotTemplateObject:WaitForChild("NumberLabel")
	numberLabel.Text = tostring(newCount)
end

return SlotTemplate
