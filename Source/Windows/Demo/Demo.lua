
return function(ImGui)
	local showMainWindow = ImGui.State(true)
	local showRecursiveWindow = ImGui.State(false)
	local showRuntimeInfo = ImGui.State(false)
	local showStyleEditor = ImGui.State(false)
	local showWindowlessDemo = ImGui.State(false)
	local showMainMenuBarWindow = ImGui.State(false)
	local showDebugWindow = ImGui.State(false)

	local function helpMarker(helpText: string)
		ImGui.PushConfig({ TextColor = ImGui._config.TextDisabledColor })
		local text = ImGui.Text({ "(?)" })
		ImGui.PopConfig()

		ImGui.PushConfig({ ContentWidth = UDim.new(0, 350) })
		if text.hovered() then
			ImGui.Tooltip({ helpText })
		end
		ImGui.PopConfig()
	end

	local function textAndHelpMarker(text: string, helpText: string)
		ImGui.SameLine()
		do
			ImGui.Text({ text })
			helpMarker(helpText)
		end
		ImGui.End()
	end

	-- shows each widgets functionality
	local widgetDemos = {
		Basic = function()
			ImGui.Tree({ "Basic" })
			do
				ImGui.SeparatorText({ "Basic" })

				local radioButtonState: Types.State<any> = ImGui.State(1)
				ImGui.Button({ "Button" })
				ImGui.SmallButton({ "SmallButton" })
				ImGui.Text({ "Text" })
				ImGui.TextWrapped({ string.rep("Text Wrapped ", 5) })
				ImGui.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
				ImGui.Text({ `Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= "rgb(240, 40, 10)">red text</font> <font size="32">bigger text</font>`, true, nil, true })

				ImGui.SameLine()
				do
					ImGui.RadioButton({ "Index '1'", 1 }, { index = radioButtonState })
					ImGui.RadioButton({ "Index 'two'", "two" }, { index = radioButtonState })
					if ImGui.RadioButton({ "Index 'false'", false }, { index = radioButtonState }).active() == false then
						if ImGui.SmallButton({ "Select last" }).clicked() then
							radioButtonState:set(false)
						end
					end
				end
				ImGui.End()

				ImGui.Text({ "The Index is: " .. tostring(radioButtonState.value) })

				ImGui.SeparatorText({ "Inputs" })

				ImGui.InputNum({})
				ImGui.DragNum({})
				ImGui.SliderNum({})
			end
			ImGui.End()
		end,

		Image = function()
			ImGui.Tree({ "Image" })
			do
				ImGui.SeparatorText({ "Image Controls" })

				local AssetState = ImGui.State("rbxasset://textures/ui/common/robux.png")
				local SizeState = ImGui.State(UDim2.fromOffset(100, 100))
				local RectState = ImGui.State(Rect.new(0, 0, 0, 0))
				local ScaleTypeState = ImGui.State(Enum.ScaleType.Stretch)
				local PixelatedCheckState = ImGui.State(false)
				local PixelatedState = ImGui.ComputedState(PixelatedCheckState, function(check: boolean)
					return check and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default
				end)

				local ImageColorState = ImGui.State(ImGui._config.ImageColor)
				local ImageTransparencyState = ImGui.State(ImGui._config.ImageTransparency)
				ImGui.InputColor4({ "Image Tint" }, { color = ImageColorState, transparency = ImageTransparencyState })

				ImGui.Combo({ "Asset" }, { index = AssetState })
				do
					ImGui.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, { index = AssetState })
					ImGui.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, { index = AssetState })
					ImGui.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, { index = AssetState })
					ImGui.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, { index = AssetState })
					ImGui.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, { index = AssetState })
				end
				ImGui.End()

				ImGui.SliderUDim2({ "Image Size", nil, nil, UDim2.new(1, 240, 1, 240) }, { number = SizeState })
				ImGui.SliderRect({ "Image Rect", nil, nil, Rect.new(256, 256, 256, 256) }, { number = RectState })

				ImGui.Combo({ "Scale Type" }, { index = ScaleTypeState })
				do
					ImGui.Selectable({ "Stretch", Enum.ScaleType.Stretch }, { index = ScaleTypeState })
					ImGui.Selectable({ "Fit", Enum.ScaleType.Fit }, { index = ScaleTypeState })
					ImGui.Selectable({ "Crop", Enum.ScaleType.Crop }, { index = ScaleTypeState })
				end

				ImGui.End()
				ImGui.Checkbox({ "Pixelated" }, { isChecked = PixelatedCheckState })

				ImGui.PushConfig({
					ImageColor = ImageColorState:get(),
					ImageTransparency = ImageTransparencyState:get(),
				})
				ImGui.Image({ AssetState:get(), SizeState:get(), RectState:get(), ScaleTypeState:get(), PixelatedState:get() })
				ImGui.PopConfig()

				ImGui.SeparatorText({ "Tile" })
				local TileState = ImGui.State(UDim2.fromScale(0.5, 0.5))
				ImGui.SliderUDim2({ "Tile Size", nil, nil, UDim2.new(1, 240, 1, 240) }, { number = TileState })

				ImGui.PushConfig({
					ImageColor = ImageColorState:get(),
					ImageTransparency = ImageTransparencyState:get(),
				})
				ImGui.Image({ "rbxasset://textures/grid2.png", SizeState:get(), nil, Enum.ScaleType.Tile, PixelatedState:get(), TileState:get() })
				ImGui.PopConfig()

				ImGui.SeparatorText({ "Slice" })
				local SliceScaleState = ImGui.State(1)
				ImGui.SliderNum({ "Image Slice Scale", 0.1, 0.1, 5 }, { number = SliceScaleState })

				ImGui.PushConfig({
					ImageColor = ImageColorState:get(),
					ImageTransparency = ImageTransparencyState:get(),
				})
				ImGui.Image({ "rbxasset://textures/ui/chatBubble_blue_notify_bkg.png", SizeState:get(), nil, Enum.ScaleType.Slice, PixelatedState:get(), nil, Rect.new(12, 12, 56, 56), 1 }, SliceScaleState:get())
				ImGui.PopConfig()

				ImGui.SeparatorText({ "Image Button" })
				local count = ImGui.State(0)

				ImGui.SameLine()
				do
					ImGui.PushConfig({
						ImageColor = ImageColorState:get(),
						ImageTransparency = ImageTransparencyState:get(),
					})
					if ImGui.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
						count:set(count.value + 1)
					end
					ImGui.PopConfig()

					ImGui.Text({ `Click count: {count.value}` })
				end
				ImGui.End()
			end
			ImGui.End()
		end,

		Selectable = function()
			ImGui.Tree({ "Selectable" })
			do
				local sharedIndex = ImGui.State(2)
				ImGui.Selectable({ "Selectable #1", 1 }, { index = sharedIndex })
				ImGui.Selectable({ "Selectable #2", 2 }, { index = sharedIndex })
				if ImGui.Selectable({ "Double click Selectable", 3, true }, { index = sharedIndex }).doubleClicked() then
					sharedIndex:set(3)
				end

				ImGui.Selectable({ "Impossible to select", 4, true }, { index = sharedIndex })
				if ImGui.Button({ "Select last" }).clicked() then
					sharedIndex:set(4)
				end

				ImGui.Selectable({ "Independent Selectable" })
			end
			ImGui.End()
		end,

		Combo = function()
			ImGui.Tree({ "Combo" })
			do
				ImGui.PushConfig({ ContentWidth = UDim.new(1, -200) })
				local sharedComboIndex = ImGui.State("No Selection")

				local NoPreview, NoButton
				ImGui.SameLine()
				do
					NoPreview = ImGui.Checkbox({ "No Preview" })
					NoButton = ImGui.Checkbox({ "No Button" })
					if NoPreview.checked() and NoButton.isChecked.value == true then
						NoButton.isChecked:set(false)
					end
					if NoButton.checked() and NoPreview.isChecked.value == true then
						NoPreview.isChecked:set(false)
					end
				end
				ImGui.End()

				ImGui.Combo({ "Basic Usage", NoButton.isChecked:get(), NoPreview.isChecked:get() }, { index = sharedComboIndex })
				do
					ImGui.Selectable({ "Select 1", "One" }, { index = sharedComboIndex })
					ImGui.Selectable({ "Select 2", "Two" }, { index = sharedComboIndex })
					ImGui.Selectable({ "Select 3", "Three" }, { index = sharedComboIndex })
				end
				ImGui.End()

				ImGui.ComboArray({ "Using ComboArray" }, { index = "No Selection" }, { "Red", "Green", "Blue" })

				local sharedComboIndex2 = ImGui.State("7 AM")

				ImGui.Combo({ "Combo with Inner widgets" }, { index = sharedComboIndex2 })
				do
					ImGui.Tree({ "Morning Shifts" })
					do
						ImGui.Selectable({ "Shift at 7 AM", "7 AM" }, { index = sharedComboIndex2 })
						ImGui.Selectable({ "Shift at 11 AM", "11 AM" }, { index = sharedComboIndex2 })
						ImGui.Selectable({ "Shift at 3 PM", "3 PM" }, { index = sharedComboIndex2 })
					end
					ImGui.End()
					ImGui.Tree({ "Night Shifts" })
					do
						ImGui.Selectable({ "Shift at 6 PM", "6 PM" }, { index = sharedComboIndex2 })
						ImGui.Selectable({ "Shift at 9 PM", "9 PM" }, { index = sharedComboIndex2 })
					end
					ImGui.End()
				end
				ImGui.End()

				local ComboEnum = ImGui.ComboEnum({ "Using ComboEnum" }, { index = Enum.UserInputState.Begin }, Enum.UserInputState)
				ImGui.Text({ "Selected: " .. ComboEnum.index:get().Name })
				ImGui.PopConfig()
			end
			ImGui.End()
		end,

		Tree = function()
			ImGui.Tree({ "Trees" })
			do
				ImGui.Tree({ "Tree using SpanAvailWidth", true })
				do
					helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
				end
				ImGui.End()

				local tree1 = ImGui.Tree({ "Tree with Children" })
				do
					ImGui.Text({ "Im inside the first tree!" })
					ImGui.Button({ "Im a button inside the first tree!" })
					ImGui.Tree({ "Im a tree inside the first tree!" })
					do
						ImGui.Text({ "I am the innermost text!" })
					end
					ImGui.End()
				end
				ImGui.End()

				ImGui.Checkbox({ "Toggle above tree" }, { isChecked = tree1.state.isUncollapsed })
			end
			ImGui.End()
		end,

		CollapsingHeader = function()
			ImGui.Tree({ "Collapsing Headers" })
			do
				ImGui.CollapsingHeader({ "A header" })
				do
					ImGui.Text({ "This is under the first header!" })
				end
				ImGui.End()

				local secondHeader = ImGui.State(false)
				ImGui.CollapsingHeader({ "Another header" }, { isUncollapsed = secondHeader })
				do
					if ImGui.Button({ "Shhh... secret button!" }).clicked() then
						secondHeader:set(true)
					end
				end
				ImGui.End()
			end
			ImGui.End()
		end,

		Group = function()
			ImGui.Tree({ "Groups" })
			do
				ImGui.SameLine()
				do
					ImGui.Group()
					do
						ImGui.Text({ "I am in group A" })
						ImGui.Button({ "Im also in A" })
					end
					ImGui.End()

					ImGui.Separator()

					ImGui.Group()
					do
						ImGui.Text({ "I am in group B" })
						ImGui.Button({ "Im also in B" })
						ImGui.Button({ "Also group B" })
					end
					ImGui.End()
				end
				ImGui.End()
			end
			ImGui.End()
		end,

		Tab = function()
			ImGui.Tree({ "Tabs" })
			do
				ImGui.Tree({ "Simple" })
				do
					ImGui.TabBar()
					do
						ImGui.Tab({ "Apples" })
						do
							ImGui.Text({ "Who loves apples?" })
						end
						ImGui.End()
						ImGui.Tab({ "Broccoli" })
						do
							ImGui.Text({ "And what about broccoli?" })
						end
						ImGui.End()
						ImGui.Tab({ "Carrots" })
						do
							ImGui.Text({ "But carrots are the best." })
						end
						ImGui.End()
					end
					ImGui.End()
					ImGui.Separator()
					ImGui.Text({ "Very important questions." })
				end
				ImGui.End()

				ImGui.Tree({ "Closable" })
				do
					local a = ImGui.State(true)
					local b = ImGui.State(true)
					local c = ImGui.State(true)

					ImGui.TabBar()
					do
						ImGui.Tab({ "🍎", true }, { isOpened = a })
						do
							ImGui.Text({ "Who loves apples?" })
							if ImGui.Button({ "I don't like apples." }).clicked() then
								a:set(false)
							end
						end
						ImGui.End()
						ImGui.Tab({ "🥦", true }, { isOpened = b })
						do
							ImGui.Text({ "And what about broccoli?" })
							if ImGui.Button({ "Not for me." }).clicked() then
								b:set(false)
							end
						end
						ImGui.End()
						ImGui.Tab({ "🥕", true }, { isOpened = c })
						do
							ImGui.Text({ "But carrots are the best." })
							if ImGui.Button({ "I disagree with you." }).clicked() then
								c:set(false)
							end
						end
						ImGui.End()
					end
					ImGui.End()
					ImGui.Separator()
					if ImGui.Button({ "Actually, let me reconsider it." }).clicked() then
						a:set(true)
						b:set(true)
						c:set(true)
					end
				end
				ImGui.End()
			end
			ImGui.End()
		end,

		Indent = function()
			ImGui.Tree({ "Indents" })
			ImGui.Text({ "Not Indented" })
			ImGui.Indent()
			do
				ImGui.Text({ "Indented" })
				ImGui.Indent({ 7 })
				do
					ImGui.Text({ "Indented by 7 more pixels" })
					ImGui.End()

					ImGui.Indent({ -7 })
					do
						ImGui.Text({ "Indented by 7 less pixels" })
					end
					ImGui.End()
				end
				ImGui.End()
			end
			ImGui.End()
		end,

		Input = function()
			ImGui.Tree({ "Input" })
			do
				local NoField, NoButtons, Min, Max, Increment, Format = ImGui.State(false), ImGui.State(false), ImGui.State(0), ImGui.State(100), ImGui.State(1), ImGui.State("%d")

				ImGui.PushConfig({ ContentWidth = UDim.new(1, -120) })
				local InputNum = ImGui.InputNum({
					[ImGui.Args.InputNum.Text] = "Input Number",
					-- [ImGui.Args.InputNum.NoField] = NoField.value,
					[ImGui.Args.InputNum.NoButtons] = NoButtons.value,
					[ImGui.Args.InputNum.Min] = Min.value,
					[ImGui.Args.InputNum.Max] = Max.value,
					[ImGui.Args.InputNum.Increment] = Increment.value,
					[ImGui.Args.InputNum.Format] = { Format.value },
				})
				ImGui.PopConfig()
				ImGui.Text({ "The Value is: " .. InputNum.number.value })
				if ImGui.Button({ "Randomize Number" }).clicked() then
					InputNum.number:set(math.random(1, 99))
				end
				local NoFieldCheckbox = ImGui.Checkbox({ "NoField" }, { isChecked = NoField })
				local NoButtonsCheckbox = ImGui.Checkbox({ "NoButtons" }, { isChecked = NoButtons })
				if NoFieldCheckbox.checked() and NoButtonsCheckbox.isChecked.value == true then
					NoButtonsCheckbox.isChecked:set(false)
				end
				if NoButtonsCheckbox.checked() and NoFieldCheckbox.isChecked.value == true then
					NoFieldCheckbox.isChecked:set(false)
				end

				ImGui.PushConfig({ ContentWidth = UDim.new(1, -120) })
				ImGui.InputVector2({ "InputVector2" })
				ImGui.InputVector3({ "InputVector3" })
				ImGui.InputUDim({ "InputUDim" })
				ImGui.InputUDim2({ "InputUDim2" })
				local UseFloats = ImGui.State(false)
				local UseHSV = ImGui.State(false)
				local sharedColor = ImGui.State(Color3.new())
				local transparency = ImGui.State(0)
				ImGui.SliderNum({ "Transparency", 0.01, 0, 1 }, { number = transparency })
				ImGui.InputColor3({ "InputColor3", UseFloats:get(), UseHSV:get() }, { color = sharedColor })
				ImGui.InputColor4({ "InputColor4", UseFloats:get(), UseHSV:get() }, { color = sharedColor, transparency = transparency })
				ImGui.SameLine()
				ImGui.Text({ sharedColor:get():ToHex() })
				ImGui.Checkbox({ "Use Floats" }, { isChecked = UseFloats })
				ImGui.Checkbox({ "Use HSV" }, { isChecked = UseHSV })
				ImGui.End()

				ImGui.PopConfig()

				ImGui.Separator()

				ImGui.SameLine()
				do
					ImGui.Text({ "Slider Numbers" })
					helpMarker("ctrl + click slider number widgets to input a number")
				end
				ImGui.End()
				ImGui.PushConfig({ ContentWidth = UDim.new(1, -120) })
				ImGui.SliderNum({ "Slide Int", 1, 1, 8 })
				ImGui.SliderNum({ "Slide Float", 0.01, 0, 100 })
				ImGui.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" })
				ImGui.SliderNum({ "Odd Ranges", 0.001, -math.pi, math.pi, "%f radians" })
				ImGui.SliderNum({ "Big Numbers", 1e4, 1e5, 1e7 })
				ImGui.SliderNum({ "Few Numbers", 1, 0, 3 })
				ImGui.PopConfig()

				ImGui.Separator()

				ImGui.SameLine()
				do
					ImGui.Text({ "Drag Numbers" })
					helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
				end
				ImGui.End()
				ImGui.PushConfig({ ContentWidth = UDim.new(1, -120) })
				ImGui.DragNum({ "Drag Int" })
				ImGui.DragNum({ "Slide Float", 0.001, -10, 10 })
				ImGui.DragNum({ "Percentage", 1, 0, 100, "%d %%" })
				ImGui.PopConfig()
			end
			ImGui.End()
		end,

		InputText = function()
			ImGui.Tree({ "Input Text" })
			do
				local InputText = ImGui.InputText({ "Input Text Test", "Input Text here" })
				ImGui.Text({ "The text is: " .. InputText.text.value })
			end
			ImGui.End()
		end,

		MultiInput = function()
			ImGui.Tree({ "Multi-Component Input" })
			do
				local sharedVector2 = ImGui.State(Vector2.new())
				local sharedVector3 = ImGui.State(Vector3.new())
				local sharedUDim = ImGui.State(UDim.new())
				local sharedUDim2 = ImGui.State(UDim2.new())
				local sharedColor3 = ImGui.State(Color3.new())
				local SharedRect = ImGui.State(Rect.new(0, 0, 0, 0))

				ImGui.SeparatorText({ "Input" })

				ImGui.InputVector2({}, { number = sharedVector2 })
				ImGui.InputVector3({}, { number = sharedVector3 })
				ImGui.InputUDim({}, { number = sharedUDim })
				ImGui.InputUDim2({}, { number = sharedUDim2 })
				ImGui.InputRect({}, { number = SharedRect })

				ImGui.SeparatorText({ "Drag" })

				ImGui.DragVector2({}, { number = sharedVector2 })
				ImGui.DragVector3({}, { number = sharedVector3 })
				ImGui.DragUDim({}, { number = sharedUDim })
				ImGui.DragUDim2({}, { number = sharedUDim2 })
				ImGui.DragRect({}, { number = SharedRect })

				ImGui.SeparatorText({ "Slider" })

				ImGui.SliderVector2({}, { number = sharedVector2 })
				ImGui.SliderVector3({}, { number = sharedVector3 })
				ImGui.SliderUDim({}, { number = sharedUDim })
				ImGui.SliderUDim2({}, { number = sharedUDim2 })
				ImGui.SliderRect({}, { number = SharedRect })

				ImGui.SeparatorText({ "Color" })

				ImGui.InputColor3({}, { color = sharedColor3 })
				ImGui.InputColor4({}, { color = sharedColor3 })
			end
			ImGui.End()
		end,

		Tooltip = function()
			ImGui.PushConfig({ ContentWidth = UDim.new(0, 250) })
			ImGui.Tree({ "Tooltip" })
			do
				if ImGui.Text({ "Hover over me to reveal a tooltip" }).hovered() then
					ImGui.Tooltip({ "I am some helpful tooltip text" })
				end
				local dynamicText = ImGui.State("Hello ")
				local numRepeat = ImGui.State(1)
				if ImGui.InputNum({ "# of repeat", 1, 1, 50 }, { number = numRepeat }).numberChanged() then
					dynamicText:set(string.rep("Hello ", numRepeat:get()))
				end
				if ImGui.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
					ImGui.Tooltip({ dynamicText:get() })
				end
			end
			ImGui.End()
			ImGui.PopConfig()
		end,

		Plotting = function()
			ImGui.Tree({ "Plotting" })
			do
				local curTime = os.clock() * 15

				local Progress = ImGui.State(0)
				-- formula to cycle between 0 and 100 linearly
				local newValue = math.clamp((math.abs(curTime % 100 - 50)) - 7.5, 0, 35) / 35
				Progress:set(newValue)

				ImGui.ProgressBar({ "Progress Bar" }, { progress = Progress })
				ImGui.ProgressBar({ "Progress Bar", `{math.floor(Progress:get() * 1753)}/1753` }, { progress = Progress })
			end
			ImGui.End()
		end,
	}
	local widgetDemosOrder = { "Basic", "Image", "Selectable", "Combo", "Tree", "CollapsingHeader", "Group", "Tab", "Indent", "Input", "MultiInput", "InputText", "Tooltip", "Plotting" }

	local function recursiveTree()
		local theTree = ImGui.Tree({ "Recursive Tree" })
		do
			if theTree.state.isUncollapsed.value then
				recursiveTree()
			end
		end
		ImGui.End()
	end

	local function recursiveWindow(parentCheckboxState)
		local theCheckbox
		ImGui.Window({ "Recursive Window" }, { size = ImGui.State(Vector2.new(175, 100)), isOpened = parentCheckboxState })
		do
			theCheckbox = ImGui.Checkbox({ "Recurse Again" })
		end
		ImGui.End()

		if theCheckbox.isChecked.value then
			recursiveWindow(theCheckbox.isChecked)
		end
	end

	-- shows list of runtime widgets and states, including IDs. shows other info about runtime and can show widgets/state info in depth.
	local function runtimeInfo()
		local runtimeInfoWindow = ImGui.Window({ "Runtime Info" }, { isOpened = showRuntimeInfo })
		do
			local lastVDOM = ImGui.Internal._lastVDOM
			local states = ImGui.Internal._states

			local numSecondsDisabled = ImGui.State(3)
			local rollingDT = ImGui.State(0)
			local lastT = ImGui.State(os.clock())

			ImGui.SameLine()
			do
				ImGui.InputNum({ [ImGui.Args.InputNum.Text] = "", [ImGui.Args.InputNum.Format] = "%d Seconds", [ImGui.Args.InputNum.Max] = 10 }, { number = numSecondsDisabled })
				if ImGui.Button({ "Disable" }).clicked() then
					ImGui.Disabled = true
					task.delay(numSecondsDisabled:get(), function()
						ImGui.Disabled = false
					end)
				end
			end
			ImGui.End()

			local t = os.clock()
			local dt = t - lastT.value
			rollingDT.value += (dt - rollingDT.value) * 0.2
			lastT.value = t
			ImGui.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", rollingDT.value * 1000, 1 / rollingDT.value) })

			ImGui.Text({
				string.format("Window Position: (%d, %d), Window Size: (%d, %d)", runtimeInfoWindow.position.value.X, runtimeInfoWindow.position.value.Y, runtimeInfoWindow.size.value.X, runtimeInfoWindow.size.value.Y),
			})

			ImGui.SameLine()
			do
				ImGui.Text({ "Enter an ID to learn more about it." })
				helpMarker("every widget and state has an ID which ImGui tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
			end
			ImGui.End()

			ImGui.PushConfig({ ItemWidth = UDim.new(1, -150) })
			local enteredText = ImGui.InputText({ "ID field" }, { text = ImGui.State(runtimeInfoWindow.ID) }).state.text.value
			ImGui.PopConfig()

			ImGui.Indent()
			do
				local enteredWidget = lastVDOM[enteredText]
				local enteredState = states[enteredText]
				if enteredWidget then
					ImGui.Table({ 1 })
					ImGui.Text({ string.format('The ID, "%s", is a widget', enteredText) })
					ImGui.NextRow()

					ImGui.Text({ string.format("Widget is type: %s", enteredWidget.type) })
					ImGui.NextRow()

					ImGui.Tree({ "Widget has Args:" }, { isUncollapsed = ImGui.State(true) })
					for i, v in enteredWidget.arguments do
						ImGui.Text({ i .. " - " .. tostring(v) })
					end
					ImGui.End()
					ImGui.NextRow()

					if enteredWidget.state then
						ImGui.Tree({ "Widget has State:" }, { isUncollapsed = ImGui.State(true) })
						for i, v in enteredWidget.state do
							ImGui.Text({ i .. " - " .. tostring(v.value) })
						end
						ImGui.End()
					end
					ImGui.End()
				elseif enteredState then
					ImGui.Table({ 1 })
					ImGui.Text({ string.format('The ID, "%s", is a state', enteredText) })
					ImGui.NextRow()

					ImGui.Text({ string.format("Value is type: %s, Value = %s", typeof(enteredState.value), tostring(enteredState.value)) })
					ImGui.NextRow()

					ImGui.Tree({ "state has connected widgets:" }, { isUncollapsed = ImGui.State(true) })
					for i, v in enteredState.ConnectedWidgets do
						ImGui.Text({ i .. " - " .. v.type })
					end
					ImGui.End()
					ImGui.NextRow()

					ImGui.Text({ string.format("state has: %d connected functions", #enteredState.ConnectedFunctions) })
					ImGui.End()
				else
					ImGui.Text({ string.format('The ID, "%s", is not a state or widget', enteredText) })
				end
			end
			ImGui.End()

			if ImGui.Tree({ "Widgets" }).state.isUncollapsed.value then
				local widgetCount = 0
				local widgetStr = ""
				for _, v in lastVDOM do
					widgetCount += 1
					widgetStr ..= "\n" .. v.ID .. " - " .. v.type
				end

				ImGui.Text({ "Number of Widgets: " .. widgetCount })

				ImGui.Text({ widgetStr })
			end
			ImGui.End()

			if ImGui.Tree({ "States" }).state.isUncollapsed.value then
				local stateCount = 0
				local stateStr = ""
				for i, v in states do
					stateCount += 1
					stateStr ..= "\n" .. i .. " - " .. tostring(v.value)
				end

				ImGui.Text({ "Number of States: " .. stateCount })

				ImGui.Text({ stateStr })
			end
			ImGui.End()
		end
		ImGui.End()
	end

	local function debugPanel()
		ImGui.Window({ "Debug Panel" }, { isOpened = showDebugWindow })
		do
			ImGui.CollapsingHeader({ "Widgets" })
			do
				ImGui.SeparatorText({ "GuiService" })
				ImGui.Text({ `GuiOffset: {ImGui.Internal._utility.GuiOffset}` })
				ImGui.Text({ `MouseOffset: {ImGui.Internal._utility.MouseOffset}` })

				ImGui.SeparatorText({ "UserInputService" })
				ImGui.Text({ `MousePosition: {ImGui.Internal._utility.UserInputService:GetMouseLocation()}` })
				ImGui.Text({ `MouseLocation: {ImGui.Internal._utility.getMouseLocation()}` })

				ImGui.Text({ `Left Control: {ImGui.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)}` })
				ImGui.Text({ `Right Control: {ImGui.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)}` })
			end
			ImGui.End()
		end
		ImGui.End()
	end

	local function recursiveMenu()
		if ImGui.Menu({ "Recursive" }).state.isOpened.value then
			ImGui.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
			ImGui.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
			ImGui.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
			ImGui.Separator()
			ImGui.MenuToggle({ "Autosave" })
			ImGui.MenuToggle({ "Checked" })
			ImGui.Separator()
			ImGui.Menu({ "Options" })
			ImGui.MenuItem({ "Red" })
			ImGui.MenuItem({ "Yellow" })
			ImGui.MenuItem({ "Green" })
			ImGui.MenuItem({ "Blue" })
			ImGui.Separator()
			recursiveMenu()
			ImGui.End()
		end
		ImGui.End()
	end

	local function mainMenuBar()
		ImGui.MenuBar()
		do
			ImGui.Menu({ "File" })
			do
				ImGui.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
				ImGui.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
				ImGui.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
				recursiveMenu()
				if ImGui.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
					showMainWindow:set(false)
				end
			end
			ImGui.End()

			ImGui.Menu({ "Examples" })
			do
				ImGui.MenuToggle({ "Recursive Window" }, { isChecked = showRecursiveWindow })
				ImGui.MenuToggle({ "Windowless" }, { isChecked = showWindowlessDemo })
				ImGui.MenuToggle({ "Main Menu Bar" }, { isChecked = showMainMenuBarWindow })
			end
			ImGui.End()

			ImGui.Menu({ "Tools" })
			do
				ImGui.MenuToggle({ "Runtime Info" }, { isChecked = showRuntimeInfo })
				ImGui.MenuToggle({ "Style Editor" }, { isChecked = showStyleEditor })
				ImGui.MenuToggle({ "Debug Panel" }, { isChecked = showDebugWindow })
			end
			ImGui.End()
		end
		ImGui.End()
	end

	local function mainMenuBarExample()
		-- local screenSize = ImGui.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize
		-- ImGui.Window(
		--     {[ImGui.Args.Window.NoBackground] = true, [ImGui.Args.Window.NoTitleBar] = true, [ImGui.Args.Window.NoMove] = true, [ImGui.Args.Window.NoResize] = true},
		--     {size = ImGui.State(screenSize), position = ImGui.State(Vector2.new(0, 0))}
		-- )

		mainMenuBar()

		--ImGui.End()
	end

	-- allows users to edit state
	local styleEditor
	do
		styleEditor = function()
			local styleList = {
				{
					"Sizing",
					function()
						local UpdatedConfig = ImGui.State({})

						ImGui.SameLine()
						do
							if ImGui.Button({ "Update" }).clicked() then
								ImGui.UpdateGlobalConfig(UpdatedConfig.value)
								UpdatedConfig:set({})
							end

							helpMarker("Update the global config with these changes.")
						end
						ImGui.End()

						local function SliderInput(input: string, arguments: { any })
							local Input = ImGui[input](arguments, { number = ImGui.WeakState(ImGui._config[arguments[1]]) })
							if Input.numberChanged() then
								UpdatedConfig.value[arguments[1]] = Input.number:get()
							end
						end

						local function BooleanInput(arguments: { any })
							local Input = ImGui.Checkbox(arguments, { isChecked = ImGui.WeakState(ImGui._config[arguments[1]]) })
							if Input.checked() or Input.unchecked() then
								UpdatedConfig.value[arguments[1]] = Input.isChecked:get()
							end
						end

						ImGui.SeparatorText({ "Main" })
						SliderInput("SliderVector2", { "WindowPadding", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderVector2", { "WindowResizePadding", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderVector2", { "FramePadding", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderVector2", { "ItemSpacing", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderVector2", { "ItemInnerSpacing", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderVector2", { "CellPadding", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderNum", { "IndentSpacing", 1, 0, 36 })
						SliderInput("SliderNum", { "ScrollbarSize", 1, 0, 20 })
						SliderInput("SliderNum", { "GrabMinSize", 1, 0, 20 })

						ImGui.SeparatorText({ "Borders & Rounding" })
						SliderInput("SliderNum", { "FrameBorderSize", 0.1, 0, 1 })
						SliderInput("SliderNum", { "WindowBorderSize", 0.1, 0, 1 })
						SliderInput("SliderNum", { "PopupBorderSize", 0.1, 0, 1 })
						SliderInput("SliderNum", { "SeparatorTextBorderSize", 1, 0, 20 })
						SliderInput("SliderNum", { "FrameRounding", 1, 0, 12 })
						SliderInput("SliderNum", { "GrabRounding", 1, 0, 12 })
						SliderInput("SliderNum", { "PopupRounding", 1, 0, 12 })

						ImGui.SeparatorText({ "Widgets" })
						SliderInput("SliderVector2", { "DisplaySafeAreaPadding", nil, Vector2.zero, Vector2.new(20, 20) })
						SliderInput("SliderVector2", { "SeparatorTextPadding", nil, Vector2.zero, Vector2.new(36, 36) })
						SliderInput("SliderUDim", { "ItemWidth", nil, UDim.new(), UDim.new(1, 200) })
						SliderInput("SliderUDim", { "ContentWidth", nil, UDim.new(), UDim.new(1, 200) })
						SliderInput("SliderNum", { "ImageBorderSize", 1, 0, 12 })
						local TitleInput = ImGui.ComboEnum({ "WindowTitleAlign" }, { index = ImGui.WeakState(ImGui._config.WindowTitleAlign) }, Enum.LeftRight)
						if TitleInput.closed() then
							UpdatedConfig.value["WindowTitleAlign"] = TitleInput.index:get()
						end
						BooleanInput({ "RichText" })
						BooleanInput({ "TextWrapped" })

						ImGui.SeparatorText({ "Config" })
						BooleanInput({ "UseScreenGUIs" })
						SliderInput("DragNum", { "DisplayOrderOffset", 1, 0 })
						SliderInput("DragNum", { "ZIndexOffset", 1, 0 })
						SliderInput("SliderNum", { "MouseDoubleClickTime", 0.1, 0, 5 })
						SliderInput("SliderNum", { "MouseDoubleClickMaxDist", 0.1, 0, 20 })
					end,
				},
				{
					"Colors",
					function()
						local UpdatedConfig = ImGui.State({})

						ImGui.SameLine()
						do
							if ImGui.Button({ "Update" }).clicked() then
								ImGui.UpdateGlobalConfig(UpdatedConfig.value)
								UpdatedConfig:set({})
							end
							helpMarker("Update the global config with these changes.")
						end
						ImGui.End()

						local color4s = {
							"Text",
							"TextDisabled",
							"WindowBg",
							"PopupBg",
							"Border",
							"BorderActive",
							"ScrollbarGrab",
							"TitleBg",
							"TitleBgActive",
							"TitleBgCollapsed",
							"MenubarBg",
							"FrameBg",
							"FrameBgHovered",
							"FrameBgActive",
							"Button",
							"ButtonHovered",
							"ButtonActive",
							"Image",
							"SliderGrab",
							"SliderGrabActive",
							"Header",
							"HeaderHovered",
							"HeaderActive",
							"SelectionImageObject",
							"SelectionImageObjectBorder",
							"TableBorderStrong",
							"TableBorderLight",
							"TableRowBg",
							"TableRowBgAlt",
							"NavWindowingHighlight",
							"NavWindowingDimBg",
							"Separator",
							"CheckMark",
						}

						for _, vColor in color4s do
							local Input = ImGui.InputColor4({ vColor }, {
								color = ImGui.WeakState(ImGui._config[vColor .. "Color"]),
								transparency = ImGui.WeakState(ImGui._config[vColor .. "Transparency"]),
							})
							if Input.numberChanged() then
								UpdatedConfig.value[vColor .. "Color"] = Input.color:get()
								UpdatedConfig.value[vColor .. "Transparency"] = Input.transparency:get()
							end
						end
					end,
				},
				{
					"Fonts",
					function()
						local UpdatedConfig = ImGui.State({})

						ImGui.SameLine()
						do
							if ImGui.Button({ "Update" }).clicked() then
								ImGui.UpdateGlobalConfig(UpdatedConfig.value)
								UpdatedConfig:set({})
							end

							helpMarker("Update the global config with these changes.")
						end
						ImGui.End()

						local fonts: { [string]: Font } = {
							["Code (default)"] = Font.fromEnum(Enum.Font.Code),
							["Ubuntu (template)"] = Font.fromEnum(Enum.Font.Ubuntu),
							["Arial"] = Font.fromEnum(Enum.Font.Arial),
							["Highway"] = Font.fromEnum(Enum.Font.Highway),
							["Roboto"] = Font.fromEnum(Enum.Font.Roboto),
							["Roboto Mono"] = Font.fromEnum(Enum.Font.RobotoMono),
							["Noto Sans"] = Font.new("rbxassetid://12187370747"),
							["Builder Sans"] = Font.fromEnum(Enum.Font.BuilderSans),
							["Builder Mono"] = Font.new("rbxassetid://16658246179"),
							["Sono"] = Font.new("rbxassetid://12187374537"),
						}

						ImGui.Text({ `Current Font: {ImGui._config.TextFont.Family} Weight: {ImGui._config.TextFont.Weight} Style: {ImGui._config.TextFont.Style}` })
						ImGui.SeparatorText({ "Size" })

						local TextSize = ImGui.SliderNum({ "Font Size", 1, 4, 20 }, { number = ImGui.WeakState(ImGui._config.TextSize) })
						if TextSize.numberChanged() then
							UpdatedConfig.value["TextSize"] = TextSize.state.number:get()
						end

						ImGui.SeparatorText({ "Properties" })

						local TextFont = ImGui.WeakState(ImGui._config.TextFont.Family)
						local FontWeight = ImGui.ComboEnum({ "Font Weight" }, { index = ImGui.WeakState(ImGui._config.TextFont.Weight) }, Enum.FontWeight)
						local FontStyle = ImGui.ComboEnum({ "Font Style" }, { index = ImGui.WeakState(ImGui._config.TextFont.Style) }, Enum.FontStyle)

						ImGui.SeparatorText({ "Fonts" })
						for name: string, font: Font in fonts do
							font = Font.new(font.Family, FontWeight.state.index.value, FontStyle.state.index.value)
							ImGui.SameLine()
							do
								ImGui.PushConfig({
									TextFont = font,
								})

								if ImGui.Selectable({ `{name} | "The quick brown fox jumps over the lazy dog."`, font.Family }, { index = TextFont }).selected() then
									UpdatedConfig.value["TextFont"] = font
								end
								ImGui.PopConfig()
							end
							ImGui.End()
						end
					end,
				},
			}

			ImGui.Window({ "Style Editor" }, { isOpened = showStyleEditor })
			do
				ImGui.Text({ "Customize the look of ImGui in realtime." })

				local ThemeState = ImGui.State("Dark Theme")
				if ImGui.ComboArray({ "Theme" }, { index = ThemeState }, { "Dark Theme", "Light Theme" }).closed() then
					if ThemeState.value == "Dark Theme" then
						ImGui.UpdateGlobalConfig(ImGui.TemplateConfig.colorDark)
					elseif ThemeState.value == "Light Theme" then
						ImGui.UpdateGlobalConfig(ImGui.TemplateConfig.colorLight)
					end
				end

				local SizeState = ImGui.State("Classic Size")
				if ImGui.ComboArray({ "Size" }, { index = SizeState }, { "Classic Size", "Larger Size" }).closed() then
					if SizeState.value == "Classic Size" then
						ImGui.UpdateGlobalConfig(ImGui.TemplateConfig.sizeDefault)
					elseif SizeState.value == "Larger Size" then
						ImGui.UpdateGlobalConfig(ImGui.TemplateConfig.sizeClear)
					end
				end

				ImGui.SameLine()
				do
					if ImGui.Button({ "Revert" }).clicked() then
						ImGui.UpdateGlobalConfig(ImGui.TemplateConfig.colorDark)
						ImGui.UpdateGlobalConfig(ImGui.TemplateConfig.sizeDefault)
						ThemeState:set("Dark Theme")
						SizeState:set("Classic Size")
					end

					helpMarker("Reset ImGui to the default theme and size.")
				end
				ImGui.End()

				ImGui.TabBar()
				do
					for i, v in ipairs(styleList) do
						ImGui.Tab({ v[1] })
						do
							styleList[i][2]()
						end
						ImGui.End()
					end
				end
				ImGui.End()

				ImGui.Separator()
			end
			ImGui.End()
		end
	end

	local function widgetEventInteractivity()
		ImGui.CollapsingHeader({ "Widget Event Interactivity" })
		do
			local clickCount = ImGui.State(0)
			if ImGui.Button({ "Click to increase Number" }).clicked() then
				clickCount:set(clickCount:get() + 1)
			end
			ImGui.Text({ "The Number is: " .. clickCount:get() })

			ImGui.Separator()

			local showEventText = ImGui.State(false)
			local selectedEvent = ImGui.State("clicked")

			ImGui.SameLine()
			do
				ImGui.RadioButton({ "clicked", "clicked" }, { index = selectedEvent })
				ImGui.RadioButton({ "rightClicked", "rightClicked" }, { index = selectedEvent })
				ImGui.RadioButton({ "doubleClicked", "doubleClicked" }, { index = selectedEvent })
				ImGui.RadioButton({ "ctrlClicked", "ctrlClicked" }, { index = selectedEvent })
			end
			ImGui.End()

			ImGui.SameLine()
			do
				local button = ImGui.Button({ selectedEvent:get() .. " to reveal text" })
				if button[selectedEvent:get()]() then
					showEventText:set(not showEventText:get())
				end
				if showEventText:get() then
					ImGui.Text({ "Here i am!" })
				end
			end
			ImGui.End()

			ImGui.Separator()

			local showTextTimer = ImGui.State(0)
			ImGui.SameLine()
			do
				if ImGui.Button({ "Click to show text for 20 frames" }).clicked() then
					showTextTimer:set(20)
				end
				if showTextTimer:get() > 0 then
					ImGui.Text({ "Here i am!" })
				end
			end
			ImGui.End()

			showTextTimer:set(math.max(0, showTextTimer:get() - 1))
			ImGui.Text({ "Text Timer: " .. showTextTimer:get() })

			local checkbox0 = ImGui.Checkbox({ "Event-tracked checkbox" })
			ImGui.Indent()
			do
				ImGui.Text({ "unchecked: " .. tostring(checkbox0.unchecked()) })
				ImGui.Text({ "checked: " .. tostring(checkbox0.checked()) })
			end
			ImGui.End()

			ImGui.SameLine()
			do
				if ImGui.Button({ "Hover over me" }).hovered() then
					ImGui.Text({ "The button is hovered" })
				end
			end
			ImGui.End()
		end
		ImGui.End()
	end

	local function widgetStateInteractivity()
		ImGui.CollapsingHeader({ "Widget State Interactivity" })
		do
			local checkbox0 = ImGui.Checkbox({ "Widget-Generated State" })
			ImGui.Text({ `isChecked: {checkbox0.state.isChecked.value}\n` })

			local checkboxState0 = ImGui.State(false)
			local checkbox1 = ImGui.Checkbox({ "User-Generated State" }, { isChecked = checkboxState0 })
			ImGui.Text({ `isChecked: {checkbox1.state.isChecked.value}\n` })

			local checkbox2 = ImGui.Checkbox({ "Widget Coupled State" })
			local checkbox3 = ImGui.Checkbox({ "Coupled to above Checkbox" }, { isChecked = checkbox2.state.isChecked })
			ImGui.Text({ `isChecked: {checkbox3.state.isChecked.value}\n` })

			local checkboxState1 = ImGui.State(false)
			local _checkbox4 = ImGui.Checkbox({ "Widget and Code Coupled State" }, { isChecked = checkboxState1 })
			local Button0 = ImGui.Button({ "Click to toggle above checkbox" })
			if Button0.clicked() then
				checkboxState1:set(not checkboxState1:get())
			end
			ImGui.Text({ `isChecked: {checkboxState1.value}\n` })

			local checkboxState2 = ImGui.State(true)
			local checkboxState3 = ImGui.ComputedState(checkboxState2, function(newValue)
				return not newValue
			end)
			local _checkbox5 = ImGui.Checkbox({ "ComputedState (dynamic coupling)" }, { isChecked = checkboxState2 })
			local _checkbox5 = ImGui.Checkbox({ "Inverted of above checkbox" }, { isChecked = checkboxState3 })
			ImGui.Text({ `isChecked: {checkboxState3.value}\n` })
		end
		ImGui.End()
	end

	local function dynamicStyle()
		ImGui.CollapsingHeader({ "Dynamic Styles" })
		do
			local colorH = ImGui.State(0)
			ImGui.SameLine()
			do
				if ImGui.Button({ "Change Color" }).clicked() then
					colorH:set(math.random())
				end
				ImGui.Text({ "Hue: " .. math.floor(colorH:get() * 255) })
				helpMarker("Using PushConfig with a changing value, this can be done with any config field")
			end
			ImGui.End()

			ImGui.PushConfig({ TextColor = Color3.fromHSV(colorH:get(), 1, 1) })
			ImGui.Text({ "Text with a unique and changable color" })
			ImGui.PopConfig()
		end
		ImGui.End()
	end

	local function tablesDemo()
		local showTablesTree = ImGui.State(false)

		ImGui.CollapsingHeader({ "Tables & Columns" }, { isUncollapsed = showTablesTree })
		if showTablesTree.value == false then
			-- optimization to skip code which draws GUI which wont be seen.
			-- its a trade off because when the tree becomes opened widgets will all have to be generated again.
			-- Dear ImGui utilizes the same trick, but its less useful here because the Retained mode Backend
			ImGui.End()
		else
			ImGui.SameLine()
			do
				ImGui.Text({ "Table using NextRow and NextColumn syntax:" })
				helpMarker("calling ImGui.NextRow() in the outer loop, and ImGui.NextColumn()in the inner loop")
			end
			ImGui.End()

			ImGui.Table({ 3 })
			do
				for i = 1, 4 do
					ImGui.NextRow()
					for i2 = 1, 3 do
						ImGui.NextColumn()
						ImGui.Text({ `Row: {i}, Column: {i2}` })
					end
				end
			end
			ImGui.End()

			ImGui.Text({ "" })

			ImGui.SameLine()
			do
				ImGui.Text({ "Table using NextColumn only syntax:" })
				helpMarker("only calling ImGui.NextColumn() in the inner loop, the result is identical")
			end
			ImGui.End()

			ImGui.Table({ 2 })
			do
				for i = 1, 4 do
					for i2 = 1, 2 do
						ImGui.NextColumn()
						ImGui.Text({ `Row: {i}, Column: {i2}` })
					end
				end
			end
			ImGui.End()

			ImGui.Separator()

			local TableRowBg = ImGui.State(false)
			local TableBordersOuter = ImGui.State(false)
			local TableBordersInner = ImGui.State(true)
			local TableUseButtons = ImGui.State(true)
			local TableNumRows = ImGui.State(3)

			ImGui.Text({ "Table with Customizable Arguments" })
			ImGui.Table({
				[ImGui.Args.Table.NumColumns] = 4,
				[ImGui.Args.Table.RowBg] = TableRowBg.value,
				[ImGui.Args.Table.BordersOuter] = TableBordersOuter.value,
				[ImGui.Args.Table.BordersInner] = TableBordersInner.value,
			})
			do
				for i = 1, TableNumRows:get() do
					for i2 = 1, 4 do
						ImGui.NextColumn()
						if TableUseButtons.value then
							ImGui.Button({ `Month: {i}, Week: {i2}` })
						else
							ImGui.Text({ `Month: {i}, Week: {i2}` })
						end
					end
				end
			end
			ImGui.End()

			ImGui.Checkbox({ "RowBg" }, { isChecked = TableRowBg })
			ImGui.Checkbox({ "BordersOuter" }, { isChecked = TableBordersOuter })
			ImGui.Checkbox({ "BordersInner" }, { isChecked = TableBordersInner })

			ImGui.SameLine()
			do
				ImGui.RadioButton({ "Buttons", true }, { index = TableUseButtons })
				ImGui.RadioButton({ "Text", false }, { index = TableUseButtons })
			end
			ImGui.End()

			ImGui.InputNum({
				[ImGui.Args.InputNum.Text] = "Number of rows",
				[ImGui.Args.InputNum.Min] = 0,
				[ImGui.Args.InputNum.Max] = 100,
				[ImGui.Args.InputNum.Format] = "%d",
			}, { number = TableNumRows })

			ImGui.End()
		end
	end

	local function layoutDemo()
		ImGui.CollapsingHeader({ "Widget Layout" })
		do
			ImGui.Tree({ "Widget Alignment" })
			do
				ImGui.Text({ "ImGui.SameLine has optional argument supporting horizontal and vertical alignments." })
				ImGui.Text({ "This allows widgets to be place anywhere on the line." })
				ImGui.Separator()

				ImGui.SameLine()
				do
					ImGui.Text({ "By default child widgets will be aligned to the left." })
					helpMarker('ImGui.SameLine()\n\tImGui.Button({ "Button A" })\n\tImGui.Button({ "Button B" })\nImGui.End()')
				end
				ImGui.End()

				ImGui.SameLine()
				do
					ImGui.Button({ "Button A" })
					ImGui.Button({ "Button B" })
				end
				ImGui.End()

				ImGui.SameLine()
				do
					ImGui.Text({ "But can be aligned to the center." })
					helpMarker('ImGui.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })\n\tImGui.Button({ "Button A" })\n\tImGui.Button({ "Button B" })\nImGui.End()')
				end
				ImGui.End()

				ImGui.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })
				do
					ImGui.Button({ "Button A" })
					ImGui.Button({ "Button B" })
				end
				ImGui.End()

				ImGui.SameLine()
				do
					ImGui.Text({ "Or right." })
					helpMarker('ImGui.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })\n\tImGui.Button({ "Button A" })\n\tImGui.Button({ "Button B" })\nImGui.End()')
				end
				ImGui.End()

				ImGui.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })
				do
					ImGui.Button({ "Button A" })
					ImGui.Button({ "Button B" })
				end
				ImGui.End()

				ImGui.Separator()

				ImGui.SameLine()
				do
					ImGui.Text({ "You can also specify the padding." })
					helpMarker('ImGui.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })\n\tImGui.Button({ "Button A" })\n\tImGui.Button({ "Button B" })\nImGui.End()')
				end
				ImGui.End()

				ImGui.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
				do
					ImGui.Button({ "Button A" })
					ImGui.Button({ "Button B" })
				end
				ImGui.End()
			end
			ImGui.End()

			ImGui.Tree({ "Widget Sizing" })
			do
				ImGui.Text({ "Nearly all widgets are the minimum size of the content." })
				ImGui.Text({ "For example, text and button widgets will be the size of the text labels." })
				ImGui.Text({ "Some widgets, such as the Image and Button have Size arguments will will set the size of them." })
				ImGui.Separator()

				textAndHelpMarker("The button takes up the full screen-width.", 'ImGui.Button({ "Button", UDim2.fromScale(1, 0) })')
				ImGui.Button({ "Button", UDim2.fromScale(1, 0) })
				textAndHelpMarker("The button takes up half the screen-width.", 'ImGui.Button({ "Button", UDim2.fromScale(0.5, 0) })')
				ImGui.Button({ "Button", UDim2.fromScale(0.5, 0) })

				textAndHelpMarker("Combining with SameLine, the buttons can fill the screen width.", "The button will still be larger that the text size.")
				local num = ImGui.State(2)
				ImGui.SliderNum({ "Number of Buttons", 1, 1, 8 }, { number = num })
				ImGui.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
				do
					for i = 1, num.value do
						ImGui.Button({ `Button {i}`, UDim2.fromScale(1 / num.value, 0) })
					end
				end
				ImGui.End()
			end
			ImGui.End()

			ImGui.Tree({ "Content Width" })
			do
				local value = ImGui.State(50)
				local index = ImGui.State(Enum.Axis.X)

				ImGui.Text({ "The Content Width is a size property which determines the width of input fields." })
				ImGui.SameLine()
				do
					ImGui.Text({ "By default the value is UDim.new(0.65, 0)" })
					helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
				end
				ImGui.End()

				ImGui.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." })
				ImGui.Text({ "Therefore, we can use ImGui.PushConfig() to change the width" })

				ImGui.Separator()

				ImGui.SameLine()
				do
					ImGui.Text({ "Content Width = 150 pixels" })
					helpMarker("UDim.new(0, 150)")
				end
				ImGui.End()

				ImGui.PushConfig({ ContentWidth = UDim.new(0, 150) })
				ImGui.DragNum({ "number", 1, 0, 100 }, { number = value })
				ImGui.InputEnum({ "axis" }, { index = index }, Enum.Axis)
				ImGui.PopConfig()

				ImGui.SameLine()
				do
					ImGui.Text({ "Content Width = 50% window width" })
					helpMarker("UDim.new(0.5, 0)")
				end
				ImGui.End()

				ImGui.PushConfig({ ContentWidth = UDim.new(0.5, 0) })
				ImGui.DragNum({ "number", 1, 0, 100 }, { number = value })
				ImGui.InputEnum({ "axis" }, { index = index }, Enum.Axis)
				ImGui.PopConfig()

				ImGui.SameLine()
				do
					ImGui.Text({ "Content Width = -150 pixels from the right side" })
					helpMarker("UDim.new(1, -150)")
				end
				ImGui.End()

				ImGui.PushConfig({ ContentWidth = UDim.new(1, -150) })
				ImGui.DragNum({ "number", 1, 0, 100 }, { number = value })
				ImGui.InputEnum({ "axis" }, { index = index }, Enum.Axis)
				ImGui.PopConfig()
			end
			ImGui.End()

			ImGui.Tree({ "Content Height" })
			do
				local text = ImGui.State("a single line")
				local value = ImGui.State(50)
				local index = ImGui.State(Enum.Axis.X)
				local progress = ImGui.State(0)

				-- formula to cycle between 0 and 100 linearly
				local newValue = math.clamp((math.abs((os.clock() * 15) % 100 - 50)) - 7.5, 0, 35) / 35
				progress:set(newValue)

				ImGui.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." })
				ImGui.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." })
				ImGui.Text({ "We use ImGui.PushConfig() to change this value." })

				ImGui.Separator()
				ImGui.SameLine()
				do
					ImGui.Text({ "Content Height = 0 pixels" })
					helpMarker("UDim.new(0, 0)")
				end
				ImGui.End()

				ImGui.InputText({ "text" }, { text = text })
				ImGui.ProgressBar({ "progress" }, { progress = progress })
				ImGui.DragNum({ "number", 1, 0, 100 }, { number = value })
				ImGui.ComboEnum({ "axis" }, { index = index }, Enum.Axis)

				ImGui.SameLine()
				do
					ImGui.Text({ "Content Height = 60 pixels" })
					helpMarker("UDim.new(0, 60)")
				end
				ImGui.End()

				ImGui.PushConfig({ ContentHeight = UDim.new(0, 60) })
				ImGui.InputText({ "text", nil, nil, true }, { text = text })
				ImGui.ProgressBar({ "progress" }, { progress = progress })
				ImGui.DragNum({ "number", 1, 0, 100 }, { number = value })
				ImGui.ComboEnum({ "axis" }, { index = index }, Enum.Axis)
				ImGui.PopConfig()

				ImGui.Text({ "This property can be used to force the height of a text box." })
				ImGui.Text({ "Just make sure you enable the MultiLine argument." })
			end
			ImGui.End()
		end
		ImGui.End()
	end

	-- showcases how widgets placed outside of a window are placed inside root
	local function windowlessDemo()
		ImGui.PushConfig({ ItemWidth = UDim.new(0, 150) })
		ImGui.SameLine()
		do
			ImGui.TextWrapped({ "Windowless widgets" })
			helpMarker("Widgets which are placed outside of a window will appear on the top left side of the screen.")
		end
		ImGui.End()

		ImGui.Button({})
		ImGui.Tree({})
		do
			ImGui.InputText({})
		end
		ImGui.End()

		ImGui.PopConfig()
	end

	-- main demo window
	return function()
		local NoTitleBar: Types.State<boolean> = ImGui.State(false)
		local NoBackground: Types.State<boolean> = ImGui.State(false)
		local NoCollapse: Types.State<boolean> = ImGui.State(false)
		local NoClose: Types.State<boolean> = ImGui.State(true)
		local NoMove: Types.State<boolean> = ImGui.State(false)
		local NoScrollbar: Types.State<boolean> = ImGui.State(false)
		local NoResize: Types.State<boolean> = ImGui.State(false)
		local NoNav: Types.State<boolean> = ImGui.State(false)
		local NoMenu: Types.State<boolean> = ImGui.State(false)

		if showMainWindow.value == false then
			ImGui.Checkbox({ "Open main window" }, { isChecked = showMainWindow })
			return
		end

		debug.profilebegin("ImGui/Demo/Window")
		local window: Types.Window = ImGui.Window({
			[ImGui.Args.Window.Title] = "ImGui Demo Window",
			[ImGui.Args.Window.NoTitleBar] = NoTitleBar.value,
			[ImGui.Args.Window.NoBackground] = NoBackground.value,
			[ImGui.Args.Window.NoCollapse] = NoCollapse.value,
			[ImGui.Args.Window.NoClose] = NoClose.value,
			[ImGui.Args.Window.NoMove] = NoMove.value,
			[ImGui.Args.Window.NoScrollbar] = NoScrollbar.value,
			[ImGui.Args.Window.NoResize] = NoResize.value,
			[ImGui.Args.Window.NoNav] = NoNav.value,
			[ImGui.Args.Window.NoMenu] = NoMenu.value,
		}, { size = ImGui.State(Vector2.new(600, 550)), position = ImGui.State(Vector2.new(100, 25)), isOpened = showMainWindow })

		if window.state.isUncollapsed.value and window.state.isOpened.value then
			debug.profilebegin("ImGui/Demo/MenuBar")
			mainMenuBar()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/Options")
			ImGui.CollapsingHeader({ "Window Options" })
			do
				ImGui.Table({ 3, false, false, false })
				do
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoTitleBar" }, { isChecked = NoTitleBar })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoBackground" }, { isChecked = NoBackground })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoCollapse" }, { isChecked = NoCollapse })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoClose" }, { isChecked = NoClose })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoMove" }, { isChecked = NoMove })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoScrollbar" }, { isChecked = NoScrollbar })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoResize" }, { isChecked = NoResize })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoNav" }, { isChecked = NoNav })
					ImGui.NextColumn()
					ImGui.Checkbox({ "NoMenu" }, { isChecked = NoMenu })
				end
				ImGui.End()
			end
			ImGui.End()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/Events")
			widgetEventInteractivity()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/States")
			widgetStateInteractivity()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/Recursive")
			ImGui.CollapsingHeader({ "Recursive Tree" })
			recursiveTree()
			ImGui.End()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/Style")
			dynamicStyle()
			debug.profileend()

			ImGui.Separator()

			debug.profilebegin("ImGui/Demo/Widgets")
			ImGui.CollapsingHeader({ "Widgets" })
			do
				for _, name in widgetDemosOrder do
					debug.profilebegin(`ImGui/Demo/Widgets/{name}`)
					widgetDemos[name]()
					debug.profileend()
				end
			end
			ImGui.End()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/Tables")
			tablesDemo()
			debug.profileend()

			debug.profilebegin("ImGui/Demo/Layout")
			layoutDemo()
			debug.profileend()
		end
		ImGui.End()
		debug.profileend()

		if showRecursiveWindow.value then
			recursiveWindow(showRecursiveWindow)
		end
		if showRuntimeInfo.value then
			runtimeInfo()
		end
		if showDebugWindow.value then
			debugPanel()
		end
		if showStyleEditor.value then
			styleEditor()
		end
		if showWindowlessDemo.value then
			windowlessDemo()
		end

		if showMainMenuBarWindow.value then
			mainMenuBarExample()
		end

		return window
	end
end
