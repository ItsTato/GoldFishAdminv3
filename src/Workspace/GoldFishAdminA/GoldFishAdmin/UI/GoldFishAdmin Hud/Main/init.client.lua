local draggable = require(script.DraggableObject);

local sp = script.Parent;
local wait = task.wait;
local tweenService = game:GetService("TweenService");
local userInputService = game:GetService("UserInputService");
local data = nil;
local data2 = nil;
local cmdBarEnabled = false;
local prefix = "";
local Icon = require(game.ReplicatedStorage.Icon);
local selected = 0;

local giveStaff = game.ReplicatedStorage.GoldFishEvents.GiveStaff;

local menuButton = Icon.new();
menuButton:setImage(10372440676);
menuButton:setEnabled(true);
menuButton:setLabel("");

--[[
menuButton.hoverStarted:Connect(function()
	if menuButton.isSelected == true then
		menuButton:setLabel("Close");
	else
		menuButton:setLabel("Open");
	end;
end);
--]]

--[[
menuButton.hoverEnded:Connect(function()
	menuButton:setLabel("");
end);
--]]

menuButton.selected:Connect(function()
	menuButton:setImage(6031094678);
	sp.WindowContainer.TopBar.Visible = true;
end);

menuButton.deselected:Connect(function()
	menuButton:setImage(10372440676);
	sp.WindowContainer.TopBar.Visible = false;
end);

sp.WindowContainer.TopBar.CloseButton.MouseButton1Click:Connect(function()
	menuButton:setImage(10372440676);
	sp.WindowContainer.TopBar.Visible = false;
end);

sp.WindowContainer.TopBar.Changed:Connect(function()
	if sp.WindowContainer.TopBar.Visible == true then
		menuButton:select();
	else
		menuButton:deselect();
	end;
end)

if game.ReplicatedStorage.GoldFishEvents:FindFirstChild("SendCommand") then
	userInputService.InputBegan:Connect(function()
		if userInputService:GetFocusedTextBox() == nil then
			if userInputService:IsKeyDown(Enum.KeyCode.Semicolon) then
				task.wait();
				sp.CMDBar.Visible = true;
				sp.CMDBar.TextBox:CaptureFocus();
			end;
		end;
	end);

	sp.CMDBar.TextBox.FocusLost:Connect(function()
		if userInputService:IsKeyDown(Enum.KeyCode.Return) or userInputService:IsKeyDown(Enum.KeyCode.KeypadEnter) then
			sp.CMDBar.Visible = false;
			game.ReplicatedStorage.GoldFishEvents.SendCommand:FireServer(sp.CMDBar.TextBox.Text);
			sp.CMDBar.TextBox.Text = "";
		end;
	end);
end;

game.ReplicatedStorage.GoldFishEvents.GivePrefix.OnClientEvent:Connect(function(Prefix)
	prefix = Prefix;
end);

local function ApplyAnimationOne(element)
	local tweenEnter = tweenService:Create(element,TweenInfo.new(.25),{ Transparency = .5 });
	local tweenLeave = tweenService:Create(element,TweenInfo.new(.25),{ Transparency = 1 });
	element.MouseEnter:Connect(function()
		tweenEnter:Play();
	end);
	element.MouseLeave:Connect(function()
		tweenLeave:Play();
	end);
end;

ApplyAnimationOne(sp.WindowContainer.TopBar.Container.Main.Commands);
ApplyAnimationOne(sp.WindowContainer.TopBar.Container.Main.Staff);

sp.WindowContainer.TopBar.Container.Main.Commands.MouseButton1Click:Connect(function()
	sp.WindowContainer.TopBar.Container.Main.Commands.Visible = false;
	sp.WindowContainer.TopBar.Container.Main.Staff.Visible = false;
	game.ReplicatedStorage.GoldFishEvents.GetCommands:FireServer();

	sp.WindowContainer.TopBar.Header.Text = "Loading";

end);

game.ReplicatedStorage.GoldFishEvents.GetCommands.OnClientEvent:Connect(function(response)
	data = response;
	
	local total = 0;

	for _, _ in pairs(data) do
		total+=1;
	end;

	local Index = 0;

	sp.WindowContainer.TopBar.Header.Text = "Loading ("..total-Index..")";

	for Command, Usage in pairs(data) do
		local cmd = sp.WindowContainer.TopBar.Container.Commands.CommandTemplate:Clone();
		cmd.onHover.Value = Usage;
		cmd.Text.Text = Command;
		cmd.Animation.Disabled = false;
		cmd.Position = UDim2.new(cmd.Position.X.Scale,0,cmd.Size.Y.Scale*Index,0);
		--sp.WindowContainer.TopBar.Container.CanvasSize = UDim2.new(sp.WindowContainer.TopBar.Container.CanvasSize.X.Scale,0,(cmd.Size.Y.Scale*(Index+1))+0.01,0);
		cmd.Visible = true;
		cmd.Name = Command
		cmd.Parent = sp.WindowContainer.TopBar.Container.Commands;
		Index+=1;
		sp.WindowContainer.TopBar.Header.Text = "Loading ("..total-Index..")";
	end;

	sp.WindowContainer.TopBar.Header.Text = "Main"

	sp.WindowContainer.TopBar.BackButton.Visible = true;
	selected = 1;
end);

sp.WindowContainer.TopBar.Container.Main.Staff.MouseButton1Click:Connect(function()
	sp.WindowContainer.TopBar.Container.Main.Commands.Visible = false;
	sp.WindowContainer.TopBar.Container.Main.Staff.Visible = false;
	giveStaff:FireServer();
end);

giveStaff.OnClientEvent:Connect(function(response)
	data2 = response;
	sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text = "";
	local isOne = true;

	sp.WindowContainer.TopBar.Container.Staff.TextLabel.Size = UDim2.new(sp.WindowContainer.TopBar.Container.Staff.TextLabel.Size.X.Scale,0,1,0);
	local function newLine(modifier)
		sp.WindowContainer.TopBar.Container.Staff.TextLabel.Size = UDim2.new(sp.WindowContainer.TopBar.Container.Staff.TextLabel.Size.X.Scale,0,.081,0);
		--local size = sp.WindowContainer.TopBar.Container.CanvasSize;
		--sp.WindowContainer.TopBar.Container.CanvasSize = UDim2.new(size.X.Scale,0,size.Y.Scale+(.081*modifier),0);
		return "\n";
	end;

	local function color(text,color)
		return tostring("<font color=\""..color.."\">"..text.."</font>");
	end;

	sp.WindowContainer.TopBar.Container.Staff.TextLabel.Visible = true;

	for Index, Items in pairs(data2) do
		if Index ~= "Guest" then
			if isOne == true then
				sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text = color(Index,"#75f0df")..newLine(1);
			else
				sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text = sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text..color(Index,"#75f0df")..newLine(1);
			end;
			isOne = false;
			for Index2, StaffMember in pairs(Items) do
				local isOn = false;
				local plrName = game.Players:GetNameFromUserIdAsync(StaffMember);
				for Index3, Player in pairs(game.Players:getChildren()) do
					if StaffMember == Player.UserId then
						isOn = true;
					end;
				end;
				if isOn == true then
					sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text = sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text..color(plrName,"#75f086")..newLine(1);
				else
					sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text = sp.WindowContainer.TopBar.Container.Staff.TextLabel.Text..plrName..newLine(1);
				end;
			end;
		end;
	end;

	--sp.WindowContainer.TopBar.Container.CanvasSize = UDim2.new(sp.WindowContainer.TopBar.Container.CanvasSize.X.Scale,0,.882,0);

	selected = 2;
	sp.WindowContainer.TopBar.BackButton.Visible = true;
end);

sp.WindowContainer.TopBar.BackButton.MouseButton1Click:Connect(function()
	if selected == 1 then
		sp.WindowContainer.TopBar.Container.CanvasSize = UDim2.new(0,0,.882,0);
		
		sp.WindowContainer.TopBar.Container.Commands.CommandTemplate.Parent = script;
		for _, Command in pairs(sp.WindowContainer.TopBar.Container.Commands:getChildren()) do
			Command:Destroy();
		end;
		script.CommandTemplate.Parent = sp.WindowContainer.TopBar.Container.Commands;
		sp.WindowContainer.TopBar.Container.Main.Commands.Visible = true;
		sp.WindowContainer.TopBar.Container.Main.Staff.Visible = true;
		sp.WindowContainer.TopBar.BackButton.Visible = false;
		selected = 0;
	elseif selected == 2 then
		sp.WindowContainer.TopBar.Container.CanvasSize = UDim2.new(0,0,.882,0);
		
		sp.WindowContainer.TopBar.Container.Staff.TextLabel.Visible = false;
		sp.WindowContainer.TopBar.Container.Main.Commands.Visible = true;
		sp.WindowContainer.TopBar.Container.Main.Staff.Visible = true;
		sp.WindowContainer.TopBar.BackButton.Visible = false;
	end;
end);

local drag = draggable.new(script.Parent.WindowContainer.TopBar);

drag:Enable();






--[[
local gfTrends = Icon.new();
gfTrends:setImage(10508904060);
gfTrends:setEnabled(true);
gfTrends:setLabel("");

gfTrends.selected:Connect(function()
	gfTrends:setImage(6031094678);
end);

gfTrends.deselected:Connect(function()
	gfTrends:setImage(10508904060);
end);
--]]