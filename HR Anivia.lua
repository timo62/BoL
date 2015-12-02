if myHero.charName ~= "Anivia" then return end

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("OBEEJABDGJJ") 
-- Script Status --

local ts
local Qm = nil
local Rm = nil
local LocalVersion = "1.2"
local autoupdate = true --Change to false if you don't wan't autoupdates

	function OnLoad()
	
  if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	Menu = scriptConfig("HR Anivia", "menu")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("RCheck", "Disable R if no enemies on R", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
	if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LaneClear", "LaneClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("mManager", "Harass Mana",  SCRIPT_PARAM_SLICE, 50, 0, 100, 0) 
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("mManager", "LaneClear Mana",  SCRIPT_PARAM_SLICE, 50, 0, 100, 0) 
	
	--Menu:addSubMenu("Auto", "misc")
	
	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qDraw", "(Q) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("wDraw", "(W) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("eDraw", "(E) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("rDraw", "(R) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	
	CustomLoad()
	
	end
	
	function CustomLoad()
	CheckVPred()
	Skills()		
	FindUpdates()
	
	if _G.Reborn_Initialised then
	elseif _G.Reborn_Loaded then
	PrintChat("<font color=\"#ccae00\"><b>HR Anivia : </b></font>".."<font color=\"#00ae26\"><b>Loaded.</b></font>")	
	PrintChat("<font color=\"#ccae00\"><b>HR Anivia : </b></font>".."<font color=\"#00ae26\"><b>Loading Sac.</b></font>")	
	SAC = true
	SX = false
	else
    LoadOrb()
	
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	ts = TargetSelector(TARGET_LESS_CAST, 1000, DAMAGE_PHYSICAL)
	ts.name = "Anivia"
	Menu:addTS(ts)
	
  end
  end
	
	function LoadOrb()
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	PrintChat("<font color=\"#ccae00\"><b>HR Anivia : </b></font>".."<font color=\"#00ae26\"><b>Loaded.</b></font>")
	PrintChat("<font color=\"#ccae00\"><b>HR Anivia : </b></font>".."<font color=\"#00ae26\"><b>Loading SxOrbWalk.</b></font>")	
	require("SxOrbWalk")
	Menu:addSubMenu("SxOrbWalk", "SXMenu")
	SxOrb:LoadToMenu(Menu.SXMenu)
	SAC = false
	SX = true
	else
	local ToUpdate = {}
    ToUpdate.Version = 1
    ToUpdate.UseHttps = true
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/Superx321/BoL/master/common/SxOrbWalk.Version"
    ToUpdate.ScriptPath =  "/Superx321/BoL/master/common/SxOrbWalk.lua"
    ToUpdate.SavePath = LIB_PATH.."/SxOrbWalk.lua"
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". </b></font>") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
    ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
    ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
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
	
	function UseSpells()
	for _, unit in pairs(GetEnemyHeroes()) do
		local health = unit.health
		local dmgQ = getDmg("Q", unit, myHero)
		local dmgE = getDmg("E", unit, myHero)
		local dmgR = getDmg("R", unit, myHero)
		if GetDistance(unit) <= 1000 then
		if not Menu.killsteal.KSOn then return end
			if health <= dmgQ and Menu.killsteal.UseQ and myHero:CanUseSpell(_Q) == READY and ValidTarget(unit) then
				CastQ(unit)
			end
			if health <= dmgE and Menu.killsteal.UseE and myHero:CanUseSpell(_E) == READY and ValidTarget(unit) then
				CastSpell(_E, unit)
			end
			if health <= dmgR and Menu.killsteal.UseR and myHero:CanUseSpell(_R) == READY and ValidTarget(unit) then
				CastR(unit)
			end
			if health <= 40 + (20 * myHero.level) and Menu.killsteal.I and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) then
				CastSpell(Ignite, unit)
			end
	end
	end
	end
	
	function OnTick()
	if myHero.dead then return end
	ts:update()
	Target = GetCustomTarget()

	ComboKey = Menu.keys.ComboKey
	HarassKey = Menu.keys.Harass
	LaneClearKey = Menu.keys.LaneClear
	
	if ComboKey then 
	Combo(Target)
	end
	
	if HarassKey and not ComboKey then
	Harass(Target)
	end	
	
	if LaneClearKey and not ComboKey then
	LaneClear()
	end
	
	UseSpells()
	
	if Qm ~= nil then
	DetectQ()
	end
	
	if Menu.combo.RCheck then
	if Rm ~= nil then
	if not ValidR() then CastSpell(_R) end
	end
	end
	
	end
	
function GetCustomTarget()
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
		if Menu.combo.UseE then 
			CastSpell(_E, unit)
		end	
		if Menu.combo.UseR then 
			CastR(unit)
		end	
	end
end

function Harass(unit)
	if(myHero:CanUseSpell(_Q) == READY and (myHero.mana / myHero.maxMana > Menu.harass.mManager /100 ) and ts.target~=nil and Menu.harass.UseQ ) then 
  CastQ(unit)
	end
	if(myHero:CanUseSpell(_E) == READY and (myHero.mana / myHero.maxMana > Menu.harass.mManager /100 ) and ts.target~=nil and Menu.harass.UseW ) then 
  CastSpell(_E, unit)
	end
end

function LaneClear()
	enemyMinions:update()
    if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseE and GetDistance(minion) <= 600 and myHero:CanUseSpell(_E) == READY then
				CastSpell(_E, minion)
				end
			end		 
		end
	end
end

function CastQ(unit)
	if Qm ~=nil then
	return
	end
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, false)
				
		if HitChance >= 2 then
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
end

function CastW(unit)
	if unit ~= nil and GetDistance(unit) <= SkillW.range and myHero:CanUseSpell(_W) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillW.delay, SkillW.width, SkillW.range, SkillW.speed, myHero, false)
				
		if HitChance >= 2 then
			CastSpell(_W, CastPosition.x, CastPosition.z)
		end
	end
end

function CastR(unit)
	if unit ~= nil and GetDistance(unit) <= SkillR.range and myHero:CanUseSpell(_R) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero, false)
				
		if HitChance >= 2 then
			CastSpell(_R, CastPosition.x, CastPosition.z)
		end
	end
end

function DetectQ()
	for i=1, heroManager.iCount, 1 do
	local hero = heroManager:GetHero(i)
	if hero.team ~= myHero.team then
	if GetDistance(hero, Qm) < 150 then
	CastSpell(_Q)
end
end
end
end

function ValidR()
	local ccount = 0
	for i = 1, heroManager.iCount, 1 do
	local hero = heroManager:GetHero(i)
	if hero.team ~= myHero.team and ValidTarget(hero) then
	if GetDistance(hero, Rm) < 500 then
	ccount = ccount + 1
end
end
end
	if ccount > 0 then return true else return false end	
end

function OnProcessSpell(object, spell)
local Q = myHero:GetSpellData(_Q)
	if spell.name == Q.name then
	Start = spell.startPos
	End = spell.endPos
	Qm = Start - End
	PrintChat("Start : "..Start)
	PrintChat("End : "..End)
	PrintChat("Qm : "..Qm)
	end
end
 
function OnCreateObj(object)
	if object.name == "cryo_storm_green_team.troy" then
		Rm = object
	end
end

function OnDeleteObj(object)
	if object.name == "cryo_FlashFrost_mis.troy" then
		Qm = nil
	end
	if object.name == "cryo_storm_green_team.troy" then
		Rm = nil
	end
end

function OnDraw()
	if not myHero.dead and not Menu.drawing.mDraw then
		if myHero:CanUseSpell(_Q) == READY and Menu.drawing.qDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillQ.range, RGB(9, 40, 164))
		end
		if myHero:CanUseSpell(_W) == READY and Menu.drawing.wDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillW.range, RGB(9, 164, 148))
		end
		if myHero:CanUseSpell(_E) == READY and Menu.drawing.eDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillE.range, RGB(186, 72, 8))
		end
		if myHero:CanUseSpell(_R) == READY and Menu.drawing.rDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillR.range, RGB(124, 196, 0))
		end
		
		if Menu.drawing.myHero then
			DrawCircle(myHero.x, myHero.y, myHero.z, 660, RGB(250, 6, 6))
		end

		if Target ~= nil and ValidTarget(Target) then
			if Menu.drawing.tText then
				DrawText3D("Current Target",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFF00)
			end
		end
	end
end

function Skills()
	SkillQ = { name = "Flash Frost", range = 1075, delay = 0.250, speed = 850, width = 110, ready = false }
	SkillW = { name = "Crystallize", range = 1000, delay = 0.25, speed = math.huge, width = 100, ready = false }
	SkillE = { name = "Frostbite", range = 650, delay = 0.25, speed = 850, width = nil, ready = false }
	SkillR = { name = "Glacial Storm", range = 625, delay = 0.100, speed = math.huge, width = 350, ready = false }
end
	
local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Anivia.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#00ff00\"><b>Updating HR Anivia, don't press F9.</b></font>")	
				Update()
			end
		else
		PrintChat("<font color=\"#00ff00\"><b>An error occured, while updating, please reload.</b></font>")

		end
	else
		PrintChat("<font color=\"#00ff00\"><b>Could not connect to update Server.</b></font>")	
	end
end

function Update()
	DownloadFile("http://"..serveradress..scriptadress.."/HR Anivia.lua",SCRIPT_PATH.."HR Anivia.lua", function ()
		PrintChat("<font color=\"#00ff00\"><b>HR Anivia Updated, press 2xF9.</b></font>")	
		updated = true
	end)
end
	
	
	
	
	
	
	
	
class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
        DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
    end
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
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
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
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end
