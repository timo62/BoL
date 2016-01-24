if myHero.charName ~= "Draven" then return end

-- SCRIPT STATUS -- 
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("OBEEIHEIBBH") 
-- SCRIPT STATUS -- 

local ts
local LocalVersion = "3.02"
local autoupdate = true --Change to false if you don't wan't autoupdates
local reticles = {}
local movementHuman = true
local qStacks = 0
local LastAxe = 0
local SAC = false
local SX = false
local BarrierMenu = false
local HealMenu = false
local Ulting = nil

function OnLoad()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then Heal = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then Heal = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerbar") then Barrier = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbar") then Barrier = SUMMONER_2 end
  	Menu = scriptConfig("HR Draven Axes", "HRDravenAxes")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("TripleQ", "Use Triple Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("WSlow", "Use W if slowed", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseEDmg", "Use E to give damage", SCRIPT_PARAM_ONOFF, false)
	Menu.combo:addParam("UseEAway", "Use E to away melee enemies", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("RangeEA", "Max Range to use E",  SCRIPT_PARAM_SLICE, 200, 175, 500, 0) 
	--[[Menu.combo:addParam("REnemies", "Use R if can hit x (1 disable)", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
	Menu.combo:addParam("RangeRA", "Max Range to use R",  SCRIPT_PARAM_SLICE, 2000, 1500, 10000, 0)--]]
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("LastHit", "lasthit")
	Menu.lasthit:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("GapCloser", "gapcloser")
	Menu.gapcloser:addParam("UseEGap", "Use E to GapCloser", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Interrupt", "interrupt")
	Menu.interrupt:addParam("UseEInt", "Use E to Interrupt", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)	
	Menu.killsteal:addParam("RMode", "R Mode", SCRIPT_PARAM_LIST, 1, { "With CC", "Without CC"})
	Menu.killsteal:addParam("RangeR", "Max Range to use R",  SCRIPT_PARAM_SLICE, 2000, 1500, 10000, 0) 
	if Ignite then Menu.killsteal:addParam("UseIgnite", "Use Ignite", SCRIPT_PARAM_ONOFF, true)	end
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LaneClear", "LaneClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	Menu.keys:addParam("LastHit", "LastHit", SCRIPT_PARAM_ONKEYDOWN, false, 88)
	
	-- Mana Managers
	Menu.harass:addParam("manaUseQ", "Mana Q", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
    Menu.laneclear:addParam("manaUseQ", "Mana Q", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
    Menu.lasthit:addParam("manaUseQ", "Mana Q", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
	-- Mana Managers
	
	if Heal or Barrier then Menu:addSubMenu("Auto Heal/Barrier", "misc") end
    if Heal then Menu.misc:addParam("AutoHeal", "Auto Heal", SCRIPT_PARAM_ONOFF, true) end
	if Heal then Menu.misc:addParam("HealCc", "Heal",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0) end
    if Barrier then Menu.misc:addParam("AutoBarrier", "Auto Barrier", SCRIPT_PARAM_ONOFF, true) end
	if Barrier then Menu.misc:addParam("BarrierCc", "Barrier",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0) end

	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("myColor", "Draw My Range Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("eDraw", "Draw Stand Aside (E) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("eColor", "Draw Stand Aside (E) Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("tColor", "Draw Target Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("reticle", "Draw Reticles", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addParam("AutoCatch", "Auto Catch", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("L"))
	Menu:addParam("CatchMode", "Catch Mode", SCRIPT_PARAM_LIST, 2, { "To Mouse", "To Hero"})
	Menu:addParam("QMode", "Logic Mode", SCRIPT_PARAM_LIST, 1, {"Logic 1"--[[, "Logic 2"]]})
	IDPerma = Menu:permaShow("AutoCatch")
	Menu.permaShowEdit(IDPerma, "lText", "[HR Draven Axes] Catch Axes")
	Menu.permaShowEdit(IDPerma, "lTextColor", 0xff00ff00)
	CheckVPred()
	if _G.Reborn_Initialised or _G.Reborn_Loaded then
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Loading SAC.</b></font>")
	DelayAction(function()  
	SAC = true
	SX = false
	PW = false
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>SAC Loaded.</b></font>")	
	Menu:addSubMenu("Orbwalker", "OrbWalker")
	Menu.OrbWalker:addParam("info", "SAC Detected", SCRIPT_PARAM_INFO, " ")
	end, 10)
	elseif _Pewalk then
	Menu:addSubMenu("Orbwalker", "OrbWalker")
	Menu.OrbWalker:addParam("info", "Pewalk Detected", SCRIPT_PARAM_INFO, " ")
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Pewalk Loaded.</b></font>")
	SAC = false
	SX = false
	PW = true
	else
  	orbwalkCheck()
  	end
	
	customLoad()
	
	enemyMinions = minionManager(MINION_ENEMY, 600, myHero, MINION_SORT_HEALTH_ASC)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_PHYSICAL)
	ts.name = "Draven"
	Menu:addTS(ts)
	PriorityOnLoad()
end

function customLoad()
	FindUpdates()
	Skills()	
	Tables()
end

function PriorityOnLoad()
	if heroManager.iCount < 10 or (TwistedTreeline and heroManager.iCount < 6) then
		PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Too few champions to arrange priority.</b></font>")
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
	
	if Menu.AutoCatch and Menu.CatchMode == 1 then
	  DrawCircle(mousePos.x, mousePos.y, mousePos.z, 400, ARGB(255, 0, 0, 255))
	end
	
	if Menu.drawing.reticle then
	  if reticles ~= nil then
	  for i, reticle in ipairs(reticles) do
	  DrawCircle(reticle.x, reticle.y, reticle.z, 100, ARGB(210, 0, 0, 255))
	  end
	  end
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

 function AutoHeal()
 if Heal then
 	for _, unit in pairs(GetEnemyHeroes()) do
		if GetDistance(unit) <= 1000 then
			if Menu.misc.AutoHeal and myHero:CanUseSpell(Heal) == READY then
				if myHero.health/myHero.maxHealth < Menu.misc.HealCc/100 then
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
		if GetDistance(unit) <= 1000 then
			if Menu.misc.AutoBarrier and myHero:CanUseSpell(Barrier) == READY then
				if myHero.health/myHero.maxHealth < Menu.misc.BarrierCc/100 then
					CastSpell(Barrier)
end
end
end
end
end
end

function orbwalkCheck()
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Loading SxOrbWalk.</b></font>")
	require("SxOrbWalk")
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>SxOrbWalk Loaded.</b></font>")	
	Menu:addSubMenu("Orbwalker", "OrbWalker")
	SxOrb:LoadToMenu(Menu.OrbWalker)
	SAC = false
	SX = true
	PW = false
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
    if obj.name == "draven_r_missile_end_sound.troy" and obj.team ~= TEAM_ENEMY then
    Ulting = nil
    end
    if obj.team == TEAM_ENEMY then return end
    if obj.name == "Draven_Base_Q_ReticleCatchSuccess.troy" then
    if qStacks > 3 then return end
    LastAxe = os.clock()
    DelayAction(function()qStacks = qStacks + 1 end,0.10)
    end
    if obj.name == "Draven_Base_Q_activation.troy" then
    if qStacks >= 3 then return end
    qStacks = qStacks + 1
    end
    if obj.name == "Draven_Base_Q_reticle_self.troy" then
    table.insert(reticles, obj)
    elseif obj.name == "draven_spinning_buff_end_sound.troy" then
    qStacks = 0
    end
    end
end


function OnDeleteObj(obj)
    if obj ~= nil and obj.name ~= nil and obj.x ~= nil and obj.z ~= nil then
    if obj.name == "Draven_R_cas.troy" and obj.team ~= TEAM_ENEMY then
    Ulting = obj
    end
 	if obj.team == TEAM_ENEMY then return end
	if obj.name == "Draven_Base_Q_reticle_self.troy" then
	if qStacks ~= 1 then 
	qStacks = qStacks - 1 
	else
	DelayAction(function()qStacks = qStacks - 1 end,0.3)
	end
    for i, reticle in ipairs(reticles) do
	if obj.name == reticle.name then
    table.remove(reticles, i)  
	end
    end
	end
end
end
  
function AutoR()

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
	end 
	
	if Heal then
	if Menu.misc.AutoHeal then
	AutoHeal()
	end 
	end
	
	if Barrier then
	if Menu.misc.AutoBarrier then
	AutoBarrier()
	end
	end

	--[[if Menu.combo.REnemies == 1 then
	return 
	else
	AutoR()
	end--]]

	if SX then
	SxOrb:RegisterAfterAttackCallback(QTriple)
	elseif SAC then
	_G.AutoCarry.Plugins:RegisterOnAttacked(QTriple)
	elseif PW then
	_Pewalk.AddAfterAttackCallback(QTriple)
	end

    if qStacks == 3 and os.clock() - LastAxe >= 1.5 then
    qStacks = qStacks - 1
    end

CatchAxes()
CatchAxes1()
AwayMelee()
end

function QTriple()
if qStacks == 2 and Menu.combo.TripleQ and ComboKey then
CastSpell(_Q)
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
		if qStacks < 2 and Menu.combo.UseQ then 
			CastSpell(_Q)
		end	
		if Menu.combo.WSlow then

		if HaveBuffs(myHero, 10) then
			CastSpell(_W)
		end
		end	

		if Menu.combo.UseEDmg then 
			CastE(unit)
		end	
	end
end

function Harass(unit)
	if (myHero:CanUseSpell(_Q) == READY and ts.target~=nil and Menu.harass.UseQ and qStacks < 1 ) and Menu.harass.manaUseQ <= 100*myHero.mana/myHero.maxMana then 
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
		local dmgE = math.floor((myHero:GetSpellData(_E).level - 1)*70 + 35 + myHero.damage * 0.4)
		local dmgR = math.floor((myHero:GetSpellData(_R).level - 1)*175 + 100 + myHero.damage * 1.1) 
		local buffsList = 6, 8, 11, 20, 21, 23, 29
			if health <= dmgE and Menu.killsteal.UseE and myHero:CanUseSpell(_E) == READY and ValidTarget(unit) then
				CastE(unit)
			end
			if Menu.killsteal.RMode == 1 then
			if health <= dmgR*2 and Menu.killsteal.UseR and myHero:CanUseSpell(_R) == READY and ValidTarget(unit) and GetDistance(unit) <= Menu.killsteal.RangeR and HaveBuffs(unit, buffsList) then
				CastR(unit)
			end
			elseif Menu.killsteal.RMode == 2 then
			if health <= dmgR and Menu.killsteal.UseR and myHero:CanUseSpell(_R) == READY and ValidTarget(unit) and GetDistance(unit) <= Menu.killsteal.RangeR then
				CastR(unit)
			end
			end
			if Ignite then
			if health <= 40 + (20 * myHero.level) and Menu.killsteal.UseIgnite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 650 then
				CastSpell(Ignite, unit)
			end
			end
	 end
end

function HaveBuffs(unit, buffs)
        for i = 1, unit.buffCount, 1 do      
            local buff = unit:getBuff(i) 
            if buff.valid and buff.type == buffs then
                return true            
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
	if Ulting ~= nil then return end
	if unit ~= nil and myHero:CanUseSpell(_R) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineAOECastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero)
				
		if HitChance >= 2 then
			CastSpell(_R, CastPosition.x, CastPosition.z)
		end
	end
end

function GetAADmg(unit)
	local RawDMG = myHero.totalDamage
	return RawDMG
end

function CatchAxes()
	if Menu.AutoCatch and Menu.CatchMode == 1 then

	for _, unit in pairs(GetEnemyHeroes()) do
	if ValidTarget(unit) and GetDistance(unit) <= 900 then
	local health = unit.health
	if unit.health <= GetAADmg(unit)*2 then ForcePointSx() return end
	end

	if tablelength(reticles) <= 0 then
	ForcePointSx()
	end

	if tablelength(reticles) > 0 then
    for i, reticle in ipairs(reticles) do
    if (math.abs(mousePos.x - reticle.x) <= 400 and math.abs(mousePos.z - reticle.z) <= 400) and not (reticle.x <= 55 and reticle.y <= 55) then
    if Menu.QMode == 1 then
	if SAC then
	if GetDistance(reticle) <= 50 then 
	ForcePointSx()
	else _G.AutoCarry.Orbwalker:OverrideOrbwalkLocation(reticle)
	end
	end
	if PW then
	if GetDistance(reticle) <= 50 then 
	ForcePointSx()
	else _Pewalk.ForcePoint(reticle)
	end
	end
	if SX then
	if GetDistance(reticle) <= 50 then 
	ForcePointSx()
	else
	SxOrb:ForcePoint(reticle.x, reticle.z)
	end
	end
	elseif Menu.QMode == 2 then
	if SAC then
	
	end
	if PW then

	end
	if SX then
	
	end
	end
	else ForcePointSx()
end
end
end
end
end
end

function CatchAxes1()
	if Menu.AutoCatch and Menu.CatchMode == 2 then

	for _, unit in pairs(GetEnemyHeroes()) do
	if ValidTarget(unit) and GetDistance(unit) <= 900 then
	local health = unit.health
	if unit.health <= GetAADmg(unit)*2 then ForcePointSx() return end
	end

	if tablelength(reticles) <= 0 then
	ForcePointSx()
	end

	if tablelength(reticles) > 0 then
    for i, reticle in ipairs(reticles) do
    if (math.abs(myHero.x - reticle.x) <= 900 and math.abs(myHero.z - reticle.z) <= 900) and not (reticle.x <= 55 and reticle.y <= 55) then
    if Menu.QMode == 1 then
	if SAC then
	if GetDistance(reticle) <= 50 then 
	ForcePointSx()
	else _G.AutoCarry.Orbwalker:OverrideOrbwalkLocation(reticle)
	end
	end
	if PW then
	if GetDistance(reticle) <= 50 then 
	ForcePointSx()
	else _Pewalk.ForcePoint(reticle)
	end
	end
	if SX then
	if GetDistance(reticle) <= 50 then 
	ForcePointSx()
	else
	SxOrb:ForcePoint(reticle.x, reticle.z)
	end
	end
	elseif Menu.QMode == 2 then
	if SAC then

	end
	if PW then

	end
	if SX then

	end
	end
	else ForcePointSx()
end
end
end
end
end
end

function ForcePointSx()
	if SAC then
	_G.AutoCarry.Orbwalker:OverrideOrbwalkLocation(nil)
	end
	if PW then
	_Pewalk.ForcePoint(nil)
	end
	if SX then
	SxOrb:ForcePoint(nil)
	end
end

function AwayMelee()
	if not Menu.combo.UseEAway then return end
	if ComboKey then
	local ChampsMelee = {
        ['Aatrox']      = {true},
        ['Akali']       = {true},
        ['Alitar']      = {true},
        ['Amumu']       = {true},
        ['Blitzcrank']  = {true},
        ['Braum']       = {true},
        ['Chogath']     = {true},
        ['Darius']      = {true},
        ['Diana']       = {true},
        ['DrMundo']     = {true},
        ['Ekko']        = {true},
        ['Blitzcrank']  = {true},
        ['Elise']       = {true},
        ['Evelynn']     = {true},
        ['Fiora']       = {true},
        ['Fizz']        = {true},
        ['Garen']       = {true},
        ['Gragas']      = {true},
        ['Hecarim']     = {true},
        ['Illaoi']      = {true},
        ['Irelia']      = {true},
        ['JarvanIV']    = {true},
        ['Jax']         = {true},
        ['Jayce']       = {true},
        ['Kassadin']    = {true},
        ['Katarina']    = {true},
        ['Kayle']       = {true},
        ['Khazix']      = {true},
        ['LeeSin']      = {true},
        ['Leona']       = {true},
        ['Malphite']    = {true},
        ['Maokai']      = {true},
        ['MasterYi']    = {true},
        ['Mordekaiser'] = {true},
        ['Nasus']       = {true},
        ['Nautilus']    = {true},
        ['Nidalee']     = {true},
        ['Nocturne']    = {true},
        ['Nunu']        = {true},
        ['Olaf']        = {true},
        ['Pantheon']    = {true},
        ['Poppy']       = {true},
        ['Rammus']      = {true},
        ['Rek']         = {true},
        ['Rengar']      = {true},
        ['Riven']       = {true},
        ['Rumble']      = {true},
        ['Sejuani']     = {true},
        ['Shaco']       = {true},
        ['Shen']        = {true},
        ['Shyvana']     = {true},
        ['Singed']      = {true},
        ['Sion']        = {true},
        ['Skarner']     = {true},
        ['TahmKench']   = {true},
        ['Talon']       = {true},
        ['Taric']       = {true},
        ['Thresh']      = {true},
        ['Trundle']     = {true},
        ['Tryndamere']  = {true},
        ['Udyr']        = {true},
        ['Vi']          = {true},
        ['Volibear']    = {true},
        ['Warwick']     = {true},
        ['MonkeyKing']  = {true},
        ['XinZhao']     = {true},
        ['Yasuo']       = {true},
        ['Yorick']      = {true},
        ['Zac']         = {true},
        ['Zed']         = {true},
    }
	for _, enemy in pairs(GetEnemyHeroes()) do
    if ChampsMelee[enemy.charName] and GetDistance(enemy) <= Menu.combo.RangeEA and ValidTarget(enemy) and not enemy.dead then
    CastE(enemy)
	end
	end
end
end

function Tables()
    isAGapcloserUnitTarget = {
        ['AkaliShadowDance']		= {true, Champ = 'Akali', 		spellKey = 'R'},
        ['Headbutt']     			= {true, Champ = 'Alistar', 	spellKey = 'W'},
        ['DianaTeleport']       	= {true, Champ = 'Diana', 		spellKey = 'R'},
        ['IreliaGatotsu']     		= {true, Champ = 'Irelia',		spellKey = 'Q'},
        ['JaxLeapStrike']         	= {true, Champ = 'Jax', 		spellKey = 'Q'},
        ['JayceToTheSkies']       	= {true, Champ = 'Jayce',		spellKey = 'Q'},
        ['MaokaiUnstableGrowth']    = {true, Champ = 'Maokai',		spellKey = 'W'},
        ['MonkeyKingNimbus']  		= {true, Champ = 'MonkeyKing',	spellKey = 'E'},
        ['Pantheon_LeapBash']   	= {true, Champ = 'Pantheon',	spellKey = 'W'},
        ['PoppyHeroicCharge']       = {true, Champ = 'Poppy',		spellKey = 'E'},
        ['QuinnE']       			= {true, Champ = 'Quinn',		spellKey = 'E'},
        ['XenZhaoSweep']     		= {true, Champ = 'XinZhao',		spellKey = 'E'},
        ['blindmonkqtwo']	    	= {true, Champ = 'LeeSin',		spellKey = 'Q'},
        ['FizzPiercingStrike']	    = {true, Champ = 'Fizz',		spellKey = 'Q'},
        ['RengarLeap']	    		= {true, Champ = 'Rengar',		spellKey = 'Q/R'},
        ['YasuoDashWrapper']	    = {true, Champ = 'Yasuo',		spellKey = 'E'},
    }
	
    isAGapcloserUnitNoTarget = {
        ['AatroxQ']					= {true, Champ = 'Aatrox', 		range = 1000,  	projSpeed = 1200, spellKey = 'Q'},
        ['GragasE']					= {true, Champ = 'Gragas', 		range = 600,   	projSpeed = 2000, spellKey = 'E'},
        ['GravesMove']				= {true, Champ = 'Graves', 		range = 425,   	projSpeed = 2000, spellKey = 'E'},
        ['HecarimUlt']				= {true, Champ = 'Hecarim', 	range = 1000,   projSpeed = 1200, spellKey = 'R'},
        ['JarvanIVDragonStrike']	= {true, Champ = 'JarvanIV',	range = 770,   	projSpeed = 2000, spellKey = 'Q'},
        ['JarvanIVCataclysm']		= {true, Champ = 'JarvanIV', 	range = 650,   	projSpeed = 2000, spellKey = 'R'},
        ['KhazixE']					= {true, Champ = 'Khazix', 		range = 900,   	projSpeed = 2000, spellKey = 'E'},
        ['khazixelong']				= {true, Champ = 'Khazix', 		range = 900,   	projSpeed = 2000, spellKey = 'E'},
        ['LeblancSlide']			= {true, Champ = 'Leblanc', 	range = 600,   	projSpeed = 2000, spellKey = 'W'},
        ['LeblancSlideM']			= {true, Champ = 'Leblanc', 	range = 600,   	projSpeed = 2000, spellKey = 'WMimic'},
        ['LeonaZenithBlade']		= {true, Champ = 'Leona', 		range = 900,  	projSpeed = 2000, spellKey = 'E'},
        ['UFSlash']					= {true, Champ = 'Malphite', 	range = 1000,  	projSpeed = 1800, spellKey = 'R'},
        ['RenektonSliceAndDice']	= {true, Champ = 'Renekton', 	range = 450,  	projSpeed = 2000, spellKey = 'E'},
        ['SejuaniArcticAssault']	= {true, Champ = 'Sejuani', 	range = 650,  	projSpeed = 2000, spellKey = 'Q'},
        ['ShenShadowDash']			= {true, Champ = 'Shen', 		range = 575,  	projSpeed = 2000, spellKey = 'E'},
        ['RocketJump']				= {true, Champ = 'Tristana', 	range = 900,  	projSpeed = 2000, spellKey = 'W'},
        ['slashCast']				= {true, Champ = 'Tryndamere', 	range = 650,  	projSpeed = 1450, spellKey = 'E'},
    }
	
    isAChampToInterrupt = {
        ['KatarinaR']					= {true, Champ = 'Katarina',	spellKey = 'R'},
        ['GalioIdolOfDurand']			= {true, Champ = 'Galio',		spellKey = 'R'},
        ['Crowstorm']					= {true, Champ = 'FiddleSticks',spellKey = 'R'},
        ['Drain']						= {true, Champ = 'FiddleSticks',spellKey = 'W'},
        ['AbsoluteZero']				= {true, Champ = 'Nunu',		spellKey = 'R'},
        ['ShenStandUnited']				= {true, Champ = 'Shen',		spellKey = 'R'},
        ['UrgotSwap2']					= {true, Champ = 'Urgot',		spellKey = 'R'},
        ['AlZaharNetherGrasp']			= {true, Champ = 'Malzahar',	spellKey = 'R'},
        ['FallenOne']					= {true, Champ = 'Karthus',		spellKey = 'R'},
        ['Pantheon_GrandSkyfall_Jump']	= {true, Champ = 'Pantheon',	spellKey = 'R'},
        ['VarusQ']						= {true, Champ = 'Varus',		spellKey = 'Q'},
        ['CaitlynAceintheHole']			= {true, Champ = 'Caitlyn',		spellKey = 'R'},
        ['MissFortuneBulletTime']		= {true, Champ = 'MissFortune',	spellKey = 'R'},
        ['InfiniteDuress']				= {true, Champ = 'Warwick',		spellKey = 'R'},
        ['LucianR']						= {true, Champ = 'Lucian',		spellKey = 'R'}
    }
end

function OnProcessSpell(unit, spell)
	if Menu.interrupt.UseEInt then
    if isAChampToInterrupt[spell.name] and GetDistanceSqr(unit) <= 715*715 then
        CastE(unit)
    end
    end

	if Menu.gapcloser.UseEGap then 
    if unit.team ~= myHero.team then
	
        if isAGapcloserUnitTarget[spell.name] then
        if spell.target and spell.target.networkID == myHero.networkID then
            CastE(unit)
        end
        end
		
        if isAGapcloserUnitNoTarget[spell.name] and GetDistanceSqr(unit) <= 2000*2000 and (spell.target == nil or (spell.target and spell.target.isMe)) then
            CastE(unit)
        end
    end
end
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Draven Axes.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Updating, don't press F9.</b></font>")
			Update()
			else
			PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>You have the latest version.</b></font>")
			end
		else
		PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>An error occured, while updating, please reload.</b></font>")
		end
	else
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Could not connect to update Server.</b></font>")
	end
end

function Update()
	DownloadFile("http://"..serveradress..scriptadress.."/HR Draven Axes.lua",SCRIPT_PATH.."HR Draven Axes.lua", function ()
	PrintChat("<font color=\"#415cf6\"><b>[HR Draven Axes] </b></font>".."<font color=\"#01cc9c\"><b>Updated, press 2x F9.</b></font>")
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
