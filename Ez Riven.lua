local LocalVersion = "0.7"
local AutoUpdate = true

if myHero.charName ~= "Riven" then return end
local LastQ = 0
local Wrange = 260
local Rrange2 = 900
local RCasted = false
local LastSpell = 0
local Loaded = false
local SAC = false
local NX = false
local RTIME = 0
local QCount = 0

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("TGJKINJKFKL") 
-- Script Status --

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/timo62/GetChallengerEz/master"
local scriptname = "Ez Riven"
local scriptmsg = "<font color=\"#06CD51\"><b>[Ez Riven]</b></font>"
    function FindUpdates()
    if not AutoUpdate then return end
    local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/"..scriptname..".version")
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(LocalVersion) then
            PrintChat(scriptmsg.."<font color=\"#C2FDF3\"><b> Updating, don't press F9.</b></font>")
            Update()
            else
            PrintChat(scriptmsg.."<font color=\"#C2FDF3\"><b> You have the latest version.</b></font>")
            end
        else
        PrintChat(scriptmsg.."<font color=\"#C2FDF3\"><b> An error occured, while updating, please reload.</b></font>")
        end
    else
    PrintChat(scriptmsg.."<font color=\"#C2FDF3\"><b> Could not connect to update Server.</b></font>")
    end
end

function Update()
    DownloadFile("http://"..serveradress , scriptadress.."/"..scriptname..".lua",SCRIPT_PATH..scriptname..".lua", function()
    PrintChat(scriptmsg.."<font color=\"#C2FDF3\"><b> Updated, press 2x F9.</b></font>")
    end)
end

function OnLoad()
		Menu = scriptConfig("Ez Riven", "EZRiven")

		Menu:addSubMenu("Combo", "c")
		Menu.c:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.c:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
		Menu.c:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.c:addParam("useR", "Use R", SCRIPT_PARAM_ONOFF, true)
		Menu.c:addParam("combos", "Combo Mode", SCRIPT_PARAM_LIST, 1, {"Basic", "E-Q-Q-W-Q"})

		Menu:addSubMenu("LaneClear/JungleClear", "jc")
		Menu.jc:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.jc:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
		Menu.jc:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)

    Menu:addSubMenu("Auto W", "autoW")
      Menu.autoW:addParam("W", "Use Auto W",SCRIPT_PARAM_ONOFF, true)
      Menu.autoW:addParam("S", "x Enemies for Auto W", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)

  		Menu:addSubMenu("Items Settings", "items")
  		Menu.items:addParam("Use", "Use Items", SCRIPT_PARAM_ONOFF, true) 
 		Menu.items:addParam("UseBRK", "Use BRK", SCRIPT_PARAM_ONOFF, true) 
 		Menu.items:addParam("UseHydra", "Use Hydra", SCRIPT_PARAM_ONOFF, true) 
 		Menu.items:addParam("UseYoumu", "Use Youmuu", SCRIPT_PARAM_ONOFF, true) 
 		Menu.items:addParam("UseQSS", "Use QSS", SCRIPT_PARAM_ONOFF, true)
 		Menu.items:addParam("UseZhonya", "Use Zhonya", SCRIPT_PARAM_ONOFF, true)
  		Menu.items:addParam("ZhonyaAmount", "Zhonya %", SCRIPT_PARAM_SLICE, 15, 0, 100, 0)

  		Menu:addSubMenu("Draws Settings", "draws")
  		Menu.draws:addParam("CDTracker", "Use CD Tracker", SCRIPT_PARAM_ONOFF, true) 

  		if VIP_USER then
 		Menu:addSubMenu("Auto Leveler", "AutoLvL")
  		Menu.AutoLvL:addParam("On", "Use Auto Leveler", SCRIPT_PARAM_ONOFF, false)
  		end
		Menu:addParam("fleeKey", "Flee Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))

		ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_PHYSICAL)
 		ts.name = "Riven"
 		Menu:addTS(ts)
		enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
		jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
		PrintChat(scriptmsg.."<font color=\"#C2FDF3\"><b> Loaded Version: "..LocalVersion.."</b></font>")
		FindUpdates()
		CheckSummoner()
		OrbWalk()
  ___GetInventorySlotItem = rawget(_G, "GetInventorySlotItem")
  _G.GetInventorySlotItem = GetSlotItem
  _G.ITEM_1 = 06
  _G.ITEM_2 = 07
  _G.ITEM_3 = 08
  _G.ITEM_4 = 09
  _G.ITEM_5 = 10
  _G.ITEM_6 = 11
  _G.ITEM_7 = 12
end
		function OrbWalk()
    	OrbwalkList = {}
        if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
        DelayAction(function()SAC = true end,15)
        Menu:addSubMenu("OrbWalk", "OrbWalk")
        Menu.OrbWalk:addParam("info", "Sac Detected.", SCRIPT_PARAM_INFO, "")
        elseif FileExist(LIB_PATH .. "Nebelwolfi's Orb Walker.lua") or _G.NebelwolfisOrbWalkerInit then
        require "Nebelwolfi's Orb Walker"
        NX = true
        Menu:addSubMenu("OrbWalk", "OrbWalk")
        _G.NebelwolfisOrbWalkerClass(Menu.OrbWalk)
        end
        end

  function CheckSummoner()
  if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
  if myHero:GetSpellData(SUMMONER_1).name:find("summonerflash") then Flash = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerflash") then Flash = SUMMONER_2 end
  if myHero:GetSpellData(SUMMONER_1).name:find("summonerbar") then Heal = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbar") then Heal = SUMMONER_2 end
  if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then Barrier = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then Barrier = SUMMONER_2 end
  if myHero:GetSpellData(SUMMONER_1).name:find("summonercleanse") then Cleanse = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonercleanse") then Cleanse = SUMMONER_2 end
  end

  function HaveBuffs(unit, buffs)
        for i = 1, unit.buffCount, 1 do      
            local buff = unit:getBuff(i) 
            if buff.valid and buff.type == buffs then
                return true            
            end                    
        end
  end

  ItemNames     = {
  [3144]        = "BilgewaterCutlass",
  [3153]        = "ItemSwordOfFeastAndFamine",
  [3405]        = "TrinketSweeperLvl1",
  [3166]        = "TrinketTotemLvl1",
  [3361]        = "TrinketTotemLvl3",
  [3362]        = "TrinketTotemLvl4",
  [2003]        = "RegenerationPotion",
  [3146]        = "HextechGunblade",
  [3187]        = "HextechSweeper",
  [3364]        = "TrinketSweeperLvl3",
  [3074]        = "ItemTiamatCleave",
  [3077]        = "ItemTiamatCleave",
  [3340]        = "TrinketTotemLvl1",
  [3090]        = "ZhonyasHourglass",
  [3142]        = "YoumusBlade",
  [3157]        = "ZhonyasHourglass",
  [3350]        = "TrinketTotemLvl2",
  [3140]        = "QuicksilverSash",
  [3139]        = "ItemMercurial",
  }

  function CastItems()
  if Target ~= nil then
  if Menu.items.UseBRK then
  local slot = GetInventorySlotItem(3153)
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY and GetDistance(Target) <= 450 then
  CastSpell(slot, Target)
  end
  end

  if Menu.items.UseHydra then
  local slot = GetInventorySlotItem(3074)
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY and GetDistance(Target) <= 185 then
  CastSpell(slot)
  end
  end

  if Menu.items.UseQSS then

  if GetInventorySlotItem(3139) ~= nil then 
  local slot = GetInventorySlotItem(3139) 
  elseif GetInventorySlotItem(3140) ~= nil then 
  local slot = GetInventorySlotItem(3140) end 

  local buffsList = 6,8,9,11,20,21,23,24,29,30,31
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY and GetDistance(Target) <= 600 and HaveBuffs(myHero, buffsList) then
  CastSpell(slot)
  end
  end

  if Menu.items.UseYoumu then
  local slot = GetInventorySlotItem(3142)
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY then
  CastSpell(slot)
  end
  end

  if Menu.items.UseZhonya then
  local slot = GetInventorySlotItem(3157)
  if myHero.health <= (myHero.maxHealth * Menu.items.ZhonyaAmount / 100) and slot ~= nil and myHero:CanUseSpell(slot) == READY and CountEnemyHeroInRange(900) >= 1 then CastSpell(slot) end
  end
  end
  end

  function GetSlotItem(id, unit)
  
  unit = unit or myHero

  if (not ItemNames[id]) then
  return ___GetInventorySlotItem(id, unit)
  end

  local name  = ItemNames[id]
  
  for slot = ITEM_1, ITEM_7 do
  local item = unit:GetSpellData(slot).name
  if ((#item > 0) and (item:lower() == name:lower())) then
  return slot
  end
  end
  end

Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,}

function OnTick()
	Checks()
  autoW()

	if SAC then 
	if _G.AutoCarry.Keys.AutoCarry then Combo() 
    if Menu.items.Use then CastItems() end end
    if _G.AutoCarry.Keys.LaneClear then LaneJung() end
    elseif NX then
	if _G.NebelwolfisOrbWalker.Config.k.Combo then Combo() 
    if Menu.items.Use then CastItems() end end
    if _G.NebelwolfisOrbWalker.Config.k.LaneClear then LaneJung() end
    end
    if Menu.fleeKey then Flee() end

  if VIP_USER then
  if Menu.AutoLvL.On and os.clock() - LastSpell >= 0.5 then
  LastSpell = os.clock()  
  DelayAction(function() autoLevelSetSequence(Sequence) end,2)
  end
  end

end

  _G.LevelSpell = function(id)
  if GetGameVersion():lower():find("6.2") and Menu.AutoLvL.On then
  msg = "<font color=\"#06CD51\"><b>[Ez Riven]</b></font>"
  local offsets = { 
  [_Q] = 0x41,
  [_W] = 0xFC,
  [_E] = 0x64,
  [_R] = 0xAA,
  }
  local p = CLoLPacket(0x0153)
  p.vTable = 0xFE9264
  p:EncodeF(myHero.networkID)
  p:Encode1(offsets[id])
  for i = 1, 4 do p:Encode1(0xF7) end
  for i = 1, 4 do p:Encode1(0xAF) end
  p:Encode1(0x8F)
  for i = 1, 4 do p:Encode1(0xA5) end
  SendPacket(p)
  if id == _Q then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>Q</b></font>") end
  if id == _W then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>W</b></font>") end
  if id == _E then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>E</b></font>") end
  if id == _R then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>R</b></font>") end
  end
  end

function LaneJung()
		enemyMinions:update()
		jungleMinions:update()
 		for _, minion in pairs(enemyMinions.objects) do
			if Menu.jc.useQ then CastQAA(minion) end
			if Menu.jc.useW then CastW(minion) end
 		end
 		for _, minion in pairs(jungleMinions.objects) do
			if Menu.jc.useQ then CastQAA(minion) end
			if Menu.jc.useE then 
				DelayAction(function ()
					CastE(minion)
				end,0.05)	
			end
			if Menu.jc.useW then 
				DelayAction(function ()
					CastW(minion)
				end,0.05) 
			end
 		end
 end

function Combo()
	if Menu.c.combos == 1 then Combo1() end
	if Menu.c.combos == 2 then Combo2() end
end


function Combo1()
		if Target ~= nil then
		Checks()

    if Menu.c.useE and Menu.c.useR then
      CastSpell(_E,mousePos.x, mousePos.z)
      CastR(Target)
    end

    if Menu.c.useE then
      CastSpell(_E, mousePos.x, mousePos.z)
    end

		if Menu.c.useR then
			CastR(Target)
		end

		if Menu.c.useW then 
			CastW(Target) 
		end

		if Menu.c.useQ then 
			CastQAA(Target) 
		end
		
	end
end

function Combo2()
	if Target ~= nil then
	Checks()

	if Menu.c.useQ then 
		CastQAA(Target) 
	end

	if Menu.c.useW then
		if Wready then
		if QCount >= 2 and GetDistance(Target) <= 255 then
		CastSpell(_W)
		end
	end
	end

	if Menu.c.useE then
		CastE(Target) 
	end

	if Menu.c.useR then
		CastR(Target)
	end
end
end

function autoW()
  Checks()
    if Menu.autoW.W and CountEnemyHeroInRange(Wrange) >= Menu.autoW.S then
      CastW(Target)
    end
  end

function Flee()
		if Menu.fleeKey then
		myHero:MoveTo(mousePos.x, mousePos.z)
		CastSpell(_Q, mousePos.x, mousePos.z)
		CastSpell(_E, mousePos.x, mousePos.z)
		end
end

function CastQAA(target)
		if ValidTarget(target) and myHero:CanUseSpell(_Q) == READY and GetTickCount() > LastQ + 760 then
		CastSpell(_Q, target.x, target.z)
		end
end

function CastW(target)
		if ValidTarget(target) and GetDistance(target) <= 255 and myHero:CanUseSpell(_W) == READY and myHero:GetSpellData(_Q).currentCd > 0.5 then
		CastSpell(_W)
		end
end

function CastE(target)
		if ValidTarget(target) and myHero:GetSpellData(_Q).currentCd > 0.5 then
		CastSpell(_E, target.x, target.z)
		end
end

function CastR(target)
		if ValidTarget(target) then
		if not UltOn() and myHero:CanUseSpell(_R) == READY then CastSpell(_R) end
		if UltOn() then
		if rDmg(target) >= target.health or RTIME-os.clock() <= -11 then
		if GetDistance(target) <= 1000 and myHero:CanUseSpell(_R) == READY then 
		CastSpell(_R, target.x, target.z) 
		end
		end
		end
end
end

function rDmg(unit)
  local Lvl = myHero:GetSpellData(_R).level
  if Lvl < 1 then return 0 end
  local DMGCALC = 0
  bad = myHero.addDamage*(1.2)
  ad = myHero.totalDamage+bad
  local hpercent = unit.health/unit.maxHealth
  if hpercent <= 0.25 then
  DMGCALC = 120*myHero:GetSpellData(_R).level+120+1.8*bad
  else
  DMGCALC = (40*myHero:GetSpellData(_R).level+40+0.6*bad) * (hpercent)*(-2.67) + 3.67
  end
  return myHero:CalcDamage(unit, DMGCALC)
  end

function OnUpdateBuff(unit,buff)
	if unit and buff and unit.isMe then
		if buff.name=="RivenTriCleave" then 
			QCount = QCount + 1
		end
	end
end

function Checks()
		ts:update()
		Qready = (myHero:CanUseSpell(_Q) == READY)
		Wready = (myHero:CanUseSpell(_W) == READY)
		Eready = (myHero:CanUseSpell(_E) == READY)
		Rready = (myHero:CanUseSpell(_R) == READY)
		if ts.target and ts.target ~= nil and ValidTarget(ts.target) and not ts.target.dead then
		Target = ts.target
		else Target = nil
		end
end

function UltOn()
	if RCasted then return true else return false end
end

function OnDraw()
	if Menu.draws.CDTracker then DrawCD() end
end

function GetHPBarPos(enemy)
	enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}--GetEnemyBarData()
	local barPos = GetUnitHPBarPos(enemy)
	local barPosOffset = GetUnitHPBarOffset(enemy)
	local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
	local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
	local BarPosOffsetX = 171
	local BarPosOffsetY = 46
	local CorrectionY = 39
	local StartHpPos = 31

	barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
	barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)

	local StartPos = Vector(barPos.x , barPos.y, 0)
	local EndPos = Vector(barPos.x + 108 , barPos.y , 0)
	return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawCD()
	for i = 1, heroManager.iCount, 1 do
		local champ = heroManager:getHero(i)
		if champ ~= nil and champ ~= myHero and champ.visible and champ.dead == false then
			local barPos = GetHPBarPos(champ)
			if OnScreen(barPos.x, barPos.y) then
				local cd = {}
				cd[0] = math.ceil(champ:GetSpellData(SPELL_1).currentCd)
				cd[1] = math.ceil(champ:GetSpellData(SPELL_2).currentCd)
				cd[2] = math.ceil(champ:GetSpellData(SPELL_3).currentCd)
				cd[3] = math.ceil(champ:GetSpellData(SPELL_4).currentCd)
		   	
				local spellColor = {}
				spellColor[0] = 0xBBFFD700;
				spellColor[1] = 0xBBFFD700;
				spellColor[2] = 0xBBFFD700;
				spellColor[3] = 0xBBFFD700;
									   
				if cd[0] == nil or cd[0] == 0 then cd[0] = "Q" spellColor[0] = 0xBBFFFFFF end
				if cd[1] == nil or cd[1] == 0 then cd[1] = "W" spellColor[1] = 0xBBFFFFFF end
				if cd[2] == nil or cd[2] == 0 then cd[2] = "E" spellColor[2] = 0xBBFFFFFF end
				if cd[3] == nil or cd[3] == 0 then cd[3] = "R" spellColor[3] = 0xBBFFFFFF end
		   	
				if champ:GetSpellData(SPELL_1).level == 0 then spellColor[0] = 0xBBFF0000 end
				if champ:GetSpellData(SPELL_2).level == 0 then spellColor[1] = 0xBBFF0000 end
				if champ:GetSpellData(SPELL_3).level == 0 then spellColor[2] = 0xBBFF0000 end
				if champ:GetSpellData(SPELL_4).level == 0 then spellColor[3] = 0xBBFF0000 end
				DrawRectangle(barPos.x-6, barPos.y-40, 80, 15, 0xBB202020)
				DrawText("[" .. cd[0] .. "]" ,12, barPos.x-5+2, barPos.y-40, spellColor[0])
				DrawText("[" .. cd[1] .. "]", 12, barPos.x+15+2, barPos.y-40, spellColor[1])
				DrawText("[" .. cd[2] .. "]", 12, barPos.x+35+2, barPos.y-40, spellColor[2])
				DrawText("[" .. cd[3] .. "]", 12, barPos.x+54+2, barPos.y-40, spellColor[3])
			end
		end
	end
end

function OnApplyBuff(unit, source, buff)
	if unit and buff and unit == myHero and buff.name == "RivenFengShuiEngine" then RCasted = true RTIME = os.clock() end
end

function OnRemoveBuff(unit, buff)
	if unit and buff and unit == myHero and buff.name == "rivenwindslashready" then RCasted = false RTIME = 0 end
	if unit and buff and unit.isMe then
		if buff.name=="RivenTriCleave" then 
		  	QCount = 0	
		end
	end
end

function OrbAttack(enemy)
 
  if Mode == "A" then
  --"A": Try Attack once and wait until next AA
    LastAATry = os.clock()
  end
  
  LastMove = os.clock()
  myHero:Attack(enemy)
end

function OnProcessAttack(unit, spell)
 
  if unit == nil or unit.networkID ~= myHero.networkID then
    return
  end
  
  if spell.name:find("Attack") then
    --AA starts ( ~ Wind up)
    AnimationTime = spell.animationTime
    WindUpTime = spell.windUpTime
    LastAAStart = os.clock()-GetLatency()/2000-WindUpTime
    LastAAEnd = os.clock()-GetLatency()/2000
    --something else
  end
  
end

function OnProcessSpell(unit, spell)
   if unit == nil or unit.networkID ~= myHero.networkID then
    return
  end
  
  if spell.name == "RivenTriCleave" then
    LastQ = os.clock()-GetLatency()/2000
  elseif spell.name == "ItemTiamatCleave" then
    LastTiamat = os.clock()-GetLatency()/2000
  end

end

function OnAnimation(unit, animation)

   if unit == nil or unit.networkID ~= myHero.networkID then
    return
  end
  
  if animation:find("Attack") and os.clock()-GetLatency()/2000 > LastQ+0.1 and os.clock()-GetLatency()/2000 > LastTiamat+0.1 then
  --Splash damage of Q and using Tiamat also be detected by "BasicAttack"
  --So you have to check when you use Q and Tiamat lastly
    --AA starts (Wind up ~ )
    LastAATry = os.clock()-GetLatency()/2000
    LastAAStart = os.clock()-GetLatency()/2000
    -- something else
  end

	if unit.isMe then
	if animation == "Spell1a" or animation == "Spell1b" then
  	DelayAction(function() DoEmote(1) end, 0.3-GetLatency()/1000)
  	ResetAAs()
    LastQ = GetTickCount()
	elseif animation == "Spell1c" then
  	DelayAction(function() DoEmote(0) end, 0.4-GetLatency()/1000)
  	ResetAAs()
    LastQ = GetTickCount()
end
end
end

function ResetAAs()
	if SAC then
	_G.AutoCarry.Orbwalker:ResetAttackTimer()
	elseif NX then
	_G.NebelwolfisOrbWalker:ResetAA()
	end
end
