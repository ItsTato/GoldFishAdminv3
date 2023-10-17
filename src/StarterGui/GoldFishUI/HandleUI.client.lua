
local sp = script.Parent;
local wait = task.wait;
local TweenService = game:GetService("TweenService");

local Modules = sp.Modules;
local UI = sp.UI;

local TitleConstructor = require(Modules.TitleConstructor);

local MainWindow = TitleConstructor.new("MainWindow","Gold Fish Admin",UI);
MainWindow:AddButton("closeButton",6031094678,Color3.fromRGB(255, 98, 101),function() --Color3.fromRGB(80,80,80) when not custom is optimal!
	MainWindow:SetVisible(false);
end);
MainWindow:SetVisible(true);

local InfoWindow = TitleConstructor.new("InfoWindow","About GFA",UI);
InfoWindow:AddButton("closeButton",6031094678,Color3.fromRGB(255, 98, 101),function()
	InfoWindow:SetVisible(false);
end);
InfoWindow:SetVisible(false);

local CommandsWindow = TitleConstructor.new("CommandsWindow","Commands",UI);
CommandsWindow:AddButton("closeButton",6031094678,Color3.fromRGB(255,98,101),function()
	CommandsWindow:SetVisible(false);
end);
CommandsWindow:SetVisible(false);

--[[
NewWindow:AddButton("backButton",6031091000,Color3.fromRGB(80,80,80),function()
	print("Went back to the future!");
end);
NewWindow:HideButton("backButton");
--]]

function addCategory(buttonName:string,categoryName:string,categoryDesc:string,categoryIcon,onClick)
	local newCat = MainWindow.Content1.ScrollingFrame.PlaceHolder:Clone();
	newCat.Visible = true;
	newCat.Name = buttonName;
	newCat.buttonName.Text = categoryName;
	newCat.buttonDesc.Text = categoryDesc;
	newCat.buttonIcon.Image = "http://www.roblox.com/asset/?id="..categoryIcon;
	newCat.Parent = MainWindow.Content1.ScrollingFrame;
	--newButton.Position = UDim2.new(0,0,0,0); -- .25 for each button so
	local posYScale = (rawlen(MainWindow.Content1.ScrollingFrame:GetChildren())-2)*.25;
	newCat.Position = UDim2.new(0,0,posYScale,0);
	newCat.MouseEnter:Connect(function()
		local tween1 = TweenService:Create(newCat.buttonIcon,TweenInfo.new(.25),{Size=UDim2.new(.278,0,.9,0),Position=UDim2.new(.358,0,.05,0)});
		local tween2 = TweenService:Create(newCat.buttonName,TweenInfo.new(.15),{TextTransparency=1});
		local tween3 = TweenService:Create(newCat.buttonDesc,TweenInfo.new(.15),{TextTransparency=1});
		tween1:Play();
		tween2:Play();
		tween3:Play();
		-- size: {0.278, 0},{0.95, 0} pos: {0.358, 0},{0.025, 0}
	end);
	newCat.MouseLeave:Connect(function()
		local tween1 = TweenService:Create(newCat.buttonIcon,TweenInfo.new(.25),{Size=UDim2.new(.247,0,.8,0),Position=UDim2.new(.037,0,.1,0)});
		local tween2 = TweenService:Create(newCat.buttonName,TweenInfo.new(.15),{TextTransparency=0});
		local tween3 = TweenService:Create(newCat.buttonDesc,TweenInfo.new(.15),{TextTransparency=0});
		tween1:Play();
		tween2:Play();
		tween3:Play();
		-- size: {0.247, 0},{0.8, 0} pos: {0.037, 0},{0.1, 0}
	end);
	newCat.MouseButton1Click:Connect(function()
		local animFrame = Instance.new("Frame",newCat);
		local animUICorner = Instance.new("UICorner",animFrame);
		animFrame.BackgroundColor3 = Color3.fromRGB(255,255,255);
		animUICorner.CornerRadius = UDim.new(1,0);
		animFrame.Size = UDim2.new(0,0,1,0);
		animFrame.Position = UDim2.new(.5,0,0,0);
		animFrame.BorderSizePixel = 0;
		animFrame.Transparency = .25;
		local tween1 = TweenService:Create(animFrame,TweenInfo.new(.4),{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),Transparency=.8});
		local tween2 = TweenService:Create(animUICorner,TweenInfo.new(.2),{CornerRadius=UDim.new(0.55,0)});
		local tween3 = TweenService:Create(animFrame,TweenInfo.new(.4),{Transparency=1});
		local tween4 = TweenService:Create(animUICorner,TweenInfo.new(.2),{CornerRadius=UDim.new(0,0)});
		tween1:Play();
		tween2:Play();
		tween2.Completed:Connect(function()
			tween3:Play();
			tween4:Play();
		end);
		tween3.Completed:Connect(function()
			animUICorner:Destroy();
			animFrame:Destroy();
		end);
		onClick();
	end);
end;

addCategory("AboutButton","About","What is this?",6026568227,function()
	InfoWindow:ToggleVisibility();
end);

addCategory("CommandsButton","Commands","List of commands.",6022668907,function()
	CommandsWindow:ToggleVisibility();
end);

-- Now in generator function
--MainWindow:SetParent(UI);
--InfoWindow:SetParent(UI);
