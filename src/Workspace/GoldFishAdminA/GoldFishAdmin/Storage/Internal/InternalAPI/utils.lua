local module = { };

function module:Utils(config)
	local utils = { };

	function utils.guessPlayer(text)
		for _, Player in pairs(game.Players:getChildren()) do
			if string.match(string.lower(Player.Name),string.lower(text)) then
				if string.sub(string.lower(text),0,string.len(text)) == string.sub(string.lower(Player.Name),0,string.len(text)) then
					return Player.Name;
				end;
			end;
		end;
	end;
	
	--[[
	function utils.guessPlayers(text)
		local toGuess = string.split(text,",");
		for Index, Item in pairs(toGuess) do

		end;
	end;
	--]]

	function utils.guessTeam(text)
		for _, Team in pairs(game:GetService("Teams"):getChildren()) do
			if string.match(string.lower(Team.Name),string.lower(text)) then
				if string.sub(string.lower(text),0,string.len(text)) == string.sub(string.lower(Team.Name),0,string.len(text)) then
					return Team;
				end;
			end;
		end;
	end;

	function utils.guessItem(text)
		for _, Item in pairs(script.Storage:getChildren()) do
			if string.match(string.lower(Item.Name),string.lower(text)) then
				if string.sub(string.lower(text),0,string.len(text)) == string.sub(string.lower(Item.Name),0,string.len(text)) then
					return Item;
				end;
			end;
		end;
	end;

	function utils.guessInDir(dir,itemName:StringValue,returnItemOrName)
		for _, Item in pairs(dir:getChildren()) do
			if string.match(string.lower(Item.Name),string.lower(itemName)) then
				if string.sub(string.lower(itemName),0,string.len(itemName)) == string.sub(string.lower(Item.Name),0,string.len(itemName)) then
					if string.lower(returnItemOrName) == "item" then
						return Item;
					elseif string.lower(returnItemOrName) == "name" then
						return Item.Name;
					end;
				end;
			end;
		end;
	end;

	function utils.getPlayerRank(playerObj)
		local plrRankName = "";
		for Rank, Users in pairs(config["Ranks"]) do
			if table.find(Users,playerObj.UserId) then
				plrRankName = Rank;
			end;
		end;
		if plrRankName == "" or plrRankName == nil then
			plrRankName = "Guest";
		end;
		return plrRankName;
	end;

	function utils.getPlayerRankNum(playerObj)
		return config["Rank Podium"][utils.getPlayerRank(playerObj)];
	end;
	
	return utils;
end;

function module:CreatePopUpWindow(title:string,cnt:string)
	local window = game:GetService("StarterGui"):WaitForChild("GoldFishAdmin Hud").PopUpWindowContainer:Clone();
	window.Name = title
	window.TopBar.Title.Text = title;
	window.TopBar.TextLabel.Text = cnt;
	
	local WindowManager = {  };
	
	WindowManager.Ui = window;
	
	function WindowManager:Send(plr:Player)
		local window2 = window:Clone();
		window2.Handler.Disabled = false;
		window2.TopBar.Visible = true;
		window2.Parent = plr.PlayerGui["GoldFishAdmin Hud"];
	end;
	
	function WindowManager:Delete()
		window:Destroy();
	end;
	
	return WindowManager;
end;

function module:Log(msg)
	warn(" | GoldFishAdmin |  "..msg);
end;

return module;