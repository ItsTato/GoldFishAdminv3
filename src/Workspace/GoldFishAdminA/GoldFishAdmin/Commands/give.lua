return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	if args[2] == nil then
		return
	end;
	if args[1] == "me" then
		local success = pcall(function()
			local newTools = utils.guessItem(args[2]):Clone();
			newTools.Parent = executer.Backpack;
		end);
	elseif args[1] == "others" or args[1] == "*o" then
		for _, Player in pairs(game:GetService("Players"):getChildren()) do
			if Player.Name ~= executer.Name then
				local success = pcall(function()
					local newTools = utils.guessItem(args[2]):Clone();
					newTools.Parent = Player.Backpack;
				end);
			end;
		end;
	elseif args[1] == "all" or args[1] == "*a" then
		for _, Player in pairs(game:GetService("Players"):getChildren()) do
			local success = pcall(function()
				local newTools = utils.guessItem(args[2]):Clone();
				newTools.Parent = Player.Backpack;
			end);
		end;
	else
		local success = pcall(function()
			local newTools = utils.guessItem(args[2]):Clone();
			newTools.Parent = game.Players[utils.guessPlayer(args[1])].Backpack;
		end);
	end;
end;