if not VIP_USER then 
PrintChat("<font color=\"#DD4050\"><b>[HR AutoLvl] </b></font>".."<font color=\"#00D2FF\"><b>You need to be VIP to use this script.</b></font>")
return end

function OnLoad() AutoLvl() end

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("XKNONJQJMOK") 
-- Script Status --

class 'AutoLvl'
function AutoLvl:__init()
  self.Version = 0.7
  self.LastSpell = 0
  self:Menu()
  self:CheckUpdate()
  AddTickCallback(function() self:Tick() end)
  self:SendMsg("[Loaded]")
  self:SendMsg("[Turned to OFF. Turn ON in Menu]")
  Sequence = {}
end

function AutoLvl:Menu()
  Menu = scriptConfig("Hr AutoLeveler", "HrAutoLvl"..myHero.charName)
  Menu:addParam("On", "Active AutoLeveler", SCRIPT_PARAM_ONOFF, true) 
  Menu:addSubMenu("Setup levels", "Levels")
  Menu.Levels:addSubMenu("Levels", "ll")
  Menu.Levels:addParam("Changer", "Setup level skills", SCRIPT_PARAM_LIST, 1, {"Automatic", "Manual"}) 

  if Menu.Levels.Changer == 1 then
  Menu.Levels.ll:addParam("info", "Automatic", SCRIPT_PARAM_INFO, "")
  elseif Menu.Levels.Changer == 2 then
  for i = 1, 18 do
  self.MenuPP = tostring(i)
  Menu.Levels.ll:addParam("A"..self.MenuPP, "Up level "..i..": ", SCRIPT_PARAM_LIST, 0, {"Q", "W", "E", "R"}) 
  end
  end

  Menu.Levels:setCallback("Changer", function(Value) 
  if Value == 1 then
  Menu.Levels.ll:addParam("info", "Automatic", SCRIPT_PARAM_INFO, "")
  for i = 1, 18 do
  self.MenuPP = tostring(i)
  Menu.Levels.ll:removeParam("A"..self.MenuPP)
  end 
  elseif Value == 2 then 
  Menu.Levels.ll:removeParam("info")
  for i = 1, 18 do
  self.MenuPP = tostring(i)
  Menu.Levels.ll:addParam("A"..self.MenuPP, "Up level "..i..": ", SCRIPT_PARAM_LIST, 0, {"Q", "W", "E", "R"}) 
  end
  end
  end)

  Menu.On = false
end

function AutoLvl:SendMsg(msg)
  PrintChat("<font color=\"#DD4050\"><b>[HR AutoLvl] </b></font>".."<font color=\"#00D2FF\"><b>"..msg.."</b></font>")
end

ListBlock = {
  ["Nidalee"] = true, ["Jayce"] = true, ["Karma"] = true, ["Elise"] = true,
}

function AutoLvl:Tick()
  if Menu.On and os.clock() - self.LastSpell >= 1.0 then
  self.LastSpell = os.clock()  
  DelayAction(function() autoLevelSetSequence(Sequence[myHero.charName]) end,0.5)
end

  if Menu.Levels.Changer == 1 then
  self:Sequence()
  elseif Menu.Levels.Changer == 2 then
  Mf = Menu.Levels.ll
  Sequence = {
  [myHero.charName] = 
  {Mf.A1,Mf.A2,Mf.A3,Mf.A4,Mf.A5,Mf.A6,Mf.A7,Mf.A8,Mf.A9,Mf.A10,Mf.A11,Mf.A12,Mf.A13,Mf.A14,Mf.A15,Mf.A16,Mf.A17,Mf.A18},
  }
end
end

if ListBlock[myHero.charName] then
_G.GetHeroLeveled = function()
return player:GetSpellData(SPELL_1).level + player:GetSpellData(SPELL_2).level + player:GetSpellData(SPELL_3).level + player:GetSpellData(SPELL_4).level-1
end
end

_G.LevelSpell = function(id)
if (string.find(GetGameVersion(), 'Releases/6.2') ~= nil) and Menu.On then
local msg = "<font color=\"#DD4050\"><b>[HR AutoLvl] </b></font>"
local offsets = { 
[_Q] = 0x41, [1] = 0x41,
[_W] = 0xFC, [2] = 0xFC,
[_E] = 0x64, [3] = 0x64,
[_R] = 0xAA, [4] = 0xAA,
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


function AutoLvl:Sequence()
  Sequence = {
  ["Shyvana"] = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Gragas"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["JarvanIV"] = {3,1,2,1,1,4,2,3,1,3,4,1,2,2,3,4,3,2},
  ["Irelia"] = {2,3,1,2,2,4,3,3,2,1,4,2,3,1,1,4,3,1},
  ["Garen"] = {1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Gnar"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Aatrox"] = {2,1,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Amumu"] = {2,3,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1},
  ["Nunu"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Fiddlesticks"] = {2,3,2,1,1,4,1,3,1,3,4,1,2,3,2,4,3,2},
  ["Teemo"] = {3,1,2,1,1,4,3,3,2,3,4,1,1,3,2,4,2,2},
  ["ChoGath"] = {1,2,3,1,1,4,1,1,2,2,4,2,3,2,3,4,3,3},
  ["Darius"] = {1,2,3,1,1,4,1,2,1,2,4,3,2,2,3,4,3,3},
  ["DrMundo"] = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Elise"] = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Evelynn"] = {1,3,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
  ["Fiora"] = {2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Gangplank"] = {1,2,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Hecarim"] = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
  ["Jax"] = {2,3,1,1,1,4,3,2,3,2,4,2,1,1,3,4,2,3},
  ["Jayce"] = {1,3,1,2,1,2,1,2,1,2,1,2,2,3,3,3,3,3},
  ["Ahri"] = {1,3,2,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3},
  ["Akali"] = {1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Anivia"] = {1,3,3,1,3,4,3,2,3,2,4,2,2,2,1,4,1,1},
  ["Annie"] = {1,2,1,3,1,4,1,1,2,2,4,2,2,3,3,4,3,3},
  ["Azir"] = {2,1,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Brand"] = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Cassiopeia"] = {3,1,2,3,3,4,1,1,3,3,4,1,1,2,2,4,2,2},
  ["Orianna"] = {3,1,2,1,1,4,2,1,3,1,4,2,3,2,2,4,3,3},
  ["Lux"] = {3,1,2,3,3,4,1,2,3,1,4,2,3,1,1,4,2,2},
  ["Diana"] = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Ekko"] = {2,1,3,1,1,4,2,2,1,2,4,1,2,3,3,4,3,3},
  ["Ezreal"] = {1,2,3,1,1,4,2,2,1,3,4,1,2,2,3,4,3,3},
  ["Fizz"] = {2,1,3,2,2,4,3,2,1,2,4,1,1,3,1,4,3,3},
  ["Galio"] = {1,2,3,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3},
  ["Heimerdinger"] = {1,2,3,1,1,4,2,2,2,1,4,1,2,3,3,4,3,3},
  ["Ashe"] = {2,1,3,2,2,4,1,2,1,2,4,1,1,3,3,4,3,3},
  ["Kalista"] = {3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Graves"] = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
  ["Caitlyn"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Vayne"] = {2,1,3,2,2,4,1,2,2,1,4,1,1,3,3,4,3,3},
  ["MissFortune"] = {1,2,3,1,2,4,1,1,2,1,4,2,2,3,3,4,3,3},
  ["Corki"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Draven"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Jinx"] = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3},
  ["Leona"] = {1,3,2,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Alistar"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Janna"] = {3,1,3,2,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
  ["Braum"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Bard"] = {1,2,3,1,1,4,2,1,1,2,4,2,2,3,3,4,3,3},
  ["Blitzcrank"] = {1,3,2,1,1,4,2,1,3,1,4,2,2,2,3,4,3,3},
  ["Morgana"] = {2,1,3,2,2,4,1,1,3,1,4,1,2,2,3,4,3,3},
  ["Soraka"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Karma"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Karthus"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Kassadin"] = {2,1,3,3,2,4,1,1,3,1,4,2,1,2,3,4,3,2},
  ["Katarina"] = {1,2,3,1,1,4,2,2,1,2,4,1,2,3,3,4,3,3},
  ["Kayle"] = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Kennen"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["KhaZix"] = {1,3,2,1,1,4,1,1,3,3,4,3,3,2,2,4,2,2},
  ["KogMaw"] = {2,3,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
  ["Leblanc"] = {2,1,3,2,1,4,2,2,1,3,4,2,1,1,3,4,3,3},
  ["LeeSin"] = {1,2,3,1,1,4,1,3,1,3,4,2,2,2,2,4,3,3},
  ["Riven"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Viktor"] = {1,3,3,2,3,4,3,1,3,1,4,1,2,1,2,4,2,2},
  ["Lissandra"] = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Lucian"] = {1,3,2,1,1,4,1,2,1,3,4,3,2,3,2,4,2,3},
  ["Lulu"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["MasterYi"] = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
  ["Malphite"] = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Malzahar"] = {3,2,1,3,3,4,1,3,2,3,4,2,2,1,1,4,1,2},
  ["Maokai"] = {3,1,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Mordekaiser"] = {3,2,3,2,1,4,3,1,3,2,4,2,2,3,1,4,1,1},
  ["Nami"] = {1,2,3,2,2,4,2,3,2,1,4,3,3,3,1,4,1,1},
  ["Nasus"] = {1,2,3,1,1,4,3,1,2,1,4,3,3,2,3,4,2,2},
  ["Nautilus"] = {3,1,2,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
  ["Nidalee"] = {1,3,2,1,1,4,3,1,1,3,4,3,3,2,2,4,2,2},
  ["Nocturne"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Olaf"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Pantheon"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Poppy"] = {1,3,2,1,1,4,2,1,3,1,4,2,2,2,3,4,3,3},
  ["Quinn"] = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Rammus"] = {2,1,3,3,2,4,3,3,3,2,4,2,2,1,1,4,1,1},
  ["RekSai"] = {2,1,3,2,1,4,1,1,2,1,4,3,2,2,3,4,2,3},
  ["Renekton"] = {2,3,1,1,1,4,1,3,1,3,4,3,2,3,2,4,2,2},
  ["Rengar"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Rumble"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Ryze"] = {1,2,3,1,1,4,2,1,2,1,4,3,2,3,2,4,3,3},
  ["Sejuani"] = {2,3,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1},
  ["Shaco"] = {2,3,1,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
  ["Shen"] = {1,3,1,2,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Singed"] = {1,3,1,3,1,4,1,2,1,3,4,3,3,2,2,4,2,2},
  ["Sion"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Sivir"] = {1,3,2,1,1,4,3,2,1,2,4,1,2,2,3,4,3,3},
  ["Skarner"] = {1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Sona"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Swain"] = {2,3,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Syndra"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["TahmKench"] = {1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Talon"] = {2,3,2,1,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Taric"] = {3,1,2,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
  ["Teemo"] = {3,1,2,1,3,4,1,3,1,3,4,3,1,2,2,4,2,2},
  ["Thresh"] = {3,1,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Tristana"] = {3,1,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
  ["Trundle"] = {1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Tryndamere"] = {3,1,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["TwistedFate"] = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Twitch"] = {3,2,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Udyr"] = {4,2,4,3,4,2,4,2,4,3,2,3,2,3,3,1,1,1},
  ["Urgot"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Zed"] = {1,2,3,1,1,4,1,3,2,1,4,3,3,2,3,4,2,2},
  ["Varus"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Veigar"] = {1,2,3,2,2,4,1,2,3,1,4,2,1,1,3,4,3,3},
  ["VelKoz"] = {2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Vi"] = {2,3,1,1,1,4,1,2,3,1,4,3,2,3,2,4,2,3},
  ["Viktor"] = {1,3,3,2,3,4,3,1,3,1,4,1,2,1,2,4,2,2},
  ["Vladimir"] = {1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Volibear"] = {3,2,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1},
  ["Warwick"] = {2,1,3,1,2,4,2,1,2,1,4,2,1,3,3,4,3,3},
  ["MonkeyKing"] = {3,1,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
  ["Xerath"] = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3},
  ["XinZhao"] = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3},
  ["Yasuo"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Yorick"] = {3,2,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
  ["Zac"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
  ["Ziggs"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},  
  ["Zyra"] = {3,1,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},  
  ["Zilean"] = {1,2,1,3,1,4,1,3,1,3,4,3,2,3,2,4,2,2},
  ["Kindred"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
  ["Illaoi"] = {1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
  ["Jhin"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
}
end
