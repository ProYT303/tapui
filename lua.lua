TAPGui = {scriptName = "TapGUI:SetName('name')", rainbow = false, expanded = false, expanding = nil, expandedRendered = false, sliderFocused = false, sliderFocusedOn = nil, windows = {}}


function TAPGui:SetName(name) 
	TAPGui.scriptName = name;
end
function TAPGui:NameRainbow(bool) 
	TAPGui.rainbow = bool;
end
function TAPGui:NewWindow(name)
	local new = {name = name, toggles = {}, buttons = {}, sliders = {}};
	function new:addToggle(toggleName, func)
		local d = {name = toggleName, callback = func, toggled = false}
		function d:Toggle()
			d.toggled = not d.toggled;
			func(d.toggled)
		end
		table.insert(new.toggles, d)
	end
	function new:addButton(buttonName, func)
		local d = {name = buttonName, callback = func}
		function d:Execute()
			func()
		end
		table.insert(new.buttons, d)
	end
	function new:addSlider(SliderName,defaultInteger,minimumInteger,maximalInteger,func)
		local d = {name = SliderName, callback = func, number = defaultInteger, min = minimumInteger, max = maximalInteger}
		function d:Update(number)
			d.number = number
			func(number)
		end
		table.insert(new.sliders, d)
	end
	return new
end
function TAPGui:InsertWindow(w) 
	table.insert(TAPGui.windows, w)
end

function render(TAPGui)

	local ParentTapGUI = Instance.new("ScreenGui")
	local NameHandler = Instance.new("Frame")
	local ScriptLabel = Instance.new("TextLabel")
		
		
	ParentTapGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ParentTapGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ParentTapGUI.Name = 'susamogus'
	NameHandler.Parent = ParentTapGUI
	NameHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameHandler.BackgroundTransparency = 1.000
	NameHandler.BorderSizePixel = 0
	NameHandler.Size = UDim2.new(0.0843373463, 0, 0.212523714, 0)
	NameHandler.Name = "handler"
	ScriptLabel.Parent = NameHandler
	ScriptLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScriptLabel.BackgroundTransparency = 1.000
	ScriptLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ScriptLabel.BorderSizePixel = 0
	ScriptLabel.Size = UDim2.new(0, 274, 0, 101)
	ScriptLabel.Font = Enum.Font.SourceSans
	ScriptLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	ScriptLabel.TextScaled = true
	ScriptLabel.TextSize = 14.000
	ScriptLabel.TextWrapped = true
	ScriptLabel.Text = TAPGui.scriptName
	for i,v in ipairs(TAPGui.windows) do

		local TextButton = Instance.new("TextButton")

		TextButton.Parent = NameHandler
		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.BackgroundTransparency = 0.800
		TextButton.Position = UDim2.new(0.0843373463, 0, 0.5 + (0.5 * i), 0)
		TextButton.Size = UDim2.new(0, 200, 0, 50)
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.TextScaled = true
		TextButton.TextSize = 14.000
		TextButton.TextWrapped = true
		TextButton.Text = v.name
		TextButton.MouseButton1Up:Connect(function()
			
			if TAPGui.expanded and not TAPGui.sliderFocused then
				if TAPGui.expanding == v.name then
					TAPGui.expanded = false
					TAPGui.expanding = nil
					TextButton.BackgroundTransparency = 0.800
				end
			elseif not TAPGui.expanded and #v.toggles > 0 or #v.buttons > 0 or #v.sliders > 0 then
				TAPGui.expanded = true
				TAPGui.expanding = v.name
				TextButton.BackgroundTransparency = 0.500
			end
		end)
	end
	coroutine.wrap(function()
		repeat
			
			local hue = tick() % 1 / 1
			local color = Color3.fromHSV(hue, 1, 1)

			ScriptLabel.TextColor3 = color
			wait(.05)
		
		until not TAPGui.NameRainbow ;
	end)()
	
	coroutine.wrap(function()
		while wait() do
			if TAPGui.expanded and TAPGui.expanding ~= nil and not TAPGui.expandedRendered and not TAPGui.sliderFocused then
				
				wait()
				local e = nil;
				for i,v in ipairs(TAPGui.windows) do
					if v.name == TAPGui.expanding then
						e = v
					end
				end
				if e then
					local next = 0
					for i, v in ipairs(e.toggles) do 
						local TextButton = Instance.new("TextButton")
						TextButton.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild('susamogus'):WaitForChild("handler")
						TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						coroutine.wrap(function()
							repeat
								if v.toggled then
									TextButton.BackgroundTransparency = 0.500
								else 
									TextButton.BackgroundTransparency = 0.900
								end	
								wait()
							until not TextButton;
						end)()

						TextButton.Position = UDim2.new(3.3, 0, 0.5 + (0.5 * i), 0)
						TextButton.Size = UDim2.new(0, 148, 0, 50)
						TextButton.Font = Enum.Font.SourceSans
						TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.TextScaled = true
						TextButton.TextSize = 14.000
						TextButton.TextWrapped = true
						TextButton.Text = v.name
						TextButton.MouseButton1Up:Connect(function()
							v:Toggle()
						end)
						TextButton.Name = 'expanded'
						next = 0.5 + (0.5 * i)
					end
					for i, v in ipairs(e.buttons) do 
						local TextButton = Instance.new("TextButton")
						TextButton.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild('susamogus'):WaitForChild("handler")
						TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BackgroundTransparency = 0.800
						TextButton.Position = UDim2.new(3.3, 0, next + (0.5 * i), 0)
						TextButton.Size = UDim2.new(0, 148, 0, 50)
						TextButton.Font = Enum.Font.SourceSans
						TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.TextScaled = true
						TextButton.TextSize = 14.000
						TextButton.TextWrapped = true
						TextButton.Text = v.name
						TextButton.MouseButton1Up:Connect(function()
							TextButton.BackgroundTransparency = 0.500
							v:Execute()

							wait(1)

							TextButton.BackgroundTransparency = 0.800

						end)
						TextButton.BackgroundTransparency = 0.800
						TextButton.Name = 'expanded'
						next = next + (0.5 * i)
					end
					for i, v in ipairs(e.sliders) do 
						local TextButton = Instance.new("TextButton")
						TextButton.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild('susamogus'):WaitForChild("handler")
						TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BackgroundTransparency = 0.800
						TextButton.Position = UDim2.new(3.3, 0, next + (0.5 * i), 0)
						TextButton.Size = UDim2.new(0, 148, 0, 50)
						TextButton.Font = Enum.Font.SourceSans
						TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.TextScaled = true
						TextButton.TextSize = 14.000
						TextButton.TextWrapped = true
						local numberonstring = v.name .. ":" .. tostring(v.number)
						TextButton.Text = numberonstring
						TextButton.MouseButton1Up:Connect(function()
							TAPGui.sliderFocused = not TAPGui.sliderFocused;
							if TAPGui.sliderFocused then
								TextButton.BackgroundTransparency = 0.400
								
							else
								TextButton.BackgroundTransparency = 1
							end
							
						end)
						local up = Enum.KeyCode.Up
						local down = Enum.KeyCode.Down
						
						TextButton.Name = 'expanded'
						
						game:GetService("UserInputService").InputBegan:Connect(function()
							if not TAPGui.sliderFocused then
								return
							end
							
							if game:GetService("UserInputService"):IsKeyDown(up) and (v.number + 1) <= v.max then
								TextButton.Text = v.name .. ":" .. tostring(v.number)
								
								
								v:Update(v.number + 1)
							end
							if game:GetService("UserInputService"):IsKeyDown(down) and (v.number - 1) >= v.min  then
								TextButton.Text = v.name .. ":" .. tostring(v.number)
								
								
								v:Update(v.number - 1)
							end
						end)

						
					end
				end
				
				TAPGui.expandedRendered = true;

			else 
				if not TAPGui.expanded then
					for i, v in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild('susamogus'):WaitForChild("handler"):GetChildren()) do
						if v.Name == "expanded" then
							v:Destroy()
						end
					end
					TAPGui.expandedRendered = false;
					TAPGui.sliderFocused = false
				end
			end
			wait()
		end
	end)()

end
