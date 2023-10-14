local cmdName = "";
local onHover = "";

onHover = script.Parent.onHover.Value;
cmdName = script.Parent.Text.Text;

script.Parent.onHover:Destroy();

script.Parent.MouseEnter:Connect(function()
	script.Parent.Text.Text = onHover;
	for i = 1,.5,-.02 do
		script.Parent.Transparency = i;
		task.wait();
	end;
end);

script.Parent.MouseLeave:Connect(function()
	script.Parent.Text.Text = cmdName;
	for i = .5,1,.02 do
		script.Parent.Transparency = i;
		task.wait();
	end;
end);
