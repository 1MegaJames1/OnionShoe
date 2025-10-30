local UserInputService = game:GetService("UserInputService")
local menuui = script.Parent
local frame = menuui:WaitForChild("Main")
local scalable = frame:WaitForChild("scalable")    

local function setupDragResize(part, mode)
	local dragging = false
	local startPos, startSize, inputStart

	part.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			inputStart = input.Position
			startPos = frame.Position
			startSize = frame.Size

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
		local delta = input.Position - inputStart

		if mode == "drag" then
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)

		elseif mode == "corner1" then
			local newWidth = math.max(startSize.X.Offset - delta.X, -280)
			local newHeight = math.max(startSize.Y.Offset - delta.Y, -480)
			local dx = startSize.X.Offset - newWidth
			local dy = startSize.Y.Offset - newHeight
			frame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, newHeight)
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + dx, startPos.Y.Scale, startPos.Y.Offset + dy)

		elseif mode == "corner2" then
			local newWidth = math.max(startSize.X.Offset + delta.X, -280)
			local newHeight = math.max(startSize.Y.Offset - delta.Y, -480)
			local dy = startSize.Y.Offset - newHeight
			frame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, newHeight)
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset, startPos.Y.Scale, startPos.Y.Offset + dy)

		elseif mode == "corner3" then
			local newWidth = math.max(startSize.X.Offset - delta.X, -280)
			local newHeight = math.max(startSize.Y.Offset + delta.Y, -480)
			local dx = startSize.X.Offset - newWidth
			frame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, newHeight)
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + dx, startPos.Y.Scale, startPos.Y.Offset)

		elseif mode == "corner4" then
			local newWidth = math.max(startSize.X.Offset + delta.X, -280)
			local newHeight = math.max(startSize.Y.Offset + delta.Y, -480)
			frame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, newHeight)

		elseif mode == "linex1" then
			local newWidth = math.max(startSize.X.Offset - delta.X, -280)
			local dx = startSize.X.Offset - newWidth
			frame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, startSize.Y.Offset)
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + dx, startPos.Y.Scale, startPos.Y.Offset)

		elseif mode == "linex2" then
			local newWidth = math.max(startSize.X.Offset + delta.X, -280)
			frame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, startSize.Y.Offset)

		elseif mode == "liney1" then
			local newHeight = math.max(startSize.Y.Offset - delta.Y, -480)
			local dy = startSize.Y.Offset - newHeight
			frame.Size = UDim2.new(startSize.X.Scale, startSize.X.Offset, startSize.Y.Scale, newHeight)
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset, startPos.Y.Scale, startPos.Y.Offset + dy)

		elseif mode == "liney2" then
			local newHeight = math.max(startSize.Y.Offset + delta.Y, -480)
			frame.Size = UDim2.new(startSize.X.Scale, startSize.X.Offset, startSize.Y.Scale, newHeight)
		end
	end)
end

for _, v in pairs(scalable:GetChildren()) do
	if v:IsA("GuiObject") then
		local name = v.Name:lower()
		setupDragResize(v, name)
	end
end
