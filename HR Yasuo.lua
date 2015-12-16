if myHero.charName ~= "Yasuo" then return end

-- Script Status --
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQIKAAAABgBAAEFAAAAdQAABBkBAAGUAAAAKQACBBkBAAGVAAAAKQICBHwCAAAQAAAAEBgAAAGNsYXNzAAQNAAAAU2NyaXB0U3RhdHVzAAQHAAAAX19pbml0AAQLAAAAU2VuZFVwZGF0ZQACAAAAAgAAAAgAAAACAAotAAAAhkBAAMaAQAAGwUAABwFBAkFBAQAdgQABRsFAAEcBwQKBgQEAXYEAAYbBQACHAUEDwcEBAJ2BAAHGwUAAxwHBAwECAgDdgQABBsJAAAcCQQRBQgIAHYIAARYBAgLdAAABnYAAAAqAAIAKQACFhgBDAMHAAgCdgAABCoCAhQqAw4aGAEQAx8BCAMfAwwHdAIAAnYAAAAqAgIeMQEQAAYEEAJ1AgAGGwEQA5QAAAJ1AAAEfAIAAFAAAAAQFAAAAaHdpZAAEDQAAAEJhc2U2NEVuY29kZQAECQAAAHRvc3RyaW5nAAQDAAAAb3MABAcAAABnZXRlbnYABBUAAABQUk9DRVNTT1JfSURFTlRJRklFUgAECQAAAFVTRVJOQU1FAAQNAAAAQ09NUFVURVJOQU1FAAQQAAAAUFJPQ0VTU09SX0xFVkVMAAQTAAAAUFJPQ0VTU09SX1JFVklTSU9OAAQEAAAAS2V5AAQHAAAAc29ja2V0AAQIAAAAcmVxdWlyZQAECgAAAGdhbWVTdGF0ZQAABAQAAAB0Y3AABAcAAABhc3NlcnQABAsAAABTZW5kVXBkYXRlAAMAAAAAAADwPwQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawABAAAACAAAAAgAAAAAAAMFAAAABQAAAAwAQACBQAAAHUCAAR8AgAACAAAABAsAAABTZW5kVXBkYXRlAAMAAAAAAAAAQAAAAAABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAUAAAAIAAAACAAAAAgAAAAIAAAACAAAAAAAAAABAAAABQAAAHNlbGYAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAtAAAAAwAAAAMAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAAFAAAABQAAAAUAAAAFAAAABgAAAAYAAAAGAAAABgAAAAUAAAADAAAAAwAAAAYAAAAGAAAABgAAAAYAAAAGAAAABgAAAAYAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAIAAAACAAAAAgAAAAIAAAAAgAAAAUAAABzZWxmAAAAAAAtAAAAAgAAAGEAAAAAAC0AAAABAAAABQAAAF9FTlYACQAAAA4AAAACAA0XAAAAhwBAAIxAQAEBgQAAQcEAAJ1AAAKHAEAAjABBAQFBAQBHgUEAgcEBAMcBQgABwgEAQAKAAIHCAQDGQkIAx4LCBQHDAgAWAQMCnUCAAYcAQACMAEMBnUAAAR8AgAANAAAABAQAAAB0Y3AABAgAAABjb25uZWN0AAQRAAAAc2NyaXB0c3RhdHVzLm5ldAADAAAAAAAAVEAEBQAAAHNlbmQABAsAAABHRVQgL3N5bmMtAAQEAAAAS2V5AAQCAAAALQAEBQAAAGh3aWQABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAEJgAAACBIVFRQLzEuMA0KSG9zdDogc2NyaXB0c3RhdHVzLm5ldA0KDQoABAYAAABjbG9zZQAAAAAAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAXAAAACgAAAAoAAAAKAAAACgAAAAoAAAALAAAACwAAAAsAAAALAAAADAAAAAwAAAANAAAADQAAAA0AAAAOAAAADgAAAA4AAAAOAAAACwAAAA4AAAAOAAAADgAAAA4AAAACAAAABQAAAHNlbGYAAAAAABcAAAACAAAAYQAAAAAAFwAAAAEAAAAFAAAAX0VOVgABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAoAAAABAAAAAQAAAAEAAAACAAAACAAAAAIAAAAJAAAADgAAAAkAAAAOAAAAAAAAAAEAAAAFAAAAX0VOVgA="), nil, "bt", _ENV))() ScriptStatus("REHIDFEKDDH") 
-- Script Status --

local ts
local knockedup = 0
local LocalVersion = "1.4"
local autoupdate = true --Change to false if you don't wan't autoupdates

	function OnLoad()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	
	Menu = scriptConfig("HR Yasuo", "menu")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseQ3", "Use Q3", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseEGap", "Use E to GapClose", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("DistanceToE", "Min Distance for GapClose",SCRIPT_PARAM_SLICE, 300, 0, 475, 0)
	Menu.combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addSubMenu("R Options", "r")
	Menu.combo.r:addParam("r1v1", "Use R in 1v1", SCRIPT_PARAM_ONOFF, true)
	Menu.combo.r:addParam("rTower", "Use R in enemy tower", SCRIPT_PARAM_ONOFF, false)
	Menu.combo.r:addParam("rOption", "Use R when x enemies knocked up", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true) 
	
	Menu:addSubMenu("LastHit", "lasthit")
	Menu.lasthit:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.lasthit:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("JungleClear", "jungleclear")
	Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.jungleclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
	
	Menu:addSubMenu("Auto Interrupt", "qSettings")
	Menu.qSettings:addParam("UseQ", "Use Q3 to Interrupt Spells", SCRIPT_PARAM_ONOFF, true)
	Menu.qSettings:addSubMenu("Spells to Interrupt", "spells")
	
	Menu:addSubMenu("W Block Spells", "wSettings")
	Menu.wSettings:addParam("WtoBlock", "Use W to Block Spells", SCRIPT_PARAM_ONOFF, true)
	Menu.wSettings:addSubMenu("Spells to Block", "spells")
	
	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qDraw", "(Q) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qColor", "(Q) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("q3Draw", "(Q3) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("q3Color", "(Q3) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("eDraw", "(E) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("eColor", "(E) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LastHit", "LastHit", SCRIPT_PARAM_ONKEYDOWN, false, 88)
	Menu.keys:addParam("LaneJungClear", "LaneClear / JungleClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	Menu.keys:addParam("Flee", "Flee", SCRIPT_PARAM_ONKEYDOWN, false, 75)
	
	Menu:addParam("pred", "Prediction Type", SCRIPT_PARAM_LIST, 1, { "VPrediction", "HPrediction"})
	CustomLoad()
	
	if FileExist(LIB_PATH .. "/HPrediction.lua") then
	require 'HPrediction'
	
	HPred = HPrediction()
	HP_Q = HPSkillshot({type = "DelayLine", delay = 0.25, range = 475, width = 40, speed = math.huge})
	HP_Q3 = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1000, width = 40, speed = math.huge})
	UseHP = true
else
	UseHP = false
	PrintChat("<font color=\"#ccae00\"><b>HR Yasuo : </b></font>".."<font color=\"#00ae26\"><b>If you want other Prediction download : HPrediction.</b></font>")
end
	end
	
	function CustomLoad()
	CheckVPred()
	Skills()		
	FindUpdates()
	GenerateTables()
	
        for i = 1, heroManager.iCount,1 do
            local hero = heroManager:getHero(i)
            if hero.team ~= player.team then
                if Champions[hero.charName] ~= nil then
                    for index, skillshot in pairs(Champions[hero.charName].skillshots) do
                        if skillshot.blockable == true then
                            Menu.wSettings.spells:addParam(skillshot.spellName, hero.charName .. " - " .. skillshot.name, SCRIPT_PARAM_ONOFF, true)
                        end
                    end
                end
            end
        end
	
        for i, a in pairs(GetEnemyHeroes()) do
            if Interrupt[a.charName] ~= nil then
                for i, spell in pairs(Interrupt[a.charName].stop) do
                    Menu.qSettings.spells:addParam(spell.spellName, a.charName.." - "..spell.name, SCRIPT_PARAM_ONOFF, true)
                end
            end
        end
	
	if _G.Reborn_Initialised then
	elseif _G.Reborn_Loaded then
	PrintChat("<font color=\"#ccae00\"><b>HR Yasuo : </b></font>".."<font color=\"#00ae26\"><b>Loaded.</b></font>")	
	PrintChat("<font color=\"#ccae00\"><b>HR Yasuo : </b></font>".."<font color=\"#00ae26\"><b>Loading Sac.</b></font>")
	else
    LoadOrb()
	end
	
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGIC)
	ts.name = "Yasuo"
	Menu:addTS(ts)
	PriorityOnLoad()
  end
  
	function LoadOrb()
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	PrintChat("<font color=\"#ccae00\"><b>HR Yasuo : </b></font>".."<font color=\"#00ae26\"><b>Loaded.</b></font>")
	PrintChat("<font color=\"#ccae00\"><b>HR Yasuo : </b></font>".."<font color=\"#00ae26\"><b>Loading SxOrbWalk.</b></font>")	
	require("SxOrbWalk")
	Menu:addSubMenu("SxOrbWalk", "SXMenu")
	SxOrb:LoadToMenu(Menu.SXMenu)
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
		if GetDistance(unit) <= 650 then
		if not Menu.killsteal.KSOn then return end
			if health <= dmgQ and Menu.killsteal.UseQ and ValidTarget(unit) then
				CastQ(unit)
				CastQ3(unit)
				end
				
			if Ignite then
			if health <= 40 + (20 * myHero.level) and Menu.killsteal.I and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) then
				CastSpell(Ignite, unit)
			end
			end
	end
	end
	end
	
function CountEnemyInRange(range, object)
    object = object or myHero
    range = range and range * range or myHero.range * myHero.range
    local enemyInRange = 0
    for i = 1, heroManager.iCount, 1 do
        local hero = heroManager:getHero(i)
        if ValidTarget(hero) and not hero.dead and hero.visible and hero.team ~= myHero.team and GetDistanceSqr(object, hero) <= range then
            enemyInRange = enemyInRange + 1
        end
    end
    return enemyInRange
end
	
	function OnTick()
	if myHero.dead then return end
	
	ts:update()
	
	Target = GetCustomTarget()
	
	ComboKey = Menu.keys.ComboKey
	HarassKey = Menu.keys.Harass
	LastHitKey = Menu.keys.LastHit
	LaneClearKey = Menu.keys.LaneJungClear
	JungleClearKey = Menu.keys.LaneJungClear
	FleeKey = Menu.keys.Flee
	
	if ComboKey then 
	Combo(Target)
	end
	
	if HarassKey and not ComboKey then
	Harass(Target)
	end	
	
	if LastHitKey and not ComboKey then
	LastHit()
	end
	
	if LaneClearKey and not ComboKey then
	LaneClear()
	end
	
	if JungleClearKey and not ComboKey then
	JungleClear()
	end
	
	if FleeKey and not ComboKey then
	Flee()
	end
	
	UseSpells()
	end

function OnCreateObj(obj)
    if not obj then return end
	if obj and (obj.name=="Yasuo_base_R_indicator_beam.troy" or obj.name=="Yasuo_Skin02_R_indicator_beam.troy") then
		knockedup = knockedup + 1
    end
end

function OnDeleteObj(obj)
    if not obj then return end
	if obj and (obj.name=="Yasuo_base_R_indicator_beam.troy" or obj.name=="Yasuo_Skin02_R_indicator_beam.troy") then
		knockedup = knockedup - 1
    end
end
	
function GetCustomTarget()
	ts:update()	
	if ValidTarget(ts.target) and ts.target.type == myHero.type then
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
		if Menu.combo.UseQ3 then 
			CastQ3(unit)
		end
	    if Menu.combo.UseEGap then
			UseEGap(unit)
		end
			
		if Menu.combo.UseE and GetDistance(unit) <= SkillE.range and myHero:CanUseSpell(_E) == READY and not TargetDashed(unit) and not UnderTurret(unit) then 
			CastSpell(_E, unit)
		end	
		if CountEnemyInRange(SkillR.range, myHero) >= 2 then 
		if Menu.combo.r.UseR and GetDistance(unit) <= SkillR.range and myHero:CanUseSpell(_R) == READY and knockedup >= Menu.combo.r.rOption then
			if not Menu.combo.r.rTower then if UnderTurret(unit) then return end end
			DelayAction(function() CastSpell(_R) end, 0.3)
		end	
		elseif CountEnemyInRange(SkillR.range, myHero) <= 1 then
		if Menu.combo.r.r1v1 and GetDistance(unit) <= SkillR.range and myHero:CanUseSpell(_R) == READY and knockedup >= 1 then
			if not Menu.combo.r.rTower then if UnderTurret(unit) then return end end
			DelayAction(function() CastSpell(_R) end, 0.3)
		end	
	end
end
end

function Flee()
    mPos = getNearestMinion(mousePos)
    if myHero:CanUseSpell(_E) == READY and mPos then
        CastSpell(_E, mPos) 
    else 
        myHero:MoveTo(mousePos.x, mousePos.z) 
    end
end

function TargetDashed(unit)
    if TargetHaveBuff("YasuoDashWrapper", unit) then
            return true
        end
    return false
end

function UseEGap(unit)
    local TargetDistance = GetDistance(unit)
    if TargetDistance > SkillE.range and Menu.combo.UseEGap then
            mPos = getNearestMinion(unit)
            if myHero:CanUseSpell(_E) == READY and mPos then 
                CastSpell(_E, mPos)
            end
        end             
        if TargetDistance >= Menu.combo.DistanceToE then
            object = getNearestMinion(mousePos)
            if myHero:CanUseSpell(_E) == READY and Menu.combo.UseEGap and object then
                if object.networkID ~= unit.networkID then
                    CastSpell(_E, object)
                end
            end
        end    
end

function getNearestMinion(unit)

    local closestMinion = nil
    local nearestDistance = 0

        enemyMinions:update()
        jungleMinions:update()
        for index, minion in pairs(enemyMinions.objects) do
            if minion ~= nil and minion.valid and string.find(minion.name,"Minion_") == 1 and minion.team ~= player.team and minion.dead == false then
                if GetDistance(minion) <= SkillE.range then
                    if GetDistance(eEndPos(minion), unit) < GetDistance(unit) and nearestDistance < GetDistance(minion) then
                        nearestDistance = GetDistance(minion)
                        closestMinion = minion
                    end
                end
            end
        end
        for index, minion in pairs(jungleMinions.objects) do
            if minion ~= nil and minion.valid and minion.dead == false then
                if GetDistance(minion) <= SkillE.range then
                    if GetDistance(eEndPos(minion), unit) < GetDistance(unit) and nearestDistance < GetDistance(minion) then
                        nearestDistance = GetDistance(minion)
                        closestMinion = minion
                    end
                end
            end
        end
        for i = 1, heroManager.iCount, 1 do
            local minion = heroManager:getHero(i)
            if ValidTarget(minion, SkillE.range) then
                if GetDistance(minion) <= SkillE.range then
                    if GetDistance(eEndPos(minion), unit) < GetDistance(unit) and nearestDistance < GetDistance(minion) then
                        nearestDistance = GetDistance(minion)
                        closestMinion = minion
                    end
                end
            end
        end
    return closestMinion
end

function eEndPos(unit)

    if unit ~= nil then
        if GetDistance(myHero,unit) < 410 then
           dashPointT = myHero + (Vector(unit) - myHero):normalized() * 485
        else 
           dashPointT = myHero + (Vector(unit) - myHero):normalized() * (GetDistance(myHero,unit) + 65)
        end
        return dashPointT
    end
end

function Harass(unit)
	ts:update()
	if myHero:CanUseSpell(_Q) == READY and ts.target ~= nil and Menu.harass.UseQ  then 
  CastQ(unit)
  CastQ3(unit)
	end
end

function LastHit()
	enemyMinions:update()
		for i, minion in pairs(enemyMinions.objects) do
		local dmgQ = getDmg("Q", minion, myHero)
		local dmgE = getDmg("E", minion, myHero)
		local health = minion.health
			if ValidTarget(minion) and minion ~= nil then
				if Menu.lasthit.UseQ and health <= dmgQ  then
					CastQ(minion)
					CastQ3(minion)
				end
				if Menu.lasthit.UseE and GetDistance(minion) <= SkillE.range and myHero:CanUseSpell(_E) == READY and health <= dmgE and not TargetDashed(unit) then
					CastSpell(_E, minion)
				end				
		end
	end
end

function LaneClear()
	enemyMinions:update()
		for i, minion in pairs(enemyMinions.objects) do
		local dmgE = getDmg("E", minion, myHero)
		local health = minion.health
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseQ then
					CastQ(minion)
					CastQ3(minion)
				end
				if Menu.laneclear.UseE and GetDistance(minion) <= SkillE.range and myHero:CanUseSpell(_E) == READY and health <= dmgE and not TargetDashed(unit) then
					CastSpell(_E, minion)
				end
		end
	end
end

function JungleClear()
	jungleMinions:update()
	for i, jungleMinion in pairs(jungleMinions.objects) do
		if jungleMinion ~= nil then
		if Menu.jungleclear.UseQ then CastQ(jungleMinion) CastQ3(jungleMinion) end
		if Menu.jungleclear.UseE and GetDistance(jungleMinion) <= SkillE.range and not TargetDashed(unit) then CastSpell(_E, jungleMinion) end
end
end
end

function CastQ(unit)
	if Menu.pred == 1 then
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, false)
 
		if HitChance >= 2 then
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
	elseif Menu.pred == 2 then
  local QPos, QHitChance = HPred:GetPredict(HP_Q, unit, myHero)
  
  if QHitChance > 0 then
    CastSpell(_Q, QPos.x, QPos.z)
  end
  end
 end

function CastQ3(unit)
	if Menu.pred == 1 then
	if unit ~= nil and GetDistance(unit) <= 1000 and myHero:CanUseSpell(_Q) == READY and myHero:GetSpellData(_Q).name == "yasuoq3w" then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, 1000, SkillQ.speed, myHero, false)
 
		if HitChance >= 2 then
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
	elseif Menu.pred == 2 then
  local QPos, QHitChance = HPred:GetPredict(HP_Q3, unit, myHero)
  
  if QHitChance > 0 then
    CastSpell(_Q, QPos.x, QPos.z)
  end
  end
 end
 
function OnDraw()
	if not myHero.dead and not Menu.drawing.mDraw then
	
		if myHero:GetSpellData(_Q).name == "yasuoq3w" and myHero:CanUseSpell(_Q) == READY and Menu.drawing.q3Draw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, 1000, RGB(Menu.drawing.q3Color[2], Menu.drawing.q3Color[3], Menu.drawing.q3Color[4]))
		end 
		
		if myHero:GetSpellData(_Q).name == "YasuoQW" and myHero:CanUseSpell(_Q) == READY and Menu.drawing.qDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillQ.range, RGB(Menu.drawing.qColor[2], Menu.drawing.qColor[3], Menu.drawing.qColor[4]))
		end
		
		if myHero:CanUseSpell(_E) == READY and Menu.drawing.eDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillE.range, RGB(Menu.drawing.eColor[2], Menu.drawing.eColor[3], Menu.drawing.eColor[4]))
		end
		
		if Menu.drawing.myHero then
			DrawCircle(myHero.x, myHero.y, myHero.z, 240, RGB(250, 6, 6))
		end

		if Target ~= nil and ValidTarget(Target) then
			if Menu.drawing.tText then
				DrawText3D("Current Target",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFF00)
			end
			end
end
end

function Skills()
	SkillQ = { name = "YasuoQ", range = 475, delay = 0.25, speed = math.huge, width = 40, ready = false }
	SkillE = { name = "", range = 475, delay = 0.25, speed = math.huge, width = 40, ready = false }
	SkillR = { name = "", range = 1200, delay = nil, speed = math.huge, width = 40, ready = false }
end
	
local priorityTable = {
 
    AP = {
        "Annie", "Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
        "Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
        "Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "MasterYi", "VelKoz", "Azir", "Ekko",
    },
    Support = {
        "Alistar", "Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Nunu", "Sona", "Soraka", "Taric", "Thresh", "Zilean", "Braum", "Bard", "TahmKench",
    },
 
    Tank = {
        "Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
        "Warwick", "Yorick", "Zac", "Illaoi", "RekSai",
    },
 
    AD_Carry = {
        "Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "KogMaw", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
        "Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "Lucian", "Jinx",
 
    },
 
    Bruiser = {
        "Aatrox", "Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
        "Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Gnar", "Kindred"
    },
 
}
 
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
                SetPriority(priorityTable.AP,       enemy, 2)
                SetPriority(priorityTable.Support,  enemy, 5)
                SetPriority(priorityTable.Bruiser,  enemy, 3)
                SetPriority(priorityTable.Tank,     enemy, 4)
        end
end
 
function PriorityOnLoad()
        if heroManager.iCount < 10 then
				PrintChat("<font color=\"#ccae00\"><b>HR Yasuo : </b></font>".."<font color=\"#00ae26\"><b>Too few champions to arrange priority.</b></font>")	
        else
                arrangePrioritys()
        end
end
	
function OnProcessSpell(object, spell)
	if Menu.wSettings.WtoBlock then
        if object.team ~= player.team and string.find(spell.name, "Basic") == nil then
            if Champions[object.charName] ~= nil then
                skillshot = Champions[object.charName].skillshots[spell.name]
                if  skillshot ~= nil and skillshot.blockable == true then
                    range = skillshot.range
                    if not spell.startPos then
                        spell.startPos.x = object.x
                        spell.startPos.z = object.z                        
                    end                    
                    if GetDistance(spell.startPos) <= range then
                        if GetDistance(spell.endPos) <= 475 then
                            if myHero:CanUseSpell(_W) == READY and Menu.wSettings.spells[spell.name] then 
                                DelayAction(function ()
                                    CastSpell(_W, object.x, object.z)
                                end, 0.5)
                            end
                        end
                    end
                end
            end
        end 
end
    if Interrupt[object.charName] ~= nil then
        spell = Interrupt[object.charName].stop[spell.name]
        if spell ~= nil then
            if Menu.qSettings.spells[spell.name] then
                if ValidTarget(unit) and GetDistance(object) < 1000 and myHero:CanUseSpell(_Q) and Menu.qSettings.UseQ then
                    CastQ3(unit)
                end
            end
        end
    end
end


function GenerateTables()
	
Champions = {
    ["Aatrox"] = {charName = "Aatrox", skillshots = {
        ["AatroxE"] = {spellKey = _E, name = "Blade of Torment", spellName = "AatroxE", spellDelay = 250, projectileName = "AatroxBladeofTorment_mis.troy", projectileSpeed = 1200, range = 1075, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["AatroxW"] = {spellKey = _W, spellName = "AatroxW", checkName = true, name = "AatroxW", isAutoBuff = true, range = 125, isSelfCast = true, noAnimation = true},
        ["AatroxQ"] = {name = "AatroxQ", spellName = "AatroxQ", spellDelay = 250, projectileName = "AatroxQ.troy", projectileSpeed = 450, range = 650, radius = 145, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["AatroxR"] = { spellKey = _R, isSelfCast = true, isAutoBuff = true, spellName = "AatroxR", name = "AatroxR", range = 125},
    }},
    ["Ahri"] = {charName = "Ahri", skillshots = {
        ["AhriOrbofDeception"] = {spellKey = _Q, name = "Orb of Deception", spellName = "AhriOrbofDeception", spellDelay = 250, projectileName = "Ahri_Orb_mis.troy", projectileSpeed = 1750, range = 800, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Orb of Deception Back"] = {name = "Orb of Deception Back", spellName = "AhriOrbofDeception!", spellDelay = 750, projectileName = "Ahri_Orb_mis_02.troy", projectileSpeed = 915, range = 800, radius = 100, type = "LINE"},
        ["AhriSeduce"] = {spellKey = _E, isTrueRange = true, isCollision = true, name = "Charm", spellName = "AhriSeduce", spellDelay = 250, projectileName = "Ahri_Charm_mis.troy", projectileSpeed = 1600, range = 1075, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["AhriFoxFire"] = { spellKey = _W, isSelfCast = true, spellName = "AhriFoxFire", name = "AhriFoxFire", range = 750, projectileSpeed = 1400},
    }},
    ["Alistar"] = {charName = "Alistar", skillshots = {
    --unfinished
        ["Headbutt"] = {spellKey = _W, isTargeted = true, name = "Headbutt", spellName = "Headbutt", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, type = "LINE"},
        ["Pulverize"] = {spellKey = _Q, isSelfCast = true, name = "Pulverize", spellName = "Pulverize", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 250, type = "CIRCULAR"},
    }},
    ["Amumu"] = {charName = "Amumu", skillshots = {
        ["BandageToss"] = {spellKey = _Q, isCollision = true, name = "Bandage Toss", spellName = "BandageToss", spellDelay = 250, projectileName = "Bandage_beam.troy", projectileSpeed = 2000, range = 1100, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Tantrum"] = {spellKey = _E, isSelfCast = true, name = "Tantrum", spellName = "Tantrum", spellDelay = 250, range = 200, type = "CIRCULAR"},
        ["AuraofDespair"] = { spellKey = _W, isSelfCast = true, heroHasNoBuff = "AuraofDespair", spellName = "AuraofDespair", name = "AuraofDespair", range = 300, },
    }},
    ["Anivia"] = {charName = "Anivia", skillshots = {
        ["FlashFrostSpell"] = {spellKey = _Q, name = "Flash Frost", spellName = "FlashFrostSpell", spellDelay = 250, projectileName = "cryo_FlashFrost_mis.troy", projectileSpeed = 850, range = 1100, radius = 110, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Frostbite"] = {spellKey = _E, isTargeted = true, targetHasBuff = "chilled", name = "Frostbite", spellName = "Frostbite", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Glacial Storm"] = {spellKey = _R, name = "Glacial Storm", spellName = "GlacialStorm", spellDelay = 250, projectileName = "Ahri_Orb_mis.troy", range = 615, radius = 400, type = "CIRCULAR"},
    }},
    ["Akali"] = {charName = "Akali", skillshots = {
    --unfinished
        ["AkaliQ"] = {spellKey = _Q, isTargeted = true, name = "AkaliQ", spellName = "AkaliQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Crescent Slash"] = {spellKey = _E, isSelfCast = true, name = "Crescent Slash", spellName = "CrescentSlash", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 325, type = "CIRCULAR"},
        ["Shadow Dance"] = {spellKey = _R, isTargeted = true, name = "Shadow Dance", spellName = "Shadow Dance", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 800, type = "LINE"},
    }},
    ["Ashe"] = {charName = "Ashe", skillshots = {
        ["EnchantedCrystalArrow"] = { name = "Enchanted Arrow", spellName = "EnchantedCrystalArrow", spellDelay = 250, projectileName = "EnchantedCrystalArrow_mis.troy", projectileSpeed = 1600, range = 25000, radius = 130, type = "LINE", fuckedup = false, blockable = true, danger = 1},
        ["Volley"] = {spellKey = _W, isTrueRange = true, name = "Volley", spellName = "Volley", spellDelay = 250, range = 1200, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["FrostShot"] = { spellKey = _Q, isSelfCast = true, isAutoBuff = true, heroHasNoBuff = "FrostShot", noAnimation = true, spellName = "FrostShot", name = "FrostShot", range = 600, projectileName = "IceArrow_mis.troy",},
    }},
    ["Annie"] = {charName = "Annie", skillshots = {
    --unfinished
        ["Disintegrate"] = {spellKey = _Q, isTargeted = true, name = "Disintegrate", spellName = "Disintegrate", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["MoltenShield"] = { spellKey = _E, isSelfCast = true, spellName = "MoltenShield", name = "MoltenShield", range = math.huge, },
        ["Incinerate"] = {spellKey = _W, isTrueRange = true, name = "Incinerate", spellName = "Incinerate", spellDelay = 500, projectileName = "Thresh_Q_whip_beam.troy", range = 625, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["InfernalGuardian"] = { spellKey = _R, type = "CIRCULAR", checkName = true, spellName = "InfernalGuardian", name = "InfernalGuardian", range = 600, radius = 290},
    }},
    ["Blitzcrank"] = {charName = "Blitzcrank", skillshots = {
        ["RocketGrabMissile"] = {spellKey = _Q, isCollision = true, isTrueRange = true, name = "Rocket Grab", spellName = "RocketGrabMissile", spellDelay = 250, projectileName = "FistGrab_mis.troy", projectileSpeed = 1800, range = 1050, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Power Fist"] = {spellKey = _E, isSelfCast = true, targetHasBuff = "rocketgrab2", name = "Power Fist", spellName = "PowerFist", spellDelay = 250, range = math.huge,},
        ["Static Field"] = {spellKey = _R, isSelfCast = true, name = "Static Field", spellName = "StaticField", spellDelay = 250, range = 550, type = "CIRCULAR"},
    }},
    ["Brand"] = {charName = "Brand", skillshots = {
        ["BrandBlaze"] = {spellKey = _Q, isCollision = true, name = "BrandBlaze", spellName = "BrandBlaze", spellDelay = 250, projectileName = "BrandBlaze_mis.troy", projectileSpeed = 1600, range = 900, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Pillar of Flame"] = {spellKey = _W, name = "Pillar of Flame", spellName = "BrandFissure", spellDelay = 875, projectileName = "BrandPOF_tar_green.troy", range = 900, radius = 240, type = "CIRCULAR"},
        ["BrandWildfire"] = {name = "BrandWildfire", spellName = "BrandWildfire", castDelay = 250, projectileName = "BrandWildfire_mis.troy", projectileSpeed = 1000, range = 1100, radius = 250, type = "circular", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Caitlyn"] = {charName = "Caitlyn", skillshots = {
        ["CaitlynPiltoverPeacemaker"] = {spellKey = _Q, name = "Piltover Peacemaker", spellName = "CaitlynPiltoverPeacemaker", spellDelay = 625, projectileName = "caitlyn_Q_mis.troy", projectileSpeed = 2200, range = 1300, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Caitlyn Entrapment"] = {name = "Caitlyn Entrapment", spellName = "CaitlynEntrapment", spellDelay = 150, projectileName = "caitlyn_entrapment_mis.troy", projectileSpeed = 2000, range = 950, radius = 80, type = "LINE"},
        ["CaitlynHeadshotMissile"] = {name = "Ace in the Hole", spellName = "CaitlynHeadshotMissile", range = 3000, fuckedup = false, blockable = true, danger = 1, projectileName = "caitlyn_ult_mis.troy"},
    }},
    ["Cassiopeia"] = {charName = "Cassiopeia", skillshots = {
        ["Noxious Blast"] = {spellKey = _Q, name = "Noxious Blast", spellName = "Noxious Blast", spellDelay = 600, range = 850, radius = 75, type = "CIRCULAR"},
        ["CassiopeiaTwinFang"] = {spellKey = _E, isTargeted = true, targetHasBuff = "poison", name = "Twin Fang", spellName = "CassiopeiaTwinFang", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", projectileSpeed = 1800,  range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Chogath"] = {charName = "Chogath", skillshots = {
        ["Rupture"] = {spellKey = _Q, name = "Rupture", spellName = "Rupture", spellDelay = 875, projectileName = "rupture_cas_01_red_team.troy", range = 950, radius = 125, type = "CIRCULAR"},
        ["Feast"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "Feast", name = "Feast", range = 150, },
--["Rupture"] = { spellKey = _Q, castType = 0, spellName = "Rupture", name = "Rupture", range = 950, projectileName = "AnnieBasicAttack_mis.troy",},
--["VorpalSpikes"] = { spellKey = _E, castType = 0, spellName = "VorpalSpikes", name = "VorpalSpikes", range = 40, projectileName = "TristanaBasicAttack_mis.troy", radius = 170,},
        ["FeralScream"] = { spellKey = _W, type = "LINE", spellName = "FeralScream", name = "FeralScream", range = 700, radius = 200 },

    }},
    ["Corki"] = {charName = "Corki", skillshots = {
        ["PhosphorusBomb"] = {spellKey = _Q, name = "Phosphorus Bomb", spellName = "PhosphorusBomb", spellDelay = 750, spellAnimationDelay = 250, projectileName = "LayWaste_point.troy", range = 825, radius = 250, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["GGun"] = { spellKey = _E, type = "LINE", spellName = "GGun", name = "GGun", range = 600, radius = 200, noAnimation = true,},
        ["Missile Barrage"] = {spellKey = _R, isCollision = true, heroHasBuff = "corkimissilebarragenc", isTrueRange = true, name = "Missile Barrage", spellName = "MissileBarrage", spellDelay = 250, projectileName = "corki_MissleBarrage_mis.troy", projectileSpeed = 2000, range = 1300, radius = 40, type = "LINE"},
        ["MissileBarrageBig"] = {spellKey = _R, isCollision = true, name = "Missile Barrage big", heroHasBuff = "mbcheck2", spellName = "MissileBarrageBig", spellDelay = 250, projectileName = "Corki_MissleBarrage_DD_mis.troy", projectileSpeed = 2000, range = 1600, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Darius"] = {charName = "Darius", skillshots = {
    --unfinished
        ["Noxian Guillotine"] = {spellKey = _R, isTargeted = true, isExecute = true, name = "Noxian Guillotine", spellName = "NoxianGuillotine", spellDelay = 250, range = 460, type = "LINE"},
        ["Crippling Strike"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, name = "Crippling Strike", spellName = "Crippling Strike", spellDelay = 250, range = 125, type = "CIRCULAR"},
        ["DariusAxeGrabCone"] = {spellKey = _E, isTrueRange = true, name = "Apprehend", spellName = "DariusAxeGrabCone", spellDelay = 320, range = 570, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["DariusCleave"] = {spellKey = _Q, isSelfCast = true, name = "Decimate", spellName = "DariusCleave", spellDelay = 230, range = 425, type = "CIRCULAR"},
    }},
    ["Diana"] = {charName = "Diana", skillshots = {
        --["Diana Arc"] = {spellKey = _Q, name = "DianaArc", spellName = "DianaArc", spellDelay = 250, projectileName = "Diana_Q_trail.troy", projectileSpeed = 1600, range = 830, radius = 100, type = "CIRCULAR"},
        ["DianaArc"] = {spellKey = _Q, name = "DianaArc", spellName = "DianaArc", spellDelay = 250, projectileName = "Diana_Q_trail.troy", range = 830, radius = 200, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Pale Cascade"] = {spellKey = _W, isSelfCast = true, isShield = true, name = "Pale Cascade", spellName = "PaleCascade", spellDelay = 230, range = 200, type = "CIRCULAR", noAnimation = true,
            damage = function () return 25 + myHero.ap * .3 + 15 * myHero:GetSpellData(_W).level end},
        ["Lunar Rush"] = {spellKey = _R, isTargeted = true, name = "Lunar Rush", spellName = "LunarRush", spellDelay = 250, range = 825, type = "LINE"},
    }},
    ["Draven"] = {charName = "Draven", skillshots = {
        ["DravenFury"] = { spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, spellName = "DravenFury", name = "DravenFury", range = 550, },
        ["DravenSpinning"] = { spellKey = _Q, isSelfCast = true, isAutoBuff = true, noAnimation = true, spellName = "DravenSpinning", name = "DravenSpinning", range = 550, },
        ["DravenDoubleShot"] = {spellKey = _E, name = "Stand Aside", spellName = "DravenDoubleShot", spellDelay = 250, projectileName = "Draven_E_mis.troy", projectileSpeed = 1400, range = 1100, radius = 130, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["DravenRCast"] = {spellKey = _R, isExecute = true, name = "DravenR", spellName = "DravenRCast", spellDelay = 500, projectileName = "Draven_R_mis!.troy", projectileSpeed = 2000, range = 25000, radius = 160, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Elise"] = {charName = "Elise", skillshots = {
        ["EliseHumanE"] = {spellKey = _E, isCollision = true, name = "Cocoon", checkName = true, spellName = "EliseHumanE", spellDelay = 250, projectileName = "Elise_human_E_mis.troy", projectileSpeed = 1450, range = 1100, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EliseHumanQ"] = {spellKey = _Q, isTargeted = true, checkName = true, name = "Neurotoxin", spellName = "EliseHumanQ", spellDelay = 250, range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1, fuckedUp = false, blockable = true, danger = 1},
        ["Venomous Bite"] = {spellKey = _Q, isTargeted = true, checkName = true, name = "Venomous Bite", spellName = "EliseSpiderQCast", spellDelay = 250, range = 475, type = "LINE"},
        ["Skittering Frenzy"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Skittering Frenzy", spellName = "EliseSpiderW", spellDelay = 250, range = 300, type = "CIRCULAR"},
        ["EliseHumanW"] = {spellKey = _W, isCollision = true, name = "Volatile Spiderling", checkName = true, spellName = "EliseHumanW", spellDelay = 250, projectileName = "Elise_human_E_mis.troy", projectileSpeed = 1450, range = 950, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        
    }},
    ["Ezreal"] = {charName = "Ezreal", skillshots = {
        ["EzrealMysticShot"]             = {spellKey = _Q, isCollision = true, name = "Mystic Shot",      spellName = "EzrealMysticShot", spellDelay = 250, projectileName = "Ezreal_mysticshot_mis.troy",  projectileSpeed = 2000, range = 1100, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EzrealEssenceFlux"]            = {spellKey = _W, name = "Essence Flux",     spellName = "EzrealEssenceFlux",     spellDelay = 250, projectileName = "Ezreal_essenceflux_mis.troy", projectileSpeed = 1500, range = 900,  radius = 80,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EzrealMysticShotPulse"] = {name = "Mystic ShotPulse(E)",      spellName = "EzrealMysticShotPulse", spellDelay = 250, projectileName = "Ezreal_mysticshot_mis.troy",  projectileSpeed = 2000, range = 1200,  radius = 80,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["EzrealTrueshotBarrage"]        = {spellKey = _R, isExecute = true, name = "Trueshot Barrage", spellName = "EzrealTrueshotBarrage", spellDelay = 1000, projectileName = "Ezreal_TrueShot_mis.troy", projectileSpeed = 2000, range = 20000, radius = 160, type = "LINE", fuckedup = false, blockable = true, danger = 1},
    }},
    ["Evelynn"] = {charName = "Evelynn", skillshots = {
    --unfinished
        ["Ravage"] = {spellKey = _E, isTargeted = true, name = "Ravage", spellName = "Ravage", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 225, type = "LINE"},
        ["Dark Frenzy"] = {spellKey = _W, isSelfCast = true, name = "Dark Frenzy", spellName = "DarkFrenzy", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "LINE"},
        ["Hate Spike"] = {spellKey = _Q, isSelfCast = true, name = "Hate Spike", spellName = "HateSpike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "LINE"},
    }},
    
    ["Heimerdinger"] = {charName = "Heimerdinger", skillshots = {
        ["HextechMicroRockets"]   = {spellKey = _W, isCollision = true, name = "Hextech Micro-Rockets",      spellName = "HextechMicroRockets", spellDelay = 250, projectileName = "Ezreal_mysticshot_mis.troy",  projectileSpeed = 1200, range = 1100, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["CH-2ElectronStormGrenade"]    = {spellKey = _E, name = "CH-2 Electron Storm Grenade",     spellName = "CH-2ElectronStormGrenade",     spellDelay = 250, projectileName = "Ezreal_essenceflux_mis.troy", projectileSpeed = 1750, range = 925,  radius = 80,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["FiddleSticks"] = {charName = "FiddleSticks", skillshots = {
        ["DarkWind"] = {spellKey = _E, isTargeted = true, name = "Dark Wind", spellName = "DarkWind", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 750, projectileSpeed = 1500, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Fiora"] = {charName = "Fiora", skillshots = {
        ["FioraQ"] = { spellKey = _Q, isTargeted = true, spellName = "FioraQ", name = "FioraQ", range = 600,},
        ["FioraFlurry"] = { spellKey = _E, isSelfCast = true, isAutoBuff = true, noAnimation = true, spellName = "FioraFlurry", name = "FioraFlurry", range = 500, projectileSpeed = 0, projectileName = "AnnieBasicAttack_mis.troy",},
        ["FioraDance"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "FioraDance", name = "FioraDance", range = 400, },
        --["FioraRiposte"] = { spellKey = _W, castType = 0, spellName = "FioraRiposte", name = "FioraRiposte", range = 20, projectileSpeed = 0, projectileName = "AnnieBasicAttack_mis.troy",},
    }},
    ["Fizz"] = {charName = "Fizz", skillshots = {
        ["Leap Strike"] = {spellKey = _Q, isTargeted = true, name = "Leap Strike", spellName = "LeapStrike", spellDelay = 250, range = 700,},
        ["Seastone Trident"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Seastone Trident", spellName = "SeastoneTrident", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "CIRCULAR"},
        --["Fizz Ultimate"] = {name = "Fizz ULT", spellName = "FizzMarinerDoom", spellDelay = 250, projectileName = "Fizz_UltimateMissile.troy", projectileSpeed = 1350, range = 1275, radius = 80, type = "LINE"},
        ["FizzMarinerDoom"] = {name = "Fizz ULT", spellName = "FizzMarinerDoom", castDelay = 250, projectileName = "Fizz_UltimateMissile.troy", projectileSpeed = 1350, range = 1275, radius = 80, type = "line", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Galio"] = {charName = "Galio", skillshots = {
        ["GalioResoluteSmite"] =  { spellKey = _Q, name = "GalioResoluteSmite", spellName = "GalioResoluteSmite", spellDelay = 250, projectileName = "galio_concussiveBlast_mis.troy", projectileSpeed = 850, range = 2000, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["GalioRighteousGust"] = { spellKey = _E, type = "LINE", spellName = "GalioRighteousGust", name = "GalioRighteousGust", range = 1180, projectileSpeed = 1200, radius = 120,},
        ["GalioBulwark"] = { spellKey = _W, isTargeted = true, isShield = true, spellName = "GalioBulwark", name = "GalioBulwark", range = 800, },
        ["GalioIdolOfDurand"] = { spellKey = _R, isSelfCast = true, channelDuration = 2000, spellName = "GalioIdolOfDurand", name = "GalioIdolOfDurand", range = 600, },
    }},
    ["Gangplank"] = {charName = "Gangplank", skillshots = {
        ["RaiseMorale"] = { spellKey = _E, isSelfCast = true, isAutoBuff = true, spellName = "RaiseMorale", name = "RaiseMorale", range = 125, projectileName = "pirate_raiseMorale_mis.troy",},
        --["CannonBarrage"] = { spellKey = _R, castType = 0, spellName = "CannonBarrage", name = "CannonBarrage", range = 20000, projectileName = "missing_instant.troy",},
        ["Parley"] = { spellKey = _Q, isTargeted = true, spellName = "Parley", name = "Parley", range = 625, projectileName = "pirate_parley_mis.troy",},
        --["RemoveScurvy"] = { spellKey = _W, castType = 0, spellName = "RemoveScurvy", name = "RemoveScurvy", range = 20,},
    }},
    ["Gragas"] = {charName = "Gragas", skillshots = {
        ["GragasBarrelRoll"] = {spellKey = _Q, name = "Barrel Roll", spellName = "GragasBarrelRoll", spellDelay = 250, projectileName = "gragas_barrelroll_mis.troy", projectileSpeed = 1000, range = 950, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Barrel Roll Missile"] = {name = "Barrel Roll Missile", spellName = "GragasBarrelRollMissile", spellDelay = 0, projectileName = "gragas_barrelroll_mis.troy", projectileSpeed = 1000, range = 1115, radius = 180, type = "CIRCULAR"},
    }},
    --edit
    ["Graves"] = {charName = "Graves", skillshots = {
        ["GravesClusterShot"] = {spellKey = _Q, name = "Buckshot", spellName = "GravesClusterShot", spellDelay = 250, projectileName = "Graves_ClusterShot_mis.troy", projectileSpeed = 1750, range = 900, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["SmokeScreen"] = {spellKey = _W, name = "Smoke Screen", spellName = "SmokeScreen", spellDelay = 250, projectileName = "Graves_SmokeGrenade_mis.troy", projectileSpeed = 1500, range = 950, radius = 300, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["GravesChargeShot"] = {spellKey = _R, isExecute = true, name = "Collateral Damage", spellName = "GravesChargeShot", spellDelay = 250, projectileName = "Graves_ChargedShot_mis.troy", projectileSpeed = 1500, range = 1000, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Irelia"] = {charName = "Irelia", skillshots = {
        ["IreliaGatotsu"] = { spellKey = _Q, isTargeted = true, spellName = "IreliaGatotsu", name = "IreliaGatotsu", range = 650,},
        ["IreliaEquilibriumStrike"] = { spellKey = _E, isTargeted = true, spellName = "IreliaEquilibriumStrike", name = "IreliaEquilibriumStrike", range = 425,
            castReq = function (target) return myHero.health < target.health end},
        ["IreliaTranscendentBlades"] = { spellKey = _R, type = "LINE", spellName = "IreliaTranscendentBlades", name = "IreliaTranscendentBlades", range = 1200, projectileSpeed = 1600, projectileName = "Irelia_ult_dagger_mis.troy", radius = 120, fuckedUp = false, blockable = true, danger = 1},
        ["IreliaHitenStyle"] = { spellKey = _W, isSelfCast = true, noAnimation = true, spellName = "IreliaHitenStyle", name = "IreliaHitenStyle", range = math.huge,},
    }},
    ["Janna"] = {charName = "Janna", skillshots = {
        ["HowlingGale"] = { spellKey = _Q, type = "LINE", spellName = "HowlingGale", name = "HowlingGale", range = 1100, projectileName = "HowlingGale_mis.troy", radius = 150, fuckedUp = false, blockable = true, danger = 1},
        ["Zephyr"] = {spellKey = _W, isTargeted = true, name = "Zephyr", spellName = "Zephyr", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, projectileSpeed = 1500, type = "LINE"},
        ["Eye Of The Storm"] = {spellKey = _E, isTargeted = true, isShield = true, name = "Eye Of The Storm", spellName = "EyeOfTheStorm", spellDelay = 250, range = 800, type = "CIRCULAR",
            damage = function () return 40 + 40 * myHero:GetSpellData(_E).level + myHero.ap * .7 end
            },
    }},
    ["Jax"] = {charName = "Jax", skillshots = {
    --unfinished
        ["Leap Strike"] = {spellKey = _Q, isTargeted = true, name = "Leap Strike", spellName = "LeapStrike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["Empower"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, name = "Empower", spellName = "Empower", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
    }},
    ["Jayce"] = {charName = "Jayce", skillshots = {
        ["JayceToTheSkies"] = {spellKey = _Q, isTargeted = true, checkName = true, name = "JayceQ", spellName = "JayceToTheSkies", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Thundering Blow"] = {spellKey = _E, isTargeted = true, checkName = true, name = "Thundering Blow", spellName = "JayceThunderingBlow", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 240, type = "LINE"},
        ["Hyper Charge"] = {spellKey = _W, isSelfCast = true, checkName = true, isAutoReset = true, name = "Hyper Charge", spellName = "jaycehypercharge", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "CIRCULAR"},
        ["JayceStaticField"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Lightning Field", spellName = "JayceStaticField", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 285, type = "CIRCULAR"},
        ["jayceshockblast"] = {spellKey = _Q, isCollision = true, checkName = true, name = "JayceShockBlast", spellName = "jayceshockblast", spellDelay = 250, projectileName = "JayceOrbLightning.troy", projectileSpeed = 1450, range = 1050, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["JayceShockBlastCharged"] = {name = "JayceShockBlastCharged", spellName = "JayceShockBlast", spellDelay = 250, projectileName = "JayceOrbLightningCharged.troy", projectileSpeed = 2350, range = 1600, radius = 70, type = "LINE"},
    }},
    ["Jinx"] = {charName = "Jinx", skillshots = {
        ["JinxWMissile"] =  {spellKey = _W, isCollision = true, name = "Zap", spellName = "JinxWMissile", spellDelay = 600, projectileName = "Jinx_W_mis.troy", projectileSpeed = 3300, range = 1450, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["JinxRWrapper"] =  {name = "Super Mega Death Rocket", spellName = "JinxRWrapper", spellDelay = 600, projectileName = "Jinx_R_Mis.troy", projectileSpeed = 2200, range = 20000, radius = 120, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }}, 
    ["Karthus"] = {charName = "Karthus", skillshots = {
        ["Lay Waste"] = {spellKey = _Q, name = "Lay Waste", spellName = "LayWaste", spellDelay = 750, spellAnimationDelay = 250, projectileName = "LayWaste_point.troy", range = 875, radius = 50, type = "CIRCULAR"},
    }},
    ["Karma"] = {charName = "Karma", skillshots = {
    --unfinished
        ["Focused Resolve"] = {spellKey = _W, isTargeted = true, name = "Focused Resolve", spellName = "FocusedResolve", spellDelay = 250, range = 650, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE"},
        ["Mantra"] = {spellKey = _R, isSelfCast = true, name = "Mantra", spellName = "Mantra", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 950, type = "CIRCULAR"},
        ["KarmaQ"] = {spellKey = _Q, isCollision = true, name = "KarmaQ", spellName = "KarmaQ", spellDelay = 250, projectileName = "TEMP_KarmaQMis.troy", projectileSpeed = 1700, range = 950, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["KarmaSolKimShield"] = { spellKey = _E, isTargeted = true, isShield = true, spellName = "KarmaSolKimShield", name = "KarmaSolKimShield", range = 800, noAnimation = true,
            damage = function () return 40 + myHero.ap * .5 + 40 * myHero:GetSpellData(_E).level end},
    }},
    ["Kassadin"] = {charName = "Kassadin", skillshots = {
    --unfinished
        ["NullSphere"] = {spellKey = _Q, isTargeted = true, name = "Null Sphere", spellName = "NullSphere", spellDelay = 250, range = 650, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Nether Blade"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, isAutoBuff = true, noAnimation = true, name = "Nether Blade", spellName = "NetherBlade", spellDelay = 250, range = 250, type = "CIRCULAR"},
        ["Force Pulse"] = {spellKey = _E, isTrueRange = true, name = "Force Pulse", spellName = "ForcePulse", spellDelay = 250, range = 700, radius = 200, type = "LINE"},
    }},
    
    ["Katarina"] = {charName = "Katarina", skillshots = {
        ["KatarinaE"] = { spellKey = _E, isTargeted = true, spellName = "KatarinaE", name = "KatarinaE", range = 700, projectileSpeed = 0, projectileName = "AnnieBasicAttack_mis.troy",},
        ["KatarinaW"] = { spellKey = _W, isSelfCast = true, spellName = "KatarinaW", name = "KatarinaW", range = 375, projectileSpeed = 1400, projectileName = "Disintegrate_mis.troy",},
        ["KatarinaR"] = { spellKey = _R, isSelfCast = true, channelDuration = 2500, spellName = "KatarinaR", name = "KatarinaR", range = 550, projectileName = "katarina_deathLotus_mis.troy", fuckedup = false, blockable = true, danger = 1},
        ["KatarinaQ"] = { spellKey = _Q, isTargeted = true, spellName = "KatarinaQ", name = "KatarinaQ", range = 675, projectileSpeed = 1100, projectileName = "katarina_bouncingBlades_mis.troy", fuckedUp = false, blockable = true, danger = 1},
    }}, 
    ["Kayle"] = {charName = "Kayle", skillshots = {
    --unfinished
        ["Reckoning"] = {spellKey = _Q, isTargeted = true, name = "Reckoning", spellName = "Reckoning", spellDelay = 250, range = 650, fuckedUp = false, blockable = true, danger = 1},
        ["DivineBlessing"] = {spellKey = _W, isTargeted = true, isHeal = true, name = "Divine Blessing", spellName = "DivineBlessing", spellDelay = 250, range = 900, type = "LINE"},
        ["Righteous Fury"] = {spellKey = _E, isSelfCast = true, noAnimation = true, name = "Righteous Fury", spellName = "RighteousFury", spellDelay = 250, range = 650},
        ["JudicatorIntervention"] = { spellKey = _R, isTargeted = true, isShield = true, isUntargetable = true, spellName = "JudicatorIntervention", name = "JudicatorIntervention", range = 900,},
    }},
    ["Kennen"] = {charName = "Kennen", skillshots = {
        ["KennenShurikenHurlMissile1"] = {spellKey = _Q, isCollision = true, name = "Thundering Shuriken", spellName = "KennenShurikenHurlMissile1", spellDelay = 180, projectileName = "kennen_ts_mis.troy", projectileSpeed = 1700, range = 1050, radius = 50, type = "LINE", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Khazix"] = {charName = "Khazix", skillshots = {
        ["KhazixQ"] = {spellKey = _Q, isTargeted = true, name = "KhazixQ", spellName = "KhazixQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 375, type = "LINE"},
        ["KhazixW"] = {spellKey = _W, isCollision = true, name = "KhazixW", spellName = "KhazixW", spellDelay = 250, projectileName = "Khazix_W_mis_enhanced.troy", projectileSpeed = 1700, range = 1000, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["khazixwlong"] = {name = "khazixwlong", spellName = "khazixwlong", spellDelay = 250, projectileName = "Khazix_W_mis_enhanced.troy", projectileSpeed = 1700, range = 1025, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["KogMaw"] = {charName = "KogMaw", skillshots = {
        ["CausticSpittle"] = {spellKey = _Q, isTargeted = true, name = "Caustic Spittle", spellName = "CausticSpittle", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Bio-Arcane Barrage"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, name = "Bio-Arcane Barrage", spellName = "BioArcaneBarrage", spellDelay = 250, range = 600, type = "CIRCULAR"},
        ["KogMawVoidOozeMissile"] = {spellKey = _E, name = "Void Ooze", spellName = "KogMawVoidOozeMissile", spellDelay = 250, projectileName = "KogMawVoidOoze_mis.troy", projectileSpeed = 1450, range = 1200, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Living Artillery"] = {spellKey = _R, name = "Living Artillery", spellName = "KogMawLivingArtillery", spellDelay = 850, projectileName = "KogMawLivingArtillery_mis.troy", range = 2200, radius = 100, type = "CIRCULAR"}
    }},
    ["Leblanc"] = {charName = "Leblanc", skillshots = {
        --unfinished
        ["SigilQ"] = {spellKey = _Q, isTargeted = true, name = "Sigil of Silence", spellName = "SigilQ", spellDelay = 250, projectileName = "non.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LeblancChaosOrbM"] = {spellKey = _R, isTargeted = true, checkName = true, name = "Sigil of Silence R", spellName = "LeblancChaosOrbM", spellDelay = 250, projectileName = "non.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LeblancSoulShackle"] = {spellKey = _E, isCollision = true, name = "Ethereal Chains", spellName = "LeblancSoulShackle", spellDelay = 250, projectileName = "leBlanc_shackle_mis.troy", projectileSpeed = 1600, range = 960, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LeblancSoulShackleM"] = {name = "Ethereal Chains R", spellName = "LeblancSoulShackleM", spellDelay = 250, projectileName = "leBlanc_shackle_mis_ult.troy", projectileSpeed = 1600, range = 960, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["LeeSin"] = {charName = "LeeSin", skillshots = {
        ["BlindMonkQOne"] = {spellKey = _Q, isCollision = true, checkName = true, name = "Sonic Wave", spellName = "BlindMonkQOne", spellDelay = 250, projectileName = "blindMonk_Q_mis_01.troy", projectileSpeed = 1800, range = 975, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["blindmonkqtwo"] = {spellKey = _Q, checkName = true, isSelfCast = true, name = "Sonic Wave2", spellName = "blindmonkqtwo", spellDelay = 250, range = 975, radius = 70, type = "LINE"},
        ["BlindMonkEOne"] = { spellKey = _E, isSelfCast = true, spellName = "BlindMonkEOne", name = "BlindMonkEOne", range = 350, },        
        ["BlindMonkRKick"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "BlindMonkRKick", name = "BlindMonkRKick", range = 375, projectileSpeed = 1500,},
    }},
    ["Leona"] = {charName = "Leona", skillshots = {
        ["LeonaShieldOfDaybreakAttack"] = {spellKey = _Q, isTargeted = true, isAutoReset = true, name = "Shield of Daybreak", spellName = "LeonaShieldOfDaybreakAttack", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["LeonaSolarBarrier"] = { spellKey = _W, isSelfCast = true, spellName = "LeonaSolarBarrier", name = "LeonaSolarBarrier", range = 275, },
        ["Zenith Blade"] = {spellKey = _E, name = "Zenith Blade", spellName = "LeonaZenithBlade", spellDelay = 250, projectileName = "Leona_ZenithBlade_mis.troy", projectileSpeed = 2000, range = 900, radius = 80, type = "LINE"},
        ["Leona Solar Flare"] = {spellKey = _R, name = "Leona Solar Flare", spellName = "LeonaSolarFlare", spellDelay = 250, projectileName = "Leona_SolarFlare_cas.troy", projectileSpeed = 2000, range = 1200, radius = 300, type = "CIRCULAR"}
    }},
    ["Lissandra"] = {charName = "Lissandra", skillshots = {
        ["LissandraW"] = { spellKey = _W, isSelfCast = true, isRoot = true, spellName = "LissandraW", name = "LissandraW", range = 450, },
        ["LissandraR"] = { spellKey = _R, isTargeted = true, isStun = true, spellName = "LissandraR", name = "LissandraR", range = 550, },
        --find projectile speed
        ["LissandraQ"] = { spellKey = _Q, type = "LINE", spellName = "LissandraQ", name = "LissandraQ", projectileName = "Lissandra_Q_Shards.troy", projectileSpeed = 1400, range = 725, radius = 75, fuckedUp = false, blockable = true, danger = 1},
        --["LissandraE"] = { spellKey = _E, castType = 0, spellName = "LissandraE", name = "LissandraE", range = 25000, projectileSpeed = 850, projectileName = "Lissandra_E_Missile.troy", radius = 110,},
        ["LissandraE"] = {name = "LissandraE", spellName = "LissandraE", castDelay = 250, projectileName = "Lissandra_E_Missle.troy", projectileSpeed = 850, range = 1500, radius = 140, fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Lucian"] = {charName = "Lucian", skillshots = {
        ["LucianQ"] =  {spellKey = _Q, name = "LucianQ", isTargeted = true, spellName = "LucianQ", spellDelay = 350, projectileName = "Lucian_Q_laser.troy", range = 570, radius = 65, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LucianW"] =  {spellKey = _W, name = "LucianW", spellName = "LucianW", spellDelay = 300, projectileName = "Lucian_W_mis.troy", projectileSpeed = 1600, range = 1000, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Lulu"] = {charName = "Lulu", skillshots = {
        ["LuluQ"] = {spellKey = _Q, name = "LuluQ", spellName = "LuluQ", spellDelay = 250, projectileName = "Lulu_Q_Mis.troy", projectileSpeed = 1450, range = 1000, radius = 50, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LuluW"] = { spellKey = _W, isTargeted = true, isStun = true, spellName = "LuluW", name = "LuluW", range = 650, },
        ["LuluE"] = { spellKey = _E, isTargeted = true, isShield = true, spellName = "LuluE", name = "LuluE", range = 650,
            damage = function () return 40 + 40 * myHero:GetSpellData(_E).level + myHero.ap * .6 end,},
        ["LuluR"] = { spellKey = _R, isTargeted = true, isShield = true, spellName = "LuluR", name = "LuluR", range = 900,
            damage = function () return 150 + 150 * myHero:GetSpellData(_W).level + myHero.ap * .5 end,},
    }},
    ["Lux"] = {charName = "Lux", skillshots = {
        ["LuxLightBinding"] =  {spellKey = _Q, isCollision = true, name = "Light Binding", spellName = "LuxLightBinding", spellDelay = 250, projectileName = "LuxLightBinding_mis.troy", projectileSpeed = 1200, range = 1175, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LuxLightStrikeKugel"] = {spellKey = _W, name = "LuxLightStrikeKugel", spellName = "LuxLightStrikeKugel", spellDelay = 250, projectileName = "LuxLightstrike_mis.troy", projectileSpeed = 1400, range = 1100, radius = 275, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["LuxMaliceCannon"] =  {spellKey = _R, isExecute = true, name = "Lux Malice Cannon", spellName = "LuxMaliceCannon", spellDelay = 950, projectileName = "Enrageweapon_buf_02.troy", range = 3500, radius = 190, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        --["LuxPrismaticWave"] = { spellKey = _W, castType = 0, spellName = "LuxPrismaticWave", name = "LuxPrismaticWave", range = 10000, radius = 150,},
    }},
    ["MasterYi"] = {charName = "Master Yi", skillshots = {
    --unfinished
        ["Alpha Strike"] = {spellKey = _Q, isTargeted = true, isUntargetable = true, name = "Alpha Strike", spellName = "AlphaStrike", spellDelay = 250, range = 600,},
        ["Wuju Style"] = {spellKey = _E, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Wuju Style", spellName = "WujuStyle", },
        ["Meditate"] = { spellKey = _W, isSelfCast = true, isAutoReset = true, spellName = "Meditate", name = "Meditate", range = 200, },
    }},
    ["Malzahar"] = {charName = "Malzahar", skillshots = {
        ["Null Zone"] = {spellKey = _W, name = "Null Zone", spellName = "NullZone", spellDelay = 600, range = 800, radius = 250, type = "CIRCULAR"},
        ["Malefic Visions"] = {spellKey = _E, isTargeted = true, name = "Malefic Visions", spellName = "MaleficVisions", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, type = "LINE"},
        ["Nether Grasp"] = {spellKey = _R, isTargeted = true, channelDuration = 2500, name = "Nether Grasp", spellName = "NetherGrasp", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE"},
    }},
    ["Malphite"] = {charName = "Malphite", skillshots = {
        ["SeismicShard"] = {spellKey = _Q, isTargeted = true, name = "Seismic Shard", spellName = "SeismicShard", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Ground Slam"] = {spellKey = _E, isSelfCast = true, name = "Ground Slam", spellName = "GroundSlam", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 200, type = "CIRCULAR"},
        ["Brutal Strikes"] = {spellKey = _W, isSelfCast = true, noAnimation = true, isAutoBuff = true, name = "Brutal Strikes", spellName = "BrutalStrikes", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 200, type = "CIRCULAR"},
        ["UFSlash"] = {name = "UFSlash", spellName = "UFSlash", spellDelay = 250, projectileName = "TEST", projectileSpeed = 1800, range = 1000, radius = 160, type = "LINE"},    
    }},
    ["Maokai"] = {charName = "Maokai", skillshots = {
        ["MaokaiUnstableGrowth"] = { spellKey = _W, isTargeted = true, spellName = "MaokaiUnstableGrowth", name = "MaokaiUnstableGrowth", range = 650, },
        ["MaokaiTrunkLine"] = { spellKey = _Q, type = "LINE", spellName = "MaokaiTrunkLine", name = "MaokaiTrunkLine", range = 600, projectileSpeed = 1200, radius = 110, fuckedUp = false, blockable = true, danger = 1},
        ["MaokaiDrain3"] = { spellKey = _R, type = "CIRCULAR", spellName = "MaokaiDrain3", name = "MaokaiDrain3", range = 625, radius = 575,},
        ["MaokaiSapling2"] = { spellKey = _E, type = "LINE", spellName = "MaokaiSapling2", name = "MaokaiSapling2", range = 1100, projectileSpeed = 1750, projectileName = "Maokai_sapling_mis.troy", radius = 175},
    }},
    ["Mordekaiser"] = {charName = "Mordekaiser", skillshots = {
        ["MordekaiserMaceOfSpades"] = { spellKey = _Q, isAutoReset = true, spellName = "MordekaiserMaceOfSpades", name = "MordekaiserMaceOfSpades", range = 125,},
        ["MordekaiserCreepingDeathCast"] = { spellKey = _W, isTargeted = true, isShield = true, spellName = "MordekaiserCreepingDeathCast", name = "MordekaiserCreepingDeathCast", range = 750, projectileName = "mordekaiser_creepingDeath_mis.troy", radius = 200,},
        ["MordekaiserChildrenOfTheGrave"] = { spellKey = _R, isTargeted = true, isExecute = true, spellName = "MordekaiserChildrenOfTheGrave", name = "MordekaiserChildrenOfTheGrave", range = 850,},
        ["MordekaiserSyphonOfDestruction"] = { spellKey = _E, type = "LINE", spellName = "MordekaiserSyphonOfDestruction", name = "MordekaiserSyphonOfDestruction", range = 700, radius = 200},
    }},
    ["Morgana"] = {charName = "Morgana", skillshots = {
        ["DarkBindingMissile"] = {spellKey = _Q, isCollision = true, name = "Dark Binding", spellName = "DarkBindingMissile", spellDelay = 250, projectileName = "DarkBinding_mis.troy", projectileSpeed = 1200, range = 1300, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["TormentedSoil"] = { spellKey = _W, spellName = "TormentedSoil", name = "TormentedSoil", range = 900, radius = 175, type = "CIRCULAR"},
        --["SoulShackles"] = { spellKey = _R, castType = 0, spellName = "SoulShackles", name = "SoulShackles", range = 625, projectileName = "AnnieBasicAttack_mis.troy",},
        --["BlackShield"] = { spellKey = _E, castType = 0, spellName = "BlackShield", name = "BlackShield", range = 750, projectileName = "AnnieBasicAttack_mis.troy",},

    }},
    ["DrMundo"] = {charName = "DrMundo", skillshots = {
        ["InfectedCleaverMissile"] = {spellKey = _Q, isCollision = true, name = "Infected Cleaver", spellName = "InfectedCleaverMissile", spellDelay = 250, projectileName = "dr_mundo_infected_cleaver_mis.troy", projectileSpeed = 2000, range = 1000, radius = 75, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        --["BurningAgony"] = { spellKey = _W, isSelfCast = true, spellName = "BurningAgony", name = "BurningAgony", range = 325, projectileName = "AnnieBasicAttack_mis.troy",},
        ["Sadism"] = { spellKey = _R, isSelfCast = true, isHeal = true, spellName = "Sadism", name = "Sadism", range = math.huge, projectileName = "dr_mundo_sadism_cas_02.troy",},
        ["Masochism"] = { spellKey = _E, isSelfCast = true, isAutoBuff = true, spellName = "Masochism", name = "Masochism", range = 300, },
    }},
    ["Nami"] = {charName = "Nami", skillshots = {
        ["NamiQ"] = {spellKey = _Q, name = "NamiQ", spellName = "NamiQ", spellDelay = 850, projectileName = "Nami_Q_mis.troy", range = 875, radius = 100, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Ebb and Flow"] = {spellKey = _W, isTargeted = true, name = "Ebb and Flow", spellName = "EbbAndFlow", spellDelay = 250, range = 725,},
        ["TidecallersBlessing"] = {spellKey = _E, isSelfCast = true, name = "TidecallersBlessing", spellName = "TidecallersBlessing", spellDelay = 250, range = 800, type = "CIRCULAR"},
    }},
    ["Nasus"] = {charName = "Nasus", skillshots = {
    --unfinished
        ["NasusW"] = {spellKey = _W, isTargeted = true, name = "Wither", spellName = "NasusW", spellDelay = 250, range = 600, type = "LINE"},
        ["NasusE"] = {spellKey = _E, spellName = "NasusE", name = "NasusE", range = 650, radius = 400, type = "CIRCULAR" },
        ["NasusQ"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Siphoning Strike", spellName = "NasusQ", spellDelay = 250, range = 125, type = "CIRCULAR"},
    }},
    ["Nautilus"] = {charName = "Nautilus", skillshots = {
        ["NautilusAnchorDrag"] = {spellKey = _Q, isCollision = true, name = "Dredge Line", spellName = "NautilusAnchorDrag", spellDelay = 250, projectileName = "Nautilus_Q_mis.troy", projectileSpeed = 2000, range = 1080, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["NautilusPiercingGaze"] = { spellKey = _W, isSelfCast = true, isShield = true, spellName = "NautilusPiercingGaze", name = "NautilusPiercingGaze", range = math.huge, },
        ["NautilusSplashZone"] = { spellKey = _E, isSelfCast = true, spellName = "NautilusSplashZone", name = "NautilusSplashZone", range = 600, },
        ["NautilusGrandLine"] = { spellKey = _R, isTargeted = true, spellName = "NautilusGrandLine", name = "NautilusGrandLine", range = 825, projectileSpeed = 1400, },
    }},
    ["Nidalee"] = {charName = "Nidalee", skillshots = {
        ["JavelinToss"] = {spellKey = _Q, isCollision = true, name = "Javelin Toss", spellName = "JavelinToss", spellDelay = 125, projectileName = "nidalee_javelinToss_mis.troy", projectileSpeed = 1300, range = 1500, radius = 60, type = "LINE", checkName = true, fuckedUp = false, blockable = true, danger = 1},
        ["PrimalSurge"] = { spellKey = _E, isTargeted = true, isHeal = true, spellName = "PrimalSurge", name = "PrimalSurge", range = 600, checkName = true, },
        ["Bushwhack"] = { spellKey = _W, type = "CIRCULAR", spellName = "Bushwhack", name = "Bushwhack", range = 900, radius = 70, checkName = true, },
        
        ["Swipe"] = { spellKey = _E, type = "LINE", spellName = "Swipe", name = "Swipe", range = 400, radius = 200, checkName = true, },
        ["Pounce"] = { spellKey = _W, isSelfCast = true, spellName = "Pounce", name = "Pounce", range = 375, checkName = true, },
        ["Takedown"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, spellName = "Takedown", name = "Takedown", range = 500, checkName = true, },
        
        --["AspectOfTheCougar"] = { spellKey = _R, castType = 0, spellName = "AspectOfTheCougar", name = "AspectOfTheCougar", range = 20, projectileName = "TeemoBasicAttack_mis.troy",},
    }},
    ["Nocturne"] = {charName = "Nocturne", skillshots = {
        ["NocturneDuskbringer"] =  {spellKey = _Q, name = "NocturneDuskbringer", spellName = "NocturneDuskbringer", spellDelay = 250, projectileName = "NocturneDuskbringer_mis.troy", projectileSpeed = 1400, range = 1200, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Unspeakable Horror"] = {spellKey = _E, isTargeted = true, name = "UnspeakableHorror", spellName = "UnspeakableHorror", spellDelay = 250, range = 425, type = "LINE"},
    }},
    ["Olaf"] = {charName = "Olaf", skillshots = {
        ["OlafAxeThrow"] = {spellKey = _Q, name = "Undertow", spellName = "OlafAxeThrow", spellDelay = 250, projectileName = "olaf_axe_mis.troy", projectileSpeed = 1600, range = 1000, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Reckless Swing"] = {spellKey = _E, isTargeted = true, name = "Reckless Swing", spellName = "RecklessSwing", spellDelay = 250, range = 325, type = "LINE"},
        ["Vicious Strikes"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Vicious Strikes", spellName = "ViciousStrikes", range = 200},
    }},
    ["Orianna"] = {charName = "Orianna", skillshots = {
        --["OrianaReturn"] = { spellKey = ExtraSpell5, castType = 1, spellName = "OrianaReturn", name = "OrianaReturn", range = 10000, projectileSpeed = 2250, projectileName = "Oriana_Ghost_mis_return.troy", radius = 200,},
        --["OrianaRedact"] = { spellKey = ExtraSpell3, castType = 3, spellName = "OrianaRedact", name = "OrianaRedact", range = 1500, projectileSpeed = 2250, projectileName = "Oriana_Ghost_mis_protect.troy", radius = 80,},
        --["OrianaIzuna"] = { spellKey = ExtraSpell1, castType = 3, spellName = "OrianaIzuna", name = "OrianaIzuna", range = 2000, projectileSpeed = 1350, projectileName = "Oriana_Ghost_mis.troy", radius = 80,},
        --["OrianaDetonateCommand"] = { spellKey = _R, castType = 0, spellName = "OrianaDetonateCommand", name = "OrianaDetonateCommand", range = 410, projectileSpeed = 1200, radius = 80,},
        ["OrianaIzunaCommand"] = { spellKey = _Q, type = "LINE", spellName = "OrianaIzunaCommand", name = "OrianaIzunaCommand", range = 825, projectileSpeed = 1200, radius = 80,},
        
        ["OrianaRedactCommand"] = { spellKey = _E, isTargeted = true, isShield = true, spellName = "OrianaRedactCommand", name = "OrianaRedactCommand", range = 1120, projectileSpeed = 1200, radius = 80,},
        ["OrianaDissonanceCommand"] = { spellKey = _W, isSelfCast = true, spellName = "OrianaDissonanceCommand", name = "OrianaDissonanceCommand", range = math.huge, radius = 80,},
    }},
    ["Pantheon"] = {charName = "Pantheon", skillshots = {
    --unfinished
        ["SpearShot"] = {spellKey = _Q, isTargeted = true, name = "Spear Shot", spellName = "SpearShot", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Aegis of Zeonia"] = {spellKey = _W, isTargeted = true, name = "Aegis of Zeonia", spellName = "PantheonW", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE"},
        ["Pantheon_Heartseeker"] = {spellKey = _E, channelDuration = 750, name = "Heartseeker Strike", spellName = "Pantheon_Heartseeker", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 2000, range = 600, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Poppy"] = {charName = "Poppy", skillshots = {
    --unfinished
        ["Devastating Blow"] = {spellKey = _Q, isTargeted = true, name = "Devastating Blow", spellName = "DevastatingBlow", spellDelay = 250, range = 125, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE"},
        ["Heroic Charge"] = {spellKey = _E, isTargeted = true, name = "Heroic Charge", spellName = "HeroicCharge", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 525, type = "LINE"},
        ["Paragon of Demacia"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Paragon of Demacia", spellName = "PoppyW", spellDelay = 250, range = 300,},
    }},
    ["Quinn"] = {charName = "Quinn", skillshots = {
        ["QuinnQ"] = {spellKey = _Q, isCollision = true, name = "QuinnQ", spellName = "QuinnQ", spellDelay = 250, projectileName = "Quinn_Q_missile.troy", projectileSpeed = 1550, range = 1050, radius = 80, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["QuinnE"] = { spellKey = _E, isTargeted = true, spellName = "QuinnE", name = "QuinnE", range = 750, },
    }},
    ["Rumble"] = {charName = "Rumble", skillshots = {
        ["RumbleGrenade"] =  {spellKey = _E, name = "RumbleGrenade", spellName = "RumbleGrenade", spellDelay = 250, projectileName = "rumble_taze_mis.troy", projectileSpeed = 2000, range = 800, radius = 90, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Flamespitter"] =  {spellKey = _Q, name = "Flamespitter", spellName = "Flamespitter", spellDelay = 250, range = 650, radius = 90, type = "CIRCULAR"},
        ["RumbleShield"] = { spellKey = _W, isSelfCast = true, isShield = true, spellName = "RumbleShield", name = "RumbleShield", range = math.huge, 
            damage = function () return 20 + 30 * myHero:GetSpellData(_W).level + myHero.ap * .4 end,},
    }},
    ["Rengar"] = {charName = "Rengar", skillshots = {
    --unfinished
        ["RengarE"] = {spellKey = _E, isTargeted = true, name = "Bola Strike", spellName = "RengarE", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 575, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Savagery"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Savagery", spellName = "Savagery", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        --["Empowered Savagery"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, hasBuff="" ,name = "Empowered Savagery", spellName = "EmpoweredSavagery", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["Battle Roar"] = {spellKey = _W, isSelfCast = true, noAnimation = true, name = "Battle Roar", spellName = "RengarQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "CIRCULAR"},
    }},
    ["Renekton"] = {charName = "Renekton", skillshots = {
    --unfinished
        ["Ruthless Predator"] = {spellKey = _W, isTargeted = true, isAutoReset = true, name = "Ruthless Predator", spellName = "RuthlessPredator", spellDelay = 250, range = 125, projectileName = "swain_shadowGrasp_transform.troy", type = "LINE"},
        ["Cull the Meek"] = {spellKey = _Q, isSelfCast = true, isTrueRange = true, name = "Cull the Meek", spellName = "RenektonQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 225, type = "CIRCULAR"},
        ["Slice And Dice"] = {spellKey = _E, name = "Slice", spellName = "Slice", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 450, radius = 200, type = "LINE"},
    }},
    ["Riven"] = {charName = "Riven", skillshots = {
    --unfinished
        ["Ki Burst"] = {spellKey = _W, isSelfCast = true, name = "Ki Burst", spellName = "RivenW", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["Broken Wings"] = {spellKey = _Q, name = "Broken Wings", spellName = "RivenTriCleave", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 260, radius = 200, type = "LINE"},
        ["Valor"] = {spellKey = _E, name = "Valor", spellName = "Valor", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", range = 325, radius = 200, type = "LINE"},
        ["RivenR"] = {spellKey = _R, name = "Blade of the Exile", spellName = "RivenR", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", range = 900, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Ryze"] = {charName = "Ryze", skillshots = {
    --unfinished
        ["Overload"] = {spellKey = _Q, isTargeted = true, name = "Overload", spellName = "Overload", spellDelay = 250, range = 600, projectileName = "Overload_mis.troy", type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Rune Prison"] = {spellKey = _W, isTargeted = true, name = "Rune Prison", spellName = "RunePrison", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "LINE"},
        ["SpellFlux"] = {spellKey = _E, isTargeted = true, name = "Spell Flux", spellName = "SpellFlux", spellDelay = 250, projectileName = "SpellFlux_mis.troy", range = 600, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Desperate Power"] = {spellKey = _R, isSelfCast = true, name = "Desperate Power", spellName = "Desperate Power", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 600, type = "CIRCULAR"},
    }},
    ["Sejuani"] = {charName = "Sejuani", skillshots = {
        ["SejuaniR"] = {name = "SejuaniR", spellName = "SejuaniGlacialPrisonCast", spellDelay = 250, projectileName = "Sejuani_R_mis.troy", projectileSpeed = 1600, range = 1200, radius = 110, type = "LINE"},    
    }},
    ["Shaco"] = {charName = "Shaco", skillshots = {
        ["TwoShivPoison"] = { spellKey = _E, isTargeted = true, spellName = "TwoShivPoison", name = "TwoShivPoison", range = 625, projectileName = "JesterDagger.troy", fuckedUp = false, blockable = true, danger = 1},
        --["HallucinateFull"] = { spellKey = _R, castType = 0, spellName = "HallucinateFull", name = "HallucinateFull", range = 500, projectileName = "AnnieBasicAttack_mis.troy",},
        --["Deceive"] = { spellKey = _Q, castType = 0, spellName = "Deceive", name = "Deceive", range = 25000, projectileName = "AnnieBasicAttack_mis.troy",},
        --["JackInTheBox"] = { spellKey = _W, type = "CIRCULAR", spellName = "JackInTheBox", name = "JackInTheBox", range = 425, projectileName = "TristannaBasicAttack4_mis.troy",},
    }},
    ["Shen"] = {charName = "Shen", skillshots = {
        ["ShadowDash"] = {name = "ShadowDash", spellName = "ShenShadowDash", spellDelay = 0, projectileName = "shen_shadowDash_mis.troy", projectileSpeed = 3000, range = 575, radius = 50, type = "LINE"},
        ["ShenVorpalStar"] = { spellKey = _Q, isTargeted = true, spellName = "ShenVorpalStar", name = "ShenVorpalStar", range = 475, projectileSpeed = 1500, projectileName = "shen_vorpalStar_mis.troy"},
        ["ShenFeint"] = { spellKey = _W, isShield = true, isSelfCast = true, spellName = "ShenFeint", name = "ShenFeint", range = math.huge, 
            damage = function () return 20 + 40 * myHero:GetSpellData(_W).level + myHero.ap * .6 end,},
        --["ShenStandUnited"] = { spellKey = _R, castType = 0, spellName = "ShenStandUnited", name = "ShenStandUnited", range = 25000, projectileName = "AnnieBasicAttack_mis.troy",},
    }},
    ["Shyvana"] = {charName = "Shyvana", skillshots = { 
        ["ShyvanaDoubleAttack"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, spellName = "ShyvanaDoubleAttack", name = "ShyvanaDoubleAttack", range = 125, },
        ["ShyvanaFireball"] = { spellKey = _E, spellName = "ShyvanaFireball", name = "ShyvanaFireball", range = 925, projectileSpeed = 1200, projectileName = "shyvana_flameBreath_mis.troy", radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ShyvanaImmolationAura"] = { spellKey = _W, isSelfCast = true, noAnimation = true, spellName = "ShyvanaImmolationAura", name = "ShyvanaImmolationAura", range = 150, },
    }}, 
    ["Skarner"] = {charName = "Skarner", skillshots = {
    --unfinished        
        ["Crystal Slash"] = {spellKey = _Q, isSelfCast = true, name = "Crystal Slash", spellName = "CrystalSlash", spellDelay = 250, range = 300, type = "CIRCULAR"},
        ["Fracture"] = {spellKey = _E, name = "Fracture", spellName = "Fracture", spellDelay = 250, projectileName = "TEMP_KarmaQMis.troy", projectileSpeed = 1700, range = 900, radius = 45, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["SkarnerExoskeleton"] = { spellKey = _W, isSelfCast = true, isShield = true, spellName = "SkarnerExoskeleton", name = "SkarnerExoskeleton", range = math.huge, 
            damage = function () return 25 + 55 * myHero:GetSpellData(_W).level + myHero.ap * .8 end,}
    }},
    ["Sion"] = {charName = "Sion", skillshots = {
        ["CrypticGaze"] = { spellKey = _Q, isTargeted = true, isStun = true, spellName = "CrypticGaze", name = "CrypticGaze", range = 550, projectileName = "CrypticGaze_mis.troy",},
        --["DeathsCaressFull"] = { spellKey = _W, castType = 0, spellName = "DeathsCaressFull", name = "DeathsCaressFull", range = 1, projectileName = "AnnieBasicAttack_mis.troy",},
        --["Cannibalism"] = { spellKey = _R, castType = 0, spellName = "Cannibalism", name = "Cannibalism", range = 1,},
        --["Enrage"] = { spellKey = _E, castType = 0, spellName = "Enrage", name = "Enrage", range = 1, projectileName = "FuryoftheAncient_mis.troy",},
    }},
    ["Sivir"] = {charName = "Sivir", skillshots = { --hard to measure speed
        --unfinished
        ["SivirQ"] = {spellKey = _Q, name = "Boomerang Blade", spellName = "SivirQ", spellDelay = 250, projectileName = "Sivir_Base_Q_mis.troy", projectileSpeed = 1350, range = 1075, radius = 101, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Ricochet"] = {spellKey = _W, isSelfCast = true, isAutoReset = true, name = "Ricochet", spellName = "Ricochet", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 550, type = "LINE"},
    }},
    ["Sona"] = {charName = "Sona", skillshots = {
        ["HymnofValor"] = {spellKey = _Q, isSelfCast = true, name = "Hymn of Valor", spellName = "HymnofValor", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["SonaAriaofPerseverance"] = { spellKey = _W, isSelfCast = true, isHeal = true, spellName = "SonaAriaofPerseverance", name = "SonaAriaofPerseverance", range = 1000,},
        ["SonaCrescendo"] = {name = "Crescendo", spellName = "SonaCrescendo", spellDelay = 250, projectileName = "SonaCrescendo_mis.troy", projectileSpeed = 2400, range = 1000, radius = 150, type = "LINE", fuckedUp = false, blockable = true, danger = 1},      
    }},
    ["Soraka"] = {charName = "Soraka", skillshots = {
        ["Infuse"] = {spellKey = _E, isTargeted = true, name = "Infuse", spellName = "Infuse", spellDelay = 250, range = 725, type = "LINE"},
        ["Starcall"] = {spellKey = _Q, isSelfCast = true, isTrueRange = true, name = "Starcall", spellName = "Starcall", spellDelay = 250, range = 675, type = "CIRCULAR"},        
        ["AstralBlessing"] = {spellKey = _W, isTargeted = true, isHeal = true, spellName = "AstralBlessing", name = "AstralBlessing", range = 750},
        ["Wish"] = { spellKey = _R, isTargeted = true, isHeal = true, spellName = "Wish", name = "Wish", range = math.huge},
    }},
    ["Swain"] = {charName = "Swain", skillshots = {
    --unfinished
        ["Decrepify"] = {spellKey = _Q, isTargeted = true, name = "Decrepify", spellName = "Decrepify", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 625, radius = 125, type = "LINE", fuckedUp = false, blockable = true, danger = 1, fuckedUp = false, blockable = true, danger = 1},
        ["Nevermove"] = {spellKey = _W, name = "Nevermove", spellName = "SwainShadowGrasp", spellDelay = 875, projectileName = "swain_shadowGrasp_transform.troy", range = 900, radius = 125, type = "CIRCULAR"},
        ["Torment"] = {spellKey = _E, isTargeted = true, name = "Torment", spellName = "Torment", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", projectileSpeed = 1000, range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Syndra"] = {charName = "Syndra", skillshots = {
        ["SyndraQ"] = {name = "SyndraQ", spellName = "SyndraQ", spellDelay = 200, projectileName = "Syndra_Q_cas.troy", projectileSpeed = 300, range = 800, radius = 180, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Talon"] = {charName = "Talon", skillshots = {
    --unfinished
        ["Noxian Diplomacy"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Noxian Diplomacy", spellName = "TalonQ", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
        ["Cutthroat"] = {spellKey = _E, isTargeted = true, name = "Cutthroat", spellName = "Cutthroat", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["Rake"] = {spellKey = _W, name = "Rake", spellName = "Rake", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 2000, range = 600, radius = 200, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ShadowAssault"] = {spellKey = _R, isSelfCast = true, name = "Shadow Assault", spellName = "ShadowAssault", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 500, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Taric"] = {charName = "Taric", skillshots = {
        ["Imbue"] = { spellKey = _Q, isTargeted = true, isHeal = true, spellName = "Imbue", name = "Imbue", range = 750, },
        ["Dazzle"] = {spellKey = _E, isTargeted = true, name = "Dazzle", spellName = "Dazzle", spellDelay = 250, range = 625, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Shatter"] = {spellKey = _W, isSelfCast = true, name = "Shatter", spellName = "Shatter", spellDelay = 250, range = 200, type = "CIRCULAR"},
        ["Radiance"] = {spellKey = _R, isSelfCast = true, name = "Radiance", spellName = "Radiance", spellDelay = 250, range = 200, type = "CIRCULAR"},
    }},
    ["Teemo"] = {charName = "Teemo", skillshots = {
    --insert projectile speed
        ["BlindingDart"] = {spellKey = _Q, isTargeted = true, name = "BlindingDart", spellName = "BlindingDart", spellDelay = 250, projectileName = "BlindShot_mis.troy", projectileSpeed = 1900, range = 680, fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Thresh"] = {charName = "Thresh", skillshots = {
        ["ThreshQ"] = {spellKey = _Q, isCollision = true, name = "ThreshQ", spellName = "ThreshQ", spellDelay = 500, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 1900, range = 1075, radius = 65, type = "LINE", fuckedUp = false, blockable = true, danger = 1}
    }},
    ["Tristana"] = {charName = "Tristana", skillshots = {
    --unfinished
        ["Explosive Shot"] = {spellKey = _E, isTargeted = true, isAutoReset = true, name = "Explosive Shot", spellName = "ExplosiveShot", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "LINE"},
        ["Rapid Fire"] = {spellKey = _Q, isSelfCast = true, name = "Rapid Fire", spellName = "RapidFire", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["BusterShot"] = {spellKey = _R, isTargeted = true, isExecute = true, name = "Buster Shot", spellName = "BusterShot", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 645, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Trundle"] = {charName = "Trundle", skillshots = {
        ["TrundlePain"] = { spellKey = _R, isTargeted = true, spellName = "TrundlePain", name = "TrundlePain", range = 700,},
        ["trundledesecrate"] = { spellKey = _W, spellName = "trundledesecrate", name = "trundledesecrate", range = 900, radius = 1000, type = "CIRCULAR"},
        ["TrundleTrollSmash"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, spellName = "TrundleTrollSmash", name = "TrundleTrollSmash", range = 125,},
        ["TrundleCircle"] = { spellKey = _E, spellName = "TrundleCircle", name = "TrundleCircle", range = 1000, radius = 62, type = "CIRCULAR"},
    }},
    ["Tryndamere"] = {charName = "Tryndamere", skillshots = {
        ["UndyingRage"] = { spellKey = _R, isSelfCast = true, isShield = true, spellName = "UndyingRage", name = "UndyingRage", range = math.huge,},
    }},
    ["TwistedFate"] = {charName = "TwistedFate", skillshots = {
        ["WildCards"] = {spellKey = _Q, name = "Loaded Dice", spellName = "WildCards", spellDelay = 250, projectileName = "Roulette_mis.troy", projectileSpeed = 1000, range = 1450, radius = 40, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Pick A Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Pick A Card", spellName = "PickACard", spellDelay = 250, projectileName = "Thresh_Q_whip_beam.troy", projectileSpeed = 1500, range = 700, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Gold Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Gold Card", spellName = "goldcardlock", spellDelay = 250, projectileName = "TwistedFate_Base_W_GoldCard.troy", projectileSpeed = 1500, range = math.huge, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Blue Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Blue Card", spellName = "bluecardlock", spellDelay = 250, projectileName = "TwistedFate_Base_W_BlueCard.troy", projectileSpeed = 1500, range = math.huge, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Red Card"] = {spellKey = _W, isSelfCast = true, checkName = true, name = "Red Card", spellName = "redcardlock", spellDelay = 250, projectileName = "TwistedFate_Base_W_RedCard.troy", projectileSpeed = 1500, range = math.huge, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Twitch"] = {charName = "Twitch", skillshots = {
        ["TwitchVenomCask"] = { spellKey = _W, type = "LINE", spellName = "TwitchVenomCask", name = "TwitchVenomCask", projectileName = "Twitch_Venom_Splash.troy", projectileSpeed = 1400, range = 900, radius = 200, fuckedUp = false, blockable = true, danger = 1},
        ["HideInShadows"] = { spellKey = _Q, isSelfCast = true, isAutoBuff = true, noAnimation = ture, spellName = "HideInShadows", name = "HideInShadows", range = 550, },
        ["Expunge"] = { spellKey = _E, isSelfCast = true, spellName = "Expunge", name = "Expunge", range = 1200, fuckedUp = false, blockable = true, danger = 1},
        --["FullAutomatic"] = { spellKey = _R, castType = 0, spellName = "FullAutomatic", name = "FullAutomatic", range = 1200,},
    }},
    ["Udyr"] = {charName = "Udyr", skillshots = {       
        ["UdyrPhoenixStance"] = { spellKey = _R, isSelfCast = true, noAnimation = true, isAutoBuff = true, spellName = "UdyrPhoenixStance", name = "UdyrPhoenixStance", range = math.huge,},
        ["UdyrTurtleStance"] = { spellKey = _W, isSelfCast = true, noAnimation = true, isShield = true, spellName = "UdyrTurtleStance", name = "UdyrTurtleStance", range = math.huge,},
        ["UdyrBearStance"] = { spellKey = _E, isSelfCast = true, noAnimation = true, spellName = "UdyrBearStance", name = "UdyrBearStance", range = math.huge,},
        ["UdyrTigerStance"] = { spellKey = _Q, isSelfCast = true, noAnimation = true, isAutoBuff = true, spellName = "UdyrTigerStance", name = "UdyrTigerStance", range = math.huge,},

    }},
    
    ["Urgot"] = {charName = "Urgot", skillshots = {
        ["UrgotHeatseekingLineMissile"] = {name = "Acid Hunter", spellName = "UrgotHeatseekingLineMissile", spellDelay = 175, projectileName = "UrgotLineMissile_mis.troy", projectileSpeed = 1600, range = 1000, radius = 60, type = "LINE", fuckedUp = false, blockable = true, danger = 1, fuckedUp = false, blockable = true, danger = 1},
        ["UrgotPlasmaGrenade"] = {name = "Plasma Grenade", spellName = "UrgotPlasmaGrenade", spellDelay = 250, projectileName = "UrgotPlasmaGrenade_mis.troy", projectileSpeed = 1750, range = 900, radius = 250, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["MonkeyKing"] = {charName = "MonkeyKing", skillshots = {
    --unfinished
        ["MonkeyKingNimbus"] = {spellKey = _E, isTargeted = true, name = "Nimbus Strike", spellName = "MonkeyKingNimbus", spellDelay = 250, range = 625, type = "LINE"},
        ["MonkeyKingQAttack"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, isTrueRange = true, name = "Crushing Blow", spellName = "MonkeyKingQAttack", spellDelay = 250, range = 325, type = "CIRCULAR"},
    }},
    ["Vladimir"] = {charName = "Vladimir", skillshots = {
        --["VladimirSanguinePool"] = { spellKey = _W, castType = 0, spellName = "VladimirSanguinePool", name = "VladimirSanguinePool", range = 1050, projectileName = "DarkWind_mis.troy", radius = 120,},
        ["VladimirHemoplague"] = { spellKey = _R, type = "CIRCULAR", spellName = "VladimirHemoplague", name = "VladimirHemoplague", range = 700, projectileSpeed = 1200, projectileName = "VladHemoPlague_cas.troy", radius = 175,},
        ["VladimirTidesofBlood"] = { spellKey = _E, isSelfCast = true, spellName = "VladimirTidesofBlood", name = "VladimirTidesofBlood", range = 610, projectileSpeed = 1100, projectileName = "VladTidesofBlood_mis.troy", radius = 120,},
        ["VladimirTransfusion"] = { spellKey = _Q, isTargeted = true, spellName = "VladimirTransfusion", name = "VladimirTransfusion", range = 600,},
    }},
    ["Volibear"] = {charName = "Volibear", skillshots = {
        ["VolibearQ"] = { spellKey = _Q, isAutoReset = true, spellName = "VolibearQ", name = "VolibearQ", range = 125, },
        ["VolibearR"] = { spellKey = _R, isAutoBuff = true, spellName = "VolibearR", name = "VolibearR", range = 125, },
        ["VolibearE"] = { spellKey = _E, isSelfCast = true, spellName = "VolibearE", name = "VolibearE", range = 425, projectileName = "FerosciousHowl_cas3.troy",},
        ["VolibearW"] = { spellKey = _W, isTargeted = true, isExecute = true, spellName = "VolibearW", name = "VolibearW", range = 400, },
    }},
    ["Warwick"] = {charName = "Warwick", skillshots = {
    --unfinished
        ["Hungering Strike"] = {spellKey = _Q, isTargeted = true, name = "Hungering Strike", spellName = "HungeringStrike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 400, type = "LINE"},
        ["Hunters Call"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Hunters Call", spellName = "HuntersCall", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 300, type = "CIRCULAR"},
    }},
    ["Varus"] = {charName = "Varus", skillshots = {
        ["VarusQ!"] = {spellKey = _Q, name = "Varus Q Missile", spellName = "VarusQ!", spellDelay = 0, projectileName = "VarusQ_mis.troy", projectileSpeed = 1900, range = 1600, radius = 70, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["VarusE"] = {spellKey = _E, name = "Varus E", spellName = "VarusE", spellDelay = 250, projectileName = "VarusEMissileLong.troy", projectileSpeed = 1500, range = 925, radius = 275, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["VarusR"] = {name = "VarusR", spellName = "VarusR", spellDelay = 250, projectileName = "VarusRMissile.troy", projectileSpeed = 1950, range = 1250, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    
    ["Vayne"] = {charName = "Vayne", skillshots = {
        --["VayneInquisition"] = { spellKey = _R, castType = 0, spellName = "VayneInquisition", name = "VayneInquisition", range = 1, projectileName = "AnnieBasicAttack_mis.troy",},
        --["VayneCondemn"] = { spellKey = _E, castType = 0, spellName = "VayneCondemn", name = "VayneCondemn", range = 550, projectileSpeed = 1200, projectileName = "vayne_E_mis.troy",},
        --["VayneSilveredBolts"] = { spellKey = _W, castType = 0, spellName = "VayneSilveredBolts", name = "VayneSilveredBolts", range = 10000, radius = 50,},
        ["VayneTumble"] = { isAutoReset = true, isDash = true, spellName = "VayneTumble", name = "VayneTumble", range = 300, },
        ["VayneCondemn"] = {name = "VayneCondemn", spellName = "VayneCondemn", castDelay = 250, projectileName = "vayne_E_mis.troy", projectileSpeed = 1200, range = 550, radius = 450, fuckedUp = false, blockable = true, danger = 1}
    }}, 
    ["Veigar"] = {charName = "Veigar", skillshots = {
        ["BalefulStrike"] = {spellKey = _Q, isTargeted = true, name = "Baleful Strike", spellName = "BalefulStrike", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, projectileSpeed = 1500, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["Dark Matter"] = {spellKey = _W, name = "VeigarDarkMatter", targetHasBuff = "Stun", spellName = "VeigarDarkMatter", spellDelay = 1250, projectileName = "!", range = 900, radius = 112, type = "CIRCULAR"},
        ["Primordial Burst"] = {spellKey = _R, isTargeted = true, isExecute = true, name = "Primordial Burst", spellName = "PrimordialBurst", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 650, projectileSpeed = 1500, type = "LINE"},
    }},
    ["Vi"] = {charName = "Vi", skillshots = {
    --unfinished
        ["Excessive Force"] = {spellKey = _E, isSelfCast = true, isAutoReset = true, name = "Excessive Force", spellName = "ExcessiveForce", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 125, type = "CIRCULAR"},
    }},
    ["XinZhao"] = {charName = "XinZhao", skillshots = {
        ["Talon Strike"] = {spellKey = _Q, isSelfCast = true, isAutoReset = true, name = "Talon Strike", spellName = "TalonStrike", spellDelay = 250, range = 175, type = "LINE"},
        ["Battle Cry"] = {spellKey = _W, isSelfCast = true, isAutoBuff = true, noAnimation = true, name = "Battle Cry", spellName = "BattleCry", spellDelay = 250, range = 300,},
        ["Crescent Sweep"] = {spellKey = _R, isSelfCast = true, name = "Crescent Sweep", spellName = "CrescentSweep", spellDelay = 250, range = 300, type = "CIRCULAR"},
        ["Audacious Charge"] = { spellKey = _E, isTargeted = true, spellName = "XinZhaoCharge", name = "Audacious Charge", range = 600, },
    }},
    ["Xerath"] = {charName = "Xerath", skillshots = {
        ["XerathMageSpear"] = { spellKey = _E, type = "LINE", isCollision = true, isStun = true, spellName = "XerathMageSpear", name = "XerathMageSpear", projectileName = "Xerath_Base_E_mis.troy", range = 1050, projectileSpeed = 1600, radius = 70, fuckedUp = false, blockable = true, danger = 1},
        ["XerathArcanopulseChargeUp"] = { spellKey = _Q, type = "LINE", spellName = "XerathArcanopulseChargeUp", heroHasNoBuff = "XerathArcanopulseChargeUp", name = "XerathArcanopulseChargeUp", range = 1000, radius = 100, },
        ["XerathArcanopulseChargeUp2"] = { spellKey = _Q, type = "LINE", spellName = "XerathArcanopulseChargeUp2", heroHasBuff = "XerathArcanopulseChargeUp", name = "XerathArcanopulseChargeUp2", range = 750, radius = 100, fuckedUp = false, blockable = true, danger = 1},
        --range function
        ["XerathArcaneBarrage2"] = { spellKey = _W, type = "CIRCULAR", spellName = "XerathArcaneBarrage2", name = "XerathArcaneBarrage2", range = 1100, spellDelay = 750, radius = 200, fuckedUp = false, blockable = true, danger = 1},
        ["XerathLocusOfPower2"] = { spellKey = _R, type = "CIRCULAR", spellName = "XerathLocusOfPower2", name = "XerathLocusOfPower2", projectileName = "Xerath_Base_R_mis.troy", range = 5600, radius = 100, spellDelay = 750, fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Yasuo"] = {charName = "Yasuo", skillshots = {
        ["Steel Tempest"] = {spellKey = _Q, name = "Steel Tempest", isTrueRange = true, spellName = "SteelTempest", spellDelay = 250, projectileName = "Yasuo_Q_WindStrike.troy", range = 475, radius = 50, type = "LINE"},
        ["yasuoq3w"] = {spellKey = _Q, name = "Steel Tempest3", checkName = true, spellName = "yasuoq3w", spellDelay = 250, projectileName = "Yasuo_Q_wind_mis.troy", projectileSpeed = 1500, range = 900, radius = 100, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
    ["Yorick"] = {charName = "Yorick", skillshots = {       
        ["YorickDecayed"] = { spellKey = _W, spellName = "YorickDecayed", name = "YorickDecayed", range = 600, radius = 100, type = "CIRCULAR"},
        --["YorickReviveAlly"] = { spellKey = _R, castType = 0, spellName = "YorickReviveAlly", name = "YorickReviveAlly", range = 850, projectileSpeed = 1500,},
        ["YorickSpectral"] = { spellKey = _Q, isSelfCast = true, isAutoReset = true, noAnimation = true, spellName = "YorickSpectral", name = "YorickSpectral", range = 125,},
        ["YorickRavenous"] = { spellKey = _E, isTargeted = true, spellName = "YorickRavenous", name = "YorickRavenous", range = 550, },
    }},
    ["Zed"] = {charName = "Zed", skillshots = {
        ["ZedShuriken"] = {spellKey = _Q, name = "ZedShuriken", spellName = "ZedShuriken", spellDelay = 250, projectileName = "Zed_Q_Mis.troy", projectileSpeed = 1700, range = 925, radius = 50, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZedShadowSlash"] = { spellKey = _E, isSelfCast = true, spellName = "ZedShadowSlash", name = "ZedShadowSlash", range = 290,},
    }},
    ["Ziggs"] = {charName = "Ziggs", skillshots = {
        ["ZiggsQ"] =  {spellKey = _Q, isCollision = true, name = "ZiggsQ", spellName = "ZiggsQ", spellDelay = 250, projectileName = "ZiggsQ.troy", projectileSpeed = 1700, range = 1400, radius = 155, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZiggsW"] =  {spellKey = _W, name = "ZiggsW", spellName = "ZiggsW", spellDelay = 250, projectileName = "ZiggsW_mis.troy", projectileSpeed = 1700, range = 1000, radius = 325, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZiggsE"] =  {spellKey = _E, name = "ZiggsE", spellName = "ZiggsE", spellDelay = 250, projectileName = "ZiggsE_Mis_Large.troy", projectileSpeed = 1700, range = 900, radius = 250, type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZiggsR"] = { spellKey = _R, isExecute = true, type = "LINE", spellName = "ZiggsR", name = "ZiggsR", range = 5000, projectileSpeed = 1750, projectileName = "ZiggsR_Mis_Nuke.troy", radius = 550, fuckedup = false, blockable = true, danger = 1},
    }},
    ["Zilean"] = {charName = "Zilean", skillshots = {
    --unfinished
        ["TimeBomb"] = {spellKey = _Q, isTargeted = true, name = "Time Bomb", spellName = "TimeBomb", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, radius = 330, type = "CIRCULAR", fuckedUp = false, blockable = true, danger = 1},
        ["Rewind"] = {spellKey = _W, isSelfCast = true, name = "Rewind", spellName = "Rewind", spellDelay = 250, projectileName = "swain_shadowGrasp_transform.troy", range = 700, type = "CIRCULAR"},
        ["ChronoShift"] = { spellKey = _R, isTargeted = true, isShield = true, spellName = "ChronoShift", name = "ChronoShift", range = 900, },
    }},
    ["Zyra"] = {charName = "Zyra", skillshots = {
        ["Deadly Bloom"]   = {spellKey = _Q, name = "Deadly Bloom", spellName = "ZyraQFissure", spellDelay = 625, projectileName = "zyra_Q_cas.troy", range = 800, radius = 220, type = "CIRCULAR"},
        ["Rampant Growth"]   = {spellKey = _W, name = "Rampant Growth", spellName = "Rampant Growth", spellDelay = 625, projectileName = "zyra_Q_cas.troy", range = 850, radius = 220, type = "CIRCULAR"},
        ["ZyraGraspingRoots"] = {spellKey = _E, name = "Grasping Roots", spellName = "ZyraGraspingRoots", spellDelay = 250, projectileName = "Zyra_E_sequence_impact.troy", projectileSpeed = 1150, range = 1150, radius = 70,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
        ["ZyraBrambleZone"] = { spellKey = _R, type = "CIRCULAR", spellName = "ZyraBrambleZone", name = "ZyraBrambleZone", range = 700, spellDelay = 250, radius = 400},
        ["zyrapassivedeathmanager"] = { spellKey = _Q, checkName = true, name = "Zyra Passive", spellName = "zyrapassivedeathmanager", spellDelay = 500, projectileName = "zyra_passive_plant_mis.troy", projectileSpeed = 2000, range = 1474, radius = 60,  type = "LINE", fuckedUp = false, blockable = true, danger = 1},
    }},
}
	
Interrupt = {
    ["Katarina"] = {charName = "Katarina", stop = {["KatarinaR"] = {name = "Death lotus", spellName = "KatarinaR", ult = true }}},
    ["Nunu"] = {charName = "Nunu", stop = {["AbsoluteZero"] = {name = "Absolute Zero", spellName = "AbsoluteZero", ult = true }}},
    ["Malzahar"] = {charName = "Malzahar", stop = {["AlZaharNetherGrasp"] = {name = "Nether Grasp", spellName = "AlZaharNetherGrasp", ult = true}}},
    ["Caitlyn"] = {charName = "Caitlyn", stop = {["CaitlynAceintheHole"] = {name = "Ace in the hole", spellName = "CaitlynAceintheHole", ult = true, projectileName = "caitlyn_ult_mis.troy"}}},
    ["FiddleSticks"] = {charName = "FiddleSticks", stop = {["Crowstorm"] = {name = "Crowstorm", spellName = "Crowstorm", ult = true}}},
    ["Galio"] = {charName = "Galio", stop = {["GalioIdolOfDurand"] = {name = "Idole of Durand", spellName = "GalioIdolOfDurand", ult = true}}},
    ["Janna"] = {charName = "Janna", stop = {["ReapTheWhirlwind"] = {name = "Monsoon", spellName = "ReapTheWhirlwind", ult = true}}},
    ["MissFortune"] = {charName = "MissFortune", stop = {["MissFortune"] = {name = "Bullet time", spellName = "MissFortuneBulletTime", ult = true}}},
    ["MasterYi"] = {charName = "MasterYi", stop = {["MasterYi"] = {name = "Meditate", spellName = "Meditate", ult = false}}},
    ["Pantheon"] = {charName = "Pantheon", stop = {["PantheonRJump"] = {name = "Skyfall", spellName = "PantheonRJump", ult = true}}},
    ["Shen"] = {charName = "Shen", stop = {["ShenStandUnited"] = {name = "Stand united", spellName = "ShenStandUnited", ult = true}}},
    ["Urgot"] = {charName = "Urgot", stop = {["UrgotSwap2"] = {name = "Position Reverser", spellName = "UrgotSwap2", ult = true}}},
    ["Varus"] = {charName = "Varus", stop = {["VarusQ"] = {name = "Piercing Arrow", spellName = "Varus", ult = false}}},
    ["Warwick"] = {charName = "Warwick", stop = {["InfiniteDuress"] = {name = "Infinite Duress", spellName = "InfiniteDuress", ult = true}}},
}

end
	
local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Yasuo.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#00ff00\"><b>Updating HR Yasuo, don't press F9.</b></font>")	
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
	DownloadFile("http://"..serveradress..scriptadress.."/HR Yasuo.lua",SCRIPT_PATH.."HR Yasuo.lua", function ()
		PrintChat("<font color=\"#00ff00\"><b>HR Yasuo Updated, press 2xF9.</b></font>")	
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
