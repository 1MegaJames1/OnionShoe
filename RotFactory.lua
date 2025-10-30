local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Sigma
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

local container = Instance.new("Frame") container.Parent = screengui container.Size = UDim2.new(0.20,0,0.3,0) container.Name = "Bigbah"
container.Draggable = true container.Active = true container.Position = UDim2.new(0.35,0,0.35,0) container.BackgroundColor3 = Color3.fromRGB(118, 16, 24)
addCorner(container, 0.1)

local title = Instance.new("TextLabel") title.Parent = container title.Size = UDim2.new(1,0,0.2,0) title.Text = "🧠🔥 Rot Factory 🔥🧠" title.BorderSizePixel = 0 title.BackgroundTransparency = 1  
title.TextColor3 = Color3.fromRGB(255,255,255) title.Interactable = false title.TextScaled = true title.Font = Enum.Font.GothamBold title.Position = UDim2.new(0,0,0,0) title.TextXAlignment = Enum.TextXAlignment.Center

local core = Instance.new("Frame") core.Name = "Core" core.Parent = container core.Position = UDim2.new(0,0,0.2,0) core.Size = UDim2.new(1, 0, 0.65, 0) core.BorderSizePixel = 0 core.BackgroundTransparency = 1
local grid = Instance.new("UIGridLayout") grid.Name = "Grid" grid.Parent = core grid.CellSize = UDim2.new(0.215,0,0.135,0) grid.CellPadding = UDim2.new(0.035,0,0.05,0) grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.FillDirectionMaxCells = 4 grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
 
local function addSwitch(text, name, order, callback)
	local on = false
	local main = Instance.new("Frame")
	local bttnTxt = Instance.new("TextLabel") bttnTxt.Parent = core bttnTxt.Text = text bttnTxt.TextColor3 = Color3.fromRGB(255,255,255) bttnTxt.TextScaled = true
	bttnTxt.BackgroundColor3 = Color3.fromRGB(0,0,0) bttnTxt.BackgroundTransparency = 0.75 bttnTxt.BorderSizePixel = 0 bttnTxt.LayoutOrder = (order -1) addCorner(bttnTxt, 0.3)
	local bttnClk = Instance.new("TextButton") bttnClk.Parent = core bttnClk.Name = name bttnClk.LayoutOrder = order bttnClk.Text = ""
	bttnClk.BorderSizePixel = 0 bttnClk.BackgroundColor3 = Color3.fromRGB(130, 131, 131) bttnClk.AutoButtonColor = false addCorner(bttnClk, 0.3)
	local fx = Instance.new("Frame") fx.Size = UDim2.new(0.25,0,1,0) fx.Parent = bttnClk fx.BorderSizePixel = 0
	addCorner(fx, 1)
	
	
	bttnClk.MouseButton1Click:connect(function()
		on = not on
		local targetPos = on and UDim2.new(0.75,0,fx.Position.Y.Scale,0) or UDim2.new(0,0,fx.Position.Y.Scale,0)
		local tween = tweenService:Create(fx, tweenInfo, {Position = targetPos})
		tween:Play()
		task.wait(0.3)
		if on then bttnClk.BackgroundColor3 = Color3.fromRGB(95, 149, 103)
		else
			bttnClk.BackgroundColor3 = Color3.fromRGB(130, 131, 131)
		end
		callback(on)
	end)
end

local scaleUpButton = Instance.new("TextButton") scaleUpButton.Parent = container scaleUpButton.Size = UDim2.new(0.1,0,0.1,0) scaleUpButton.Text = "+" scaleUpButton.Position = UDim2.new(0.75,0,0.85,0)
scaleUpButton.BorderSizePixel = 0 addCorner(scaleUpButton, 0.35) scaleUpButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16) scaleUpButton.BackgroundTransparency = 0.75 scaleUpButton.TextColor3 = Color3.fromRGB(255,255,255) scaleUpButton.TextScaled = true

local scaleDownButton = Instance.new("TextButton") scaleDownButton.Parent = container scaleDownButton.Size = UDim2.new(0.1,0,0.1,0) scaleDownButton.Text = "-" scaleDownButton.Position = UDim2.new(0.15, 0, 0.85,0)
scaleDownButton.BorderSizePixel = 0 addCorner(scaleDownButton, 0.35) scaleDownButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16) scaleDownButton.BackgroundTransparency = 0.75 scaleDownButton.TextColor3 = Color3.fromRGB(255,255,255) scaleDownButton.TextScaled = true

addSwitch("Speed Boost", "speedToggle", 2, function(enabled) local char = player.Character or player.CharacterAdded:Wait() local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = enabled and 45 or 18 end end)
addSwitch("Jump Boost", "jumpToggle", 4, function(enabled) local char = player.Character or player.CharacterAdded:Wait() local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.JumpHeight = enabled and 12 or 7.2 end end)


local function scale(change)
	local currentX = container.Size.X.Scale
	local currentY = container.Size.Y.Scale

	local newX = math.clamp(currentX + change, 0.2, 0.45)
	local newY = math.clamp(currentY + change, 0.3, 0.55)

	local tween = tweenService:Create(container, tweenInfo, {Size = UDim2.new(newX,0,newY,0)}) tween:Play()
end

local function ParseGenerationValue(text)
	if typeof(text) ~= "string" then return 0 end
	local cleanText = text:gsub("%$", ""):gsub("/s", "")
	local numPart = cleanText:match("([%d%.]+)")
	local suffix = cleanText:match("([KMBT])%s*$")
	if not numPart then return 0 end
	local number = tonumber(numPart) or 0
	local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
	if suffix and multipliers[suffix] then
		number *= multipliers[suffix]
	end
	return number
end


scaleUpButton.MouseButton1Click:Connect(function()
	scale(0.05)
end)

scaleDownButton.MouseButton1Click:Connect(function()
	scale(-0.05)
end)
