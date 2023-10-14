local tweenService = game:GetService("TweenService");

local ProgressBar = {};

function ProgressBar.new(parent:Instance,uicorner:Instance,zindex:number)
	local bar = {};
	bar.newFrame = Instance.new("Frame");
	bar.newFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 127);
	bar.newFrame.Transparency = .2;
	bar.newFrame.Size = UDim2.new(0,0,1,0);
	bar.newFrame.Parent = parent;
	bar.newFrame.ZIndex = zindex;
	bar.newFrame.BorderSizePixel = 0;
	bar.newFrame.Position = UDim2.new(0,0,0,0);
	bar.internalSize = 0;
	bar.newUiCorner = uicorner:Clone();
	bar.newUiCorner.Parent = bar.newFrame;
	function bar:SetProgress(newProgress:number)
		local newXScale = newProgress/100;
		bar.internalSize = newXScale;
		local Tween = tweenService:Create(bar.newFrame,TweenInfo.new(.25),{Size = UDim2.new(newXScale,0,1,0)});
		Tween:Play();
	end;
	function bar:IncrementProgress(progress:number)
		local newXScale = bar.internalSize+(progress/100);
		bar.internalSize = newXScale;
		local Tween = tweenService:Create(bar.newFrame,TweenInfo.new(.25),{Size = UDim2.new(newXScale,0,1,0)});
		Tween:Play();
	end;
	function bar:Destroy()
		local Tween = tweenService:Create(bar.newFrame,TweenInfo.new(.25),{Transparency = 1});
		Tween:Play();
		Tween.Completed:Connect(function()
			bar.newFrame:Destroy();
		end);
	end;
	return bar;
end;

return ProgressBar;
