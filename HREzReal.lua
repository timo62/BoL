if myHero.charName ~= "Ezreal" then return end
local ts

class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '3' or '4')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '3' or '4')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        local recv,sent,time = self.Socket:getstats()
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</size>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</s'..'ize>')-1)) + self.File:len()
        end
        self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*self.File:len(),2)..'%)'
    end
    if not (self.Receive or (#self.Snipped > 0)) and self.RecvStarted and self.Size and math.round(100/self.Size*self.File:len(),2) > 95 then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = tonumber(self.File:sub(ContentStart + 1,ContentEnd-1))
            if self.OnlineVersion > self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback(function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        local recv,sent,time = self.Socket:getstats()
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1)) + self.File:len()
        end
        self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*self.File:len(),2)..'%)'
    end
    if not (self.Receive or (#self.Snipped > 0)) and self.RecvStarted and math.round(100/self.Size*self.File:len(),2) > 95 then
        self.DownloadStatus = 'Downloading Script (100%)'
        local HeaderEnd, ContentStart = self.File:find('<sc'..'ript>')
        local ContentEnd, _ = self.File:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local f = io.open(self.SavePath,"w+b")
            f:write(self.File:sub(ContentStart + 1,ContentEnd-1))
            f:close()
            if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
            end
        end
        self.GotScriptUpdate = true
    end
end

function OnLoad()
	MyBasicRange = myHero.range + (GetDistance(myHero.minBBox) - 3)
	Menu = scriptConfig("HR EzReal", "menu")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseR", "R To Kill", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Anti-GapCloser", "antigap")
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LaneClear", "LaneClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("mManager", "Harass Mana",  SCRIPT_PARAM_SLICE, 50, 0, 100, 0) 
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("mManager", "LaneClear Mana",  SCRIPT_PARAM_SLICE, 50, 0, 100, 0) 
	
	Menu:addSubMenu("Drawing", "draw")
	--Menu.draw:addParam("PermaShow", "Perma Show", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Auto", "misc")
	
 	if _G.Reborn_Initialised then
	elseif _G.Reborn_Loaded then
	PrintChat("<font color=\"#00ff00\"><b>HR EzReal Loaded.</b></font>")	
	PrintChat("<font color=\"#ff0000\"><b>Loading Sac.</b></font>")	
	SACLoaded = true
	else
	IgniteCheck()
	HealCheck()
	BarrierCheck()
  orbwalkCheck()
	CheckVPred()
	Skills()
	Checks()
	CheckUpdate()
  end
	
  ts = TargetSelector(TARGET_LESS_CAST, MyBasicRange, DAMAGE_PHYSICAL)
	ts.name = "Ezreal"
	Menu:addTS(ts)
end

function CheckUpdate()
	local ToUpdate = {}
    ToUpdate.Version = 1.0
    ToUpdate.UseHttps = true
	ToUpdate.Name = "HR EzReal"
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/HiranN/BoL/master/HREzReal.version"
    ToUpdate.ScriptPath =  "/HiranN/BoL/master/HREzReal.lua"
    ToUpdate.SavePath = SCRIPT_PATH.."/" .. GetCurrentEnv().FILE_NAME
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
    ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
    ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	
end

function CheckVPred()
	if FileExist(LIB_PATH .. "/VPrediction.lua") then
		require("VPrediction")
		VP = VPrediction()
	else
		local ToUpdate = {}
		ToUpdate.Version = 0.0
		ToUpdate.UseHttps = true
		ToUpdate.Name = "VPrediction"
		ToUpdate.Host = "raw.githubusercontent.com"
		ToUpdate.VersionPath = "/SidaBoL/Scripts/master/Common/VPrediction.version"
		ToUpdate.ScriptPath =  "/SidaBoL/Scripts/master/Common/VPrediction.lua"
		ToUpdate.SavePath = LIB_PATH.."/VPrediction.lua"
		ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
		ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
		ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
		ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
		ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
end

 function AutoIgnite()
 if Ignite and ts.target ~= nil then
 if Menu.killsteal.UseIgnite and ts.target.health <= 40 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY then
  CastSpell(Ignite, ts.target)
  end
  end
end

 function AutoHeal()
		if ValidTarget(GetCustomTarget(), 750) then
			if Menu.misc.AutoHeal and myHero:CanUseSpell(Heal) == READY then
				if myHero.level > 5 and myHero.health/myHero.maxHealth < Menu.misc.HealCc/100 then
					CastSpell(Heal)
				elseif  myHero.level < 6 and myHero.health/myHero.maxHealth < (Menu.misc.HealCc/100)*.75 then
					CastSpell(Heal)
				end
			end
		end
end

 function AutoBarrier()
		if ValidTarget(GetCustomTarget(), 750) then
			if Menu.misc.AutoBarrier and myHero:CanUseSpell(Heal) == READY then
				if myHero.level > 5 and myHero.health/myHero.maxHealth < Menu.misc.BarrierCc/100 then
					CastSpell(Barrier)
				elseif  myHero.level < 6 and myHero.health/myHero.maxHealth < (Menu.misc.BarrierCc/100)*.75 then
					CastSpell(Barrier)
				end
			end
		end
end

 function HealCheck()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then Heal = SUMMONER_1
  Menu.misc:addParam("AutoHeal", "Auto Heal", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("HealCc", "Heal",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0) 
elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then Heal = SUMMONER_2
  Menu.misc:addParam("AutoHeal", "Auto Heal", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("HealCc", "Heal",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0) 
 end
end

 function BarrierCheck()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerbarrier") then Barrier = SUMMONER_1
  Menu.misc:addParam("AutoBarrier", "Auto Barrier", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("BarrierCc", "Barrier",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbarrier") then Barrier = SUMMONER_2
  Menu.misc:addParam("AutoBarrier", "Auto Barrier", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("BarrierCc", "Barrier",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
 end
end

function IgniteCheck()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1
  Menu.killsteal:addParam("UseIgnite", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2
  Menu.killsteal:addParam("UseIgnite", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
 end
end

function orbwalkCheck()
	PrintChat("<font color=\"#00ff00\"><b>HR EzReal Loaded.</b></font>")	
	PrintChat("<font color=\"#ff0000\"><b>Loading SxOrbWalk.</b></font>")	
	require("SxOrbWalk")
	Menu:addSubMenu("SxOrbWalk", "SXMenu")
	SxOrb:LoadToMenu(Menu.SXMenu)
	SACLoaded = false
end

function OnTick()	
	if myHero.dead then return end
	ts:update()
	Target = GetCustomTarget()

	if Menu.keys.ComboKey then 
	Combo(Target)
	end
	
	if Menu.keys.Harass then
	Harass(Target)
	end
	
	if Menu.killsteal.KSOn then
	KillSteal()
	AutoIgnite()
	end 
	
	if Menu.misc.AutoHeal then
	AutoHeal()
	end 
	
	if Menu.misc.AutoBarrier then
	AutoBarrier()
	end
	
	if Menu.keys.LaneClear then
	LaneClear()
	end
end
 
function GetCustomTarget()
	if SelectedTarget ~= nil and ValidTarget(SelectedTarget, 1500) then
		return SelectedTarget
	end
	ts:update()	
	if ts.target and not ts.target.dead and ts.target.type == myHero.type then
		return ts.target
	else
		return nil
	end
end

function Combo(unit)
	if ValidTarget(unit) and unit ~= nil and unit.type == myHero.type then
	
		if Menu.combo.UseQ then 
			CastQ(unit)
		end	
		if Menu.combo.UseW then 
			CastW(unit)
		end	

		if Menu.combo.UseR then
				local dmgR = getDmg("R", unit, myHero) + ((myHero.damage)*0.44) + ((myHero.ap)*0.9)
				if unit.health < dmgR then
					CastR(unit)
				end
		end
	end
end

function Harass(unit)
	if ValidTarget(unit) and unit ~= nil and unit.type == myHero.type and not IsMyManaLowHarass() then
	
		if Menu.harass.UseQ then 
			CastQ(unit)
		end	

		if Menu.harass.UseW then
			CastW(unit)
		end
	end
end

function LaneClear()
	enemyMinions:update()
	if not IsMyManaLowLaneClear() then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseQ and GetDistance(minion) <= SkillQ.range and SkillQ.ready then
					CastSpell(_Q, minion.x, minion.z)
				end
			end		 
		end
	end
end

function IsMyManaLowLaneClear()
    if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then
        return true
    else
        return false
    end
end

function IsMyManaLowHarass()
    if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then
        return true
    else
        return false
    end
end

function KillSteal()
	for _, unit in pairs(GetEnemyHeroes()) do
		local health = unit.health
		local dmgW = getDmg("W", unit, myHero) + ((myHero.ap)*0.8)
		local dmgQ = getDmg("Q", unit, myHero) + ((myHero.damage)*1.1) + ((myHero.ap)*0.4)
			if health < dmgW and Menu.killsteal.UseW and SkillW.ready and ValidTarget(unit) then
				CastW(unit)
			end
			if health < dmgQ and Menu.killsteal.UseQ and SkillQ.ready and ValidTarget(unit) then
				CastQ(unit)
			end
	 end
end

function CastQ(unit)
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and SkillQ.ready then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, true)
				
		if HitChance >= 2 then
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
end

function CastW(unit)
	if unit ~= nil and GetDistance(unit) <= SkillW.range and SkillW.ready then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillW.delay, SkillW.width, SkillW.range, SkillW.speed, myHero, false)
				
		if HitChance >= 2 then
			CastSpell(_W, CastPosition.x, CastPosition.z)
		end
	end
end

function CastR(unit)
	if unit ~= nil and SkillR.ready then
		CastPosition,  HitChance,  Position = VP:GetLineAOECastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero)
				
		if HitChance >= 2 then
			CastSpell(_R, CastPosition.x, CastPosition.z)
		end
	end
end

function Skills()
	SkillQ = { name = "Mystic Shot", range = 1150, delay = 0.25, speed = 2000, width = 60, ready = false }
	SkillW = { name = "Essence Flux", range = 950, delay = 0.25, speed = 1600, width = 80, ready = false }
	SkillE = { name = "Arcane Shift", range = 475, delay = nil, speed = nil, width = nil, ready = false }
	SkillR = { name = "Trueshot Barrage", range = math.huge, delay = 1.0, speed = 2000, width = 160, ready = false }

	enemyMinions = minionManager(MINION_ENEMY, SkillQ.range, myHero, MINION_SORT_HEALTH_ASC)
end
	
function Checks()
	VP = VPrediction()
	SkillQ.ready = (myHero:CanUseSpell(_Q) == READY)
	SkillW.ready = (myHero:CanUseSpell(_W) == READY)
	SkillR.ready = (myHero:CanUseSpell(_R) == READY)
end
