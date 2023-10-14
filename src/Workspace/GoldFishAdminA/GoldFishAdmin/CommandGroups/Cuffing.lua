local detainedPlrs = { };

return {

	commands = {

		detain = function(ctx)
			local executer = ctx.Executer;
			local args = ctx.Command.Args;
			local utils = ctx.Utils;
			local utilModule = ctx.UtilsModule;
			local plr = utils.guessPlayer(args[1]);
			if plr == executer.Name then
				local window = utilModule:CreatePopUpWindow("Error!","This command can't be ran on yourself.");
				window:Send(executer);
			else
				detainedPlrs[plr] = true;
				spawn(function()
					repeat
						game.Workspace[plr]:FindFirstChildOfClass("Humanoid"):UnequipTools();
						if game.Workspace[plr]:FindFirstChild("UpperTorso") then
							game.Workspace[plr].UpperTorso.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5);
						else
							game.Workspace[plr].Torso.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5);
						end;
						game:GetService("RunService").Heartbeat:Wait();
					until not detainedPlrs[plr];
				end);
			end;
		end;

		release = function(ctx)
			local utils = ctx.Utils;
			local plr = utils.guessPlayer(args[1]);
			detainedPlrs[plr] = false;
		end;
		
	};
	
	aliases = {
		
		cuff = "detain";
		
		undetain = "release";
		uncuff = "release";
		
	};
};