type CommandType = { Name : string, Args : any, Prefix : string };

local ctx = {};

function ctx.new(plr,command,args,prefix,utils,utilsModule)
	local newCtxObj = {};
	
	newCtxObj.Executer = plr;
	newCtxObj.Utils = utils;
	newCtxObj.UtilsModule = utilsModule;
	local newCmdObj : CommandType = { Name = command, Args = args, Prefix = prefix };
	newCtxObj.Command = newCmdObj;
	
	return newCtxObj;
end;

return ctx;