local version = 0.004
local AUTOUPDATE = true

	function Initiate()
	if AUTOUPDATE then
			local scriptName = "Teste"
		printMessage = function(message) print("<font color=\"#00A300\"><b>"..scriptName..":</b></font> <font color=\"#FFFFFF\">"..message.."</font>") end 
		
		--[[
		if os.time() > os.time{year=2014, month=6, day=30, hour=0, sec=1} then
			printMessage("Script disabled by : HiranN, contact him for access")
			return true
		end
		--]]
		
		SourceUpdater(scriptName, version, "raw.github.com", "/HiranN/BoL/master/Scripts/Teste.lua", SCRIPT_PATH..GetCurrentEnv().FILE_NAME, "/HiranN/BoL/master/Versions/Teste.version"):CheckUpdate()
		return false
	end
end

	if Initiate() then return end
