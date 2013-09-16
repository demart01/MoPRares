local _
local frame	= CreateFrame("Frame", nil, UIParent)
local textframe = CreateFrame("Frame", "IoTRaresText", UIParent)
textframe:SetSize(200,25)
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
	-- npc_id = {message sent, died time, name}
	[50358] = {0, 0, 0},
	[69664] = {0, 0, 0},
	[69996] = {0, 0, 0},
	[69997] = {0, 0, 0},
	[69998] = {0, 0, 0},
	[69999] = {0, 0, 0},
	[70000] = {0, 0, 0},
	[70001] = {0, 0, 0},
	[70002] = {0, 0, 0},
	[70003] = {0, 0, 0},
	--[69384] = {0, 0, 0}, --test crab
}
local message
local message_mob_id
local timer, throttle = 0, 3
local text_timer, text_throttle = 0, 10

local function DeathTimes(self,elapsed)
	text_timer = text_timer + elapsed
	if text_timer >= text_throttle then
		local t = ""
		local c = 0
		for k,v in pairs(mobs) do
			if mobs[k][2] > 0 then
				t = t .. mobs[k][3] .. " : " .. SecondsToTime(GetTime() - mobs[k][2], true) .. "\n"
				c = c + 1
			end
		end
		textframe.text:SetText(t)
		textframe:SetHeight(25 + c*13)
		text_timer = 0
	end
end

local function init()
	if GetCurrentMapAreaID() == 928 then
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

local function update(self,elapsed)
    timer = timer + elapsed;
    if timer >= throttle then
		if mobs[message_mob_id][1] + 10 < GetTime() then
			SendChatMessage(message , "CHANNEL", nil, 1)
		end
        timer = 0
		frame:SetScript("OnUpdate", nil)
    end
end

local function RandomizeTime()
	throttle = math.random()*3
	frame:SetScript("OnUpdate", update)
end

local function events(frame, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _,event_type,_,_,_,_,_,guid,name = select(1, ...)
		if event_type == "UNIT_DIED" then
			local id = tonumber(guid:sub(6, 10), 16)
			if not mobs[id] then return end
			mobs[id][2] = GetTime()
			mobs[id][3] = string.sub(name,1,20)
			message = "npc"..id..": "..name.." (0%)"
			message_mob_id = id
			RandomizeTime()
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		local guid = UnitGUID("target")
		if guid and mobs[tonumber(guid:sub(6, 10), 16)] and not UnitIsDead("target") then
			local id = tonumber(guid:sub(6, 10), 16)
			local name = UnitName("target")
			local x, y = GetPlayerMapPosition("player")
			local hp = math.floor(UnitHealth("target")*100/UnitHealthMax("target"))
			message = "npc"..id..": "..name.." ("..hp.."%). Coordinates: "..math.floor(x*100)..", "..math.floor(y*100)
			message_mob_id = id
			RandomizeTime()
		end
	elseif event == "CHAT_MSG_CHANNEL" then
		local msg,_,_,_,_,_,_,channel = select(1, ...)
		if channel == 1 and string.sub(msg,1,3) == "npc" then
			local id = tonumber(string.sub(msg,4,8))
			if mobs[id] then mobs[id][1] = GetTime() end
		end
	elseif(event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA") then
		init()
	end
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", events)
