return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	if args[1] == "me" or args[1] == nil then
		game.Workspace[executer.Name]:FindFirstChildWhichIsA("Humanoid").Health = 0;
	elseif args[1] == "*" or args[1] == "*a" or args[1] == "all" then
		for _, Player in pairs(game.Players:getChildren()) do
			game.Workspace[Player.Name]:FindFirstChildWhichIsA("Humanoid").Health = 0;
		end;
	elseif args[1] == "*o" or args[1] == "others" then
		for _, Player in pairs(game.Players:getChildren()) do
			if Player.Name ~= executer.Name then
				game.Workspace[Player.Name]:FindFirstChildWhichIsA("Humanoid").Health = 0;
			end;
		end;
	else
		local success = pcall(function()
			game.Workspace[utils.guessPlayer(args[1])]:FindFirstChildWhichIsA("Humanoid").Health = 0;
		end);
	end;
end;