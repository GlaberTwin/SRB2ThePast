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

local tantrum1 = {
	[1] = {
        name = "Metal Sonic", 
		portrait = 'MTLMAD2',
        text = "|shk2NO!|rst THIS IS NOT POSSIBLE!\nYOU |shk2CHEATED!", 
        sound = sfx_talk0, 
		delay = 126,
        next = 2
    },
    [2] = {
        name = "Metal Sonic", 
		portrait = 'MTLMAD2',
        text = "|shk2NO|pau15 NO|pau15 NO|pau15 NO|pau15 NO|pau15 NO!", 
        sound = sfx_talk0, 
		delay = 186,
        next = 3
    },
	[3] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "There's |shk1no|rst way I'm giving you the emblem, nor am I going to let you leave!",
		sound = sfx_talk0,
		delay = 120,
		next = 0
	}
}

local tantrum2 = {
	[1] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "Player?|pau15 PLAYER!|pau15 Are you there?!", 
        sound = sfx_talk0, 
		delay = 206,
        next = 2
    },
    [2] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "I just got word that Metal Sonic has trapped you in Egg Rock Zone. I've\rgot an idea on how to get you out though.", 
        sound = sfx_talk0, 
		delay = 176,
        next = 3
    },
	[3] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "We're going to load you into another level so you can get out.",
		sound = sfx_talk0,
		delay = 188,
		next = 4
	},
	[4] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD2',
		text = "|shk2NOT IF I HAVE ANYTHING TO SAY ABOUT IT!",
		sound = sfx_talk0,
		delay = 120,
		next = 0
	}
}

-- Summon the textbox with a linedef executor.
-- This is gonna suck.
addHook("LinedefExecute", function(l, m, s)
	for p in players.iterate
		if not p.textBox.tree then
			local tag = s.tag
			if tag == 588 then
				TB:DisplayBox(p, tantrum1, true)
			else
				TB:DisplayBox(p, tantrum2, true)
			end
		end
	end
end, "TANTRUM")
