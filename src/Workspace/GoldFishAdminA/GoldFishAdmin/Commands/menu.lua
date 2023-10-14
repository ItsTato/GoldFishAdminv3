return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	if executer.PlayerGui["GoldFishAdmin Hud"].WindowContainer.TopBar.Visible == true then
		executer.PlayerGui["GoldFishAdmin Hud"].WindowContainer.TopBar.Visible = false;
	elseif executer.PlayerGui["GoldFishAdmin Hud"].WindowContainer.TopBar.Visible == false then
		executer.PlayerGui["GoldFishAdmin Hud"].WindowContainer.TopBar.Visible = true;
	end;
end;