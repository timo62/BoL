if myHero.charName ~= "Ezreal" then return end
local ts
local LocalVersion = "1.2"

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
	Menu.killsteal:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("RangeR", "Range R",  SCRIPT_PARAM_SLICE, 2500, 1000, 6000, 0) 
	
	--Menu:addSubMenu("Anti-GapCloser", "antigap")
	--Menu.antigap:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	
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
	
	Menu:addSubMenu("Auto", "misc")
	
	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("myColor", "Draw My Range Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("qDraw", "Draw Mystic Shot (Q) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qColor", "Draw Mystic Shot (Q) Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("wDraw", "Draw Essence Flux (W) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("wColor", "Draw Essence Flux (W) Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("tColor", "Draw Target Color", SCRIPT_PARAM_COLOR, {255, 100, 44, 255})
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	
	CheckVPred()
	Skills()		
	IgniteCheck()
	HealCheck()
	BarrierCheck()
	findupdates()
	
 	if _G.Reborn_Initialised then
	elseif _G.Reborn_Loaded then
	PrintChat("<font color=\"#00ff00\"><b>HR EzReal Loaded.</b></font>")	
	PrintChat("<font color=\"#ff0000\"><b>Loading Sac.</b></font>")	
	SACLoaded = true
	else
  orbwalkCheck()
  end
	
	enemyMinions = minionManager(MINION_ENEMY, SkillQ.range, myHero, MINION_SORT_HEALTH_ASC)
  ts = TargetSelector(TARGET_LESS_CAST, MyBasicRange, DAMAGE_PHYSICAL)
	ts.name = "Ezreal"
	Menu:addTS(ts)
	PriorityOnLoad()
end

function PriorityOnLoad()
	if heroManager.iCount < 10 or (TwistedTreeline and heroManager.iCount < 6) then
		print("</b><font color=\"#FFFFFF\">HR EzReal : Too few champions to arrange priority.</font>")
	elseif heroManager.iCount == 6 then
		arrangePrioritysTT()
    else
		arrangePrioritys()
	end
end

function OnDraw()
	if not myHero.dead and not Menu.drawing.mDraw then
		if myHero:CanUseSpell(_Q) == READY and Menu.drawing.qDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillQ.range, RGB(Menu.drawing.qColor[2], Menu.drawing.qColor[3], Menu.drawing.qColor[4]))
		end
		if myHero:CanUseSpell(_W) == READY and Menu.drawing.wDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillW.range, RGB(Menu.drawing.wColor[2], Menu.drawing.wColor[3], Menu.drawing.wColor[4]))
		end
		
		if Menu.drawing.myHero then
			
			DrawCircle(myHero.x, myHero.y, myHero.z, myHero.range + GetDistance(myHero, myHero.minBBox), RGB(Menu.drawing.myColor[2], Menu.drawing.myColor[3], Menu.drawing.myColor[4]))
		end

		if Target ~= nil and ValidTarget(Target) then
			if Menu.drawing.tText then
				DrawText3D("Current Target",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFF00)
			end
			DrawCircle(Target.x, Target.y, Target.z, 200, RGB(Menu.drawing.tColor[2], Menu.drawing.tColor[3], Menu.drawing.tColor[4]))
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
 if Ignite and ts.target ~= nil then
 if Menu.killsteal.UseIgnite and ts.target.health <= 40 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY then
  CastSpell(Ignite, ts.target)
  end
  end
end

 function AutoHeal()
 if Heal then
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
 if Barrier then
			if Menu.misc.AutoBarrier and myHero:CanUseSpell(Barrier) == READY then
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
if myHero:GetSpellData(SUMMONER_1).name:find("summonerbar") then Barrier = SUMMONER_1
  Menu.misc:addParam("AutoBarrier", "Auto Barrier", SCRIPT_PARAM_ONOFF, true)
	Menu.misc:addParam("BarrierCc", "Barrier",  SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbar") then Barrier = SUMMONER_2
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
	if(myHero:CanUseSpell(_Q) == READY and (myHero.mana / myHero.maxMana > Menu.harass.mManager /100 ) and 				ts.target~=nil and Menu.harass.UseQ ) then 
  CastQ(unit)
	end
	if(myHero:CanUseSpell(_W) == READY and (myHero.mana / myHero.maxMana > Menu.harass.mManager /100 ) and 				ts.target~=nil and Menu.harass.UseW ) then 
  CastW(unit)
	end
end

function LaneClear()
	enemyMinions:update()
	if not IsMyManaLowLaneClear() then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseQ and GetDistance(minion) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
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
		local dmgR = getDmg("R", unit, myHero) + ((myHero.damage)*0.44) + ((myHero.ap)*0.9)
		
			if health < dmgW and Menu.killsteal.UseW and myHero:CanUseSpell(_W) == READY and ValidTarget(unit) then
				CastW(unit)
			end
			if health < dmgQ and Menu.killsteal.UseQ and myHero:CanUseSpell(_Q) == READY and ValidTarget(unit) then
				CastQ(unit)
			end
			if health < dmgR and Menu.killsteal.UseR and myHero:CanUseSpell(_R) == READY and ValidTarget(unit) and GetDistance(unit) <= Menu.killsteal.RangeR then
				CastR(unit)
			end
	 end
end

function CastQ(unit)
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, true)
				
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
	if unit ~= nil and myHero:CanUseSpell(_R) == READY then
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


local serveradress = "github.com"
local scriptadress = "HiranN/BoL/master"

function findupdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR EzReal.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#00ff00\"><b>Updating HR EzReal, don't press F9.</b></font>")	
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
	DownloadFile("http://"..serveradress..scriptadress.."/HR EzReal.lua",SCRIPT_PATH.."HR EzReal.lua", function ()
		PrintChat("<font color=\"#00ff00\"><b>Updated, press 2xF9.</b></font>")	
		updated = true
	end)
end
