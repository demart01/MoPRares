MoPRares = LibStub("AceAddon-3.0"):NewAddon("MoPRares")
local L = LibStub("AceLocale-3.0"):GetLocale("MoPRares", true)

local debug = 1

local _
local frame	= CreateFrame("Frame", nil, UIParent)
local textframe = CreateFrame("Frame", "MoPRaresText", UIParent)
textframe:SetSize(220,25)
textframe:SetPoint("LEFT",200,100)
textframe:SetMovable(true)
textframe:EnableMouse(true)
textframe:RegisterForDrag("LeftButton")
textframe:SetScript("OnDragStart", frame.StartMoving)
textframe:SetScript("OnDragStop", frame.StopMovingOrSizing)
textframe:SetUserPlaced(true)
textframe.bg = textframe:CreateTexture(nil, "BACKGROUND")
textframe.bg:SetAllPoints(textframe)
textframe.bg:SetTexture(0,0,0,0.7)
textframe.text = textframe:CreateFontString(nil, "OVERLAY")
textframe.text:SetPoint("TOPLEFT", 10, -10)
textframe.text:SetFont("Fonts\\ARIALN.TTF",13,"OUTLINE")
textframe.text:SetTextColor(1,0.8,0,1)
local mobs = {
	-- [npc_id] = {message sent, died time, name, death reported, x coord, y coord, waypoint set, permanent coordinates}
	[50358] = {0, 0, L["Haywire Sunreaver Construct"], 0, 0, 0, 0, 0},
	[69664] = {0, 0, L["Mumta"], 0, 0, 0, 0, 0},
	[69996] = {0, 0, L["Ku'lai the Skyclaw"], 0, 0, 0, 0, 0},
	[69997] = {0, 0, L["Progenitus"], 0, 0, 0, 0, 0},
	[69998] = {0, 0, L["Goda"], 0, 0, 0, 0, 0},
	[69999] = {0, 0, L["God-Hulk Ramuk"], 0, 0, 0, 0, 0},
	[70000] = {0, 0, L["Al'tabim the All-Seeing"], 0, 0, 0, 0, 0},
	[70001] = {0, 0, L["Backbreaker Uru"], 0, 0, 0, 0, 0},
	[70002] = {0, 0, L["Lu-Ban"], 0, 0, 0, 0, 0},
	[70003] = {0, 0, L["Molthor"], 0, 0, 0, 0, 0},
	[71864] = {0, 0, L["Spelurk"], 0, 0, 0, 0, 0},
	[71919] = {0, 0, L["Zhu-Gon the Sour"], 0, 0, 0, 0, 0},
	[72032] = {0, 0, L["Captain Zvezdan"], 0, 0, 0, 0, 0},
	[72045] = {0, 0, L["Chelon"], 0, 0, 0, 0, 0},
	[72048] = {0, 0, L["Rattleskew"], 0, 0, 0, 0, 0},
	[72049] = {0, 0, L["Cranegnasher"], 0, 0, 0, 0, 0},
	[72193] = {0, 0, L["Karkanos"], 0, 0, 0, 0, 0},
	[72245] = {0, 0, L["Zesqua"], 0, 0, 0, 0, 0},
	[72769] = {0, 0, L["Spirit of Jadefire"], 0, 0, 0, 0, 0},
	[72775] = {0, 0, L["Bufo"], 0, 0, 0, 0, 0},
	[72808] = {0, 0, L["Tsavo'ka"], 0, 0, 0, 0, 0},
	[72909] = {0, 0, L["Gu'chi the Swarmbringer"], 0, 0, 0, 0, 0},
	[72970] = {0, 0, L["Golganarr"], 0, 0, 0, 0, 0},
	[73157] = {0, 0, L["Rock Moss"], 0, 0, 0, 0, 0},
	[73158] = {0, 0, L["Emerald Gander"], 0, 0, 0, 0, 0},
	[73160] = {0, 0, L["Ironfur Steelhorn"], 0, 0, 0, 0, 0},
	[73161] = {0, 0, L["Great Turtle Furyshell"], 0, 0, 0, 0, 0},
	[73163] = {0, 0, L["Imperial Python"], 0, 0, 0, 0, 0},
	[73166] = {0, 0, L["Monstrous Spineclaw"], 0, 0, 0, 0, 0},
	[73167] = {0, 0, L["Huolon"], 0, 0, 0, 0, 0},
	[73169] = {0, 0, L["Jakur of Ordon"], 0, 0, 0, 0, 0},
	[73170] = {0, 0, L["Watcher Osu"], 0, 0, 0, 0, 0},
	[73171] = {0, 0, L["Champion of the Black Flame"], 0, 0, 0, 0, 0},
	[73172] = {0, 0, L["Flintlord Gairan"], 0, 0, 0, 0, 0},
	[73173] = {0, 0, L["Urdur the Cauterizer"], 0, 0, 0, 0, 0},
	[73175] = {0, 0, L["Cinderfall"], 0, 0, 0, 0, 0},
	[73277] = {0, 0, L["Leafmender"], 0, 0, 0, 0, 0},
	[73279] = {0, 0, L["Evermaw"], 0, 0, 0, 0, 0},
	[73281] = {0, 0, L["Dread Ship Vazuvius"], 0, 0, 0, 0, 0},
	[73282] = {0, 0, L["Garnia"], 0, 0, 0, 0, 0},
	[73666] = {0, 0, L["Archiereus of Flame"], 0, 0, 0, 0, 0},
	[73704] = {0, 0, L["Stinkbraid"], 0, 0, 0, 0, 0},
	[73854] = {0, 0, L["Cranegnasher"], 0, 0, 0, 0, 0},
}
-- Map english names to localized names for compatibility with earlier versions and other english addons
-- Note: see locales/* for actual localization maps
local mobsEN = {}
mobsEN["Haywire Sunreaver Construct"] = L["Haywire Sunreaver Construct"]
mobsEN["Mumta"] = L["Mumta"]
mobsEN["Ku'lai the Skyclaw"] = L["Ku'lai the Skyclaw"]
mobsEN["Progenitus"] = L["Progenitus"]
mobsEN["Goda"] = L["Goda"]
mobsEN["God-Hulk Ramuk"] = L["God-Hulk Ramuk"]
mobsEN["Al'tabim the All-Seeing"] = L["Al'tabim the All-Seeing"]
mobsEN["Backbreaker Uru"] = L["Backbreaker Uru"]
mobsEN["Lu-Ban"] = L["Lu-Ban"]
mobsEN["Molthor"] = L["Molthor"]
mobsEN["Spelurk"] = L["Spelurk"]
mobsEN["Zhu-Gon the Sour"] = L["Zhu-Gon the Sour"]
mobsEN["Captain Zvezdan"] = L["Captain Zvezdan"]
mobsEN["Chelon"] = L["Chelon"]
mobsEN["Rattleskew"] = L["Rattleskew"]
mobsEN["Karkanos"] = L["Karkanos"]
mobsEN["Zesqua"] = L["Zesqua"]
mobsEN["Spirit of Jadefire"] = L["Spirit of Jadefire"]
mobsEN["Bufo"] = L["Bufo"]
mobsEN["Tsavo'ka"] = L["Tsavo'ka"]
mobsEN["Gu'chi the Swarmbringer"] = L["Gu'chi the Swarmbringer"]
mobsEN["Golganarr"] = L["Golganarr"]
mobsEN["Rock Moss"] = L["Rock Moss"]
mobsEN["Emerald Gander"] = L["Emerald Gander"]
mobsEN["Ironfur Steelhorn"] = L["Ironfur Steelhorn"]
mobsEN["Great Turtle Furyshell"] = L["Great Turtle Furyshell"]
mobsEN["Imperial Python"] = L["Imperial Python"]
mobsEN["Monstrous Spineclaw"] = L["Monstrous Spineclaw"]
mobsEN["Huolon"] = L["Huolon"]
mobsEN["Jakur of Ordon"] = L["Jakur of Ordon"]
mobsEN["Watcher Osu"] = L["Watcher Osu"]
mobsEN["Champion of the Black Flame"] = L["Champion of the Black Flame"]
mobsEN["Flintlord Gairan"] = L["Flintlord Gairan"]
mobsEN["Urdur the Cauterizer"] = L["Urdur the Cauterizer"]
mobsEN["Cinderfall"] = L["Cinderfall"]
mobsEN["Leafmender"] = L["Leafmender"]
mobsEN["Evermaw"] = L["Evermaw"]
mobsEN["Dread Ship Vazuvius"] = L["Dread Ship Vazuvius"]
mobsEN["Garnia"] = L["Garnia"]
mobsEN["Archiereus of Flame"] = L["Archiereus of Flame"]
mobsEN["Stinkbraid"] = L["Stinkbraid"]
mobsEN["Cranegnasher"] = L["Cranegnasher"]

local message
local message_mob_id
local timer, throttle = 0, 3
local text_timer, text_throttle = 0, 10
local general_chat
local mapContinent
local mapZone
local waypoints = {}
local playerName = UnitName("player")

local function print_d(msg)
	if debug == 1 then
		print(msg)
	end
end

-- convert english to localized npc name
local function getNPCName(npcname)
	if (GetLocale() ~= "enUS") then
		for nameEN,nameL in pairs(mobsEN) do
			if string.find(nameEN,npcname) then
				npcname = nameL
			end
		end
	end
	return npcname
end

local function getNPCId(npcname)
	local id
	for id,_ in pairs(mobs) do
		if mobs[id][3] == npcname then
			return id
		end
	end
	return 42
end

local function addWaypoint(id)
	if not _G.TomTom then
		print_d("TomTom is not loaded")
		return false
	end
	if mobs[id][7] == 0 then
		print_d("Adding waypoint for "..mobs[id][3]..": "..mobs[id][5]..","..mobs[id][6])
		waypoints[id] = _G.TomTom:AddWaypoint(tonumber(mobs[id][5]), tonumber(mobs[id][6]), mobs[id][3], false)
		mobs[id][7] = 1
	end
	return true
end

local function removeWaypoint(id)
	if not _G.TomTom then
		print_d("TomTom is not loaded")
		return false
	end
	if waypoints[id] ~= nil then
		_G.TomTom:RemoveWaypoint(waypoints[id])
		waypoints[id] = nil
		mobs[id][7] = 0
	end
	return true
end

local function DeathTimes(self,elapsed)
	text_timer = text_timer + elapsed
	if text_timer >= text_throttle then
		local text, count, currentTime = "", 0, GetTime()
		for id,_ in pairs(mobs) do
			if mobs[id][2] > 0 and (currentTime - mobs[id][2]) < 3601 then
				text = text .. mobs[id][3] .. " : " .. SecondsToTime(currentTime - mobs[id][2], true) .. "\n"
				count = count + 1
			end
		end
		textframe.text:SetText(text)
		textframe:SetHeight(25 + count*13)
		text_timer = 0
	end
end

local function getGeneral(id, name, ...)
	if id and name then
		if strfind(name, GENERAL) then
			return id
		end
	return getGeneral(...)
	end
end
	
function MoPRares:OnInitialize()
--local function init()
    local current_map_id = GetCurrentMapAreaID()
    mapContinent = GetCurrentMapContinent()
    mapZone = GetCurrentMapZone()

	if current_map_id == 928 or current_map_id == 951 then
		frame:RegisterEvent("CHAT_MSG_CHANNEL")
		frame:RegisterEvent("PLAYER_TARGET_CHANGED")
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		textframe:Show()
		textframe:SetScript("OnUpdate", DeathTimes)
	else
		frame:UnregisterEvent("CHAT_MSG_CHANNEL")
		frame:UnregisterEvent("PLAYER_TARGET_CHANGED")
		frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		textframe:Hide()
		textframe:SetScript("OnUpdate", nil)
	end
end

local function announce(self,elapsed)
	timer = timer + elapsed;
	if timer >= throttle then
		general_chat = getGeneral(GetChannelList())
		if mobs[message_mob_id][4] == true then -- npc death reported
			timer = 0
		elseif mobs[message_mob_id][2] > 0 then -- npc died but not reported
			SendChatMessage(message , "CHANNEL", nil, general_chat)
			mobs[message_mob_id][4] = true
		elseif mobs[message_mob_id][1] + 30 < GetTime() then -- npc spotted but not reported
			SendChatMessage(message , "CHANNEL", nil, general_chat)
		end
        timer = 0
		frame:SetScript("OnUpdate", nil)
	end
end

local function RandomizeTime()
	throttle = math.random()*2
	frame:SetScript("OnUpdate", announce)
end

-- RareCoordinator uses a mix of coordinate-based and non-coordinate-based general reporting, need to ignore the latter
local ignored_messages = { "varied spawn", "swims around", "next to", "around", "on the", "patrols between" }
local function ignoreMsg(msg)
	for _,value in pairs(ignored_messages) do
		if string.find(msg,value) then
			print_d("ignored message")
			return true
		end
	end
	return false
end

local function events(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
		 MoPRares:OnInitialize()
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _,event_type,_,_,_,_,_,guid,_ = select(1, ...)
		if event_type == "UNIT_DIED" and guid == UnitGUID("target") then
			local id = tonumber(guid:sub(6, 10), 16)
			if not mobs[id] then return end
			mobs[id][2] = GetTime()
			message = "[MoPRares] "..mobs[id][3].." (0%)"
			message_mob_id = id
			RandomizeTime()
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		local guid = UnitGUID("target")
		if guid and mobs[tonumber(guid:sub(6, 10), 16)] and not UnitIsDead("target") then
			local id = tonumber(guid:sub(6, 10), 16)
			local x, y = GetPlayerMapPosition("player")
			x = math.floor(x*100)
			y = math.floor(y*100)
			local hp = math.floor(UnitHealth("target")*100/UnitHealthMax("target"))
			mobs[id][2] = 0
			mobs[id][4] = false
			mobs[id][5] = x
			mobs[id][6] = y
			--message = "npc"..id..": "..mobs[id][3].." ("..hp.."%) @ "..x..", "..y
			message = "[MoPRares] "..mobs[id][3].." ("..hp.."%) @ "..x..", "..y
			message_mob_id = id
			RandomizeTime()
		end
	elseif event == "CHAT_MSG_CHANNEL" then
		local msg,author,_,_,_,_,_,channel = select(1, ...)
		general_chat = getGeneral(GetChannelList())
		if channel == general_chat then
		    -- Backwards compatibility 1.1.4 and earlier
			if string.sub(msg,1,3) == "npc" then
				local id = tonumber(string.sub(msg,4,8))
				if mobs[id] then
					mobs[id][1] = GetTime()
					-- npc12345: Name (0%)
					if string.find(msg,'%(0%%%)') then 
						mobs[id][2] = GetTime()
						mobs[id][4] = true
						removeWaypoint(id)
					-- npc12345: Name (100%) @ 50, 50
					else
						local index = 0
						if string.find(msg,"Coordinates:") then
						    -- older format
							index = string.find(msg, "nates:")+6
						else
							-- newer format
							index = string.find(msg, "@")+2
						end
						mobs[id][2] = 0
						mobs[id][4] = false
						mobs[id][5] = string.match(msg,"[^,]+",index)
						mobs[id][6] = string.match(msg,"%d+",string.find(msg, ",")+2)
						addWaypoint(id)
					end
				end
			-- MoPRares
			elseif string.find(msg,"%[MoPRares%]") then
				print_d("moprares")
				-- Rare: Name has died.
				 if string.find(msg,'%(0%%%)') then
					print_d("has died")
					local name = string.sub(msg, 12, string.find(msg,'%(')-2)
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = GetTime()
						mobs[id][4] = true
						removeWaypoint(id)
					end
				-- [MoPRares] Name (100%) @ 60, 61
				else
					print_d("has not yet died")
					local name = string.match(msg,"[^\(]+",12)
					name = string.gsub(name, "%s$", "")
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = 0
						mobs[id][4] = false
						mobs[id][5] = string.match(msg,"[^,]+",string.find(msg, "@")+2)
						mobs[id][6] = string.match(msg,"%d+",string.find(msg, ",")+2)
						print_d("me: "..playerName.." author"..author)
						if author ~= playerName then 
							addWaypoint(id)
						end
					end
				end
			-- RareAnnouncer
			elseif string.find(msg,"Rare:") or string.find(msg,"RareAnnouncer") then
				print_d("rareannouncer")
				-- Rare: Name has died.
				if string.find(msg,"has died") then
					print_d("has died")
					local name = string.sub(msg, 7, string.find(msg, "has died.")-2)
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = GetTime()
						mobs[id][4] = true
						removeWaypoint(id)
					end
				-- Rare: Name (100%) Coordinates:60, 61
				-- ignore "was last killed" messages
				elseif not string.find(msg,"was last killed") then
					print_d("has not yet died")
					local name = string.match(msg,"[^\(]+",7)
					name = string.gsub(name, "%s$", "")
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = 0
						mobs[id][4] = false
						mobs[id][5] = string.match(msg,"[^,]+",string.find(msg, "nates:")+6)
						mobs[id][6] = string.match(msg,"%d+",string.find(msg, ",")+2)
						addWaypoint(id)
					end
				end
			-- RareShare
			elseif string.find(msg,"%[RareShare%]") then
				print_d("rareshare")
				-- [RareShare] Name has been killed.
				if string.find(msg,"has been killed") then
					print_d("has died")
					local name = string.sub(msg, 13, string.find(msg, "has been killed")-2)
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = GetTime()
						mobs[id][4] = true
						removeWaypoint(id)
					end
				-- [RareShare] Karkanos spotted around 39,85 with 100% HP!
				else
					print_d("has not yet died")
					local name = string.sub(msg, 13, string.find(msg, "spotted")-2)
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = 0
						mobs[id][4] = false
						mobs[id][5] = string.match(msg,"[^,]+",string.find(msg, "around")+7)
						mobs[id][6] = string.match(msg,"%d+",string.find(msg, ",")+1)
						addWaypoint(id)
					end
				end
			-- RareCoordinator
			elseif string.find(msg,"%[RareCoordinator%]") then
				print_d("rarecoordinator")
				-- * [RareCoordinator] name is now dead *
				if string.find(msg,"is now dead") then
					local name = string.sub(msg, string.find(msg, "]")+2, string.find(msg, "is now dead")-2)
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = GetTime()
						mobs[id][4] = true
						removeWaypoint(id)
					end
				-- * [RareCoordinator] name (100%): 50.0 / 50.0 *
				-- ignore the useless messages
				elseif not ignoreMsg(msg) then
					local name = string.match(msg,"[^\(]*",string.find(msg, "]")+2)
					name = string.gsub(name, "%s$", "")
					print_d(name)
					local id = getNPCId(getNPCName(name))
					print_d(id)
					if id ~= 42 then
						mobs[id][2] = 0
						mobs[id][4] = false
						mobs[id][5] = string.match(msg,"%d+%.?%d*",string.find(msg, ":")+2)
						mobs[id][6] = string.match(msg,"%d+%.?%d*",string.find(msg, "/")+2)
						addWaypoint(id)
					end
				end
			end
		end
	end
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", events)
