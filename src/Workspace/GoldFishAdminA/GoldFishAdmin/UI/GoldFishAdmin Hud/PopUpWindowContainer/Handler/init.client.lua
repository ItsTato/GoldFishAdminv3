local draggable = require(script.DraggableObject);

local newDrag = draggable.new(script.Parent.TopBar);

newDrag:Enable();

script.Parent.TopBar.CloseButton.MouseButton1Click:Connect(function()
	script.Parent:Destroy();
end);
