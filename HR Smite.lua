local LocalVersion = "1.0"
local autoupdate = true -- Change to false if you don't want autoupdates.
local RangeSmite = 560

-- SCRIPT STATUS --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("QDGHDDKJDED") 
-- SCRIPT STATUS --

function OnLoad()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonersmite") then Smite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonersmite") then Smite = SUMMONER_2 end

	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Loaded.</b></font>")	
	if Smite ~= nil then
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Smite found.</b></font>")
	else
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Smite not found.</b></font>")	
	end

	jungleMinions = minionManager(MINION_JUNGLE, RangeSmite, myHero, MINION_SORT_MAXHEALTH_DEC)
	MenuInit()
	FindUpdates()
end

function MenuInit()
	Menu = scriptConfig("HR Smite", "HRSmite")
	
	Menu:addParam("SmiteActive", "Smite Active", SCRIPT_PARAM_ONKEYTOGGLE, true, 76)

	Menu:addSubMenu("Smite Monsters:", "smitethat")
    Menu.smitethat:addParam("SRUDragon", "Use Smite on: Dragon", SCRIPT_PARAM_ONOFF, true)
    Menu.smitethat:addParam("SRUBaron", "Use Smite on: Baron", SCRIPT_PARAM_ONOFF, true)
    Menu.smitethat:addParam("SRURazorbeak", "Use Smite on: Wraith", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRUMurkwolf", "Use Smite on: Wolf", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRUKrug", "Use Smite on: Krug", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRUGromp", "Use Smite on: Gromp", SCRIPT_PARAM_ONOFF, false)
    Menu.smitethat:addParam("SRURed", "Use Smite on: Red", SCRIPT_PARAM_ONOFF, true)
    Menu.smitethat:addParam("SRUBlue", "Use Smite on: Blue", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Draw Options:", "drawing")
    Menu.drawing:addParam("rangeSmite", "Range Smite", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUDragon", "Draw Smite damage in: Dragon", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUBaron", "Draw Smite damage in: Baron", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRURazorbeak", "Draw Smite damage in: Wraith", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUMurkwolf", "Draw Smite damage in: Wolf", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUKrug", "Draw Smite damage in: Krug", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUGromp", "Draw Smite damage in: Gromp", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRURed", "Draw Smite damage in: Red", SCRIPT_PARAM_ONOFF, true)
    Menu.drawing:addParam("SRUBlue", "Draw Smite damage in: Blue", SCRIPT_PARAM_ONOFF, true)

    DelayAction(function() Menu:permaShow("SmiteActive") end, 5.0)
end

function GetSmiteDamage()
	local SmiteDamage
	if myHero.level <= 4 then
		SmiteDamage = 370 + (myHero.level*20)
	end
	if myHero.level > 4 and myHero.level <= 9 then
		SmiteDamage = 330 + (myHero.level*30)
	end
	if myHero.level > 9 and myHero.level <= 14 then
		SmiteDamage = 240 + (myHero.level*40)
	end
	if myHero.level > 14 then
		SmiteDamage = 100 + (myHero.level*50)
	end
	return SmiteDamage
end

function GetDamageSpell()
	local SpellDamage

	if myHero.charName == "Chogath" then
	SpellDamage = 1000 + (0.7*myHero.ap)
	end

	if myHero.charName == "Nunu" then
	QLevel = myHero:GetSpellData(_Q).level
	if QLevel == 1 then
		SpellDamage = 400
	elseif QLevel == 2 then
		SpellDamage = 550
	elseif QLevel == 3 then
		SpellDamage = 700
	elseif QLevel == 4 then
		SpellDamage = 850
	elseif QLevel == 5 then
		SpellDamage = 1000
	end
	end



	return SpellDamage
end

function Spell()
	local Spell
	if myHero.charName == "Chogath" then Spell = _R end
	if myHero.charName == "Nunu" then Spell = _Q end
	return Spell
end

function OnTick()
	jungleMinions:update()
	CheckJungle()
end

function CheckJungle()
	if Menu.SmiteActive then
	for i, jungle in pairs(jungleMinions.objects) do
	if jungle ~= nil then
	if Menu.smitethat[jungle.charName:gsub("_", "")] then
	if myHero.charName == "Chogath" or myHero.charName == "Nunu" then
	ComboMonster(jungle)
	else
	SmiteMonster(jungle)
end
end
end
end   
end
end

function SmiteMonster(obj)
    local DistanceMonster = GetDistance(obj)
    if myHero:CanUseSpell(Smite) == READY and DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() then
    CastSpell(Smite, obj)
    end
end

function ComboMonster(obj)
    local DistanceMonster = GetDistance(obj)
    if myHero:CanUseSpell(Smite) == READY and myHero:CanUseSpell(Spell()) == READY then
    if DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() + GetDamageSpell() then
	CastSpell(Spell(), obj)
    DelayAction(function() CastSpell(Smite, obj) end, 0.125)
	end
	return
	end

	if myHero:CanUseSpell(Smite) == READY then
    if DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() then
    CastSpell(Smite, obj)
    end

	elseif myHero:CanUseSpell(Spell()) == READY then
    if DistanceMonster <= RangeSmite and obj.health <= GetDamageSpell() then
	CastSpell(Spell(), obj)
	end
	end
end

function OnDraw()
	if myHero.dead then return end
	for i, jungle in pairs(jungleMinions.objects) do
	if jungle ~= nil then
    if Menu.drawing[jungle.charName:gsub("_", "")] then
    MonsterDraw(jungle)
    end
	end
	end

	if Menu.drawing.rangeSmite and myHero:CanUseSpell(Smite) == READY and Menu.SmiteActive then
	DrawCircle(myHero.x, myHero.y, myHero.z, RangeSmite,ARGB(100,0,252,255))
	end

end

function MonsterDraw(minion)
        local barPos = GetUnitHPBarPos(minion)
        barPos.x = math.floor(barPos.x - 32)
        barPos.y = math.floor(barPos.y - 3)
        local maxDistance = 62
        if minion.charName == "SRU_Dragon" then
                barPos.x = barPos.x - 31
                barPos.y = barPos.y - 7
                maxDistance = 124
        elseif minion.charName == "SRU_Baron" then
                barPos.x = barPos.x - 31
                maxDistance = 124
        end
        local SmiteDistance = GetSmiteDamage() / minion.maxHealth * maxDistance
        local alphaSmite = (myHero:CanUseSpell(Smite) == READY and Menu.SmiteActive and GetDistance(minion) <= RangeSmite) and 255 or 100
        DrawRectangle(barPos.x + SmiteDistance - 8, barPos.y - 10, 20, 10, ARGB(alphaSmite,0,0,0))
        DrawText(tostring(GetSmiteDamage()), 11, barPos.x + SmiteDistance - 6, barPos.y - 11, ARGB(alphaSmite,0,252,255))
        --if GetSmiteDamage() <= minion.health then
        --DrawText("TEXT", 11, barPos.x - 25 , barPos.y - 11, ARGB(alphaSmite,0,252,255))
        --end
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Smite.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Updating, don't press F9.</b></font>")
			Update()
			else
			PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>You have the latest version.</b></font>")
			end
		else
		PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>An error occured, while updating, please reload.</b></font>")
		end
	else
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Could not connect to update Server.</b></font>")
	end
end

function Update()
	DownloadFile("http://"..serveradress..scriptadress.."/HR Smite.lua",SCRIPT_PATH.."HR Smite.lua", function ()
	PrintChat("<font color=\"#415cf6\"><b>[HR Smite] </b></font>".."<font color=\"#01cc9c\"><b>Updated, press 2xF9.</b></font>")
	end)
end
