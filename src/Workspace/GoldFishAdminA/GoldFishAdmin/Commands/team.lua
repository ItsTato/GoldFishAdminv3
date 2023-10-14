return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	print(utils.guessPlayer(args[1]));
	if args[2] ~= nil then
		if args[1] == "me" then
			local success = pcall(function()
				executer.Team = utils.guessTeam(args[2]);
			end);
		elseif args[1] == "others" or args[1] == "*o" then
			for _, Player in pairs(game.Players:getChildren()) do
				if Player.Name ~= executer.Name then
					local success = pcall(function()
						Player.Team = utils.guessTeam(args[2]);
					end);
				end;
			end;
		elseif args[1] == "all" or args[1] == "*a" then
			for _, Player in pairs(game.Players:getChildren()) do
				local success = pcall(function()
					Player.Team = utils.guessTeam(args[2]);
				end);
			end;
		else
			local success = pcall(function()
				game.Players[utils.guessPlayer(args[1])].Team = utils.guessTeam(args[2]);
			end);
		end;
	end;
end;