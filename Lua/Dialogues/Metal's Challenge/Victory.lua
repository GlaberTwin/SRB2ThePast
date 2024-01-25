-- Dialogues for the Metal's Challenge *lobby.*

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

-- Metal Sonic dialogue

local victory = {
	[1] = {
        name = "Glaber", 
		portrait = 'SSNGLABM',
        text = "Give it up, Metal! You lost fair and square.", 
        sound = sfx_talk0, 
		delay = 126,
        next = 2
    },
    [2] = {
        name = "Metal Sonic", 
		portrait = 'METLTSAD',
        text = "|shk1No one was supposed to be able to beat me, that was my hardest challenge!", 
        sound = sfx_talk0, 
		delay = 96,
        next = 3
    },
	[3] = {
		name = "Glaber",
		portrait = 'SSNGLABM',
		text = "Give the player the emblem, Metal.",
		sound = sfx_talk0,
		delay = 142,
		next = 4
	},
	[4] = {
		name = "Metal Sonic",
		portrait = 'METLTSAD',
		text = "|shk1Fine. Here.",
		sound = sfx_talk0,
		delay = 156,
		next = 5
	},
	[5] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "While we're at it, we're going to make it so you can replay this level whenever you want as an extra bonus too.",
		sound = sfx_talk0,
		delay = 130,
		next = 6
	},
	[6] = {
		name = "Glaber",
		portrait = 'SSNGLABM',
		text = "Alright Metal, we need to reprogram you to play fair.",
		sound = sfx_talk0,
		delay = 297,
		next = 0
	}
}

-- Summon the textbox with a linedef executor.
-- This is gonna suck.
addHook("LinedefExecute", function(l, m, s)
	for p in players.iterate
		if not p.textBox.tree then
			local tag = s.tag
			if tag == 1 then
				TB:DisplayBox(p, victory, true)
			end
		end
	end
end, "MVICTORY")
