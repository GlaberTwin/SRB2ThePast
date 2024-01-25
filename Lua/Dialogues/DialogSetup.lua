-- Filename's a bit of a fucking lie, I'm actually doing everything here.

-- Freeslot dialog sounds.

freeslot("sfx_talk0")
sfxinfo[sfx_talk0].caption = "/"

-- Not quite in the scope here, but also delete textboxes on level load.

local TB = CFTextBoxes -- shortcut

local hudstatus = 1
local pos = hudinfo[HUD_LIVES].y

local function hudOff()
	hud.disable("score")
	hud.disable("time")
	hud.disable("rings")
	hud.disable("lives")
end

local function hudOn()
	hud.enable("score")
	hud.enable("time")
	hud.enable("rings")
	hud.disable("lives")
end

--[[
-- Only exists for testing purposes.
COM_AddCommand("hudoff", hudOff)
COM_AddCommand("hudon", hudOn)
]]--

addHook("MapLoad", function(map) -- Make sure text boxes can't follow you between maps. Related: I fucking hate hooks???
	for p in players.iterate
		if p.textBox.tree then
			TB:CloseBox(p)
		end
		if mapheaderinfo[map].glaberlore then -- feel free to change this var's name, i just wanted to be silly
			hudOff()
		else
			if hudstatus == 0 then
				hudOn()
			end
		end
		--print(mapheaderinfo[map].glaberlore)
	end
end)