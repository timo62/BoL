local LocalVersion = "0.92"
local AutoUpdate = true

	local ChampSupportedList = {
	["Ezreal"] = true, ["TwistedFate"] = true, ["Kayle"] = true, ["Bard"] = true, ["Ryze"] = true, ["Vayne"] = true,
	}
	
	ChampName = myHero.charName
	
	if not ChampSupportedList[ChampName] then 
	PrintChat("<font color=\"#ff0000\">[</font><font color=\"#a05b6b\">S</font><font color=\"#40b5d6\">l</font><font color=\"#40b5d6\">i</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">e</font><font color=\"#40b5d6\">r</font><font color=\"#40b5d6\"> </font><font color=\"#40b5d6\">B</font><font color=\"#40b5d6\">u</font><font color=\"#40b5d6\">n</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">l</font><font color=\"#a05b6b\">e</font><font color=\"#ff0000\">]</font>"..
	"<font color=\"#01cc9c\"><b> Champion not supported.</b></font>")
	return 
	end

  if not FileExist(LIB_PATH .. "/SimpleLib.lua") then
  PrintChat("<font color=\"#ff0000\">[</font><font color=\"#a05b6b\">S</font><font color=\"#40b5d6\">l</font><font color=\"#40b5d6\">i</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">e</font><font color=\"#40b5d6\">r</font><font color=\"#40b5d6\"> </font><font color=\"#40b5d6\">B</font><font color=\"#40b5d6\">u</font><font color=\"#40b5d6\">n</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">l</font><font color=\"#a05b6b\">e</font><font color=\"#ff0000\">]</font>"..
  "<font color=\"#01cc9c\"><b> Missing the Lib : SimpleLib.</b></font>")
  return 
  end

-- Script Status --
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQIKAAAABgBAAEFAAAAdQAABBkBAAGUAAAAKQACBBkBAAGVAAAAKQICBHwCAAAQAAAAEBgAAAGNsYXNzAAQNAAAAU2NyaXB0U3RhdHVzAAQHAAAAX19pbml0AAQLAAAAU2VuZFVwZGF0ZQACAAAAAgAAAAgAAAACAAotAAAAhkBAAMaAQAAGwUAABwFBAkFBAQAdgQABRsFAAEcBwQKBgQEAXYEAAYbBQACHAUEDwcEBAJ2BAAHGwUAAxwHBAwECAgDdgQABBsJAAAcCQQRBQgIAHYIAARYBAgLdAAABnYAAAAqAAIAKQACFhgBDAMHAAgCdgAABCoCAhQqAw4aGAEQAx8BCAMfAwwHdAIAAnYAAAAqAgIeMQEQAAYEEAJ1AgAGGwEQA5QAAAJ1AAAEfAIAAFAAAAAQFAAAAaHdpZAAEDQAAAEJhc2U2NEVuY29kZQAECQAAAHRvc3RyaW5nAAQDAAAAb3MABAcAAABnZXRlbnYABBUAAABQUk9DRVNTT1JfSURFTlRJRklFUgAECQAAAFVTRVJOQU1FAAQNAAAAQ09NUFVURVJOQU1FAAQQAAAAUFJPQ0VTU09SX0xFVkVMAAQTAAAAUFJPQ0VTU09SX1JFVklTSU9OAAQEAAAAS2V5AAQHAAAAc29ja2V0AAQIAAAAcmVxdWlyZQAECgAAAGdhbWVTdGF0ZQAABAQAAAB0Y3AABAcAAABhc3NlcnQABAsAAABTZW5kVXBkYXRlAAMAAAAAAADwPwQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawABAAAACAAAAAgAAAAAAAMFAAAABQAAAAwAQACBQAAAHUCAAR8AgAACAAAABAsAAABTZW5kVXBkYXRlAAMAAAAAAAAAQAAAAAABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAUAAAAIAAAACAAAAAgAAAAIAAAACAAAAAAAAAABAAAABQAAAHNlbGYAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAtAAAAAwAAAAMAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAAFAAAABQAAAAUAAAAFAAAABgAAAAYAAAAGAAAABgAAAAUAAAADAAAAAwAAAAYAAAAGAAAABgAAAAYAAAAGAAAABgAAAAYAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAIAAAACAAAAAgAAAAIAAAAAgAAAAUAAABzZWxmAAAAAAAtAAAAAgAAAGEAAAAAAC0AAAABAAAABQAAAF9FTlYACQAAAA4AAAACAA0XAAAAhwBAAIxAQAEBgQAAQcEAAJ1AAAKHAEAAjABBAQFBAQBHgUEAgcEBAMcBQgABwgEAQAKAAIHCAQDGQkIAx4LCBQHDAgAWAQMCnUCAAYcAQACMAEMBnUAAAR8AgAANAAAABAQAAAB0Y3AABAgAAABjb25uZWN0AAQRAAAAc2NyaXB0c3RhdHVzLm5ldAADAAAAAAAAVEAEBQAAAHNlbmQABAsAAABHRVQgL3N5bmMtAAQEAAAAS2V5AAQCAAAALQAEBQAAAGh3aWQABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAEJgAAACBIVFRQLzEuMA0KSG9zdDogc2NyaXB0c3RhdHVzLm5ldA0KDQoABAYAAABjbG9zZQAAAAAAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAXAAAACgAAAAoAAAAKAAAACgAAAAoAAAALAAAACwAAAAsAAAALAAAADAAAAAwAAAANAAAADQAAAA0AAAAOAAAADgAAAA4AAAAOAAAACwAAAA4AAAAOAAAADgAAAA4AAAACAAAABQAAAHNlbGYAAAAAABcAAAACAAAAYQAAAAAAFwAAAAEAAAAFAAAAX0VOVgABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAoAAAABAAAAAQAAAAEAAAACAAAACAAAAAIAAAAJAAAADgAAAAkAAAAOAAAAAAAAAAEAAAAFAAAAX0VOVgA="), nil, "bt", _ENV))() ScriptStatus("REHIGHEFHFK") 
-- Script Status --

	function OnLoad()
	require 'SimpleLib'
	PrintChat("<font color=\"#ff0000\">[</font><font color=\"#a05b6b\">S</font><font color=\"#40b5d6\">l</font><font color=\"#40b5d6\">i</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">e</font><font color=\"#40b5d6\">r</font><font color=\"#40b5d6\"> </font><font color=\"#40b5d6\">B</font><font color=\"#40b5d6\">u</font><font color=\"#40b5d6\">n</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">l</font><font color=\"#a05b6b\">e</font><font color=\"#ff0000\">]</font>"..
	"<font color=\"#01cc9c\"><b> Loaded: </b></font>".."<font color=\"#b71c1c\"><b>"..ChampName.."</b></font>")
	BaseMenu()
	CheckSummoner()
	Skills()
  OrbwalkManager:LoadCommonKeys(Menu.Keys)
  DelayAction(function() FindUpdates() end,1.5)
	ts = _SimpleTargetSelector(TARGET_LESS_CAST_PRIORITY, 1100, DAMAGE_MAGICAL)
  ts:AddToMenu(Menu)
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
  jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	end

	function BaseMenu()
  BlockLast = {["Bard"] = true, ["TwistedFate"] = true, ["Vayne"] = true}
  BlockLane = {["Bard"] = true,}
  BlockHarass = {["Vayne"] = true,}

	Menu = scriptConfig("Slider Bundle: "..ChampName, "SliderBundle"..ChampName)
	
	Menu:addSubMenu("Combo", "combo")

  if not BlockHarass[ChampName] then
	Menu:addSubMenu("Harass", "harass")
  end

  if not BlockLast[ChampName] then
	Menu:addSubMenu("LastHit", "lasthit")
	end

  if not BlockLane[ChampName] then
	Menu:addSubMenu("LaneClear", "laneclear")
  end

	Menu:addSubMenu("JungleClear", "jungleclear")
	
	Menu:addSubMenu("KillSteal", "killsteal")
	
  Menu:addSubMenu("Keys Settings", "Keys")
  if VIP_USER then
  Menu:addSubMenu("Auto Leveler", "AutoLvL")
  Menu.AutoLvL:addParam("On", "Use Auto Leveler", SCRIPT_PARAM_ONOFF, true)
  end
	end

	function CheckSummoner()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerflash") then Flash = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerflash") then Flash = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerbar") then Heal = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbar") then Heal = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then Barrier = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then Barrier = SUMMONER_2 end
	end

	function Skills()
	if ChampName == "Ezreal" then
  QSpell = _Spell({Slot = _Q, DamageName = "Q",  Range = 1150 , Width = 80, Delay = 0.5, Speed = 1200, Collision = true, Aoe = false, Type = SPELL_TYPE.LINEAR}):AddDraw()
  WSpell = _Spell({Slot = _W, DamageName = "W",  Range = 950 , Width = 80, Delay = 0.5, Speed = 1200, Collision = false, Aoe = false, Type = SPELL_TYPE.LINEAR}):AddDraw()
  RSpell = _Spell({Slot = _R, DamageName = "R",  Range = 20000 , Width = 160, Delay = 1.0, Speed = 2000, Collision = false, Aoe = false, Type = SPELL_TYPE.LINEAR})
  Ezreal()
	elseif ChampName == "Ryze" then
  QSpell = _Spell({Slot = _Q, DamageName = "Q",  Range = 900 , Width = 65, Delay = 0.5, Speed = 1700, Collision = true, Aoe = false, Type = SPELL_TYPE.LINEAR}):AddDraw()
  Ryze()
  elseif ChampName == "TwistedFate" then
  QSpell = _Spell({Slot = _Q, DamageName = "Q",  Range = 1200 , Width = 80, Delay = 0.25, Speed = 1500, Collision = false, Aoe = false, Type = SPELL_TYPE.LINEAR}):AddDraw()
  TwistedFate()
  elseif ChampName == "Kayle" then
  Kayle()
  elseif ChampName == "Bard" then
  QSpell = _Spell({Slot = _Q, DamageName = "Q",  Range = 850 , Width = 108, Delay = 0.25, Speed = 1100, Collision = true, Aoe = false, Type = SPELL_TYPE.LINEAR}):AddDraw()
  Bard()
  elseif ChampName == "Vayne" then
  Vayne()
	end
	end

  LastSpell = 0
  if ChampName == "Ezreal" then Sequence = {1,2,3,1,1,4,2,2,1,3,4,1,2,2,3,4,3,3}
  elseif ChampName == "Ryze" then Sequence = {1,2,3,1,1,4,2,1,2,1,4,3,2,3,2,4,3,3}
  elseif ChampName == "TwistedFate" then Sequence = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
  elseif ChampName == "Kayle" then Sequence = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
  elseif ChampName == "Bard" then Sequence = {1,2,3,1,1,4,2,1,1,2,4,2,2,3,3,4,3,3}
  elseif ChampName == "Vayne" then Sequence = {2,1,3,2,2,4,1,2,2,1,4,1,1,3,3,4,3,3}
  end

  function OnTick()
  if not VIP_USER then return end
  if Menu.AutoLvL.On and os.clock() - LastSpell >= 0.5 then
  LastSpell = os.clock()  
  DelayAction(function() autoLevelSetSequence(Sequence) end,1.5)
  end
  end

  _G.LevelSpell = function(id)
  if GetGameVersion():lower():find("6.1") then
  msg = "<font color=\"#ff0000\">[</font><font color=\"#a05b6b\">S</font><font color=\"#40b5d6\">l</font><font color=\"#40b5d6\">i</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">e</font><font color=\"#40b5d6\">r</font><font color=\"#40b5d6\"> </font><font color=\"#40b5d6\">B</font><font color=\"#40b5d6\">u</font><font color=\"#40b5d6\">n</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">l</font><font color=\"#a05b6b\">e</font><font color=\"#ff0000\">]</font>"
  local offsets = { 
  [_Q] = 0x71,
  [_W] = 0xF1,
  [_E] = 0x31,
  [_R] = 0xB1,
  }
  local p = CLoLPacket(0x00DB)
  p.vTable = 0xF6D830
  p:EncodeF(myHero.networkID)
  for i = 1, 4 do p:Encode1(0x30) end
  p:Encode1(0x17)
  for i = 1, 4 do p:Encode1(0x81) end
  for i = 1, 4 do p:Encode1(0x6A) end
  p:Encode1(offsets[id])
  for i = 1, 4 do p:Encode1(0x00) end
  SendPacket(p)
  if offsets[id] == 113 then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>Q</b></font>") end
  if offsets[id] == 241 then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>W</b></font>") end
  if offsets[id] == 49 then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>E</b></font>") end
  if offsets[id] == 177 then PrintChat(msg.."<font color=\"#01cc9c\"><b> Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>R</b></font>") end
  end
  end

  function OnCreateObj(obj) 
  if obj and obj.name and obj.name:lower():find("teleport") and GetDistance(obj) < 30 then
  Recalling = true
  end
  end

  function OnDeleteObj(obj) 
  if obj and obj.name and obj.name:lower():find("teleport") and GetDistance(obj) < 30 then
  Recalling = false
  end
  end

	class 'Ezreal'
	class 'Ryze'
  class 'TwistedFate'
  class 'Bard'
  class 'Kayle' 
  class 'Vayne'
  
  --{Ezreal
	function Ezreal:__init()
	VP = VPrediction()
	AddTickCallback(function() self:Tick() end)
	self.SkillR = { name = "Trueshot Barrage", range = math.huge, delay = 1.0, speed = 2000, width = 160, ready = false }
  self:Menu()
	end

	function Ezreal:Menu()
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("AutoRA", "Auto R in x enemies (1 to disable)", SCRIPT_PARAM_SLICE, 3, 1, 5, 0) 
	Menu.combo:addParam("MaxRRange", "Max R Range", SCRIPT_PARAM_SLICE, 2000, 1000, 20000, 0)

	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("mManager", "Harass Mana", SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 

	Menu.lasthit:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.lasthit:addParam("mManager", "LastHit Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("mManager", "LaneClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.jungleclear:addParam("mManager", "JungleClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("MinRRange", "Min R Range", SCRIPT_PARAM_SLICE, 975, 600, 3000, 0)
	Menu.killsteal:addParam("MaxRRange", "Max R Range", SCRIPT_PARAM_SLICE, 2000, 1000, 20000, 0)
	if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
	end

  function Ezreal:GetDmg(spell, unit)
  if unit then
  if spell == _Q then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {35,55,75,95,115}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end

  if spell == _W then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {70,115,160,205,250}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end

  if spell == _R then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {350,500,650}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  local TrueDamage1 = TrueDamage + ScaledDamage[Lvl]*myHero.damage
  return myHero:CalcMagicDamage(unit, TrueDamage1)
  end
  end
  end

	function Ezreal:Tick()
	if myHero.dead then return end
	ts:update()
	Target = ts.target

  if Target and Target ~= nil and ValidTarget(Target) then
	if OrbwalkManager:IsCombo() then 
	self:Combo(Target)
	end

	if OrbwalkManager:IsHarass() then
	self:Harass(Target)
	end

	if OrbwalkManager:IsLastHit() then
	self:LastHit(Target)
	end
  end

	if OrbwalkManager:IsClear() then
	self:LaneClear()
	self:JungleClear()
	end

	if Menu.combo.AutoRA >= 2 then
	self:AutoR()
	end

	self:KillSteal()
	end

	function Ezreal:AutoR()
	if OrbwalkManager:IsCombo() then
	for _, enemy in pairs(GetEnemyHeroes()) do
	if GetDistance(enemy) <= Menu.combo.MaxRRange then
  local CastPosition, WillHit, NumberOfHits = Prediction:GetPrediction(enemy, {Delay = 0.125, Width = 50, Speed = 1700, Range = 950, Source = myHero, Type = SPELL_TYPE.LINEAR, Collision = false, Aoe = true, TypeOfPrediction = "VPrediction", Accuracy = 50})
  if CastPosition and WillHit and NumberOfHits >= Menu.combo.AutoRA and RSpell:IsReady() then
  CastSpell(_R, CastPosition.x, CastPosition.z)
  end
	end
	end
	end
	end

	function Ezreal:Combo(unit)
	if Menu.combo.UseQ then QSpell:Cast(unit) end
	if Menu.combo.UseW then WSpell:Cast(unit) end
	end

	function Ezreal:Harass(unit)
	if not self:ManaLow("harass") then
	if Menu.harass.UseQ then QSpell:Cast(unit) end
	if Menu.harass.UseW then WSpell:Cast(unit) end
	end
	end

	function Ezreal:LastHit()
	enemyMinions:update()
	if not self:ManaLow("lasthit") then
	for i, minion in pairs(enemyMinions.objects) do
	local health = minion.health
	if Menu.lasthit.UseQ and health <= self:GetDmg(_Q, minion) then
	if not OrbwalkManager:CanAttack() then
	if OrbwalkManager.AA.LastTarget and minion.networkID ~= OrbwalkManager.AA.LastTarget.networkID and not OrbwalkManager:IsAttacking() then
 	QSpell:Cast(minion)
	end
	end
	end
	end
	end
	end

	function Ezreal:LaneClear()
	if not self:ManaLow("laneclear") then
	if Menu.laneclear.UseQ then QSpell:LaneClear() end
	end
	end

	function Ezreal:JungleClear()
	if not self:ManaLow("jungleclear") then
	if Menu.jungleclear.UseQ then QSpell:JungleClear() end
	end
	end

	function Ezreal:ManaLow(menu)
  if menu == "harass" then if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then return true else return false end end
  if menu == "lasthit" then if myHero.mana < (myHero.maxMana * ( Menu.lasthit.mManager / 100)) then return true else return false end end
  if menu == "laneclear" then if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then return true else return false end end
  if menu == "jungleclear" then if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then return true else return false end end
	end

	function Ezreal:KillSteal()
	for _, unit in pairs(GetEnemyHeroes()) do
	local health = unit.health
	if not Menu.killsteal.KSOn then return end
	if health <= self:GetDmg(_Q, unit) and GetDistance(unit) <= 1000 and Menu.killsteal.UseQ and QSpell:IsReady() then
	QSpell:Cast(unit)
	end

	if health <= self:GetDmg(_W, unit) and Menu.killsteal.UseW and GetDistance(unit) <= 1150 and WSpell:IsReady() then
	WSpell:Cast(unit)
	end

	if health <= self:GetDmg(_R, unit) and Menu.killsteal.UseR and GetDistance(unit) <= Menu.killsteal.MaxRRange and GetDistance(unit) >= Menu.killsteal.MinRRange and RSpell:IsReady() then
	RSpell:Cast(unit)
	end

	if Ignite then
	if health <= 40 + (20 * myHero.level) and Menu.killsteal.Ignite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
	CastSpell(Ignite, unit)
	end
	end
	end
	end
	--Ezreal}

  --{Ryze
  function Ryze:__init()
  AddTickCallback(function() self:Tick() end)
  AddDrawCallback(function() self:Draw() end)
  AddApplyBuffCallback(function(source, unit, buff) self:ApplyBuff(source, unit, buff) end)
  AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
  AddUpdateBuffCallback(function(unit, buff, stacks) self:UpdateBuff(unit, buff, stacks) end)
  self.PassiveStacks = 0
  self.PassiveCharged = false
  self:Menu()
  end 

  function Ryze:Menu()
  Menu.combo:addSubMenu("W BlackList", "WBlack")
  for i, enemy in ipairs(GetEnemyHeroes()) do
  Menu.combo.WBlack:addParam(enemy.charName, "Not use W on: "..enemy.charName, SCRIPT_PARAM_ONOFF, false)
  end
  Menu.combo:addParam("ComboMode", "Combo Mode", SCRIPT_PARAM_LIST, 1, {"R W Q E", "R Q W E"})
  Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseRA", "Use R if Passive Stacks >= ", SCRIPT_PARAM_SLICE, 2, 2, 4, 0) 

  Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.harass:addParam("mManager", "Harass Mana", SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 

  Menu.lasthit:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.lasthit:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.lasthit:addParam("mManager", "LastHit Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("mManager", "LaneClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("mManager", "JungleClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end

  Menu:addSubMenu("Draws", "drawing")
  Menu.drawing:addParam("mDraw", "Disable All Draws", SCRIPT_PARAM_ONOFF, false)
  Menu.drawing:addParam("Passive", "Draw Passive Stacks", SCRIPT_PARAM_ONOFF, true)
  end

  function Ryze:Tick()
  if myHero.dead then return end
  ts:update()
  Target = ts.target
  if Target and Target ~= nil and ValidTarget(Target) then
  if OrbwalkManager:IsCombo() then 
  self:Combo(Target)
  end

  if OrbwalkManager:IsHarass() then
  self:Harass(Target)
  end

  if OrbwalkManager:IsLastHit() then
  self:LastHit(Target)
  end
  end

  if OrbwalkManager:IsClear() then
  self:LaneClear()
  self:JungleClear()
  end

  self:KillSteal()
  end

  function Ryze:GetDmg(spell, unit)
  if unit then
  if spell == _Q then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {60,85,110,135,160}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end

  if spell == _W then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {80,100,120,140,160}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end

  if spell == _E then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {36,52,64,84,100}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end
  end
  end

  function Ryze:CastW(unit)
  if unit then
  if myHero:CanUseSpell(_W) == READY then
  if GetDistance(unit) <= 615 then
  CastSpell(_W, unit)
  end
  end
  end
  end

  function Ryze:CastE(unit)
  if unit then
  if myHero:CanUseSpell(_E) == READY then
  if GetDistance(unit) <= 615 then
  CastSpell(_E, unit)
  end
  end
  end
  end

  function Ryze:Combo(unit)
  if Menu.combo.ComboMode == 1 then

  if not Menu.combo.WBlack[unit.charName] then
  if self.PassiveStacks >= Menu.combo.UseRA or self.PassiveCharged and myHero:CanUseSpell(_R) == READY and GetDistance(unit) <= 750 then CastSpell(_R)
  elseif myHero:CanUseSpell(_W) == READY then
  if Menu.combo.UseW then self:CastW(unit) end
  elseif myHero:CanUseSpell(_Q) == READY then
  if Menu.combo.UseQ then QSpell:Cast(unit) end
  elseif myHero:CanUseSpell(_E) == READY then
  if Menu.combo.UseE then self:CastE(unit) end
  end

  else

  if self.PassiveStacks >= Menu.combo.UseRA and myHero:CanUseSpell(_R) == READY and GetDistance(unit) <= 750 then CastSpell(_R)
  elseif myHero:CanUseSpell(_Q) == READY then
  if Menu.combo.UseQ then QSpell:Cast(unit) end
  elseif myHero:CanUseSpell(_E) == READY then
  if Menu.combo.UseE then self:CastE(unit) end
  end
  end

  elseif Menu.combo.ComboMode == 2 then
  if not Menu.combo.WBlack[unit.charName] then
  if self.PassiveStacks >= Menu.combo.UseRA and myHero:CanUseSpell(_R) == READY and GetDistance(unit) <= 750 then CastSpell(_R)
  elseif myHero:CanUseSpell(_Q) == READY then
  if Menu.combo.UseQ then QSpell:Cast(unit) end
  elseif myHero:CanUseSpell(_W) == READY then
  if Menu.combo.UseW and not Menu.combo.WBlack[unit.charName] then self:CastW(unit) end
  elseif myHero:CanUseSpell(_E) == READY then
  if Menu.combo.UseE then self:CastE(unit) end
  end

  else

  if self.PassiveStacks >= Menu.combo.UseRA and myHero:CanUseSpell(_R) == READY and GetDistance(unit) <= 750 then CastSpell(_R)
  elseif myHero:CanUseSpell(_Q) == READY then
  if Menu.combo.UseQ then QSpell:Cast(unit) end
  elseif myHero:CanUseSpell(_E) == READY then
  if Menu.combo.UseE then self:CastE(unit) end
  end
  end

  end
  end

  function Ryze:Harass(unit)
  if not self:ManaLow("harass") then
  if Menu.harass.UseQ then QSpell:Cast(unit) end
  end
  end

  function Ryze:LastHit()
  enemyMinions:update()
  if not self:ManaLow("lasthit") then
  for i, minion in pairs(enemyMinions.objects) do
  QDmg = self:GetDmg(_Q, minion)
  WDmg = self:GetDmg(_W, minion)
  local health = minion.health
  if not OrbwalkManager:CanAttack() then
  if OrbwalkManager.AA.LastTarget and minion.networkID ~= OrbwalkManager.AA.LastTarget.networkID and not OrbwalkManager:IsAttacking() then
  if Menu.lasthit.UseQ and health <= QDmg then QSpell:Cast(unit) end
  if Menu.lasthit.UseW and health <= WDmg then self:CastW(unit) end
  end
  end
  end
  end
  end

  function Ryze:LaneClear()
  enemyMinions:update()
  if not self:ManaLow("laneclear") then
  if Menu.laneclear.UseQ then QSpell:LaneClear() end
  for i, minion in pairs(enemyMinions.objects) do
  if Menu.laneclear.UseW and GetDistance(minion) <= 600 then CastSpell(_W, minion) end
  if Menu.laneclear.UseE and GetDistance(minion) <= 600 then CastSpell(_E, minion) end 
  end
  end
  end

  function Ryze:JungleClear()
  jungleMinions:update()
  if not self:ManaLow("jungleclear") then
  if Menu.jungleclear.UseQ then QSpell:JungleClear() end
  for i, minion in pairs(jungleMinions.objects) do
  if Menu.jungleclear.UseW and GetDistance(minion) <= 600 then CastSpell(_W, minion) end
  if Menu.jungleclear.UseE and GetDistance(minion) <= 600 then CastSpell(_E, minion) end 
  end
  end
  end

  function Ryze:ApplyBuff(source, unit, buff)
  if source and source.isMe and buff and buff.name and buff.name:find("ryzepassivecharged") then
  self.PassiveCharged = true
  end
  end

  function Ryze:RemoveBuff(unit, buff) 
  if unit and unit.isMe and buff and buff.name then
  if buff.name:find("ryzepassivestack") then
  self.PassiveStacks = 0
  end
  if buff.name:find("ryzepassivecharged") then
  self.PassiveCharged = false
  end
  end
  end

  function Ryze:UpdateBuff(unit, buff, stacks)
  if unit and unit.isMe and buff and buff.name and buff.name:find("ryzepassivestack") then
  self.PassiveStacks = stacks
  end
  end

  function Ryze:Draw()
  if not myHero.dead and not Menu.drawing.mDraw then
  if Menu.drawing.Passive then
  DrawText3D("Passive Stacks: "..self.PassiveStacks,myHero.x-100, myHero.y-50, myHero.z, 20, 0xFF631DB4)
  end
  end
  end

  function Ryze:ManaLow(menu)
  if menu == "harass" then if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then return true else return false end end
  if menu == "lasthit" then if myHero.mana < (myHero.maxMana * ( Menu.lasthit.mManager / 100)) then return true else return false end end
  if menu == "laneclear" then if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then return true else return false end end
  if menu == "jungleclear" then if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then return true else return false end end
  end

  function Ryze:KillSteal()
  for _, unit in pairs(GetEnemyHeroes()) do
  local health = unit.health
  if not Menu.killsteal.KSOn then return end
  QDmg = self:GetDmg(_Q, unit)
  WDmg = self:GetDmg(_W, unit)
  EDmg = self:GetDmg(_E, unit)

  if GetDistance(unit) <= 1000 then
  if Menu.killsteal.UseQ and health <= QDmg then QSpell:Cast(unit) end
  if Menu.killsteal.UseW and health <= WDmg then self:CastW(unit) end
  if Menu.killsteal.UseE and health <= EDmg then self:CastE(unit) end
  end

  if Ignite then
  if health <= 40 + (20 * myHero.level) and Menu.killsteal.Ignite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
  CastSpell(Ignite, unit)
  end
  end
  end
  end
  --Ryze}

  --{TwistedFate
  function TwistedFate:__init()
  VP = VPrediction()
  AddTickCallback(function() self:Tick() end)
  AddDrawCallback(function() self:Draw() end)
  AddCreateObjCallback(function(obj) self:CreateObj(obj) end)
  AddDeleteObjCallback(function(obj) self:DeleteObj(obj) end)
  AddApplyBuffCallback(function(unit, buff) self:ApplyBuff(unit, buff) end)
  AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
  AddUpdateBuffCallback(function(unit, buff) self:UpdateBuff(unit, buff) end)
  AddProcessSpellCallback(function(unit, spell) self:ProcessSpell(unit, spell) end)
  Ulting = false
  eStacks = 0
  selected = nil
  lastUse,lastUse2 = 0,0
  WREADY = false
  SelectedCard = nil
  self:Menu()
  end 

  function TwistedFate:Menu()
  Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("qMode", "Q Mode", SCRIPT_PARAM_LIST, 3, {"Always", "Stunned", "Q-W Logic"})
  Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("RangeW", "Range to use W",  SCRIPT_PARAM_SLICE, 750, 700, 1000, 0) 
  Menu.combo:addParam("UseRedCard", "Pick Red Card if can hit x enemies", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("RedCardA", "Red Card x enemies",  SCRIPT_PARAM_SLICE, 3, 2, 5, 0) 
  Menu.combo:addParam("card", "Card Type", SCRIPT_PARAM_LIST, 3, { "Blue Card", "Red Card", "Yellow Card"})
  Menu.combo:addParam("goldR", "Select Gold Card When Using Ultimate", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("BlockAA", "Block AA in card selection", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("randomCard", "Random Card if enemy killable", SCRIPT_PARAM_ONOFF, true)
  
  Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.harass:addParam("mManager", "Harass Mana",  SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 
  
  Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("card", "Card Type", SCRIPT_PARAM_LIST, 1, { "Blue Card", "Red Card", "Yellow Card"})
  Menu.laneclear:addParam("mManager", "LaneClear Mana",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("card", "Card Type", SCRIPT_PARAM_LIST, 1, { "Blue Card", "Red Card", "Yellow Card"})
  Menu.jungleclear:addParam("mManager", "JungleClear Mana",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
  
  Menu:addSubMenu("Draws", "drawing") 
  Menu.drawing:addParam("mDraw", "Disable All Draws", SCRIPT_PARAM_ONOFF, false)
  Menu.drawing:addParam("DrawCards", "Draw Cards", SCRIPT_PARAM_ONOFF, true)
  Menu.drawing:addParam("DrawRRange", "Draw R Range (Minimap)", SCRIPT_PARAM_ONOFF, true)
  Menu.drawing:addParam("eStacks", "Draw E Stacks", SCRIPT_PARAM_ONOFF, true)
  
  Menu:addSubMenu("Card Selector", "cardselector")
  Menu.cardselector:addParam("GoldCard", "Gold Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("8"))
  Menu.cardselector:addParam("BlueCard", "Blue Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("9"))
  Menu.cardselector:addParam("RedCard", "Red Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("0"))
  end

  function TwistedFate:Tick()
  if myHero.dead then return end
  ts:update()
  Target = ts.target
  if Target and Target ~= nil and ValidTarget(Target) then
  if OrbwalkManager:IsCombo() then 
  self:Combo(Target)
  end

  if OrbwalkManager:IsHarass() then
  self:Harass(Target)
  end
  end

  if OrbwalkManager:IsClear() then
  self:LaneClear()
  self:JungleClear()
  end

  self:KillSteal()
  self:SelectorCards()
  self:UltimateCard()
  end

  function TwistedFate:GetDmg(spell, unit)
  if unit then
  if spell == _Q then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {60,105,150,195,240}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end
  end
  end

  function TwistedFate:BlockAA()
  if Menu.combo.BlockAA then
  if PickingCard then
  
  if SAC then
  _G.AutoCarry.MyHero:AttacksEnabled(false)
  elseif SXORB then
  SxOrb:DisableAttacks()
  end
  
  else
  
  if SAC then
  _G.AutoCarry.MyHero:AttacksEnabled(true)
  elseif SXORB then
  SxOrb:EnableAttacks()
  end
  end
  end
  end

  function TwistedFate:CreateObj(obj)
  if obj ~= nil and obj.name ~= nil and obj.x ~= nil and obj.z ~= nil then
  if obj.name == "TwistedFate_Base_W_BlueCard.troy" then
  PickingCard = true
  PickingCard2 = true
  BlueDraw = true
  SelectedCard = "Blue"
  end
  if obj.name == "TwistedFate_Base_W_RedCard.troy" then
  PickingCard = true
  PickingCard2 = true
  RedDraw = true
  SelectedCard = "Red"
  end
  if obj.name == "TwistedFate_Base_W_GoldCard.troy" then
  PickingCard = true
  PickingCard2 = true
  GoldDraw = true
  SelectedCard = "Gold"
  end
  if obj.name == "Cardmaster_stackready.troy" then
  eStacks = "Stacked"
  end
  if obj.name == "PickaCard_yellow_tar.troy" then
  YellowTARDraw = obj
  end
  end
  end

  function TwistedFate:DeleteObj(obj)
  if obj ~= nil and obj.name ~= nil and obj.x ~= nil and obj.z ~= nil then
  if obj.name == "TwistedFate_Base_W_BlueCard.troy" then
  BlueDraw = false
  SelectedCard = nil
  end
  if obj.name == "TwistedFate_Base_W_RedCard.troy" then
  RedDraw = false
  SelectedCard = nil
  end
  if obj.name == "TwistedFate_Base_W_GoldCard.troy" then
  GoldDraw = false
  SelectedCard = nil
  end
  if obj.name == "Cardmaster_stackready.troy" then
  eStacks = 0
  end
  if obj.name == "PickaCard_yellow_tar.troy" then
  YellowTARDraw = nil
  end
  end
  end
  
  function TwistedFate:SelectorCards()
  WREADY = (myHero:CanUseSpell(_W) == READY)
  if WREADY and GetTickCount()-lastUse <= 2300 then
  if myHero:GetSpellData(_W).name == selected then 
  DelayAction(function() selected = nil end,1.0)
  CastSpell(_W) 
  end
  end
  if WREADY and myHero:GetSpellData(_W).name == "PickACard" and GetTickCount()-lastUse2 >= 2400 and GetTickCount()-lastUse >= 500 then 
  if Menu.cardselector.GoldCard then selected = "goldcardlock"
  elseif Menu.cardselector.BlueCard then selected = "bluecardlock"
  elseif Menu.cardselector.RedCard then selected = "redcardlock"
  else return end 
  CastSpell(_W)
  lastUse = GetTickCount()
  end
  end

  function TwistedFate:Combo(unit)
  local Name = myHero:GetSpellData(_W).name
  local dmgW = getDmg("W", myHero, unit)
  local Ehealth = unit.health
  spellName = nil
  if Menu.combo.UseQ then 
  self:CastQC(unit)
  self:ComboQW(unit)
  end 
    
  if Menu.combo.UseW and myHero:CanUseSpell(_W) == READY then 
    
  if Menu.combo.randomCard and Ehealth <= dmgW and GetDistance(unit) <= Menu.combo.RangeW then
  CastSpell(_W)
  end
    
  for _, unit in pairs(GetEnemyHeroes()) do
  if GetDistance(unit) <= Menu.combo.RangeW then

  local AOECastPosition, MainTargetHitChance, nTargets = VP:GetCircularAOECastPosition(Target, 0, 80, 600, 2000, myHero)
  if Menu.combo.UseRedCard and nTargets >= Menu.combo.RedCardA then
  CardSel = "Red"
  end

  if Menu.combo.card == 1 and nTargets <= 1 then
  CardSel = "Blue"
  elseif Menu.combo.card == 2 and nTargets <= 1 then
  CardSel = "Red"
  elseif Menu.combo.card == 3 and nTargets <= 1 then
  CardSel = "Gold"
  end 
        
  if Name == "PickACard" then
  CastSpell(_W)
  end
        
  if SelectedCard == CardSel then
  CastSpell(_W)
  end     
  end
  end       
  end 
  end

  function TwistedFate:Harass(unit)
  if not self:ManaLow("harass") then
  if Menu.harass.UseQ then QSpell:Cast(unit) end
  end
  end

  function TwistedFate:LaneClear()
  enemyMinions:update()
  if not self:ManaLow("laneclear") then
  for i, minion in pairs(enemyMinions.objects) do
  if ValidTarget(minion) and minion ~= nil then
  if Menu.laneclear.UseQ then
  QSpell:Cast(minion)
  end
  local Name = myHero:GetSpellData(_W).name
  if Menu.laneclear.UseW and myHero:CanUseSpell(_W) == READY and GetDistance(minion) <= 700 then
  if Menu.laneclear.card == 1 then
  CardSel = "Blue"
  elseif Menu.laneclear.card == 2 then
  CardSel = "Red"
  elseif Menu.laneclear.card == 3 then
  CardSel = "Gold"
  end 
        
  if Name == "PickACard" then
  CastSpell(_W)
  end
        
  if SelectedCard == CardSel then
  CastSpell(_W)
  end   
  end
  end
  end
  elseif self:ManaLow("laneclear") then
  for i, minion in pairs(enemyMinions.objects) do
  if ValidTarget(minion) and minion ~= nil and GetDistance(minion) <= 600 then
  local Name = myHero:GetSpellData(_W).name
  CardSel = "Blue"
  if Name == "PickACard" then
  CastSpell(_W) 
  end
        
  if SelectedCard == CardSel then
  CastSpell(_W)
  end   
  end
  end
  end
  end

  function TwistedFate:JungleClear()
  jungleMinions:update()
  if not self:ManaLow("jungleclear") then
  for i, jungleMinion in pairs(jungleMinions.objects) do
  if jungleMinion ~= nil then
  if Menu.jungleclear.UseQ then QSpell:Cast(jungleMinion)end
  local Name = myHero:GetSpellData(_W).name
  if Menu.jungleclear.UseW and myHero:CanUseSpell(_W) == READY and GetDistance(jungleMinion) <= 600 then
  if Menu.jungleclear.card == 1 then
  CardSel = "Blue"
  elseif Menu.jungleclear.card == 2 then
  CardSel = "Red"
  elseif Menu.jungleclear.card == 3 then
  CardSel = "Gold"
  end 
        
  if Name == "PickACard" then
  CastSpell(_W)
  end
        
  if SelectedCard == CardSel then
  CastSpell(_W)
  end   
  end
  end
  end
  elseif self:ManaLow("jungleclear") then
  for i, minion in pairs(jungleMinions.objects) do
  if ValidTarget(minion) and minion ~= nil and GetDistance(minion) <= 600 then
  local Name = myHero:GetSpellData(_W).name
  CardSel = "Blue"
  if Name == "PickACard" then
  CastSpell(_W) 
  end
        
  if SelectedCard == CardSel then
  CastSpell(_W)
  end   
  end
  end
  end
  end

  function TwistedFate:HaveBuffs(unit, buffs)
  for i = 1, unit.buffCount, 1 do      
  local buff = unit:getBuff(i) 
  if buff.valid and buff.type == buffs then
  return true            
  end                    
  end
  end

  function TwistedFate:ApplyBuff(unit, buff)
  if unit == nil or buff == nil then return end 
  if unit.isMe and buff.name == "cardmasterstackholder" then
  eStacks = buff.stack
  end
  end

  function TwistedFate:RemoveBuff(unit, buff)
  if unit.isMe and buff.name == "pickacard_tracker" then
  PickingCard = false
  DelayAction(function() PickingCard2 = false end,1.0)
  PickedCard = true
  end
  end

  function TwistedFate:UpdateBuff(unit, buff)
  if unit == nil or buff == nil then return end 
  if unit.isMe and buff.name == "cardmasterstackholder" and eStacks ~= "Stacked" then
  eStacks = eStacks + 1
  end
  end

  function TwistedFate:Draw()
  if not myHero.dead and not Menu.drawing.mDraw then
  if Menu.drawing.DrawCards then
    
  if BlueDraw then
  DrawCircle(myHero.x, myHero.y, myHero.z, 340, 0xff0000ff)
  end
    
  if RedDraw then
  DrawCircle(myHero.x, myHero.y, myHero.z, 340, 0xffff0000) 
  end
    
  if GoldDraw then
  DrawCircle(myHero.x, myHero.y, myHero.z, 340, 0xffffff00)
  end
  end
    
  if Menu.drawing.DrawRRange then
  DrawCircleMinimap(myHero.x + 1000, myHero.y + 1000, myHero.z - 630, 4500)
  end
    
  if Menu.drawing.eStacks then
  DrawText3D("E Stacks: "..eStacks, myHero.x-100, myHero.y-50, myHero.z-30, 20, 0xff00ff00)
  end
  end
  end

  function TwistedFate:ManaLow(menu)
  if menu == "harass" then if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then return true else return false end end
  if menu == "lasthit" then if myHero.mana < (myHero.maxMana * ( Menu.lasthit.mManager / 100)) then return true else return false end end
  if menu == "laneclear" then if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then return true else return false end end
  if menu == "jungleclear" then if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then return true else return false end end
  end

  function TwistedFate:ComboQW(unit)
  local TargetGoldCard = YellowTARDraw ~= nil and GetDistance(YellowTARDraw, unit) <= 20 
  local buffsList = 6, 8, 11, 20, 21, 23, 29
  if Menu.combo.qMode == 3 then
  if TargetGoldCard then
  QSpell:Cast(unit)
  elseif self:HaveBuffs(unit, buffsList) then
  QSpell:Cast(unit)
  elseif myHero:GetSpellData(_W).currentCd >= 1.5 then
  QSpell:Cast(unit)
  end
  end
  end

  function TwistedFate:CastQC(unit)
  if Menu.combo.qMode == 3 then return end
  if Menu.combo.qMode == 1 then
  QSpell:Cast(unit)
  elseif Menu.combo.qMode == 2 then
  if TargetHaveBuff("Stun", unit) then 
  QSpell:Cast(unit)
  end
  end
  end

  function TwistedFate:UltimateCard()
  if myHero:CanUseSpell(_W) == 8 or myHero:CanUseSpell(_W) == 32 or myHero:CanUseSpell(_W) == 64 or myHero:CanUseSpell(_W) == 96 then return end
  if Ulting then
  WREADY = (myHero:CanUseSpell(_W) == READY)
  if WREADY and GetTickCount()-lastUse <= 2300 then
  if myHero:GetSpellData(_W).name == selected then 
  DelayAction(function() selected = nil end,1.0)
  CastSpell(_W) 
  DelayAction(function() Ulting = false end,0.5)
  end
  end
  if WREADY and myHero:GetSpellData(_W).name == "PickACard" and GetTickCount()-lastUse2 >= 2400 and GetTickCount()-lastUse >= 500 then 
  selected = "goldcardlock"
  else return end 
  CastSpell(_W)
  lastUse = GetTickCount()
  end
  end


  function TwistedFate:ProcessSpell(unit, spell)
  if unit.isMe and spell.name == "PickACard" then lastUse2 = GetTickCount() end
  if unit.isMe and spell.name == "gate" then 
  if Menu.combo.goldR then 
  if myHero:CanUseSpell(_W) == READY then
  Ulting = true
  end
  end 
  end
  end

  function TwistedFate:KillSteal()
  for _, unit in pairs(GetEnemyHeroes()) do
  local health = unit.health
  if not Menu.killsteal.KSOn then return end
  QDmg = self:GetDmg(_Q, unit)

  if GetDistance(unit) <= 1300 then
  if Menu.killsteal.UseQ and health <= QDmg then QSpell:Cast(unit) end
  end

  if Ignite then
  if health <= 40 + (20 * myHero.level) and Menu.killsteal.Ignite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
  CastSpell(Ignite, unit)
  end
  end
  end
  end
  --TwistedFate}

  --{Bard
  function Bard:__init()
  VP = VPrediction()
  AddTickCallback(function() self:Tick() end)
  self:Menu()
  end

  function Bard:Menu()
  Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)

  Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.harass:addParam("mManager", "Harass Mana", SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 
  
  --[[Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("mManager", "LaneClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)]]
  
  Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("mManager", "JungleClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
  end

  function Bard:GetDmg(spell, unit)
  if unit then
  if spell == _Q then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {80,125,170,215,260}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  return myHero:CalcMagicDamage(unit, TrueDamage)
  end
  end
  end

  function Bard:Tick()
  if myHero.dead then return end
  ts:update()
  Target = ts.target

  if Target and Target ~= nil and ValidTarget(Target) then

  if OrbwalkManager:IsCombo() then 
  self:Combo(Target)
  end

  if OrbwalkManager:IsHarass() then
  self:Harass(Target)
  end
  end

  if OrbwalkManager:IsClear() then
  --self:LaneClear()
  self:JungleClear()
  end

  self:KillSteal()
  end

  function Bard:Combo(unit)
  if Menu.combo.UseQ then self:Cast(unit) end
  end

  function Bard:Harass(unit)
  if not self:ManaLow("harass") then
  if Menu.harass.UseQ then self:Cast(unit) end
  end
  end

  function Bard:LastHit()
  enemyMinions:update()
  if not self:ManaLow("lasthit") then
  for i, minion in pairs(enemyMinions.objects) do
  local health = minion.health
  if Menu.lasthit.UseQ and health <= self:GetDmg(_Q, minion) then
  if not OrbwalkManager:CanAttack() then
  if OrbwalkManager.AA.LastTarget and minion.networkID ~= OrbwalkManager.AA.LastTarget.networkID and not OrbwalkManager:IsAttacking() then
  self:Cast(minion)
  end
  end
  end
  end
  end
  end

  function Bard:LaneClear()
  enemyMinions:update()
  if not self:ManaLow("laneclear") then
  for i, minion in pairs(enemyMinions.objects) do
  if Menu.laneclear.UseQ then self:Cast(minion) end
  end
  end
  end

  function Bard:JungleClear()
  jungleMinions:update()
  if not self:ManaLow("jungleclear") then
  for i, minion in pairs(jungleMinions.objects) do
  if Menu.jungleclear.UseQ then self:Cast(minion) end
  end
  end
  end

  function Bard:ManaLow(menu)
  if menu == "harass" then if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then return true else return false end end
  if menu == "lasthit" then if myHero.mana < (myHero.maxMana * ( Menu.lasthit.mManager / 100)) then return true else return false end end
  if menu == "laneclear" then if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then return true else return false end end
  if menu == "jungleclear" then if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then return true else return false end end
  end

function Bard:Cast(unit)
  if not QSpell:IsReady() or not ValidTarget(unit) then return end

  local CastPosition, Hitchance = VP:GetLineCastPosition(unit, 0.25, 108, 850, 1100, myHero, true)
  if CastPosition then 
  local dp = GetDistance(myHero.pos, CastPosition)
  if dp < 1100 then
  local extend = 635 - dp - 20
  if extend > 1 then
  local extendedCollision = Vector(CastPosition) + (Vector(CastPosition) - Vector(myHero)):normalized() * (extend)
  if Hitchance >= 2 then
  for i, enemy in pairs(GetEnemyHeroes()) do
  if enemy ~= unit then
  if VP:CheckCol(extendedCollision, enemy, CastPosition, 0.25, 108, 850, 1100, myHero) then
  CastSpell(0, CastPosition.x, CastPosition.z)
  return
  end
  end
  end
  local col = VP:CheckMinionCollision(unit, extendedCollision, 0.25, 108, extend, 1100, CastPosition, false, true)
  if col then
  CastSpell(0, CastPosition.x, CastPosition.z)
  return
  end
  local amount = extend/10
  local count = 1
  while count <= 10 do
  local extendedWall = Vector(CastPosition) + (Vector(CastPosition) - Vector(myHero)):normalized() * (amount*count)
  local vec1 = D3DXVECTOR3(extendedWall.x, extendedWall.y,extendedWall.z)
  if IsWall(vec1) then
  CastSpell(0, CastPosition.x, CastPosition.z)
  return
  end
  count = count + 1
  end
  end
  end
  end
  end
  end


  function Bard:KillSteal()
  for _, unit in pairs(GetEnemyHeroes()) do
  local health = unit.health
  if not Menu.killsteal.KSOn then return end

  if health <= self:GetDmg(_Q, unit) and Menu.killsteal.UseQ then
  QSpell:Cast(unit)
  end

  if Ignite then
  if health <= 40 + (20 * myHero.level) and Menu.killsteal.Ignite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
  CastSpell(Ignite, unit)
  end
  end
  end
  end
  --Bard}

  --{Kayle
  function Kayle:__init()
  AddTickCallback(function() self:Tick() end)
  self:Menu()
  end

  function Kayle:Menu()
  Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)

  Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.harass:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.harass:addParam("mManager", "Harass Mana", SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 
  
  Menu.lasthit:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.lasthit:addParam("mManager", "LaneClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)

  Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("mManager", "LaneClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
  
  Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("mManager", "JungleClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end

  Menu:addSubMenu("Automatic Settings", "auto")
  Menu.auto:addSubMenu("Auto Heal", "autoh")
  Menu.auto.autoh:addParam("UseW", "Use Auto Heal", SCRIPT_PARAM_ONOFF, true)
  Menu.auto.autoh:addParam("amount", "Auto Heal if health < %", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
  Menu.auto:addSubMenu("Auto Ultimate", "autor")
  Menu.auto.autor:addParam("UseR", "Use Auto Ultimate", SCRIPT_PARAM_ONOFF, true)
  Menu.auto.autor:addParam("amount", "Auto Ultimate if health < %", SCRIPT_PARAM_SLICE, 7, 0, 100, 0)
  end

  function Kayle:GetDmg(spell, unit)
  if unit then
  if spell == _Q then
  local Lvl = myHero:GetSpellData(spell).level
  if Lvl < 1 then return 0 end
  local BaseDamage = {60,110,160,210,260}
  local ScaledDamage = {.1,.2,.3,.4,.5}
  local TrueDamage = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.ap
  local TrueDamage1 = BaseDamage[Lvl] + ScaledDamage[Lvl]*myHero.damage
  return myHero:CalcMagicDamage(unit, TrueDamage) + myHero:CalcDamage(unit, TrueDamage1)
  end
  end
  end

  function Kayle:Tick()
  if myHero.dead then return end
  ts:update()
  Target = ts.target

  if Target and Target ~= nil and ValidTarget(Target) then

  if OrbwalkManager:IsCombo() then 
  self:Combo(Target)
  end

  if OrbwalkManager:IsHarass() then
  self:Harass(Target)
  end
  end

  if OrbwalkManager:IsLastHit() then
  self:LastHit()
  end

  if OrbwalkManager:IsClear() then
  self:LaneClear()
  self:JungleClear()
  end

  self:KillSteal()
  self:AutoHeal()
  self:AutoUltimate()
  end

  function Kayle:AutoHeal()
  if Menu.auto.autoh.UseW then
  if not Recalling and not InFountain() then 
  if myHero:CanUseSpell(_W) == READY and myHero.health < (myHero.maxHealth * (Menu.auto.autoh.amount/100)) then 
  CastSpell(_W, myHero)
  end
  end
  end
  end

  function Kayle:AutoUltimate()
  if Menu.auto.autor.UseR then
  if not Recalling and not InFountain() then 
  for i, enemy in ipairs(GetEnemyHeroes()) do
  if myHero:CanUseSpell(_R) == READY and GetDistance(enemy, myHero) <= 1000 and myHero.health < (myHero.maxHealth * (Menu.auto.autor.amount/100)) then 
  CastSpell(_R, myHero)
  end
  end
  end
  end
  end

  function Kayle:Combo(unit)
  if Menu.combo.UseQ and GetDistance(unit) <= 650 then CastSpell(_Q, unit) end
  if Menu.combo.UseE and GetDistance(unit) <= 650 then CastSpell(_E) end
  end

  function Kayle:Harass(unit)
  if not self:ManaLow("harass") then
  if Menu.harass.UseQ and GetDistance(unit) <= 650 then CastSpell(_Q, unit) end
  if Menu.harass.UseE and GetDistance(unit) <= 650 then CastSpell(_E) end
  end
  end

  function Kayle:LastHit()
  enemyMinions:update()
  if not self:ManaLow("lasthit") then
  for i, minion in pairs(enemyMinions.objects) do
  local health = minion.health
  if Menu.lasthit.UseQ and health <= self:GetDmg(_Q, minion) and GetDistance(minion) <= 650 then
  if not OrbwalkManager:CanAttack() then
  if OrbwalkManager.AA.LastTarget and minion.networkID ~= OrbwalkManager.AA.LastTarget.networkID and not OrbwalkManager:IsAttacking() then
  CastSpell(_Q, minion)
  end
  end
  end
  end
  end
  end

  function Kayle:LaneClear()
  enemyMinions:update()
  if not self:ManaLow("laneclear") then
  for i, minion in pairs(enemyMinions.objects) do
  if Menu.laneclear.UseQ and GetDistance(minion) <= 650 then CastSpell(_Q, minion) end
  if Menu.laneclear.UseE and GetDistance(minion) <= 650 then CastSpell(_E) end
  end
  end
  end

  function Kayle:JungleClear()
  jungleMinions:update()
  if not self:ManaLow("jungleclear") then
  for i, minion in pairs(jungleMinions.objects) do
  if Menu.jungleclear.UseQ and GetDistance(minion) <= 650 then CastSpell(_Q, minion) end
  if Menu.jungleclear.UseE and GetDistance(minion) <= 650 then CastSpell(_E) end
  end
  end
  end

  function Kayle:ManaLow(menu)
  if menu == "harass" then if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then return true else return false end end
  if menu == "lasthit" then if myHero.mana < (myHero.maxMana * ( Menu.lasthit.mManager / 100)) then return true else return false end end
  if menu == "laneclear" then if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then return true else return false end end
  if menu == "jungleclear" then if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then return true else return false end end
  end

  function Kayle:KillSteal()
  for _, unit in pairs(GetEnemyHeroes()) do
  local health = unit.health
  if not Menu.killsteal.KSOn then return end

  if health <= self:GetDmg(_Q, unit) and Menu.killsteal.UseQ and GetDistance(unit) <= 650 then
  CastSpell(_Q, unit)
  end

  if Ignite then
  if health <= 40 + (20 * myHero.level) and Menu.killsteal.Ignite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
  CastSpell(Ignite, unit)
  end
  end
  end
  end
  --Kayle}

  --{Vayne
  function Vayne:__init()
  AddTickCallback(function() self:Tick() end)
  AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
  AddUpdateBuffCallback(function(unit, buff, stacks) self:UpdateBuff(unit, buff, stacks) end)
  self:Menu()
  VP = VPrediction()
  WStacks = {}
  end 

  function Vayne:Menu()
  Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
  Menu.combo:addParam("UseRA", "Use R >= targets", SCRIPT_PARAM_SLICE, 3, 2, 5, 0) 
  
  Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.laneclear:addParam("mManager", "LaneClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
  Menu.jungleclear:addParam("mManager", "JungleClear Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
  
  if Ignite then Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
  Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) 
  else 
  Menu.killsteal:addParam("info", "Ignite not found", SCRIPT_PARAM_INFO, "")
  end
  end

  function Vayne:Tick()
  if myHero.dead then return end
  ts:update()
  Target = ts.target
  if Target and Target ~= nil and ValidTarget(Target) then

  if OrbwalkManager:IsCombo() then 
  self:Combo(Target)
  end
  end

  if OrbwalkManager:IsClear() then
  self:LaneClear()
  self:JungleClear()
  end

  self:KillSteal()
  end

  function Vayne:UpdateBuff(unit, buff, stacks)
  if unit == nil or buff == nil then return end
  if buff.name == "vaynesilvereddebuff"then
  if stacks >= 2 then
  table.insert(WStacks, unit)
  end
  end
  end

  function Vayne:RemoveBuff(unit, buff)
  if unit == nil or buff == nil then return end
  if buff.name == "vaynesilvereddebuff" then
  table.remove(WStacks)
  end
  end

  function Vayne:QLogic(unit)
  if unit then
  if myHero:CanUseSpell(_Q) == READY and GetDistance(unit) <= 1000 and OrbwalkManager:WindUpTime() >= 0.05 then
  if WStacks ~= nil then
  for i, Stacks in ipairs(WStacks) do
  if unit.charName == Stacks.charName then CastSpell(_Q, mousePos.x, mousePos.z)
  end
  end
  end
  end
  end
  end

  function Vayne:CastE(unit)
  if not unit or unit.dead or not unit.visible or not myHero:CanUseSpell(_E) == READY then return end
  local x, y = VP:CalculateTargetPosition(unit, 0.25, 0, 2000, myHero)
  local b = unit.boundingRadius
  for _=0,(415)*100/100,b do
  local dir = x+(Vector(x)-myHero):normalized()*_
  if IsWall(D3DXVECTOR3(dir.x,dir.y,dir.z)) then
  CastSpell(_E, unit)
  end
  end
  end

  function Vayne:Combo(unit)
  if Menu.combo.UseQ then self:QLogic(unit) end
  if Menu.combo.UseE then self:CastE(unit) end 
  if CountEnemyHeroInRange(1050) >= Menu.combo.UseRA and myHero:CanUseSpell(_R) == READY then CastSpell(_R) end
  end

  function Vayne:LaneClear()
  enemyMinions:update()
  if not self:ManaLow("laneclear") then
  for i, minion in pairs(enemyMinions.objects) do
  if Menu.laneclear.UseQ then self:QLogic(minion) end
  end
  end
  end

  function Vayne:JungleClear()
  jungleMinions:update()
  if not self:ManaLow("jungleclear") then
  for i, minion in pairs(jungleMinions.objects) do
  if Menu.jungleclear.UseQ then self:QLogic(minion) end
  if Menu.jungleclear.UseE then self:CastE(minion) end 
  end
  end
  end

  function Vayne:ManaLow(menu)
  if menu == "harass" then if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then return true else return false end end
  if menu == "lasthit" then if myHero.mana < (myHero.maxMana * ( Menu.lasthit.mManager / 100)) then return true else return false end end
  if menu == "laneclear" then if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then return true else return false end end
  if menu == "jungleclear" then if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then return true else return false end end
  end

  function Vayne:KillSteal()
  for _, unit in pairs(GetEnemyHeroes()) do
  local health = unit.health
  if not Menu.killsteal.KSOn then return end
  if Ignite then
  if health <= 40 + (20 * myHero.level) and Menu.killsteal.Ignite and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
  CastSpell(Ignite, unit)
  end
  end
  end
  end
  --Vayne}

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
local scriptname = "Slider Bundle"
local scriptmsg = "<font color=\"#ff0000\">[</font><font color=\"#a05b6b\">S</font><font color=\"#40b5d6\">l</font><font color=\"#40b5d6\">i</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">e</font><font color=\"#40b5d6\">r</font><font color=\"#40b5d6\"> </font><font color=\"#40b5d6\">B</font><font color=\"#40b5d6\">u</font><font color=\"#40b5d6\">n</font><font color=\"#40b5d6\">d</font><font color=\"#40b5d6\">l</font><font color=\"#a05b6b\">e</font><font color=\"#ff0000\">]</font>"
  function FindUpdates()
  if not AutoUpdate then return end
  local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/"..scriptname..".version")
  if ServerVersionDATA then
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersion then
      if ServerVersion > tonumber(LocalVersion) then
      PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> Updating, don't press F9.</b></font>")
      Update()
      else
      PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> You have the latest version.</b></font>")
      end
    else
    PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> An error occured, while updating, please reload.</b></font>")
    end
  else
  PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> Could not connect to update Server.</b></font>")
  end
end

function Update()
  DownloadFile("http://"..serveradress..scriptadress.."/"..scriptname..".lua",SCRIPT_PATH..scriptname..".lua", function ()
  PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> Updated, press 2x F9.</b></font>")
  end)
end
