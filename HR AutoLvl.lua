if not VIP_USER then return end

function OnLoad() AutoLvl() end

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("XKNONJQJMOK") 
-- Script Status --

class 'AutoLvl'
function AutoLvl:__init()
	self.Version = 0.3
	self.LastSpell = 0
	self:Menu()
	self:CheckUpdate()
  	AddTickCallback(function() self:Tick() end)
  	self:SendMsg("[Loaded]")
end

function AutoLvl:Menu()
  	Menu = scriptConfig("Hr AutoLeveler", "HrAutoLvl")
  	Menu:addParam("On", "Active AutoLeveler", SCRIPT_PARAM_ONOFF, true) 
end

function AutoLvl:SendMsg(msg)
	PrintChat("<font color=\"#DD4050\"><b>[HR AutoLvl] </b></font>".."<font color=\"#00D2FF\"><b>"..msg.."</b></font>")
end

function AutoLvl:Tick()
  	if Menu.On and os.clock() - self.LastSpell >= 1.0 then
  	self.LastSpell = os.clock()  
  	DelayAction(function() autoLevelSetSequence(Sequence) end,0.5)
end
end

_G.LevelSpell = function(id)
if GetGameVersion():lower():find("6.2") and Menu.On then
local msg = "<font color=\"#DD4050\"><b>[HR AutoLvl] </b></font>"
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
if id == _Q then PrintChat(msg.."<font color=\"#00D2FF\"><b>Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>Q</b></font>") end
if id == _W then PrintChat(msg.."<font color=\"#00D2FF\"><b>Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>W</b></font>") end
if id == _E then PrintChat(msg.."<font color=\"#00D2FF\"><b>Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>E</b></font>") end
if id == _R then PrintChat(msg.."<font color=\"#00D2FF\"><b>Auto Leveler: </b></font>".."<font color=\"#b71c1c\"><b>R</b></font>") end
end
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
local scriptname = "HR AutoLvl"
function AutoLvl:CheckUpdate()
  	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/"..scriptname..".version")
  	if ServerVersionDATA then
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersion then
    if ServerVersion > tonumber(self.Version) then
    self:SendMsg("<font color=\"#00D2FF\"><b>Updating, don't press F9.</b></font>")
    self:DownloadUpdate()
    else
    self:SendMsg("<font color=\"#00D2FF\"><b>You have the latest version.</b></font>")
    end
    else
    self:SendMsg("<font color=\"#00D2FF\"><b>An error occured, while updating, please reload.</b></font>")
    end
  	else
  	self:SendMsg("<font color=\"#00D2FF\"><b>Could not connect to update Server.</b></font>")
end

function AutoLvl:DownloadUpdate()
  	DownloadFile("http://"..serveradress..scriptadress.."/"..scriptname..".lua",SCRIPT_PATH..scriptname..".lua", function ()
  	self:SendMsg("<font color=\"#00D2FF\"><b>Updated, press 2x F9.</b></font>")
  	end)
end
end

if myHero.charName == 'Shyvana' then
  Sequence = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Gragas' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'JarvanIV' then
  Sequence = {3,1,2,1,1,4,2,3,1,3,4,1,2,2,3,4,3,2}
	elseif myHero.charName == 'Irelia' then
  Sequence = {2,3,1,2,2,4,3,3,2,1,4,2,3,1,1,4,3,1}
	elseif myHero.charName == 'Garen' then
  Sequence = {1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Gnar' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Aatrox' then
  Sequence = {2,1,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Amumu' then
  Sequence = {2,3,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1}
	elseif myHero.charName == 'Nunu' then
  Sequence = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Fiddlesticks' then
  Sequence = {2,3,2,1,1,4,1,3,1,3,4,1,2,3,2,4,3,2}
	elseif myHero.charName == 'Teemo' then
  Sequence = {3,1,2,1,1,4,3,3,2,3,4,1,1,3,2,4,2,2}
	elseif myHero.charName == 'ChoGath' then
  Sequence = {1,2,3,1,1,4,1,1,2,2,4,2,3,2,3,4,3,3}
	elseif myHero.charName == 'Darius' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,3,2,2,3,4,3,3}
	elseif myHero.charName == 'DrMundo' then
  Sequence = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Elise' then
  Sequence = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Evelynn' then
  Sequence = {1,3,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Fiora' then
  Sequence = {2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Gangplank' then
  Sequence = {1,2,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Hecarim' then
  Sequence = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Jax' then
  Sequence = {2,3,1,1,1,4,3,2,3,2,4,2,1,1,3,4,2,3}
	elseif myHero.charName == 'Jayce' then
  Sequence = {1,3,1,2,1,2,1,2,1,2,1,2,2,3,3,3,3,3}
	elseif myHero.charName == 'Ahri' then
  Sequence = {1,3,2,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3}
	elseif myHero.charName == 'Akali' then
  Sequence = {1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Anivia' then
  Sequence = {1,3,3,1,3,4,3,2,3,2,4,2,2,2,1,4,1,1}
	elseif myHero.charName == 'Annie' then
  Sequence = {1,2,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Azir' then
  Sequence = {2,1,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Brand' then
  Sequence = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Cassiopeia' then
  Sequence = {3,1,2,3,3,4,1,1,3,3,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Orianna' then
  Sequence = {3,1,2,1,1,4,2,1,3,1,4,2,3,2,2,4,3,3}
	elseif myHero.charName == 'Lux' then
  Sequence = {3,1,2,3,3,4,1,2,3,1,4,2,3,1,1,4,2,2}
	elseif myHero.charName == 'Diana' then
  Sequence = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Ekko' then
  Sequence = {2,1,3,1,1,4,2,2,1,2,4,1,2,3,3,4,3,3}
	elseif myHero.charName == 'Ezreal' then
  Sequence = {1,2,3,1,1,4,2,2,1,3,4,1,2,2,3,4,3,3}
	elseif myHero.charName == 'Fizz' then
  Sequence = {2,1,3,2,2,4,3,2,1,2,4,1,1,3,1,4,3,3}
	elseif myHero.charName == 'Galio' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3}
	elseif myHero.charName == 'Heimerdinger' then
  Sequence = {1,2,3,1,1,4,2,2,2,1,4,1,2,3,3,4,3,3}
	elseif myHero.charName == 'Ashe' then
  Sequence = {2,1,3,2,2,4,1,2,1,2,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Kalista' then
  Sequence = {3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Graves' then
  Sequence = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Caitlyn' then
  Sequence = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Vayne' then
  Sequence = {2,1,3,2,2,4,1,2,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'MissFortune' then
  Sequence = {1,2,3,1,2,4,1,1,2,1,4,2,2,3,3,4,3,3}
  	elseif myHero.charName == 'Corki' then
  Sequence = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Draven' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Jinx' then
  Sequence = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Leona' then
  Sequence = {1,3,2,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Alistar' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Janna' then
  Sequence = {3,1,3,2,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
	elseif myHero.charName == 'Braum' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Bard' then
  Sequence = {1,2,3,1,1,4,2,1,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Blitzcrank' then
  Sequence = {1,3,2,1,1,4,2,1,3,1,4,2,2,2,3,4,3,3}
	elseif myHero.charName == 'Morgana' then
  Sequence = {2,1,3,2,2,4,1,1,3,1,4,1,2,2,3,4,3,3}
	elseif myHero.charName == 'Soraka' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Karma' then
  Sequence = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Karthus' then
  Sequence = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Kassadin' then
  Sequence = {2,1,3,3,2,4,1,1,3,1,4,2,1,2,3,4,3,2}
	elseif myHero.charName == 'Katarina' then
  Sequence = {1,2,3,1,1,4,2,2,1,2,4,1,2,3,3,4,3,3}
	elseif myHero.charName == 'Kayle' then
  Sequence = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Kennen' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'KhaZix' then
  Sequence = {1,3,2,1,1,4,1,1,3,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'KogMaw' then
  Sequence = {2,3,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
	elseif myHero.charName == 'Leblanc' then
  Sequence = {2,1,3,2,1,4,2,2,1,3,4,2,1,1,3,4,3,3}
	elseif myHero.charName == 'LeeSin' then
  Sequence = {1,2,3,1,1,4,1,3,1,3,4,2,2,2,2,4,3,3}
	elseif myHero.charName == 'Riven' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Viktor' then
  Sequence = {1,3,3,2,3,4,3,1,3,1,4,1,2,1,2,4,2,2}
	elseif myHero.charName == 'Lissandra' then
  Sequence = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Lucian' then
  Sequence = {1,3,2,1,1,4,1,2,1,3,4,3,2,3,2,4,2,3}
	elseif myHero.charName == 'Lulu' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'MasterYi' then
  Sequence = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Malphite' then
  Sequence = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Malzahar' then
  Sequence = {3,2,1,3,3,4,1,3,2,3,4,2,2,1,1,4,1,2}
	elseif myHero.charName == 'Maokai' then
  Sequence = {3,1,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Mordekaiser' then
  Sequence = {3,2,3,2,1,4,3,1,3,2,4,2,2,3,1,4,1,1}
	elseif myHero.charName == 'Nami' then
  Sequence = {1,2,3,2,2,4,2,3,2,1,4,3,3,3,1,4,1,1}
	elseif myHero.charName == 'Nasus' then
  Sequence = {1,2,3,1,1,4,3,1,2,1,4,3,3,2,3,4,2,2}
	elseif myHero.charName == 'Nautilus' then
  Sequence = {3,1,2,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
	elseif myHero.charName == 'Nidalee' then
  Sequence = {1,3,2,1,1,4,3,1,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Nocturne' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
  	elseif myHero.charName == 'Olaf' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Pantheon' then
  Sequence = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Poppy' then
  Sequence = {1,3,2,1,1,4,2,1,3,1,4,2,2,2,3,4,3,3}
	elseif myHero.charName == 'Quinn' then
  Sequence = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Rammus' then
  Sequence = {2,1,3,3,2,4,3,3,3,2,4,2,2,1,1,4,1,1}
	elseif myHero.charName == 'RekSai' then
  Sequence = {2,1,3,2,1,4,1,1,2,1,4,3,2,2,3,4,2,3}
	elseif myHero.charName == 'Renekton' then
  Sequence = {2,3,1,1,1,4,1,3,1,3,4,3,2,3,2,4,2,2}
	elseif myHero.charName == 'Rengar' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Rumble' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Ryze' then
  Sequence = {1,2,3,1,1,4,2,1,2,1,4,3,2,3,2,4,3,3}
	elseif myHero.charName == 'Sejuani' then
  Sequence = {2,3,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1}
	elseif myHero.charName == 'Shaco' then
  Sequence = {2,3,1,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
	elseif myHero.charName == 'Shen' then
  Sequence = {1,3,1,2,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Singed' then
  Sequence = {1,3,1,3,1,4,1,2,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Sion' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Sivir' then
  Sequence = {1,3,2,1,1,4,3,2,1,2,4,1,2,2,3,4,3,3}
	elseif myHero.charName == 'Skarner' then
  Sequence = {1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Sona' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Swain' then
  Sequence = {2,3,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Syndra' then
  Sequence = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'TahmKench' then
  Sequence = {1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Talon' then
  Sequence = {2,3,2,1,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
  	elseif myHero.charName == 'Taric' then
  Sequence = {3,1,2,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
  	elseif myHero.charName == 'Teemo' then
  Sequence = {3,1,2,1,3,4,1,3,1,3,4,3,1,2,2,4,2,2}
	elseif myHero.charName == 'Thresh' then
  Sequence = {3,1,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Tristana' then
  Sequence = {3,1,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Trundle' then
  Sequence = {1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Tryndamere' then
  Sequence = {3,1,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'TwistedFate' then
  Sequence = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Twitch' then
  Sequence = {3,2,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Udyr' then
  Sequence = {4,2,4,3,4,2,4,2,4,3,2,3,2,3,3,1,1,1}
	elseif myHero.charName == 'Urgot' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Zed' then
  Sequence = {1,2,3,1,1,4,1,3,2,1,4,3,3,2,3,4,2,2}
	elseif myHero.charName == 'Varus' then
  Sequence = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Veigar' then
  Sequence = {1,2,3,2,2,4,1,2,3,1,4,2,1,1,3,4,3,3}
	elseif myHero.charName == 'VelKoz' then
  Sequence = {2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
	elseif myHero.charName == 'Vi' then
  Sequence = {2,3,1,1,1,4,1,2,3,1,4,3,2,3,2,4,2,3}
	elseif myHero.charName == 'Viktor' then
  Sequence = {1,3,3,2,3,4,3,1,3,1,4,1,2,1,2,4,2,2}
  	elseif myHero.charName == 'Vladimir' then
  Sequence = {1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Volibear' then
  Sequence = {3,2,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1}
	elseif myHero.charName == 'Warwick' then
  Sequence = {2,1,3,1,2,4,2,1,2,1,4,2,1,3,3,4,3,3}
	elseif myHero.charName == 'MonkeyKing' then
  Sequence = {3,1,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif myHero.charName == 'Xerath' then
  Sequence = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'XinZhao' then
  Sequence = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Yasuo' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Yorick' then
  Sequence = {3,2,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
	elseif myHero.charName == 'Zac' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	elseif myHero.charName == 'Ziggs' then
  Sequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}	
	elseif myHero.charName == 'Zyra' then
  Sequence = {3,1,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}	
	elseif myHero.charName == 'Zilean' then
  Sequence = {1,2,1,3,1,4,1,3,1,3,4,3,2,3,2,4,2,2}	
	elseif myHero.charName == 'Kindred' then
  Sequence = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
	elseif myHero.charName == 'Illaoi' then
  Sequence = {1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
  	elseif myHero.charName == 'Jhin' then
  Sequence = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
end
