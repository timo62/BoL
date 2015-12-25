if myHero.charName ~= "TwistedFate" then return end

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("QDGGLGLFEFK") 
-- Script Status --

local ts
local Ulting = false
local eStacks = 0
local SelectorCheck = false
local Selector = "any"
local LocalVersion = "2.2"
local autoupdate = true --Change to false if you don't wan't autoupdates

	function OnLoad()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	
	Menu = scriptConfig("HR Twisted Fate", "HRTwistedFate")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("qMode", "Q Mode", SCRIPT_PARAM_LIST, 2, { "Always", "Stunned"})
	Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("card", "Card Type", SCRIPT_PARAM_LIST, 3, { "Blue Card", "Red Card", "Yellow Card"})
	Menu.combo:addParam("goldR", "Select Gold Card When Using Ultimate", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("goldCard", "Auto Select Gold Card if low life", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("goldCardLow", "Select Gold Card When x Life %",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
	Menu.combo:addParam("BlockAA", "Block AA in card selection", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("randomCard", "Random Card if enemy killable", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("mManager", "Harass Mana",  SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("card", "Card Type", SCRIPT_PARAM_LIST, 1, { "Blue Card", "Red Card", "Yellow Card"})
	Menu.laneclear:addParam("mManager", "LaneClear Mana",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu:addSubMenu("JungleClear", "jungleclear")
	Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.jungleclear:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.jungleclear:addParam("card", "Card Type", SCRIPT_PARAM_LIST, 1, { "Blue Card", "Red Card", "Yellow Card"})
	Menu.jungleclear:addParam("mManager", "JungleClear Mana",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu:addSubMenu("HitChance", "hitchance")
	Menu.hitchance:addParam("QHitCH", "Q Hit Chance",  SCRIPT_PARAM_SLICE, 2, 1, 5, 1) 
	
	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
	
	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qDraw", "(Q) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qColor", "(Q) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("DrawCards", "Draw Cards", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("DrawRRange", "Draw R Range (Minimap)", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("eStacks", "Draw E Stacks ", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Card Selector", "cardselector")
	Menu.cardselector:addParam("GoldCard", "Gold Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("8"))
	Menu.cardselector:addParam("BlueCard", "Blue Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("9"))
	Menu.cardselector:addParam("RedCard", "Red Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("0"))
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LaneJungClear", "LaneClear / JungleClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	
	Menu:addParam("pred", "Prediction Type", SCRIPT_PARAM_LIST, 1, { "VPrediction", "HPrediction"})
	CustomLoad()
	
	if FileExist(LIB_PATH .. "/HPrediction.lua") then
	require 'HPrediction'
	
	HPred = HPrediction()
	HP_Q = HPSkillshot({type = "DelayLine", delay = 0.250, range = 1200, width = 80, speed = 1500})
	UseHP = true
else
	UseHP = false
	PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>If you want other Prediction download : HPrediction.</b></font>")
end

    if _G.Reborn_Loaded or _G.AutoCarry then
	PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>Loaded.</b></font>")	
	PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>Loading Sac.</b></font>")
	DelayAction(function()  
	SAC = true
	SXORB = false
	PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>Sac Loaded.</b></font>")
	end, 10)
	else
    LoadOrb()
	end
	
	end
	
	function CustomLoad()
	CheckVPred()
	Skills()		
	FindUpdates()
	
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGIC)
	ts.name = "Twisted Fate"
	Menu:addTS(ts)
	PriorityOnLoad()
  end
  
	function LoadOrb()
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>Loaded.</b></font>")
	PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>Loading SxOrbWalk.</b></font>")	
	require("SxOrbWalk")
	Menu:addSubMenu("SxOrbWalk", "SXMenu")
	SxOrb:LoadToMenu(Menu.SXMenu)
	SAC = false
	SXORB = true
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
		if GetDistance(unit) <= 1000 then
		if not Menu.killsteal.KSOn then return end
			if health <= dmgQ and Menu.killsteal.UseQ and myHero:CanUseSpell(_Q) == READY and ValidTarget(unit) then
				CastQ(unit)
				end
				if Ignite then
			if health <= 40 + (20 * myHero.level) and Menu.killsteal.I and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) then
				CastSpell(Ignite, unit)
			end
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
	LaneClearKey = Menu.keys.LaneJungClear
	JungleClearKey = Menu.keys.LaneJungClear
	GoldCardKey = Menu.cardselector.GoldCard
	BlueCardKey = Menu.cardselector.BlueCard
	RedCardKey = Menu.cardselector.RedCard
	
	if ComboKey then 
	Combo(Target)
	end
	
	if HarassKey and not ComboKey then
	Harass(Target)
	end	
	
	if LaneClearKey and not ComboKey then
	LaneClear()
	end
	
	if JungleClearKey and not ComboKey then
	JungleClear()
	end
	
	if Ulting then
	UltimateCard()
	end
	
	if GoldCardKey then
	Selector = "Gold"
	SelectorCheck = true
	end
	
	if BlueCardKey then
	Selector = "Blue"
	SelectorCheck = true
	end
	
	if RedCardKey then
	Selector = "Red"
	SelectorCheck = true
	end
	
	SelectorCards()
	UseSpells()
	AutoCard()
	BlockAA()
	end
	
function BlockAA()
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
	
function BlockAA()
	if Menu.combo.BlockAA then
	
	if PickingCard then
	
	if SAC then
    _G.AutoCarry.MyHero:AttacksEnabled(false)
	elseif SXORB then
	SxOrb:DisableAttacks()
	end
	end
	
	if PickedCard then
	
	if SAC then
    _G.AutoCarry.MyHero:AttacksEnabled(true)
	PickedCard = false
	elseif SXORB then
	SxOrb:EnableAttacks()
	PickedCard = false
end
end
end
end

function OnApplyBuff(unit, buff)
	if unit == nil or buff == nil then return end 
	if unit.isMe and buff.name == "cardmasterstackholder" then
		eStacks = buff.stack
	end
end

function OnUpdateBuff(unit, buff)
	if unit == nil or buff == nil then return end 
	if unit.isMe and buff.name == "cardmasterstackholder" and eStacks ~= "Stacked" then
		eStacks = eStacks + 1
	end
end

function OnCreateObj(obj)
 if obj and obj.name then
  if obj.name == "TwistedFate_Base_W_BlueCard.troy" then
	PickingCard = true
	BlueDraw = true
	SelectedCard = "Blue"
  end
  if obj.name == "TwistedFate_Base_W_RedCard.troy" then
	PickingCard = true
	RedDraw = true
	SelectedCard = "Red"
  end
  if obj.name == "TwistedFate_Base_W_GoldCard.troy" then
	PickingCard = true
	GoldDraw = true
	SelectedCard = "Gold"
  end
  if obj.name == "Cardmaster_stackready.troy" then
	eStacks = "Stacked"
  end
 end
end

function OnDeleteObj(obj)
 if obj and obj.name then
  if obj.name == "TwistedFate_Base_W_BlueCard.troy" then
   BlueDraw = false
   SelectedCard = "nil"
  end
  if obj.name == "TwistedFate_Base_W_RedCard.troy" then
   RedDraw = false
   SelectedCard = "nil"
  end
  if obj.name == "TwistedFate_Base_W_GoldCard.troy" then
   GoldDraw = false
   SelectedCard = "nil"
  end
  if obj.name == "Cardmaster_stackready.troy" then
   eStacks = 0
  end
 end
end

function OnRemoveBuff(unit, buff)
	if unit.isMe and buff.name == "pickacard_tracker" then
	PickingCard = false
	PickedCard = true
	end
end
	
function AutoCard()
	if Menu.combo.goldCard then
	for _, unit in pairs(GetEnemyHeroes()) do
	if GetDistance(unit) <= 750 then
	if myHero.health > (myHero.maxHealth * (Menu.combo.goldCardLow / 100)) then return end
	local Name = myHero:GetSpellData(_W).name
	if not myHero:CanUseSpell(_W) == READY then return end
	spellName = nil
	spellName = "goldcardlock"
	
	if Name == "PickACard" then
	CastSpell(_W)
	end
	
	if Name == spellName then
	CastSpell(_W)
	end
end
end
end
end
	
function SelectorCards()
	if not myHero:CanUseSpell(_W) == READY then 
	Selector = "any"
	SelectorCheck = false
	return end
	
	if SelectorCheck then
	local Name = myHero:GetSpellData(_W).name
	
	if Name == "PickACard" then
	CastSpell(_W)
	end
	
	if SelectedCard == Selector then
	CastSpell(_W)
	SelectorCheck = false
	Selector = "any"
	end
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
	local Name = myHero:GetSpellData(_W).name
	local dmgW = getDmg("W", unit, myHero)
	local Ehealth = unit.health
	spellName = nil
		if Menu.combo.UseQ then 
		CastQC(unit)
		end	
		
		if Menu.combo.UseW and myHero:CanUseSpell(_W) == READY then 
		
		if Menu.combo.randomCard and Ehealth <= dmgW then
		CastSpell(_W)
		end
		
		for _, unit in pairs(GetEnemyHeroes()) do
		if GetDistance(unit) <= 680 then
				if Menu.combo.card == 1 then
				CardSel = "Blue"
				elseif Menu.combo.card == 2 then
				CardSel = "Red"
				elseif Menu.combo.card == 3 then
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
end

function Harass(unit)
	ts:update()
	if(myHero:CanUseSpell(_Q) == READY and (myHero.mana / myHero.maxMana > Menu.harass.mManager /100 ) and ts.target ~= nil and Menu.harass.UseQ ) then 
  CastQ(unit)
	end
end

function IsMyManaLowLaneClear()
    if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then
        return true
    else
        return false
    end
end

function IsMyManaLowJungleClear()
    if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then
        return true
    else
        return false
    end
end

function LaneClear()
	enemyMinions:update()
	if not IsMyManaLowLaneClear() then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseQ and GetDistance(minion) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
					CastQ(minion)
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
elseif IsMyManaLowLaneClear then
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

function JungleClear()
	jungleMinions:update()
	if not IsMyManaLowJungleClear() then
	for i, jungleMinion in pairs(jungleMinions.objects) do
		if jungleMinion ~= nil then
		if Menu.jungleclear.UseQ then CastQ(jungleMinion)end
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
elseif IsMyManaLowJungleClear then
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

function CastQC(unit)
	if Menu.combo.qMode == 1 then
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
	elseif Menu.combo.qMode == 2 then
	if TargetHaveBuff("Stun", unit) then 
	if Menu.pred == 1 then
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, false)
 
		if HitChance >= Menu.hitchance.QHitCH then
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
	elseif Menu.pred == 2 then
  local QPos, QHitChance = HPred:GetPredict(HP_Q, unit, myHero)
  
  if QHitChance > Menu.hitchance.QHitCH then
    CastSpell(_Q, QPos.x, QPos.z)
end
end
end
end
end

function CastQ(unit)
	if Menu.pred == 1 then
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
		CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, false)
 
		if HitChance >= Menu.hitchance.QHitCH then
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
	elseif Menu.pred == 2 then
  local QPos, QHitChance = HPred:GetPredict(HP_Q, unit, myHero)
  
  if QHitChance > Menu.hitchance.QHitCH then
    CastSpell(_Q, QPos.x, QPos.z)
  end
  end
 end

function OnDraw()
	if not myHero.dead and not Menu.drawing.mDraw then
	
		if myHero:CanUseSpell(_Q) == READY and Menu.drawing.qDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillQ.range, RGB(Menu.drawing.qColor[2], Menu.drawing.qColor[3], Menu.drawing.qColor[4]))
		end
		
		if Menu.drawing.myHero then
			DrawCircle(myHero.x, myHero.y, myHero.z, 590, RGB(250, 6, 6))
		end

		if Target ~= nil and ValidTarget(Target) then
			if Menu.drawing.tText then
			DrawText3D("Current Target",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFF00)
		end
		end
			
		if Menu.drawing.DrawCards then
		
		if BlueDraw then
		DrawCircle(myHero.x, myHero.y, myHero.z, 340, 0xff0000ff)
		end
		
		if RedDraw then
		DrawCircle(myHero.x, myHero.y, myHero.z, 340, 0xffff0000)	
		end
		
		if GoldDraw then
		DrawCircle(myHero.x, myHero.y, myHero.z, 340, 0xFFFFFF00)
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

function UltimateCard()
	if Ulting then
	local Name = myHero:GetSpellData(_W).name
				CardSel = "Gold"
				
				if Name == "PickACard" then
				CastSpell(_W)
				end
				
				if SelectedCard == CardSel then
				CastSpell(_W)
				Ulting = false
				end			
    end
end

function OnProcessSpell(unit, spell)
    if unit.isMe and spell.name == "gate" then 
    	if Menu.combo.goldR then 
		if myHero:CanUseSpell(_W) == READY then
    		Ulting = true
			end
		end 
    end
end

function Skills()
	SkillQ = { name = "WildCards", range = 1200, delay = 0.250, speed = 1500, width = 80, ready = false }
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
                SetPriority(priorityTable.Support,  enemy, 3)
                SetPriority(priorityTable.Bruiser,  enemy, 4)
                SetPriority(priorityTable.Tank,     enemy, 5)
        end
end
 
function PriorityOnLoad()
        if heroManager.iCount < 10 then
				PrintChat("<font color=\"#ccae00\"><b>HR Twisted Fate : </b></font>".."<font color=\"#00ae26\"><b>Too few champions to arrange priority.</b></font>")	
        else
                arrangePrioritys()
        end
end
	
local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Twisted Fate.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#00ff00\"><b>Updating HR Twisted Fate, don't press F9.</b></font>")	
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
	DownloadFile("http://"..serveradress..scriptadress.."/HR Twisted Fate.lua",SCRIPT_PATH.."HR Twisted Fate.lua", function ()
		PrintChat("<font color=\"#00ff00\"><b>HR Twisted Fate Updated, press 2xF9.</b></font>")	
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
