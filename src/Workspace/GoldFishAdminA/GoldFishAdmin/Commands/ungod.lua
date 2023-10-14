return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	if args[1] == nil or args[1] == "me" then
		game.Workspace[executer.Name]:FindFirstChilWhichIsA("Humanoid").MaxHealth = 1000;
		game.Workspace[executer.Name]:FindFirstChilWhichIsA("Humanoid").Health = 1000;
	elseif args[1] == "others" or args[1] == "*o" then
		for _, Player in pairs(game.Players:getChildren()) do
			if Player.Name ~= executer.Name then
				game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").MaxHealth = 1000;
				game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").Health = 1000;
			end;
		end;
	elseif args[1] == "all" or args[1] == "*a" then
		for _, Player in pairs(game.Players:getChildren()) do
			game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").MaxHealth = 1000;
			game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").Health = 1000;
		end;
	else
		local success = pcall(function()
			game.Workspace[utils.guessPlayer(args[1])]:FindFirstChilWhichIsA("Humanoid").MaxHealth = 1000;
			game.Workspace[utils.guessPlayer(args[1])]:FindFirstChilWhichIsA("Humanoid").Health = 1000;
		end);
	end;
end;