return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	local utilModule = ctx.UtilsModule;
	local InsertService = game:GetService("InsertService");
	local model = nil;
	local success, aaa = pcall(function()
		model = InsertService:LoadAsset(142785488);
	end);
	if success and aaa then
		model.Parent = game.Workspace;
		if args[1] == nil or args[1] == "me" or args[1] == "" then
			local newTools = model:Clone();
			newTools.Parent = executer.Backpack;
		elseif args[1] == "*" or args[1] == "*a" or args[1] == "all" then
			for _, Player in pairs(game.Players:getChildren()) do
				local newTools = model:Clone();
				newTools.Parent = Player.Backpack;
			end;
		elseif args[1] == "*o" or args[1] == "others" then
			for _, Player in pairs(game.Players:getChildren()) do
				if Player.Name ~= executer.Name then
					local newTools = model:Clone();
					newTools.Parent = Player.Backpack;
				end;
			end;
		else
			local success = pcall(function()
				local newTools = model:Clone();
				newTools.Parent = game.Players[utils.guessPlayer(args[1])].Backpack;
			end);
		end;
	else
		local window = utilModule:CreatePopUpWindow("Error!","F3X building tools could be fetched.");
		window:Send(executer);
	end;
end;