local WorkspaceC = game.Workspace:GetChildren()
local PlayersC = game.Players:GetChildren()
local LightingC = game.Lighting:GetChildren()
local ReplicatedFirstC = game.Workspace:GetChildren()
local ReplicatedStorageC = game.Workspace:GetChildren()
local TeamsC = game.Workspace:GetChildren()
local SoundServiceC = game.Workspace:GetChildren()
local TextChatServiceC = game.Workspace:GetChildren()

local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function getCharacter()
	return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end
local function getPlayer()
	return game.Players.LocalPlayer
end
local function addUIStroke(parent, thickness,R,G,B)
	local uiStroke = Instance.new("UIStroke")
	local thkns = thickness or 2.5 
	local clr = Color3.new(R, G, B) or Color3.new(0, 0, 0)
	uiStroke.Parent = parent
	uiStroke.Name = tostring(parent) .. "_UIStroke"
	uiStroke.Color = clr
	uiStroke.Thickness = thkns
end
local function addUICorner(parent, r)
	local corner = Instance.new("UICorner")
	corner.Parent = parent
	corner.CornerRadius = UDim.new(0,r)
end


local scrapeGui = Instance.new("ScreenGui") scrapeGui.Parent = getPlayer():WaitForChild("PlayerGui") scrapeGui.Name = "FortniteBackflip"
local mainContainer = Instance.new("Frame") mainContainer.Parent = scrapeGui mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0.2,0,0.3,0)
mainContainer.Draggable = true
mainContainer.Active = true
mainContainer.Position = UDim2.new(0.8,0,0.135,0)
mainContainer.BackgroundColor = BrickColor.Random()
addUIStroke(mainContainer)

--//Scrolling Menu
local scrollContainer = Instance.new("Frame") scrollContainer.Name = "ScrollContainer" scrollContainer.Parent = mainContainer
scrollContainer.Size = UDim2.new(1,0,0.15,0) scrollContainer.Position = UDim2.new(0,0,0,0) scrollContainer.BackgroundTransparency = 0.5
scrollContainer.BackgroundColor = BrickColor.Random()

local scrollingFrame = Instance.new("ScrollingFrame") scrollingFrame.Parent = scrollContainer scrollingFrame.BackgroundTransparency = 1
scrollingFrame.Size = UDim2.new(1,0,1,0) scrollingFrame.CanvasSize = UDim2.new(0.5,0,1,0) scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.ScrollBarThickness = 8 scrollingFrame.ScrollBarImageTransparency = 1 scrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None  scrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
scrollingFrame.ScrollingEnabled = false


local scrollLayout = Instance.new("UIGridLayout") scrollLayout.FillDirection = Enum.FillDirection.Horizontal scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.CellPadding = UDim2.new(0,5,0,0) scrollLayout.CellSize = UDim2.new(0.45,0,1,0) scrollLayout.Parent = scrollingFrame scrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local scrollUpButton = Instance.new("TextButton")  scrollUpButton.Parent = scrollContainer
scrollUpButton.Position = UDim2.new(0.95,0,0,0) scrollUpButton.Size = UDim2.new(0.047,0,0.308,0) scrollUpButton.Text = "^"
addUICorner(scrollUpButton, 8)
local scrollDownButton = Instance.new("TextButton") scrollDownButton.Parent = scrollContainer scrollDownButton.Text = "v"
scrollDownButton.Position = UDim2.new(0.95,0,0.692,0) scrollDownButton.Size = UDim2.new(0.047,0,0.308,0)
addUICorner(scrollDownButton, 8)


scrollUpButton.MouseButton1Click:Connect(function()
	local scrollStep = scrollLayout.AbsoluteCellSize.Y
	local bottomPOS = scrollLayout.AbsoluteCellSize.Y * 3
	local pos = scrollingFrame.CanvasPosition.Y
	if pos - scrollStep >= 0 then
		scrollingFrame.CanvasPosition = Vector2.new(0, pos - scrollStep)
	else
		scrollingFrame.CanvasPosition = Vector2.new(0, 0)
	end
end)

scrollDownButton.MouseButton1Click:Connect(function()
	local scrollStep = scrollLayout.AbsoluteCellSize.Y
	local bottomPOS = scrollLayout.AbsoluteCellSize.Y * 3
	local pos = scrollingFrame.CanvasPosition.Y
	if pos + scrollStep <= bottomPOS then
		scrollingFrame.CanvasPosition = Vector2.new(0, pos + scrollStep)
	else
		scrollingFrame.CanvasPosition = Vector2.new(0, bottomPOS)
	end
end)

local function makeCoreButton(name, order, callOn, callOff)
	local on = false
	local buttn = Instance.new("TextButton")
	buttn.Name = name .. "_Button"
	buttn.Text = name
	buttn.Parent = scrollingFrame
	buttn.LayoutOrder = order
	
	buttn.MouseButton1Click:Connect(function()
		on = not on
		if on then callOn() else callOff() end
	end)
end

makeCoreButton("Workspace", 1, function()
	print(WorkspaceC)
end, function() 
	print("Workspace Off")
end)
makeCoreButton("Players", 2, function()
	print("Players On")
end, function() 
	print("Players Off")
end)
makeCoreButton("Lighting", 3, function()
	print("Lighting On")
end, function() 
	print("Lighting Off")
end)
makeCoreButton("ReplicatedFirst", 4, function()
	print("ReplicatedFirst On")
end, function() 
	print("ReplicatedFirst Off")
end)
makeCoreButton("ReplicatedStorage", 5, function()
	print("ReplicatedStorage On")
end, function() 
	print("ReplicatedStorage Off")
end)
makeCoreButton("Teams", 6, function()
	print("Teams On")
end, function() 
	print("Teams Off")
end)
makeCoreButton("SoundService", 7, function()
	print("SoundService On")
end, function() 
	print("SoundService Off")
end)
makeCoreButton("TextChatService", 8, function()
	print("TextChatService On")
end, function() 
	print("TextChatService Off")
end)
local WorkspaceUI = Instance.new("Frame")
