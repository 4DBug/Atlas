# Input

Input Widgets are textboxes for typing in specific number values. See [Drag](), [Slider]() or [InputText]() for more input types.

ImGui provides a set of specific inputs for the datatypes: [Number](), [Vector2](), [Vector3](), [UDim](), [UDim2](), [Rect](), [Color3]() and the custom [Color4]().

Each Input widget has the same arguments but the types depend of the DataType:

1. Text: string? = "Input{type}" -- the text to be displayed to the right of the textbox.
2. Increment: DataType? = nil, -- the increment argument determines how a value will be rounded once the textbox looses focus.
3. Min: DataType? = nil, -- the minimum value that the widget will allow, no clamping by default.
4. Max: DataType? = nil, -- the maximum value that the widget will allow, no clamping by default.
5. Format: string | { string }? = [DYNAMIC] -- uses string.format to customise visual display.

The format string can either by a single value which will apply to every box, or a table allowing specific text.

> [!NOTE]
> If you do not specify a format option then ImGui will dynamically calculate a relevant number of sigifs and format option. For example, if you have Increment, Min and Max values of 1, 0 and 100, then ImGui will guess that you are only using integers and will format the value as an integer. As another example, if you have Increment, Min and max values of 0.005, 0, 1, then ImGui will guess you are using a float of 3 significant figures.
> 
> Additionally, for certain DataTypes, ImGui will append an prefix to each box if no format option is provided. For example, a Vector3 box will have the append values of "X: ", "Y: " and "Z: " to the relevant input box.


## Properties

