if not Tebex then
	Tebex = {}
	Tebex.commands = {}

	Tebex.nextCheck = 15 * 60
	Tebex.lastCalled = os.time() - 14 * 60

	Tebex.warn = function ( msg )
		print (msg)
	end

	Tebex.err = function ( msg )
		print (msg)
	end

	Tebex.ok = function ( msg )
		print (msg)
	end

	if not Tebex.consoleCommand then Tebex.consoleCommand = game.ConsoleCommand end

	file.CreateDir( "tebex" )

	Msg( "\n///////////////////////////////\n" )
	Msg( "//      TebexGmod v 0.1      //\n" )
	Msg( "//   https://www.tebex.io/   //\n" )
	Msg( "///////////////////////////////\n" )
	Msg( "// Loading...                //\n" )

	include( "tebex/client/apiclient.lua" )
	include( "tebex/models/config.lua" )

	include( "tebex/commands/secret.lua" )
	include( "tebex/commands/info.lua" )

	include( "tebex/models/information.lua" )
	Msg( "///////////////////////////////\n\n" )

	config = TebexConfig:init()

	if (config:get("secret") == "") then
		Tebex.err( "You have not yet defined your secret key. Use tebex:secret <secret> to define your key" )
	else
		Tebex.commands["info"](nil, {":", "info"})
	end

	function doCheck()
		if ((os.time() - Tebex.lastCalled) > Tebex.nextCheck) then
			Tebex.lastCalled = os.time()
			print ( "do check" );
		else
			print ( "zzz...." )
		end
	end

	timer.Create( "checker", 30, 0, doCheck )


	concommand.Add("tebex", function(ply, cmd, args)

		if (args[2] == nil) then
			--Help!
			return
		end

		if (Tebex.commands[args[2]] == nil) then
			Msg( "Unknown command \"tebex:" .. args[2] .. "\"" )
			return
		end

		Tebex.commands[args[2]](ply,args);

	end)
--game.ConsoleCommand( string stringCommand )

--[[
	local function clReady( ply )
		ply.ulib_ready = true
		hook.Call( ULib.HOOK_LOCALPLAYERREADY, _, ply )
	end
	concommand.Add( "ulib_cl_ready", clReady ) -- Called when the c-side player object is ready
--]]
end
