Version  = 0.1
AutoUpdate  = true

  function Update()
    local ToUpdate = {}
    ToUpdate.UseHttps = true
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/HiranN/BoL/master/Versions/Teste.version"
    ToUpdate.ScriptPath =  "/HiranN/BoL/master/Scripts/Teste.lua"
    ToUpdate.SavePath = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) Msg("Updated from v"..OldVersion.." to "..NewVersion..". Please press F9 twice to reload.") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) end
    ToUpdate.CallbackNewVersion = function(NewVersion) Msg("New version found v"..NewVersion..". Please wait until it's downloaded.") end
    ToUpdate.CallbackError = function(NewVersion) Msg("There was an error while updating.") end
    CScriptUpdate(Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
  end
