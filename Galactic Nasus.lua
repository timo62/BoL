if myHero.charName ~= "Nasus" then return end
function OnLoad() Nasus() end

--SCRIPT STATUS--
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("XKNONRJNORO") 
--SCRIPT STATUS--

class 'Nasus'
function Nasus:__init()
	self.QStacks = ReadFile(LIB_PATH.."GalacticNasus.txt")
	if self.QStacks == "" then self.QStacks = 0 end
	if GetInGameTimer() <= 75 then self.QStacks = 0 end
	self:Remove(LIB_PATH.."GalacticNasus.txt", 0, 25)
	self.Version = 0.2
	self.OrbWalkers = {}
	self.LoadedOrb = nil
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1600, DAMAGE_MAGICAL)
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)

	self:Menu()
	self:LoadTableOrbs()
	self:LoadOrb()
	self:Callbacks()
	self:SendMsg("Loaded Version: "..self.Version)
	self:CheckUpdates()
end

function Nasus:Menu()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
  	Menu = scriptConfig("Galactic Nasus", "GalacticNasus")
	Menu:addSubMenu("Combo", "Combo")
	Menu:addSubMenu("LastHit", "LastHit")
	Menu:addSubMenu("LaneClear", "LaneClear")

	Menu.Combo:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true) 
	Menu.Combo:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true) 

	Menu.LastHit:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)

	Menu.LaneClear:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.LaneClear:addParam("QL", "Only use Q to LastHit unit", SCRIPT_PARAM_ONOFF, true)

	if Ignite then 
	Menu:addSubMenu("KillSteal", "KillSteal")	
	Menu.KillSteal:addParam("Enable", "Enable KillSteal", SCRIPT_PARAM_ONOFF, true) 
	Menu.KillSteal:addParam("Ignite", "KillSteal with ignite", SCRIPT_PARAM_ONOFF, true) end
 
	Menu:addSubMenu("Draws", "Draws")	
	Menu.Draws:addParam("MinionsDmg", "Draw Q Damage on minions", SCRIPT_PARAM_ONOFF, true) 

	ts.name = "Nasus"
	Menu:addTS(ts)

	Menu:addParam("info", "Author:", SCRIPT_PARAM_INFO, "HiranN")
	Menu:addParam("info2", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
	Menu:addParam("info3", "Stacks detected :", SCRIPT_PARAM_INFO, "0")
	Menu.info3 = self.QStacks
	if self.QStacks ~= 0 then self:SendMsg("Detected Stacks: "..self.QStacks) end
end

function Nasus:SendMsg(msg)
	PrintChat("<font color=\"#E94F42\"><b>[Galactic Nasus]</b></font> ".."<font color=\"#64e3ee\"><b>"..msg..".</b></font>")
end

function Nasus:LoadTableOrbs()
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

function Nasus:LoadOrb()
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

function Nasus:Keys()
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

function Nasus:GetQDamage(unit)
	return ((myHero.totalDamage + getDmg("Q", unit, myHero) + self.QStacks) - unit.armor)
end

function Nasus:Callbacks()
	AddCreateObjCallback(function(obj) 
	if obj.name == "DeathsCaress_nova.troy" then 
	self.QStacks = self.QStacks + 3 
	Menu.info3 = self.QStacks
	end
	end)
	AddUnloadCallback(function() 
	local file = io.open(LIB_PATH.."GalacticNasus.txt", "a")
	file:write(self.QStacks)
	file:close()
	end)
	AddTickCallback(function()
	if myHero.dead then return end
	ts:update()
	Target = ts.target
	self:Combo(Target)
	self:LastHit()
	self:LaneClear()
	self:KillSteal()
	end)
	AddDrawCallback(function()
	if Menu.Draws.MinionsDmg then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
	self:DrawBarPos(minion)
	end
	end
	end)
end

function Nasus:DrawBarPos(unit)
	local barPos = GetUnitHPBarPos(unit)
	local Color = (self:GetQDamage(unit) >= unit.health) and 0xFF009900 or 0xFFFF0000
	if unit.charName:lower():find("minion") then 
	self:DrawRectangle(barPos.x - 30, barPos.y-2, 60, 4, Color)
 	if self:GetQDamage(unit) >= unit.health then 
 	DrawCircle(unit.x, unit.y, unit.z, 50, 0xFF009900)
 	end
	end
end

function Nasus:DrawRectangle(x, y, width, height, color)  
  	local A = x - 1
  	local B = x + width
  	local C = y - 1
  	local D = y + height
  	DrawLine(A, C, B, C,     1, color) --> ---
  	DrawLine(A, C, A, D,     1, color) --> |
  	DrawLine(B, C, B, D,	 1, color) -->   |
  	DrawLine(A, D, B, D,     1, color) --> ___
end

function Nasus:Combo(target)
	if not ValidTarget(target) then return end
	if self:Keys() == "Combo" then
	if Menu.Combo.Q and GetDistance(target) <= 265 then CastSpell(_Q) end
	if Menu.Combo.W and GetDistance(target) <= 600 then CastSpell(_W, target) end
	if Menu.Combo.E and GetDistance(target) <= 265 then CastSpell(_E, target.x, target.z) end
end
end

function Nasus:LastHit()
	if self:Keys() == "Lasthit" then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
	if Menu.LastHit.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	CastSpell(_Q) myHero:Attack(minion) end
	end
 	for i, minion in pairs(jungleMinions.objects) do
	if Menu.LastHit.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	CastSpell(_Q) myHero:Attack(minion) end
	end
	end
end

function Nasus:LaneClear()
	if self:Keys() == "Laneclear" then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
 	if Menu.LaneClear.QL then 
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	CastSpell(_Q) myHero:Attack(minion) end
	elseif not Menu.LaneClear.QL then
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and GetDistance(minion) <= 275 then 
	CastSpell(_Q) myHero:Attack(minion) end
	end
	end
 	for i, minion in pairs(jungleMinions.objects) do
 	if Menu.LaneClear.QL then 
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	CastSpell(_Q) myHero:Attack(minion) end
	elseif not Menu.LaneClear.QL then
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and GetDistance(minion) <= 275 then 
	CastSpell(_Q) myHero:Attack(minion) end
	end
	end
end
end

function Nasus:KillSteal()
	if not Ignite then return end
	if not Menu.KillSteal.Enable then return end 
  	for _, unit in pairs(GetEnemyHeroes()) do
 	local EnemyH = unit.health + unit.hpRegen * 2
 	if Menu.KillSteal.Ignite then
 	if EnemyH <= 40 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
 	CastSpell(Ignite, unit)
 	end
 	end
 	end
end

function Nasus:Remove(filename, starting_line, num_lines)
    local fp = io.open( filename, "r" )
    if fp == nil then return nil end
    content = {}
    i = 1;
    for line in fp:lines() do
    if i < starting_line or i >= starting_line + num_lines then
	content[#content+1] = line
	end
	i = i + 1
    end
    fp:close()
    fp = io.open( filename, "w+" )
    for i = 1, #content do
	fp:write( string.format( "%s\n", content[i] ) )
    end
    fp:close()
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
local scriptname = "Galactic Nasus"
local adressfull = "http://"..serveradress..scriptadress.."/"..scriptname..".lua"
function Nasus:CheckUpdates()
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

function Nasus:DownloadUpdate()  	
  	DownloadFile(adressfull, SCRIPT_PATH..scriptname..".lua", function ()
  	self:SendMsg("Updated, press 2x F9")
  	end)
end
