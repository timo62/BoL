if myHero.charName ~= "Draven" then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("WJMMQPMQJJP") 

local ts
local LocalVersion = "2.3"
local autoupdate = true --Change to false if you don't wan't autoupdates
local reticles = {}
local movementHuman = true
local qBuff = 0
local qStacks = 0
local SAC = false
local SX = false
local BarrierMenu = false
local HealMenu = false

function OnLoad()
  Menu = scriptConfig("HR Draven Axes", "Draven")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseW", "Use W After Catch Axe", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)	
	Menu.killsteal:addParam("RangeR", "Range R",  SCRIPT_PARAM_SLICE, 2500, 2000, 10000, 0) 
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LaneClear", "LaneClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	Menu.keys:addParam("LastHit", "LastHit", SCRIPT_PARAM_ONKEYDOWN, false, 88)
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("LastHit", "lasthit")
	Menu.lasthit:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	
	-- Mana Managers
	Menu.harass:addParam("manaUseQ", "Mana Q", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
    Menu.laneclear:addParam("manaUseQ", "Mana Q", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
    Menu.lasthit:addParam("manaUseQ", "Mana Q", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
	-- Mana Managers
	
	Menu:addSubMenu("Auto", "misc")
	
	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("myColor", "Draw My Range Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("eDraw", "Draw Stand Aside (E) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("eColor", "Draw Stand Aside (E) Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("tColor", "Draw Target Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addParam("AutoCatch", "Auto Catch", SCRIPT_PARAM_ONOFF, true)
	
	CheckVPred()
	if _G.Reborn_Initialised then
	elseif _G.Reborn_Loaded then
	PrintChat("<font color=\"#00ff00\"><b>HR Draven Axes Loaded.</b></font>")	
	PrintChat("<font color=\"#ff0000\"><b>Loading Sac.</b></font>")	
	local Skills, Keys, Items, Data, Jungle, Helper, MyHero, Minions, Crosshair, Orbwalker = AutoCarry.Helper:GetClasses()
	SAC = true
	SX = false
	else
  orbwalkCheck()
  end
	
	customLoad()
	
	enemyMinions = minionManager(MINION_ENEMY, 600, myHero, MINION_SORT_HEALTH_ASC)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 600, DAMAGE_PHYSICAL)
	ts.name = "Draven"
	Menu:addTS(ts)
	PriorityOnLoad()
end

function customLoad()
	findupdates()
	Skills()		
	IgniteCheck()
	HealCheck()
	BarrierCheck()
end

function PriorityOnLoad()
	if heroManager.iCount < 10 or (TwistedTreeline and heroManager.iCount < 6) then
		print("</b><font color=\"#FFFFFF\">HR Draven Axes : Too few champions to arrange priority.</font>")
	elseif heroManager.iCount == 6 then
		arrangePrioritysTT()
    else
		arrangePrioritys()
	end
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function OnDraw()
	if not myHero.dead and not Menu.drawing.mDraw then
	
	if Menu.AutoCatch then
	  DrawCircle(mousePos.x, mousePos.y, mousePos.z, 400, ARGB(255, 0, 0, 255))
	end
	
		if myHero:CanUseSpell(_E) == READY and Menu.drawing.eDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, 1050, RGB(Menu.drawing.eColor[2], Menu.drawing.eColor[3], Menu.drawing.eColor[4]))
		end
		
		if Menu.drawing.myHero then
			DrawCircle(myHero.x, myHero.y, myHero.z, 610, RGB(Menu.drawing.myColor[2], Menu.drawing.myColor[3], Menu.drawing.myColor[4]))
		end

		if Target ~= nil and ValidTarget(Target) then
			if Menu.drawing.tText then
				DrawText3D("Current Target",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFF00)
			end
		end
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

 function AutoIgnite()
  	for _, unit in pairs(GetEnemyHeroes()) do
	if GetDistance(unit) <= 750 then
 if Ignite and ts.target ~= nil then
 if Menu.killsteal.UseIgnite and ts.target.health <= 40 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY then
  CastSpell(Ignite, ts.target)
  end
  end
  end
  end
end

 function AutoHeal()
 if Heal then
 	for _, unit in pairs(GetEnemyHeroes()) do
		if GetDistance(unit) <= 750 then
			if Menu.misc.AutoHeal and myHero:CanUseSpell(Heal) == READY then
				if myHero.level > 5 and myHero.health/myHero.maxHealth < Menu.misc.HealCc/100 then
					CastSpell(Heal)
				elseif  myHero.level < 6 and myHero.health/myHero.maxHealth < (Menu.misc.HealCc/100)*.75 then
					CastSpell(Heal)
end
end
end
end
end
end

 function AutoBarrier()
 if Barrier then
 	for _, unit in pairs(GetEnemyHeroes()) do
		if GetDistance(unit) <= 750 then
			if Menu.misc.AutoBarrier and myHero:CanUseSpell(Barrier) == READY then
				if myHero.level > 5 and myHero.health/myHero.maxHealth < Menu.misc.BarrierCc/100 then
					CastSpell(Barrier)
				elseif  myHero.level < 6 and myHero.health/myHero.maxHealth < (Menu.misc.BarrierCc/100)*.75 then
					CastSpell(Barrier)
end
end
end
end
end
end

 function HealCheck()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then Heal = SUMMONER_1
  Menu.misc:addParam("AutoHeal", "Auto Heal", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("HealCc", "Heal",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0) 
	HealMenu = true
elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then Heal = SUMMONER_2
  Menu.misc:addParam("AutoHeal", "Auto Heal", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("HealCc", "Heal",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0) 
	HealMenu = true
 end
end

 function BarrierCheck()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerbar") then Barrier = SUMMONER_1
  Menu.misc:addParam("AutoBarrier", "Auto Barrier", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("BarrierCc", "Barrier",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
	BarrierMenu = true
elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbar") then Barrier = SUMMONER_2
  Menu.misc:addParam("AutoBarrier", "Auto Barrier", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("BarrierCc", "Barrier",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
	BarrierMenu = true
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
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	PrintChat("<font color=\"#00ff00\"><b>HR Draven Axes Loaded.</b></font>")	
	PrintChat("<font color=\"#ff0000\"><b>Loading SxOrbWalk.</b></font>")	
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

function OnCreateObj(obj)
    if obj ~= nil and obj.name ~= nil and obj.x ~= nil and obj.z ~= nil then
    if obj.name == "Draven_Q_buf.troy" then
        qBuff = qBuff + 1
    end
             
        if obj.name:find("reticle_self.troy") then
            table.insert(reticles, obj)
        elseif obj.name == "draven_spinning_buff_end_sound.troy" then
            qStacks = 0
        end
    end
end


function OnDeleteObj(obj)
    if obj ~= nil and obj.name ~= nil and obj.x ~= nil and obj.z ~= nil then
	if obj.name:find("reticle_self.troy") then
        if GetDistance(obj) > 90 then
            qStacks = qStacks - 1
        end
        for i, reticle in ipairs(reticles) do
            if obj and obj.valid and reticle.object and reticle.object.valid and obj.x == reticle.object.x and obj.z == reticle.object.z then
                table.remove(reticles, i)
            end
        end
    elseif obj.name == "Draven_Q_buf.troy" then
        qBuff = qBuff - 1            
    end
end
end
  
function DebugPrint(to_print)
	if Menu.Debug then
		print(to_print)
	end
end
  
function Skills()
	SkillQ = { name = "Spinning Axe", range = nil, delay = nil, speed = nil, width = nil, ready = false }
	SkillW = { name = "Blood Rush", range = nil, delay = nil, speed = nil, width = nil, ready = false }
	SkillE = { name = "Stand Aside", range = 1050, delay = 0.25, speed = 1400, width = 160, ready = false }
	SkillR = { name = "Whirling Death", range = math.huge, delay = 1.0, speed = 2000, width = 150, ready = false }

	priorityTable = {
			AP = {
				"Annie", "Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
				"Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
				"Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "Velkoz", "Azir", "Ekko"
			},
			
			Support = {
				"Alistar", "Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Nunu", "Sona", "Soraka", "Taric", "Thresh", "Zilean", "Braum"
			},
			
			Tank = {
				"Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Nautilus", "Shen", "Singed", "Skarner", "Volibear",
				"Warwick", "Yorick", "Zac", "Tahm Kench", "Bard"
			},
			
			AD_Carry = {
				"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "Jinx", "KogMaw", "Lucian", "MasterYi", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
				"Talon","Tryndamere", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Yasuo", "Zed", "Kindred"
			},
			
			Bruiser = {
				"Aatrox", "Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nocturne", "Olaf", "Poppy",
				"Renekton", "Rengar", "Riven", "Rumble", "Shyvana", "Trundle", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Gnar"
			}
	}

end

function SetPriority(table, hero, priority)
	for i=1, #table, 1 do
		if hero.charName:find(table[i]) ~= nil then
			TS_SetHeroPriority(priority, hero.charName)
		end
	end
end
 
function arrangePrioritys()
		for i, enemy in ipairs(GetEnemyHeroes()) do
		SetPriority(priorityTable.AD_Carry, enemy, 1)
		SetPriority(priorityTable.AP,	   enemy, 2)
		SetPriority(priorityTable.Support,  enemy, 3)
		SetPriority(priorityTable.Bruiser,  enemy, 4)
		SetPriority(priorityTable.Tank,	 enemy, 5)
		end
end

function arrangePrioritysTT()
        for i, enemy in ipairs(GetEnemyHeroes()) do
		SetPriority(priorityTable.AD_Carry, enemy, 1)
		SetPriority(priorityTable.AP,       enemy, 1)
		SetPriority(priorityTable.Support,  enemy, 2)
		SetPriority(priorityTable.Bruiser,  enemy, 2)
		SetPriority(priorityTable.Tank,     enemy, 3)
        end
end
	
	-- USE
	function OnProcessSpell(unit, spell)
	    if unit.isMe and spell.name == "dravenspinning" then
        qStacks = qStacks + 1
		end
end
	
	
	
function OnTick()
	if qStacks < 0 then qStacks = 0 end
	if myHero.dead then qStacks = 0 end
	if myHero.dead then return end
	
	ts:update()
	
	Target = GetCustomTarget()

	ComboKey = Menu.keys.ComboKey
	HarassKey = Menu.keys.Harass
	LaneClearKey = Menu.keys.LaneClear
	LastHitKey = Menu.keys.LastHit
	
	if ComboKey then 
	Combo(Target)
	end
	
	if HarassKey and not ComboKey then
	Harass(Target)
	end	
	
	if LaneClearKey and not ComboKey then
	LaneClear()
	end
	if LastHitKey and not ComboKey then
	LastHit()
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
CatchAxes()
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
		if qStacks < 2 and Menu.combo.UseQ then 
			CastSpell(_Q)
		end	
		if Menu.combo.UseW then 
			CastSpell(_W)
		end	
		if Menu.combo.UseE then 
			CastE(unit)
		end	
	end
end

function Harass(unit)
	if (myHero:CanUseSpell(_Q) == READY  and ts.target~=nil and Menu.harass.UseQ and qStacks < 1 ) and Menu.harass.manaUseQ <= 100*myHero.mana/myHero.maxMana then 
  CastSpell(_Q)
	end
end

function LaneClear()
	enemyMinions:update()
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseQ and GetDistance(minion) <= 600 and myHero:CanUseSpell(_Q) == READY and qStacks < 1 and Menu.laneclear.manaUseQ <= 100*myHero.mana/myHero.maxMana then
					CastSpell(_Q)
				end
			end		 
		end
	end
	
function LastHit()
	enemyMinions:update()
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.lasthit.UseQ and GetDistance(minion) <= 600 and myHero:CanUseSpell(_Q) == READY and qStacks < 1 and Menu.lasthit.manaUseQ <= 100*myHero.mana/myHero.maxMana then
					CastSpell(_Q)
				end
			end		 
		end
	end

function KillSteal()
	for _, unit in pairs(GetEnemyHeroes()) do
		local health = unit.health
		local dmgE = getDmg("E", unit, myHero)
		local dmgR = getDmg("R", unit, myHero) * 2
		
			if health < dmgE and Menu.killsteal.UseE and myHero:CanUseSpell(_E) == READY and ValidTarget(unit) then
				CastE(unit)
			if health < dmgR and Menu.killsteal.UseR and myHero:CanUseSpell(_R) == READY and ValidTarget(unit) and GetDistance(unit) <= Menu.killsteal.RangeR then
				CastR(unit)
			end
	 end
end
end

function CastE(unit)
	if unit ~= nil and myHero:CanUseSpell(_E) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineAOECastPosition(unit, SkillE.delay, SkillE.width, SkillE.range, SkillE.speed, myHero, false)
				
		if HitChance >= 2 then
			CastSpell(_E, CastPosition.x, CastPosition.z)
		end
	end
end

function CastR(unit)
	if unit ~= nil and myHero:CanUseSpell(_R) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineAOECastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero)
				
		if HitChance >= 2 then
			CastSpell(_R, CastPosition.x, CastPosition.z)
		end
	end
end

function CatchAxes()
	if Menu.AutoCatch then
	if movementHuman then
	if tablelength(reticles) > 0 then
    for i, reticle in ipairs(reticles) do
      if (math.abs(mousePos.x - reticle.x) <= 400 and math.abs(mousePos.z - reticle.z) <= 400) and not (reticle.x <= 55 and reticle.y <= 55) then
	  movementHuman = false
	if SAC then
	Orbwalker:OverrideOrbwalkLocation(reticle.x, reticle.z)
	end
	if SX then
	SxOrb:ForcePoint(reticle.x, reticle.z)
	end
				DelayAction(ForcePointSx, 0.8)
				movementHuman = true
				end
end
end
end
end
end

function ForcePointSx()
	if SAC then
	Orbwalker:OverrideOrbwalkLocation(nil)
	end
	if SX then
	SxOrb:ForcePoint(nil)
	end
end

function CheckQstacks()
	toreturnint = 0
	for i = 1, myHero.buffCount, 1 do
		local buff = myHero:getBuff(i)
		if buff.valid then
			if buff.name == "dravenspinning" then
				toreturnint = buff.stack
				return toreturnint
			end
		end
	end
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"

function findupdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Draven Axes.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#00ff00\"><b>Updating HR Draven Axes, don't press F9.</b></font>")	
				update()
			end
		else
		PrintChat("<font color=\"#00ff00\"><b>An error occured, while updating, please reload.</b></font>")

		end
	else
		PrintChat("<font color=\"#00ff00\"><b>Could not connect to update Server.</b></font>")	
	end
end

function update()
	DownloadFile("http://"..serveradress..scriptadress.."/HR Draven Axes.lua",SCRIPT_PATH.."HR Draven Axes.lua", function ()
		PrintChat("<font color=\"#00ff00\"><b>HR Draven Axes Updated, press 2xF9.</b></font>")	
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
