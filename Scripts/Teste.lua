    local ToUpdate = {}
    ToUpdate.Version = 0.1
    DelayAction(function()
        ToUpdate.UseHttps = true
        ToUpdate.Host = "raw.githubusercontent.com"
        ToUpdate.VersionPath = "/HiranN/BoL/master/Versions/Teste.version"
        ToUpdate.ScriptPath =  "/HiranN/BoL/master/Scripts/Teste.lua"
        ToUpdate.SavePath = SCRIPT_PATH.._ENV.FILE_NAME
        ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) Print("Updated to v("..NewVersion..").  .Please reload script.") end
        ToUpdate.CallbackNoUpdate = function(OldVersion) Print("No Updates Found.") end
        ToUpdate.CallbackNewVersion = function(NewVersion) Print("New Version found ("..NewVersion.."). Please wait until its downloaded") end
        ToUpdate.CallbackError = function(NewVersion) Print("Error while Downloading. Please try again.") end
        SxScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
    end, 0.5)
    Print("Version "..ToUpdate.Version.." loaded.")

end
