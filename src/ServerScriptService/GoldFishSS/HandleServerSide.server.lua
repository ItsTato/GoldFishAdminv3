--[[ --     IGNORE     -- ]]                         local wait = task.wait;
--[[ --  DON'T  TOUCH  -- ]]                         local version =    3.0;

local Config = {
	["Chat Prefix"] = ";";
	["Message Logging"] = true;
	["Command Bar"] = true;
	["Chat Commands"] = true;
};

local Ranks = {
	[255] = {"Owner", 2323052895}; -- [255] Rank Value = {"Owner" Rank Name, 1 User ID, 2 User ID, ...}
	[245] = {"Admin", };
	[235] = {"Moderator", };
	[-1] = "Guest"; -- Do NOT modify unless you completely know what you're doing!
};

local sp = script.Parent;
local Modules = sp.Modules;
local Commands = sp.Commands;
local CommandGroups = sp.CommandGroups;

Modules.Icon.Parent = game.ReplicatedStorage;

local commandList = { };
local chatMessageLogs = { };

if script.Parent:IsA("Model") then
	local oldPos = sp;
	script.Parent = game.ServerScriptService;
	oldPos:Destroy();
end;

local GoldFishEvents = Instance.new("Folder",game.ReplicatedStorage);
GoldFishEvents.Name = "GoldFishEvents";

local GetCommandsEvent = Instance.new("RemoteEvent",GoldFishEvents);
GetCommandsEvent.Name = "GetCommands";
local GetPrefixEvent = Instance.new("RemoteEvent",GoldFishEvents);
GetPrefixEvent.Name = "GetPrefix";
local GetStaffEvent = Instance.new("RemoteEvent",GoldFishEvents);
GetStaffEvent.Name = "GetStaff";
if Config["Command Bar"] == true then
	local ExecuteCommandEvent = Instance.new("RemoteEvent",GoldFishEvents);
	ExecuteCommandEvent.Name = "ExecuteCommand";
end;

GetStaffEvent.OnServerEvent:Connect(function(plr)
	GetStaffEvent:FireClient(plr,Ranks);
end);
GetCommandsEvent.OnServerEvent:Connect(function(plr)
	GetCommandsEvent:FireClient(plr,commandList);
end);

function processCommand(plr,msg)
	local commandArguments = string.split(msg, " ");
	local commandArgumentsLowered = string.split(string.lower(msg), " ");
	local commandName = string.lower(string.gsub(commandArgumentsLowered[1], Config["Chat Prefix"], ""));
	table.remove(commandArguments,1);
	if commandList[commandName] then
		local success = pcall(function()
			
		end)
	end
end;
