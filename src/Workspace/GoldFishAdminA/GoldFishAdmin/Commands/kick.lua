return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	local reason = "";
	if args[2] ~= nil then
		for Index, Item in pairs(args) do
			if Index ~= 1 then
				if Index ~= #args then
					reason = reason..Item.." ";
				else
					reason = reason..Item;
				end;
			end;
		end;
	elseif args[2] == nil then
		reason = "No reason was provided. :|";
	end;
	local success = pcall(function()
		game.Players[utils.guessPlayer(args[1])]:Kick("\n\n\nGOLDFISHADMIN\nYou have been KICKED from this experience server\n\nREASON\n"..reason.."\n\nKICKED BY\n"..executer.Name.."\n\n")
	end);
end;