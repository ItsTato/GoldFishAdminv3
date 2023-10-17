local command = {};

command.Name = "Menu";
-- How this command is called.
-- NOT the call name (aka what you would have to run for it to run).

command.CallName = "menu";
-- What a user needs to run to call this command.
-- To specify multiple calling names --or aliases--, just seperate each name with a "|".
-- Example: "mute|silence" would mean this command can be called by running "mute" or "silence".

command.Arguments = false;
-- Arguments can be a string, for example, in a ban command you would see "<player:username> <string:long>"
-- > Where <player:username> asks for a player's username
-- > Where <string:long> means anything entered after the <string:long> will be passed as a string. (Reason)
-- or they can be false. False means that this command has no specified arguments
-- and will show as such in the UI.

command.MinPerm = -1;
-- Alternatively, a command.canRun(context) function can be made!
-- > Context will ONLY contain the player object, "rankNumber", and, "rankName".
-- Important to note that you can only use EITHER MinPerm or canRun()
-- Using both will result in one of them being ignored!

-- <i> A way to replace the default Admin permission system is planned for the future.

function command.runServer(context)
    -- command.runServer() is what will run on the server side when this command is ran.
    -- If you don't know what server side means, please search for explanations and documentation
    -- before continuing, if you do, then procceed!

end;

function command.runClient(executor,context)
    -- command.runClient() is what will run on the player side of things.
    -- The first argument to this command will be the player object of who ran it.
    -- Context will still be supplied as second argument, however.

end;

return command;
