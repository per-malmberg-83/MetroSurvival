local TweenService = game:GetService("TweenService")

-- Declaration

local TrainControlsButton = {}
TrainControlsButton.__index = TrainControlsButton

-- Functions

function TrainControlsButton.new(part: Part)
	local self = setmetatable({}, TrainControlsButton)
	self.part = part
	self.originalCFrame = self.part.CFrame
	self.isAnimating = false

	self.clickDetector = part:FindFirstChild("ClickDetector")
	if not self.clickDetector then
		error("No ClickDetector found on part: " .. tostring(part))
		return nil
	end

	self.highlight = part:FindFirstChild("Highlight")
	if not self.highlight then
		error("No Highlight found on part: " .. tostring(part))
		return nil
	end

	self.clickDetector.MouseHoverEnter:Connect(function()
		self:onHoverEnter()
	end)

	self.clickDetector.MouseHoverLeave:Connect(function()
		self:onHoverLeave()
	end)

	self.clickDetector.MouseClick:Connect(function()
		self:press()
	end)

	return self
end

function TrainControlsButton:playPressAnimation()
	if self.isAnimating then
		return
	end -- Prevent multiple animations

	self.isAnimating = true

	-- Animation settings
	local tweenInfo = TweenInfo.new(
		0.1, -- Duration (seconds)
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out,
		0, -- Repeat count
		false, -- Reverses
		0 -- Delay
	)

	-- Move down (press effect)
	local pressDownTween =
		TweenService:Create(self.part, tweenInfo, { CFrame = self.originalCFrame * CFrame.new(0, -0.5, 0) })

	-- Move back up
	local pressUpTween = TweenService:Create(self.part, tweenInfo, { CFrame = self.originalCFrame })

	-- Play the sequence
	pressDownTween:Play()

	pressDownTween.Completed:Connect(function()
		pressUpTween:Play()

		pressUpTween.Completed:Connect(function()
			self.isAnimating = false
		end)
	end)
end

-- Event handlers

function TrainControlsButton:onHoverEnter()
	print("TrainControlsButton hovered")
	self.highlight.Enabled = true
end

function TrainControlsButton:onHoverLeave()
	print("TrainControlsButton unhovered")
	self.highlight.Enabled = false
end

function TrainControlsButton:press()
	print("TrainControlsButton pressed")
	self:playPressAnimation()
end

-- Create the button

local buttonPart = script.Parent
TrainControlsButton.new(buttonPart)
