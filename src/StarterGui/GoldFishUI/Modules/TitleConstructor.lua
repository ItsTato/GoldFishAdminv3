
local sp = script.Parent;
local Modules = sp;

local UI = sp.Parent.UI;
local UserContent = UI.UserContent;

local draggable = require(Modules.DraggableObject);
local TweenService = game:GetService("TweenService");

local module = {};

function module.new(name,title,parent)
	local newTitle = {};

	newTitle.BaseTitle = Instance.new("Frame",parent);
	newTitle.WindowTitle = Instance.new("TextLabel",newTitle.BaseTitle);

	newTitle.BaseTitle.Name = name;
	newTitle.BaseTitle.BackgroundColor3 = Color3.fromRGB(40,40,40);
	newTitle.BaseTitle.BorderSizePixel = 0;
	newTitle.BaseTitle.Size = UDim2.new(.269,0,.064,0);
	newTitle._drag = draggable.new(newTitle.BaseTitle);
	newTitle._drag:Enable();

	local obj = UserContent:FindFirstChild(name);
	if obj then
		for i, child in pairs(obj:GetChildren()) do
			local nC = child:Clone();
			nC.Parent = newTitle.BaseTitle;
			newTitle[nC.Name] = nC;
		end;
	end;

	newTitle.WindowTitle.Name = "WindowTitle";
	newTitle.WindowTitle.Text = title;
	newTitle.WindowTitle.Transparency = 1;
	newTitle.WindowTitle.ZIndex = 2;
	newTitle.WindowTitle.Position = UDim2.new(.018,0,0,0);
	newTitle.WindowTitle.Size = UDim2.new(.958,0,1,0); -- Calculate dynamically to adjust for buttons.
	newTitle.WindowTitle.TextTransparency = 0;
	newTitle.WindowTitle.TextScaled = true;
	newTitle.WindowTitle.BorderSizePixel = false;
	newTitle.WindowTitle.Font = Enum.Font.SourceSans;
	newTitle.WindowTitle.TextColor3 = Color3.fromRGB(255,255,255);
	newTitle.WindowTitle.TextXAlignment = Enum.TextXAlignment.Left;

	newTitle.buttons = 0;

	function newTitle:AddButton(buttonName,iconAssetId,hoverColor,onClick)
		if newTitle:FindFirstChild(buttonName) then
			error("[ GFA ]  Button name must be unique!");
		end;
		local TextButton = Instance.new("TextButton",newTitle.BaseTitle);
		local ImageLabel = Instance.new("ImageLabel",TextButton);
		local UICorner = Instance.new("UICorner",TextButton);

		UICorner.CornerRadius = UDim.new(.15,0);

		TextButton.BackgroundColor3 = Color3.fromRGB(60,60,60);
		TextButton.BackgroundTransparency = 0;
		TextButton.ZIndex = 2;
		TextButton.Size = UDim2.new(.08,0,.625,0);
		TextButton.Name = buttonName;
		TextButton.Text = "";
		TextButton.AutoButtonColor = false;

		TextButton.Position = UDim2.new(.896-(.104*newTitle.buttons),0,.188,0); -- rightest is: .896, -remove .104 per button
		newTitle.WindowTitle.Size = UDim2.new(.958-(.104*newTitle.buttons),0,newTitle.WindowTitle.Size.Y.Scale,0);

		newTitle.buttons += 1;

		ImageLabel.BackgroundTransparency = 1;
		ImageLabel.BorderSizePixel = 0;
		ImageLabel.Size = UDim2.new(1,0,1,0);
		ImageLabel.Image = "http://www.roblox.com/asset/?id="..iconAssetId;
		ImageLabel.ImageTransparency = 0;
		ImageLabel.ScaleType = Enum.ScaleType.Fit;

		TextButton.MouseEnter:Connect(function()
			local tween1 = TweenService:Create(TextButton,TweenInfo.new(.25),{BackgroundColor3=hoverColor});
			tween1:Play();
		end);

		TextButton.MouseLeave:Connect(function()
			local tween1 = TweenService:Create(TextButton,TweenInfo.new(.25),{BackgroundColor3=Color3.fromRGB(60,60,60)});
			tween1:Play();
		end);

		TextButton.MouseButton1Click:Connect(function()
			local animFrame = Instance.new("Frame",TextButton);
			local animUICorner = Instance.new("UICorner",animFrame);
			animFrame.BackgroundColor3 = Color3.fromRGB(255,255,255);
			animUICorner.CornerRadius = UDim.new(1,0);
			animFrame.Size = UDim2.new(0,0,0,0);
			animFrame.Position = UDim2.new(.5,0,.5,0);
			animFrame.BorderSizePixel = 0;
			animFrame.Transparency = .1;
			local tween1 = TweenService:Create(animFrame,TweenInfo.new(.35),{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),Transparency=.8});
			local tween2 = TweenService:Create(animUICorner,TweenInfo.new(.35),{CornerRadius=UDim.new(TextButton.UICorner.CornerRadius.Scale,0)});
			local tween3 = TweenService:Create(animFrame,TweenInfo.new(.05),{Transparency=1});
			tween1:Play();
			tween2:Play();
			tween2.Completed:Connect(function()
				tween3:Play();
			end);
			tween3.Completed:Connect(function()
				animUICorner:Destroy();
				animFrame:Destroy();
			end);
			onClick();
		end);
	end;

	function newTitle:RemoveButton(buttonName)
		if newTitle:FindFirstChild(buttonName) then
			newTitle.buttons -= 1;
			newTitle.WindowTitle.Size = UDim2.new(.958-(.104*newTitle.buttons),0,newTitle.WindowTitle.Size.Y.Scale,0);
			newTitle[buttonName]:Destroy();
		end;
	end;

	function newTitle:SetVisible(visibility)
		newTitle.BaseTitle.Visible = visibility;
		if visibility then
			newTitle:UnlockDrag();
		else
			newTitle:LockDrag();
		end;
	end;

	function newTitle:ToggleVisibility()
		if newTitle.BaseTitle.Visible then
			newTitle:SetVisible(false);
			newTitle:LockDrag();
		else
			newTitle:SetVisible(true);
			newTitle:UnlockDrag();
		end;
	end;

	function newTitle:HideButton(buttonName)
		newTitle.BaseTitle[buttonName].Visible = false;
	end;

	function newTitle:ShowButton(buttonName)
		newTitle.BaseTitle[buttonName].Visible = true;
	end;

	function newTitle:SetParent(newParent)
		newTitle.BaseTitle.Parent = newParent;
	end;

	function newTitle:LockDrag()
		newTitle._drag:Disable();
	end;

	function newTitle:UnlockDrag()
		newTitle._drag:Enable();
	end;

	return newTitle;
end;

return module;
