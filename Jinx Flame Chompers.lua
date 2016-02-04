if myHero.charName ~= "Jinx" then return end
if not FileExist(LIB_PATH .. "/VPrediction.lua") then PrintChat("<font color=\"#25A071\"><b>[Jinx Flame Chompers]</b></font> ".."<font color=\"#B8860B\"><b>Missing lib: VPrediction.</b></font>") return end

function OnLoad() Jinx() end

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("WJMNMNMJKIM") 
-- Script Status --

class 'Jinx'
function Jinx:__init()
	require 'VPrediction'
	VP = VPrediction()
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1600, DAMAGE_MAGICAL)
	ts2 = TargetSelector(TARGET_LOW_HP, math.huge, DAMAGE_MAGICAL)
	ts3 = TargetSelector(TARGET_NEAR_MOUSE, math.huge, DAMAGE_MAGICAL)
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	self.Weapon = "Minigun"
	self.TrueRange = myHero.range+GetDistance(myHero, myHero.minBBox)
	self.OrbWalkers = {}
	self.LoadedOrb = nil
	self.Version = 0.2
	self:Menu()
	self:LoadTableOrbs()
	self:LoadOrb()
	self:SendMsg("Loaded version: "..self.Version)
	self:Callbacks()
	self:CheckUpdates()
end

function Jinx:Callbacks()
	AddTickCallback(function() self:Tick() end)
	AddAnimationCallback(function(unit, animation) self:Animation(unit, animation) end)
end

function Jinx:Menu()
	Menu = scriptConfig("Jinx Flame Chompers", "JinxFlameChompers")

	Menu:addSubMenu("Combo", "Combo")
	Menu:addSubMenu("Harass", "Harass")
	Menu:addSubMenu("Logic Q", "LogicQ")
	Menu:addSubMenu("HitChances", "HitChance")
	Menu:addSubMenu("Manual R", "Manual")
	Menu:addSubMenu("KillSteal", "KillSteal")

	Menu.Combo:addParam("Q", "Use Q Logic", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true) 
	Menu.Combo:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true) 

	Menu.Harass:addParam("Q", "Use Q Logic", SCRIPT_PARAM_ONOFF, true)
	Menu.Harass:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true) 

	Menu.LogicQ:addParam("LastHit", "Change Launcher to Minigun (LastHit)", SCRIPT_PARAM_ONOFF, true)
	Menu.LogicQ:addParam("LaneClear", "Change Launcher to Minigun (LaneClear)", SCRIPT_PARAM_ONOFF, true) 
	Menu.LogicQ:addParam("JungleClear", "Change Launcher to Minigun (JungleClear)", SCRIPT_PARAM_ONOFF, true) 

	Menu.HitChance:addParam("W", "W HitChance", SCRIPT_PARAM_SLICE, 2, 1, 3, 1)
	Menu.HitChance:addParam("E", "E HitChance", SCRIPT_PARAM_SLICE, 2, 1, 3, 1)
	Menu.HitChance:addParam("R", "R HitChance", SCRIPT_PARAM_SLICE, 2, 1, 3, 1)

  	Menu.Manual:addParam("Use", "Key to use Manual R", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
 	Menu.Manual:addParam("Mode", "Mode", SCRIPT_PARAM_LIST, 3, {"Target", "Near Mouse", "Low HP"})

	Menu.KillSteal:addParam("Enable", "Enable KillSteal", SCRIPT_PARAM_ONOFF, true) 
	Menu.KillSteal:addParam("W", "KillSteal with W", SCRIPT_PARAM_ONOFF, true) 
	Menu.KillSteal:addParam("R", "KillSteal with R", SCRIPT_PARAM_ONOFF, true)

  	Menu:addParam("Flee", "Flee Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("L"))

	ts.name = "Jinx"
	Menu:addTS(ts)

	Menu:addParam("info", "Author:", SCRIPT_PARAM_INFO, "HiranN")
	Menu:addParam("info2", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
end

function Jinx:SendMsg(msg)
	PrintChat("<font color=\"#25A071\"><b>[Jinx Flame Chompers]</b></font> ".."<font color=\"#B8860B\"><b>"..msg..".</b></font>")
end

function Jinx:LoadTableOrbs()
	if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
	table.insert(self.OrbWalkers, "SAC")
	end
	if _G.MMA_IsLoaded then
	table.insert(self.OrbWalkers, "MMA")
	end
	if _G._Pewalk then
	table.insert(self.OrbWalkers, "Pewalk")
	end
	if FileExist(LIB_PATH .. "/Nebelwolfi's Orb Walker.lua") then
	table.insert(self.OrbWalkers, "NOW")
	end
	if FileExist(LIB_PATH .. "/Big Fat Orbwalker.lua") then
	table.insert(self.OrbWalkers, "Big Fat Walk")
	end
	if FileExist(LIB_PATH .. "/SOW.lua") then
	table.insert(self.OrbWalkers, "SOW")
	end
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	table.insert(self.OrbWalkers, "SxOrbWalk")
	end
	if #self.OrbWalkers > 0 then
	Menu:addSubMenu("Orbwalkers", "Orbwalkers")
	Menu:addSubMenu("Keys", "Keys")
	Menu.Orbwalkers:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, self.OrbWalkers)
	Menu.Keys:addParam("info", "Detecting keys from: "..self.OrbWalkers[Menu.Orbwalkers.Orbwalker], SCRIPT_PARAM_INFO, "")
	local OrbAlr = false
  	Menu.Orbwalkers:setCallback("Orbwalker", function(value) 
  	if OrbAlr then return end
  	OrbAlr = true
 	Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
  	self:SendMsg("Press F9 2x to load your selected Orbwalker")
  	end)
	end
end

function Jinx:LoadOrb()
	if self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SAC" then
	self.LoadedOrb = "Sac"
	TIMETOSACLOAD = false
	DelayAction(function() TIMETOSACLOAD = true end,15)
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "MMA" then
	self.LoadedOrb = "Mma"
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Pewalk" then
	self.LoadedOrb = "Pewalk"
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "NOW" then
	self.LoadedOrb = "Now"
	require "Nebelwolfi's Orb Walker"
	_G.NOWi = NebelwolfisOrbWalkerClass()
    Menu.Orbwalkers:addSubMenu("NOW", "NOW")
    _G.NebelwolfisOrbWalkerClass(Menu.Orbwalkers.NOW)	
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Big Fat Walk" then
	self.LoadedOrb = "Big"
	require "Big Fat Orbwalker"
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SOW" then
	self.LoadedOrb = "Sow"
	require "SOW"
    Menu.Orbwalkers:addSubMenu("SOW", "SOW")
    _G.SOWi = SOW(_G.VP)
	SOW:LoadToMenu(Menu.Orbwalkers.SOW)
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SxOrbWalk" then
	self.LoadedOrb = "SxOrbWalk"
	require "SxOrbWalk"
    Menu.Orbwalkers:addSubMenu("SxOrbWalk", "SxOrbWalk")
	SxOrb:LoadToMenu(Menu.Orbwalkers.SxOrbWalk)
	end
end

function Jinx:Keys()
	if self.LoadedOrb == "Sac" and TIMETOSACLOAD then
	if _G.AutoCarry.Keys.AutoCarry then return "Combo" end
	if _G.AutoCarry.Keys.MixedMode then return "Harass" end
	if _G.AutoCarry.Keys.LaneClear then return "Laneclear" end
	if _G.AutoCarry.Keys.LastHit then return "Lasthit" end
	elseif self.LoadedOrb == "Mma" then
	if _G.MMA_IsOrbwalking() then return "Combo" end
	if _G.MMA_IsDualCarrying() then return "Harass" end
	if _G.MMA_IsLaneClearing() then return "Laneclear" end
	if _G.MMA_IsLastHitting() then return "Lasthit" end
	elseif self.LoadedOrb == "Pewalk" then
	if _G._Pewalk.GetActiveMode().Carry then return "Combo" end
	if _G._Pewalk.GetActiveMode().Mixed then return "Harass" end
	if _G._Pewalk.GetActiveMode().LaneClear then return "Laneclear" end
	if _G._Pewalk.GetActiveMode().Farm then return "Lasthit" end
	elseif self.LoadedOrb == "Now" then
	if _G.NOWi.Config.k.Combo then return "Combo" end
	if _G.NOWi.Config.k.Harass then return "Harass" end
	if _G.NOWi.Config.k.LaneClear then return "Laneclear" end
	if _G.NOWi.Config.k.LastHit then return "Lasthit" end
	elseif self.LoadedOrb == "Big" then
	if _G["BigFatOrb_Mode"] == "Combo" then return "Combo" end
	if _G["BigFatOrb_Mode"] == "Harass" then return "Harass" end
	if _G["BigFatOrb_Mode"] == "LaneClear" then return "Laneclear" end
	if _G["BigFatOrb_Mode"] == "LastHit" then return "Lasthit" end
	elseif self.LoadedOrb == "Sow" then
	if _G.SOWi.Menu.Mode0 then return "Combo" end
	if _G.SOWi.Menu.Mode1 then return "Harass" end
	if _G.SOWi.Menu.Mode2 then return "Laneclear" end
	if _G.SOWi.Menu.Mode3 then return "Lasthit" end
	elseif self.LoadedOrb == "SxOrbWalk" then
	if _G.SxOrb.isFight then return "Combo" end
	if _G.SxOrb.isHarass then return "Harass" end
	if _G.SxOrb.isLaneClear then return "Laneclear" end
	if _G.SxOrb.isLastHit then return "Lasthit" end
	end
end

function Jinx:SetMove(boolean)
	if self.LoadedOrb == "Sac" and TIMETOSACLOAD then
	if boolean then _G.AutoCarry.MyHero:MovementEnabled(true)
	elseif not boolean then _G.AutoCarry.MyHero:MovementEnabled(false)
	end
	elseif self.LoadedOrb == "Mma" then
	if boolean then _G.MMA_AvoidMovement(false)
	elseif not boolean then _G.MMA_AvoidMovement(true)
 	end
	elseif self.LoadedOrb == "Pewalk" then
	if boolean then _G._Pewalk.AllowMove(true)
	elseif not boolean then _G._Pewalk.AllowMove(false)
 	end
	elseif self.LoadedOrb == "Now" then
	if boolean then _G.NOWi:SetMove(true)
	elseif not boolean then _G.NOWi:SetMove(false)
 	end
	elseif self.LoadedOrb == "Big" then
	if boolean then _G["BigFatOrb_DisableMove"] = false
	elseif not boolean then _G["BigFatOrb_DisableMove"] = true
 	end
	elseif self.LoadedOrb == "Sow" then
	if boolean then _G.SOWi.Move = true
	elseif not boolean then _G.SOWi.Move = false
 	end
	elseif self.LoadedOrb == "SxOrbWalk" then
	if boolean then _G.SxOrb:EnableMove()
	elseif not boolean then _G.SxOrb:DisableMove()
 	end
	end
end

function Jinx:GetTarget()
	if self.LoadedOrb == "Sac" and TIMETOSACLOAD then
	return _G.AutoCarry.Crosshair:GetTarget()
	elseif self.LoadedOrb == "Mma" then
	return _G.MMA_GetTarget()
	elseif self.LoadedOrb == "Pewalk" then
	return _G._Pewalk.GetTarget()
	elseif self.LoadedOrb == "Now" then
	return _G.NOWi:GetTarget()
	elseif self.LoadedOrb == "Big" then
	ts:update()
	_G["BigFatOrb_ForcedTarget"] = ts.target
	return ts.target
	elseif self.LoadedOrb == "Sow" then
	return _G.SOWi:GetTarget(true)
	elseif self.LoadedOrb == "SxOrbWalk" then
	return _G.SxOrb:GetTarget()
	end
end

function Jinx:Tick()
	if myHero.dead then return end
	Target = self:GetTarget()
	self:Combo(Target)
	self:Harass(Target)
	self:LastHit()
	self:LaneClear()
	self:ManualR()
	self:Flee()
	self:KillSteal()
end

function Jinx:Combo(target)
	if not ValidTarget(target) then return end
	if self:Keys() == "Combo" then
	if Menu.Combo.Q then self:LogicQ(target) end
	if Menu.Combo.W and GetDistance(target) >= self.TrueRange+50 then self:CastW(target) end
	if Menu.Combo.E then self:CastE(target) end
	end
end

function Jinx:Harass(target)
	if not ValidTarget(target) then return end
	if self:Keys() == "Harass" then
	if Menu.Harass.Q then self:LogicQ(target) end
	if Menu.Harass.W then self:CastW(target) end
	end
end

function Jinx:LastHit()
	if self:Keys() == "Lasthit" then
  	enemyMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
	if Menu.LogicQ.LastHit then self:FarmQ(minion) end
	end
	end
end

function Jinx:LaneClear()
	if self:Keys() == "Laneclear" then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
	if Menu.LogicQ.LaneClear then self:FarmQ(minion) end
	end
 	for i, minion in pairs(jungleMinions.objects) do
	if Menu.LogicQ.JungleClear then self:FarmQ(minion) end
	end
	end
end

function Jinx:LogicQ(unit)
	if ValidTarget(unit) and GetDistance(unit) <= 1000 then
	if self.Weapon == "Minigun" and GetDistance(unit) >= self.TrueRange+5 then
	CastSpell(_Q)
	elseif self.Weapon == "Launcher" and GetDistance(unit) <= self.TrueRange-5 then
	CastSpell(_Q)
	end
	end
end

function Jinx:FarmQ(unit)
	if ValidTarget(unit) then
	if self.Weapon == "Launcher" and GetDistance(unit) <= self.TrueRange-5 then
	CastSpell(_Q)
	end
	end
end

function Jinx:CastW(unit)
	if ValidTarget(unit) and self:Ready(_W) then 
    local CastPosition, HitChance, Position = VP:GetLineCastPosition(unit, 0.60, 40, 1450, math.huge, myHero, true)
    if CastPosition and HitChance >= Menu.HitChance.W then
    CastSpell(_W, CastPosition.x, CastPosition.z)
    end
	end
end

function Jinx:CastE(unit)
	if ValidTarget(unit) and self:Ready(_E) then 
    local CastPosition, HitChance, Position = VP:GetLineCastPosition(unit, 0.35, 50, 900, 1500, myHero, false)
    if CastPosition and HitChance >= Menu.HitChance.E then
    CastSpell(_E, CastPosition.x, CastPosition.z)
    end
	end
end

function Jinx:CastR(unit)
	if ValidTarget(unit) and self:Ready(_R) then 
    local CastPosition, HitChance, Position = VP:GetLineCastPosition(unit, 0.55, 150, math.huge, 1500, myHero, true)
    if CastPosition and HitChance >= Menu.HitChance.R then
    CastSpell(_R, CastPosition.x, CastPosition.z)
    end
	end
end

function Jinx:Ready(spell)
	if myHero:CanUseSpell(spell) == READY then return true else return false end
end

function Jinx:ManualR()
	if not Menu.Manual.Use then return end
	if Menu.Manual.Mode == 1 then
	self:CastR(Target)
	elseif Menu.Manual.Mode == 2 then
	ts3:update()
	if ts3.target ~= nil then
	self:CastR(ts3.target)
	end
	elseif Menu.Manual.Mode == 3 then
	ts2:update()
	if ts2.target ~= nil then
	self:CastR(ts2.target)
	end
	end
end

function Jinx:Flee()
	if not Menu.Flee then return end
	myHero:MoveTo(mousePos.x, mousePos.z)
  	for _, unit in pairs(GetEnemyHeroes()) do
	self:CastE(unit)
	DelayAction(function() self:CastW(unit) end,0.25)
  	end
end

function Jinx:KillSteal()
	if not Menu.KillSteal.Enable then return end
  	for _, unit in pairs(GetEnemyHeroes()) do
 	local EnemyH = unit.health + unit.hpRegen * 2
 	local DMGW = getDmg("W", unit, myHero) - 10
 	local DMGR = getDmg("R", unit, myHero) - 40
 	if EnemyH <= DMGW and Menu.KillSteal.W and self:Ready(_W) and GetDistance(unit) <= 1450 then
   	self:CastW(unit)
 	end
  	if EnemyH <= DMGR and Menu.KillSteal.R and self:Ready(_R) then
  	self:CastR(unit)
 	end
 	end
end

function Jinx:Animation(unit, animation)
	if unit.isMe then
	if animation == "Rlauncher_To_Minigun" then
	self.Weapon = "Minigun"	
	elseif animation == "Minigun_To_Rlauncher" then
	self.Weapon = "Launcher"
	end
	end		
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
local scriptname = "Jinx Flame Chompers"
local adressfull = "http://"..serveradress..scriptadress.."/"..scriptname..".lua"
function Jinx:CheckUpdates()
  	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/"..scriptname..".version")
  	if ServerVersionDATA then
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersion then
    if ServerVersion > tonumber(self.Version) then
    self:SendMsg("Updating, don't press F9")
    self:DownloadUpdate()
    else
    self:SendMsg("You have the latest version")
    end
    else
    self:SendMsg("An error occured, while updating")	
    end
  	else
  	self:SendMsg("Could not connect to update Server")
end
end

function Jinx:DownloadUpdate()  	
  	DownloadFile(adressfull, SCRIPT_PATH..scriptname..".lua", function ()
  	self:SendMsg("Updated, press 2x F9")
  	end)
end
