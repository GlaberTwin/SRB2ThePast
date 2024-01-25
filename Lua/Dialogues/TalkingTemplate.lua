-- Talking dialogue template.
-- You should never be calling these in a map (good luck running them on
-- tags 1 and 2 anyway lmao.)

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

local temp1 = {
    [1] = {
        name = "Metal Sonic", 
		portrait = 'METLTK',
        text = "I challenge you to race against me\nin various maps from SRB2's past.\n4 Tiers, 5 races each.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "Complete all 4 and I'll challenge\nyou to my best race.",
		sound = sfx_talk0,
		next = 3
	},
	[3] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "No one has ever beaten me at it, and\nno one ever will!",
		sound = sfx_talk0,
		next = 0
	}
}

local temp2 = {
    [1] = {
        name = "Template", 
        text = "A template text box...", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Template", 
        text = "...in two parts!", 
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
		if tag == 1 then
			TB:DisplayBox(p, temp1)
		elseif tag == 2 then
			TB:DisplayBox(p, temp2)
		end
	end
end, "DIAGTEMP")
