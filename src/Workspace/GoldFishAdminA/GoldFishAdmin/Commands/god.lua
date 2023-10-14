return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	local num = 999999999;
	if args[1] == nil or args[1] == "me" then
		game.Workspace[executer.Name]:FindFirstChilWhichIsA("Humanoid").MaxHealth = num;
		game.Workspace[executer.Name]:FindFirstChilWhichIsA("Humanoid").Health = num;
	elseif args[1] == "others" or args[1] == "*o" then
		for _, Player in pairs(game.Players:getChildren()) do
			if Player.Name ~= executer.Name then
				game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").MaxHealth = num;
				game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").Health = num;
			end;
		end;
	elseif args[1] == "all" or args[1] == "*a" then
		for _, Player in pairs(game.Players:getChildren()) do
			game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").MaxHealth = num;
			game.Workspace[Player.Name]:FindFirstChilWhichIsA("Humanoid").Health = num;
		end;
	else
		local success = pcall(function()
			game.Workspace[utils.guessPlayer(args[1])]:FindFirstChilWhichIsA("Humanoid").MaxHealth = num;
			game.Workspace[utils.guessPlayer(args[1])]:FindFirstChilWhichIsA("Humanoid").Health = num;
		end);
	end;
end;