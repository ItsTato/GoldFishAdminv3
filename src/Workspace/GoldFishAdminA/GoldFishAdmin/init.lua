--[[ --     IGNORE     -- ]]                         local wait = task.wait;
--[[ --  DON'T  TOUCH  -- ]]                         local version =    2.0;

local defaultConfig = {
	["Prefix"] = ";";

	["Message Logging"] = true; -- Under Development, Doesn't Work Right Now.

	["Command Bar Enabled"] = true;

	["Chat Commands Enabled"] = true;

	["Command Definitions"] = {
		--  THIS IS ONLY HOW IT'LL SHOW IN THE HELP SECTION OF THE MENU  --
		-- FIRST ROW: COMMAND NAME / ALIASES - SECOND ROW: COMMAND USAGE --
		["BTools | F3X"]                     = "btools <player/all>";
		["Cuff | Detain"]                    = "cuff <player>";
		["UnCuff | UnDetain | Release"]      = "uncuff <player>";
		["God"]                              = "god <player/all>";
		["UnGod"]                            = "ungod <player/all>";
		["Kick"]                             = "kick <player> <reason>";
		["SBan | ServerBan"]                 = "sban <player> <reason>";
		["UnSBan | UnServerBan"]             = "unsban <player>";
		["Give"]                             = "give <player/all> <item>";
		["Insert"]                           = "insert <modelId>";
		["Kill | Murder"]                    = "kill <player/all>";
		["Team"]                             = "team <player/all> <team>";
		["AdminAbuse"]                       = "funi 😏😏";
		["CMDS | Commands | Menu"]           = "cmds";
	};

	["Command Ranks"] = {
		-- FIRST ROW: COMMAND NAME           - SECOND ROW: RANK REQUIRED --
		["CMDS"]                             = "Guest";
		["Commands"]                         = "Guest";
		["Menu"]                             = "Guest";
		["AdminAbuse"]                       = "Moderator";
		["BTools"]                           = "Moderator";
		["F3X"]                              = "Moderator";
		["SBan"]                             = "Moderator";
		["ServerBan"]                        = "Moderator";
		["UnSBan"]                           = "Moderator";
		["UnServerBan"]                      = "Moderator";
		["God"]                              = "Moderator";
		["UnGod"]                            = "Moderator";
		["Kick"]                             = "Moderator";
		["Give"]                             = "Moderator";
		["Kill"]                             = "Admin";
		["Murder"]                           = "Admin";
		["Insert"]                           = "Admin";
		["Team"]                             = "Admin";
		["Cuff"]                             = "Admin";
		["Detain"]                           = "Admin";
		["UnCuff"]                           = "Admin";
		["UnDetain"]                         = "Admin";
		["Release"]                          = "Admin";
	};

	["Ranks"] = {
		--      FIRST ROW: RANK NAME - SECOND ROW: PEOPLE WITH RANK      --
		["Owner"]                    = {2323052895};
		["Admin"]                    = {};
		["Moderator"]                = {};
		["Guest"]                    = --[[ LEAVE THIS EMPTY ]]          {};
	};

	["Rank Podium"] = {
		["Owner"]       = 3;
		["Admin"]       = 2;
		["Moderator"]   = 1;
		["Guest"]       = 0
	};
};

local goldFishAdminMainModule = {};

function goldFishAdminMainModule.new()
	local returned = {};

	returned.settings = defaultConfig;

	function returned:Destroy()
		for _, Player in pairs(game:GetService("Players"):GetChildren()) do
			if Player.PlayerGui:FindFirstChild("GoldFishAdmin Hud") then
				Player.PlayerGui["GoldFishAdmin Hud"]:Destroy();
			end;
		end;
		returned = {};
		returned.settings = {};
		function returned:SetSetting()
			return nil;
		end;
		function returned:SetSettings()
			return nil;
		end;
		function returned:SetMultipleSettings()
			return nil;
		end;
		function returned:Start()
			return nil;
		end;

		script:Destroy();
	end;

	function returned:SetSetting(key,value)
		returned.settings[key] = value;
	end;

	function returned:SetSettings(newSettingsList)
		for Setting, Value in pairs(newSettingsList) do
			if returned.settings[Setting] ~= Value then
				returned.settings[Setting] = Value;
			end;
		end;
	end;

	function returned:SetMultipleSettings(listWithModified)
		returned:SetSettings(listWithModified);
	end;

	function returned:Start()
		local start =   tick();

		-- SCRIPT STORAGE ----------------------------------------------------------
		-- DON'T TOUCH OR MODIFY THIS IF YOU DON'T KNOW WHAT YOU'RE DOING! ---------

		local UI = script.UI;

		local Storage = script.Storage;

		local Commands = script.Commands;

		local CommandGroups = script.CommandGroups;

		local Internal = Storage.Internal;
		local Icon = Internal.Icon;

		local InternalAPI = Internal.InternalAPI;
		local Utils = InternalAPI.utils;
		local Ctx = InternalAPI.ctx;

		local Items = Storage.Items;

		local Models = Storage.Models;

		-- COMMAND UTILS -----------------------------------------------------------

		local utilModule = require(Utils);
		local ctxModule = require(Ctx);

		local utils = utilModule:Utils(returned.settings);

		-- COMMANDS ----------------------------------------------------------------
		-- AS OF THIS VERSION COMMANDS CAN NOW BE REGISTERED WITH OUR REGISTER. ----
		-- WE RECOMMEND USING IT AS IT WILL MAKE COMMAND DEVELOPMENT MUCH MORE  ----
		-- SIMPLE & ORGANIZED ------------------------------------------------------

		local CommandList = { };

		local cMessageLogs = { };

		----------------------------------------------------------------------------

		if not game.StarterGui:FindFirstChild("GoldFishAdmin Hud") then
			local clone = UI["GoldFishAdmin Hud"]:Clone();
			clone.Parent = game.StarterGui;
			clone.Main.Disabled = false;
		end;

		if script.Parent:IsA("Model") then
			local oldPos = script.Parent;
			script.Parent = game.ServerScriptService;
			oldPos:Destroy();
		end;

		for Item, Value in pairs(returned.settings["Command Ranks"]) do
			returned.settings["Command Ranks"][string.lower(Item)] = Value;
		end;

		local goldFishEvents = Instance.new("Folder");
		goldFishEvents.Parent = game.ReplicatedStorage;
		goldFishEvents.Name = "GoldFishEvents";

		local getCommandsEvent = Instance.new("RemoteEvent");
		getCommandsEvent.Parent = goldFishEvents;
		getCommandsEvent.Name = "GetCommands";

		local givePrefixEvent = Instance.new("RemoteEvent");
		givePrefixEvent.Parent = goldFishEvents;
		givePrefixEvent.Name = "GivePrefix";

		local giveStaff = Instance.new("RemoteEvent");
		giveStaff.Parent = goldFishEvents;
		giveStaff.Name = "GiveStaff";

		if returned.settings["Command Bar Enabled"] == true then
			local sendCmd = Instance.new("RemoteEvent");
			sendCmd.Parent = goldFishEvents;
			sendCmd.Name = "SendCommand";
		end;

		Icon.Parent = game.ReplicatedStorage;

		giveStaff.OnServerEvent:Connect(function(plr)
			giveStaff:FireClient(plr,returned.settings["Ranks"]);
		end);

		getCommandsEvent.OnServerEvent:Connect(function(plr)
			getCommandsEvent:FireClient(plr,returned.settings["Command Definitions"]);
		end);


		local function processCommand(plr,msg)
			local args = string.split(msg, " ");
			local unCapped = string.split(string.lower(msg), " ");
			local command = string.lower(string.gsub(unCapped[1], returned.settings["Prefix"], ""));
			local cmdArgs = {};
			for Index, Arg in pairs(args) do
				if Index ~= 1 then
					table.insert(cmdArgs,Arg);
				end;
			end;
			if CommandList[command] then
				local success = pcall(function()
					local requiredNum = returned.settings["Rank Podium"][returned.settings["Command Ranks"][tostring(command)]];
					if utils.getPlayerRankNum(plr) >= requiredNum then
						local ranCommand = pcall(function()
							CommandList[tostring(command)](ctxModule.new(plr,command,cmdArgs,returned.settings["Prefix"],utils,utilModule));
						end);
						if not ranCommand then
							local window = utilModule:CreatePopUpWindow("Error!","The command failed at run-time");
							window:Send(plr);
						end;
					end;
				end);
				if not success then
					utilModule:Log("Could not find permissions for command \""..command.."\"!");
					utilModule:Log("Defaulting to \"Guest\" permissions.");
					local ranCommand = pcall(function()
						CommandList[tostring(command)](ctxModule.new(plr,command,cmdArgs,returned.settings["Prefix"],utils,utilModule));
					end);
					if not ranCommand then
						local window = utilModule:CreatePopUpWindow("Error!","The command failed at run-time");
						window:Send(plr);
					end;
				end;
			else
				local window = utilModule:CreatePopUpWindow("nOOOO!!1","no command was found!!!!! 😭😭😭");
				window:Send(plr);
			end;
		end;

		game.Players.PlayerAdded:Connect(function(plr)
			if not plr.PlayerGui:FindFirstChild("GoldFishAdmin Hud") then
				UI["GoldFishAdmin Hud"]:Clone(plr.PlayerGui).Main.Disabled = false;
			end;

			givePrefixEvent:FireClient(plr,returned.settings["Prefix"]);
			plr.Chatted:Connect(function(msg)
				if returned.settings["Message Logging"] == true then
					local msgObject = {  };
					msgObject.Usr = plr;
					msgObject.Msg = msg;
					table.insert(cMessageLogs,msgObject);
				end;
				if returned.settings["Chat Commands Enabled"] == true then
					if string.sub(msg,1,1) == returned.settings["Prefix"] then
						processCommand(game.Players[plr.Name],msg);
					end;
				end;
			end);
		end);

		task.wait();

		goldFishEvents.SendCommand.OnServerEvent:Connect(function(plr,cmd)
			if returned.settings["Command Bar Enabled"] then
				processCommand(plr,cmd);
			end;
		end);

		local adminInstance = {};

		function adminInstance:RegisterCommandsIn(path:Folder)
			local a = #path:GetChildren();
			local b = 0;
			for _, CmdToAdd in pairs(path:GetChildren()) do
				CommandList[CmdToAdd.Name:lower()] = require(CmdToAdd);
				utilModule:Log("Registered command \""..CmdToAdd.Name:lower().."\"");
				for _, AliasToAdd in pairs(CmdToAdd:GetChildren()) do
					CommandList[AliasToAdd.Name:lower()] = require(CmdToAdd);
					utilModule:Log("Registered alias \""..AliasToAdd.Name:lower().."\" for command \""..CmdToAdd.Name:lower().."\"");
					b += 1;
				end;
				CmdToAdd:Destroy();
			end;
			path:Destroy();
			local aStr = "";
			local bStr = "";
			if a > 1 then
				aStr = a.." commands"
			elseif a == 1 then
				aStr = a.." command"
			elseif a < 1 then
				aStr = "0 commands"
			end;
			if b > 1 then
				bStr = b.." aliases";
			elseif b == 1 then
				bStr = b.." alias";
			elseif b < 1 then
				bStr = "0 aliases";
			end;
			utilModule:Log("Registered "..aStr.." & "..bStr);
		end;

		function adminInstance:RegisterCommandsInRoot()
			adminInstance:RegisterCommandsIn(Commands);
		end;

		function adminInstance:RegisterCommandGroupsIn(path:Folder)
			local a = 0;
			local b = #path:GetChildren();
			local c = 0;
			for _, CmdGroupToAdd in pairs(path:GetChildren()) do
				for CmdToAdd, Value in pairs(require(CmdGroupToAdd)["commands"]) do
					CommandList[CmdToAdd:lower()] = Value;
					utilModule:Log("Registered command \""..CmdToAdd:lower().."\"");
					a += 1;
				end;
				for AliasToAdd, Value in pairs(require(CmdGroupToAdd)["aliases"]) do
					--if table.find(CommandList,Value:lower()) then
					local success = pcall(function()
						CommandList[AliasToAdd:lower()] = CommandList[Value:lower()];
					end);
					if not success then
						utilModule:Log("Could not register alias \""..AliasToAdd:lower().."\" for command \""..Value:lower().."\"");
					elseif success then
						utilModule:Log("Registered alias \""..AliasToAdd:lower().."\" for command \""..Value:lower().."\"");
						c += 1;
					end
					--else
					--end;
				end;
				CmdGroupToAdd:Destroy();
			end;
			path:Destroy();
			local aStr = "";
			local bStr = "";
			local cStr = "";
			if a > 1 then
				aStr = a.." commands";
			elseif a == 1 then
				aStr = a.." command";
			elseif a < 1 then
				aStr = "0 commands";
			end;
			if b > 1 then
				bStr = b.." command groups";
			elseif b == 1 then
				bStr = b.." command group";
			elseif b < 1 then
				bStr = "0 command groups";
			end;
			if c > 1 then
				cStr = c.." aliases";
			elseif c == 1 then
				cStr = c.." alias";
			elseif c < 1 then
				cStr = "0 aliases";
			end;
			utilModule:Log("Registed "..aStr..", "..bStr.." & "..cStr);
		end;

		function adminInstance:RegisterCommandGroupsInRoot()
			adminInstance:RegisterCommandGroupsIn(CommandGroups);
		end;

		utilModule:Log("Started in "..tick()-start.."s");

		return adminInstance;
	end;

	return returned;
end;

return goldFishAdminMainModule;
