local serverBanned = { };

game.Players.PlayerAdded:Connect(function(plr)
	if table.find(serverBanned,plr.UserId) then
		plr:Kick("GOLDFISHADMIN: You have been BANNED from this experience server! REASON: \""..serverBanned[plr.UserId]["Reason"].."\" BANNED BY: "..serverBanned[plr.UserId]["Banned By"]);
	end;
end);

return {

	commands = {

		sban = function(ctx)
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
				game.Players[utils.guessPlayer(args[1])]:Kick("GOLDFISHADMIN: You have been BANNED from this experience server! REASON: \""..reason.."\" BANNED BY: "..executer.Name);
				serverBanned[game.Players[utils.guessPlayer(args[1])].UserId] = {
					["Reason"] = reason,
					["Banned By"] = executer.Name
				};
			end);
		end;
		
		unsban = function(ctx)
			local executer = ctx.Executer;
			local args = ctx.Command.Args;
			local utils = ctx.Utils;
			if args[1] ~= nil then
				local success = pcall(function()
					table.remove(serverBanned,game.Players[utils.guessPlayer(args[1])]);
				end);
			end;
		end;
		
	};
	
	aliases = {
		
		serverban = "sban";
		
		unserverban = "unsban";
		
	};
};