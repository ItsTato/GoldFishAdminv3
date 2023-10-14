return function(ctx)
	local executer = ctx.Executer;
	local args = ctx.Command.Args;
	local utils = ctx.Utils;
	local InsertService = game:GetService("InsertService");
	local success, model = pcall(InsertService.LoadAsset, InsertService, args[1]);
	if success and model then
		model.Parent = game.Workspace;
	else
		local window = ctx.UtilsModule:CreatePopUpWindow("Error!","The asset couldn't be loaded.");
		window:Send(executer);
	end;
end;