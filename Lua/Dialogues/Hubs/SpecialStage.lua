-- Dev hub dialogues.

local TB = CFTextBoxes -- shortcut

--[[ Note to self:
|delxy - Set delay between characters drawn, including spaces. Default is |del11 - 1 char per 1 tic. Decimal. Both MUST be nonzero, will be set to 1 if found as 0.
         x: how many characters to draw per tic
         y: how many tics to wait until the next char
|paunn - Pause for nn tics. This pauses AFTER drawing the next character. Decimal. MUST be nonzero, will be set to 1 if found as 0.
|shkn - Shake text. 1 - light, 2 - medium, 3 - intense
|wav - Wavy text
|rst - Reset
|esc - Parse escape sequence. Required (and recommended) for colors.
--]]
-- Shouldn't need to use any of ^^those^^ but I'm keeping them for possibly using with the proper cutscene dialog later.

-- Hub stuff

local specialrules = {
    [1] = {
        name = "Mario Goomba Blast 1-1: Demo 4 Development", 
        text = "An early development version of the Mario Mode unlockable stage. This version lacked any Goombas and had no working ? Blocks.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Mario Goomba Blast 1-1: Demo 4 Development", 
        text = "Several walls would also be missing giving certain areas a different appearance.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local wood = {
    [1] = {
        name = "Wood Zone", 
        text = "This stage had barely begun development before it got scrapped. Wood Zone was supposed to be a secret stage complete with its own sky and music.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Wood Zone", 
        text = "The sky and music did make it in, but the level was never finished.", 
        sound = sfx_talk0, 
        next = 0
    }
}

-- Summon the textbox with a linedef executor.
-- This is gonna suck.
addHook("LinedefExecute", function(l, m, s)
	if not m.player then return end
	local p = m.player
	if not p.textBox.tree then
		local tag = s.tag
		if tag == 82 then
			TB:DisplayBox(p, specialrules)
		elseif tag == 59 then
			TB:DisplayBox(p, wood)
		end
	end
end, "SPECIALGURPS")
