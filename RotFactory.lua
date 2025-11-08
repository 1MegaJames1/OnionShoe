local function waitForGame()
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
end
waitForGame()
--//Waypoints, FindBest, TpTo, 

local Players = game:GetService("Players")
local player = Players.LocalPlayer
repeat task.wait() until player

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Stats = game:GetService("Stats")
local plotsFolder = nil


local workspace = workspace
plotsFolder = workspace:WaitForChild("Plots", 10)

local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then warn("PlayerGui failed to load") return end

local screengui = Instance.new("ScreenGui")
script.Name = "Sigma"
screengui.Parent = player:WaitForChild("PlayerGui")
screengui.IgnoreGuiInset = true
screengui.ResetOnSpawn = false
screengui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local function addCorner(parent, radius)
	local uiCorner = Instance.new("UICorner")
	uiCorner.Parent = parent
	uiCorner.CornerRadius = UDim.new(radius, 0)
end

local container = Instance.new("Frame")
local containerGradient = Instance.new("UIGradient")
local containerUIStroke = Instance.new("UIStroke") containerUIStroke.Parent = container containerUIStroke.Thickness = 3
containerGradient.Parent = container
containerGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.447059, 0.105882, 0.113725)), ColorSequenceKeypoint.new(1,Color3.new(0.0156863, 0.247059, 0.317647))})
containerGradient.Rotation = 45
container.Parent = screengui
container.Size = UDim2.new(0.20,0,0.3,0)
container.Name = "Bigbah"
container.Draggable = true
container.Active = true
container.Position = UDim2.new(0.35,0,0.35,0)
container.BackgroundColor3 = Color3.fromRGB(255,255,255)
addCorner(container, 0.1)

local title = Instance.new("TextLabel")
title.Parent = container
title.Size = UDim2.new(1,0,0.1,0)
title.Text = "🧠🔥 Rot Factory 🔥🧠"
title.BorderSizePixel = 0
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Interactable = false
title.TextWrapped = false
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Position = UDim2.new(0,0,0.025,0)
title.TextXAlignment = Enum.TextXAlignment.Center


local core = Instance.new("Frame")
core.Name = "Core"
core.Parent = container
core.Position = UDim2.new(0,0,0.2,0)
core.Size = UDim2.new(1, 0, 0.65, 0)
core.BorderSizePixel = 0
core.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout")
grid.Name = "Grid"
grid.Parent = core
grid.CellSize = UDim2.new(0.215,0,0.135,0)
grid.CellPadding = UDim2.new(0.035,0,0.05,0)
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.FillDirectionMaxCells = 4
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function getCharacter(time)
	time = time or 5
	if not player then return nil end
	local character = player.Character or player.CharacterAdded:Wait()
	return character
end

local function addSwitch(parent ,text, name, order, callback)
	local on = false
	local main = Instance.new("Frame")
	local bttnTxt = Instance.new("TextLabel")
	bttnTxt.Parent = parent
	bttnTxt.Text = text
	bttnTxt.TextColor3 = Color3.fromRGB(255,255,255)
	bttnTxt.TextScaled = true
	bttnTxt.BackgroundColor3 = Color3.fromRGB(0,0,0)
	bttnTxt.BackgroundTransparency = 0.75
	bttnTxt.BorderSizePixel = 0
	bttnTxt.LayoutOrder = (order -1)
	addCorner(bttnTxt, 0.3)

	local bttnClk = Instance.new("TextButton")
	bttnClk.Parent = parent
	bttnClk.Name = name
	bttnClk.LayoutOrder = order
	bttnClk.Text = ""
	bttnClk.BorderSizePixel = 0
	bttnClk.BackgroundColor3 = Color3.fromRGB(130, 131, 131)
	bttnClk.AutoButtonColor = false
	addCorner(bttnClk, 0.3)

	local fx = Instance.new("Frame")
	fx.Size = UDim2.new(0.25,0,1,0)
	fx.Parent = bttnClk
	fx.BorderSizePixel = 0
	addCorner(fx, 1)

	bttnClk.MouseButton1Click:connect(function()
		on = not on
		local targetPos = on and UDim2.new(0.75,0,fx.Position.Y.Scale,0) or UDim2.new(0,0,fx.Position.Y.Scale,0)
		local tween = TweenService:Create(fx, tweenInfo, {Position = targetPos})
		tween:Play()
		task.wait(0.3)
		if on then
			bttnClk.BackgroundColor3 = Color3.fromRGB(95, 149, 103)
		else
			bttnClk.BackgroundColor3 = Color3.fromRGB(130, 131, 131)
		end
		callback(on)
	end)
end

local CSG = Instance.new("Frame")
CSG.Parent = screengui
CSG.Size = UDim2.new(0.075,0,0.05,0)
CSG.Position = UDim2.new(0,0,0.5,0)
local currentSpeedGui = Instance.new("TextLabel")
currentSpeedGui.Parent = CSG
currentSpeedGui.Name = "CurrentSpeedGui"
currentSpeedGui.Size = UDim2.new(1,0,1,0)
currentSpeedGui.TextColor = BrickColor.White()
currentSpeedGui.TextWrapped = false
currentSpeedGui.Font = Enum.Font.GothamBold
currentSpeedGui.BackgroundTransparency = 1
currentSpeedGui.TextScaled = true

local currentSpeedGuiGradient = Instance.new("UIGradient")
currentSpeedGuiGradient.Parent = CSG
currentSpeedGuiGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.447059, 0.105882, 0.113725)), ColorSequenceKeypoint.new(1,Color3.new(0.0156863, 0.247059, 0.317647))})
currentSpeedGuiGradient.Rotation = -45

local scaleUpButton = Instance.new("TextButton")
scaleUpButton.Parent = container
scaleUpButton.Size = UDim2.new(0.1,0,0.1,0)
scaleUpButton.Text = "+"
scaleUpButton.Position = UDim2.new(0.75,0,0.85,0)
scaleUpButton.BorderSizePixel = 0
addCorner(scaleUpButton, 0.35)
scaleUpButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
scaleUpButton.BackgroundTransparency = 0.75
scaleUpButton.TextColor3 = Color3.fromRGB(255,255,255)
scaleUpButton.TextScaled = true

local scaleDownButton = Instance.new("TextButton")
scaleDownButton.Parent = container
scaleDownButton.Size = UDim2.new(0.1,0,0.1,0)
scaleDownButton.Text = "-"
scaleDownButton.Position = UDim2.new(0.15, 0, 0.85,0)
scaleDownButton.BorderSizePixel = 0
addCorner(scaleDownButton, 0.35)
scaleDownButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
scaleDownButton.BackgroundTransparency = 0.75
scaleDownButton.TextColor3 = Color3.fromRGB(255,255,255)
scaleDownButton.TextScaled = true

local ghostButton = Instance.new("TextButton")
ghostButton.Parent = container
ghostButton.Size = UDim2.new(0.25,0,0.15,0)
ghostButton.BorderSizePixel = 0
ghostButton.TextScaled = true
ghostButton.TextColor3 = Color3.fromRGB(255,255,255)
addCorner(ghostButton, 0.35)
ghostButton.Text = "👻"
ghostButton.BackgroundTransparency = 0.75
ghostButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
ghostButton.Position = UDim2.new(0.375,0,0.825,0)



local FindBestGUIMenu = Instance.new("ScreenGui") FindBestGUIMenu.Parent = player:WaitForChild("PlayerGui")
	FindBestGUIMenu.Enabled = false
	FindBestGUIMenu.ResetOnSpawn = false
	FindBestGUIMenu.IgnoreGuiInset = true
local FindBestGUIFrame = Instance.new("Frame") FindBestGUIFrame.Parent = FindBestGUIMenu
	FindBestGUIFrame.Size = UDim2.new(0.2,0,0.3,0)
	FindBestGUIFrame.Draggable = true
	FindBestGUIFrame.Active = true
	FindBestGUIFrame.Position = UDim2.new(-0.2,0,0.135,0)
	
	
	addCorner(FindBestGUIFrame, 0.2)
local FindBestGUIUIStroke = Instance.new("UIStroke") FindBestGUIUIStroke.Parent = FindBestGUIFrame FindBestGUIUIStroke.Thickness = 3
local FindBestGUIGradient = Instance.new("UIGradient") FindBestGUIGradient.Parent = FindBestGUIFrame FindBestGUIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.447059, 0.105882, 0.113725)), ColorSequenceKeypoint.new(1,Color3.new(0.0156863, 0.247059, 0.317647))}) FindBestGUIGradient.Rotation = 135

local function scale(change)
	local currentX = container.Size.X.Scale
	local currentY = container.Size.Y.Scale
	local newX = math.clamp(currentX + change, 0.2, 0.45)
	local newY = math.clamp(currentY + change, 0.3, 0.55)
	local tween = TweenService:Create(container, tweenInfo, {Size = UDim2.new(newX,0,newY,0)})
	tween:Play()
end

local function ParseGenerationValue(text)
	if typeof(text) ~= "string" then return 0 end
	local cleanText = text:gsub("%$", ""):gsub("/s", "")
	local numPart = cleanText:match("([%d%.]+)")
	local suffix = cleanText:match("([KMBT])%s*$")
	if not numPart then return 0 end
	local number = tonumber(numPart) or 0
	local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
	if suffix and multipliers[suffix] then number *= multipliers[suffix] end
	return number
end

local function findBestRot()
	local bestModel = nil
	local bestValue = -math.huge
	for _, obj in workspace:GetDescendants() do
		if obj:IsA("TextLabel") and obj.Name == "Generation" then
			local value = ParseGenerationValue(obj.Text)
			local brainrot = obj:FindFirstAncestorOfClass("Model")
			if value and bestValue < value then
				bestValue = value
				bestModel = brainrot
			end
		end
	end
	return bestModel
end
--//FindBestGUI
local FindBestGUITitle = Instance.new("TextLabel")
	FindBestGUITitle.Parent = FindBestGUIFrame
	FindBestGUITitle.Size = UDim2.new(1,0,0.1,0)
	FindBestGUITitle.Text = "🧠🔥 Best Brainrots: 🔥🧠"
	FindBestGUITitle.BorderSizePixel = 0
	FindBestGUITitle.BackgroundTransparency = 1
	FindBestGUITitle.TextColor3 = Color3.fromRGB(255,255,255)
	FindBestGUITitle.Interactable = false
	FindBestGUITitle.TextWrapped = false
	FindBestGUITitle.TextScaled = true
	FindBestGUITitle.Font = Enum.Font.GothamBold
	FindBestGUITitle.Position = UDim2.new(0,0,0.025,0)
	FindBestGUITitle.TextXAlignment = Enum.TextXAlignment.Center
local Gunk = Instance.new("UIGridLayout")
	Gunk.Name = "GunkLayout"
	Gunk.Parent = FindBestGUIFrame
	Gunk.CellSize = UDim2.new(0.215,0,0.135,0)
	Gunk.CellPadding = UDim2.new(0.035,0,0.05,0)
	Gunk.SortOrder = Enum.SortOrder.LayoutOrder
	Gunk.FillDirectionMaxCells = 4
	Gunk.HorizontalAlignment = Enum.HorizontalAlignment.Center

local speedBoostActive = false
local jumpBoostActive = false

local PRIORITY_WALKSPEED = 51 -- Needs Work
local DEFAULT_WALKSPEED = 34
local PRIORITY_JUMPHEIGHT = 20 --Good
local DEFAULT_JUMPHEIGHT = 7.2

--//Making Buttons

addSwitch(core, "Speed Boost:", "speedToggle", 2, function(enabled)
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = enabled and PRIORITY_WALKSPEED or DEFAULT_WALKSPEED
		speedBoostActive = enabled
	end
end)

addSwitch(core, "Jump Boost:", "jumpToggle", 4, function(enabled)
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.JumpHeight = enabled and PRIORITY_JUMPHEIGHT or DEFAULT_JUMPHEIGHT
		jumpBoostActive = enabled
	end
end)

addSwitch(core, "Scanner:", "scanner", 6, function(enabled)
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("TextLabel") and obj.Name == "Generation" then
			local value = ParseGenerationValue(obj.Text)
			local brainrot = obj:FindFirstAncestorOfClass("Model")
			
			print("Model: ",brainrot, " |  Value: ",value)
		end
	end
end)

addSwitch(core, "Find Best: ", "findBest", 8, function(enabled)
	local targetPos
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	if not FindBestGUIMenu.Enabled then
		FindBestGUIMenu.Enabled = true
		targetPos = UDim2.new(0, 0, 0.135, 0)
	else
		FindBestGUIMenu.Enabled = false
		targetPos = UDim2.new(-0.2, 0, 0.135, 0)
	end

	local tween = TweenService:Create(FindBestGUIFrame, tweenInfo, {Position = targetPos})
	tween:Play()
end)

addSwitch(FindBestGUIFrame, "Test: ", "testing", 2, function(enabled)
	local character = getCharacter()
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local best = findBestRot()
	if not hrp or not best then return end
	local p1 = Instance.new("Attachment")
	p1.Parent = hrp
	local p2 = Instance.new("Attachment")
	p2.Parent = best:FindFirstChild("HumanoidRootPart") or best.PrimaryPart or best

	local oldbeam = hrp:FindFirstChild("FortniteBurger") or nil
	if oldbeam then oldbeam:destory() end
	local beam = Instance.new("Beam")
	beam.Name = "FortniteBurger"
	beam.Attachment0 = p1
	beam.Attachment1 = p2
	beam.Parent = hrp
end)

addSwitch(FindBestGUIFrame, "Clear Beams: ", "beamClear", 4, function(enabled)
	local character = getCharacter()
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _, child in ipairs(hrp:GetChildren()) do
		if child:IsA("Beam") and child.Name == "FortniteBurger" then
			child:Destroy()
		end
	end
end)


game:GetService("RunService").Stepped:Connect(function()
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if hum then
		if speedBoostActive and hum.WalkSpeed ~= PRIORITY_WALKSPEED then
			hum.WalkSpeed = PRIORITY_WALKSPEED
		end

		if jumpBoostActive and hum.JumpHeight ~= PRIORITY_JUMPHEIGHT then
			hum.JumpHeight = PRIORITY_JUMPHEIGHT
		end
		currentSpeedGui.Text = "Speed: " .. math.floor(hum.WalkSpeed)
	end
end)

scaleUpButton.MouseButton1Click:Connect(function()
	scale(0.05)
end)

scaleDownButton.MouseButton1Click:Connect(function()
	scale(-0.05)
end)

