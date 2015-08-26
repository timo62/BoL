local version = 0.001

	function Initiate()
		printMessage = function(message) print("<font color=\"#00A300\"><b>"..scriptName..":</b></font> <font color=\"#FFFFFF\">"..message.."</font>") end --[[Replaces the standard print/PrintChat function to make the script look nicer]]
		if os.time() > os.time{year=2014, month=6, day=30, hour=0, sec=1} then
			printMessage("A fail safe has disabled the script, contact the Author for access")
			return true --[[Stops the script after a certain date, allows the author to update the script without people complaining about bugs]]
		end
		SourceUpdater(scriptName, version, "raw.github.com", "/HiranN/BoL/Scripts/master/Scripts/Teste.lua", SCRIPT_PATH..GetCurrentEnv().FILE_NAME, "/HiranN/BoL/Scripts/master/Versions/Teste.version"):CheckUpdate()
		return false
	end