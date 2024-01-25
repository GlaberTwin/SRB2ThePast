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

local scene1 = {
	[1] = {
        name = "Glaber", 
		portrait = 'SSNGLABM',
        text = "WHAT WERE YOU |shk2THINKING?!", 
        sound = sfx_talk0, 
		delay = 100,
        next = 2
    },
    [2] = {
        name = "Glaber", 
		portrait = 'SSNGLABM',
        text = "YOU |shk2KNOW|rst YOU'RE NOT ALLOWED BACK HERE!", 
        sound = sfx_talk0, 
		delay = 90,
        next = 3
    },
	[3] = {
		name = "Glaber",
		portrait = 'SSNGLABM',
		text = "I SHOULD THROW YOU OUT |shk2RIGHT NOW!",
		sound = sfx_talk0,
		delay = 108,
		next = 4
	},
	[4] = {
		name = "Toad",
		portrait = 'TOADTALK',
		text = "Glaber, check this out!",
		sound = sfx_talk0,
		delay = 66,
		next = 5
	},
	[5] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "Huh?",
		sound = sfx_talk0,
		delay = 92,
		next = 6
	},
	[6] = {
		name = "Toad",
		portrait = 'TOADTALK',
		text = "The Robotnik Virus is gone!",
		sound = sfx_talk0,
		delay = 144,
		next = 7
	},
	[7] = {
		name = "Glaber",
		portrait = 'SSNGLABS',
		text = "Was this your doing?",
		sound = sfx_talk0,
		delay = 78,
		next = 8
	},
	[8] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "If so, you've done a great service for the museum, but...",
		sound = sfx_talk0,
		delay = 138,
		next = 9
	},
	[9] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "...we're still going to have to punish you for breaking in here.",
		sound = sfx_talk0,
		delay = 110,
		next = 10
	},
	[10] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "I've got an idea, come with me.",
		sound = sfx_talk0,
		delay = 120,
		next = 0
	}
}

local scene2 = {
	[1] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "Ladies and gentlemen! Today I've come to announce the opening of a brand new exhibit!", 
        sound = sfx_talk0, 
		delay = 153,
        next = 2
    },
    [2] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "Once intended to be included in our original plan,", 
        sound = sfx_talk0, 
		delay = 77,
        next = 3
    },
	[3] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "I am now happy to say that we can finally open up \"Sonic Doom 2: Bots on Mobius\" as we've always intended.",
		sound = sfx_talk0,
		delay = 172,
		next = 4
	},
	[4] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "But before I let everyone in, we've got a |wavspecial museum patron|rst to thank for making this all possible,",
		sound = sfx_talk0,
		delay = 155,
		next = 5
	},
	[5] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "and I can't think of a better way than by letting them have the first run!",
		sound = sfx_talk0,
		delay = 113,
		next = 6
	},
	[6] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "I told you I still had to punish you, and what better way then by having to go through at least Ice Cap act one again?",
		sound = sfx_talk0,
		delay = 151,
		next = 7
	},
	[7] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "But let's finish the ceremony first, shall we?",
		sound = sfx_talk0,
		delay = 100,
		next = 0
	}
}

-- Summon the textbox with a linedef executor.
-- This is gonna suck.
addHook("LinedefExecute", function(l, m, s) -- Linedef executor delay 750
	for p in players.iterate
		if not p.textBox.tree then
			TB:DisplayBox(p, scene1, true)
		end
	end
end, "TRUEEND")

addHook("LinedefExecute", function(l, m, s) -- Linedef executor delay 1146
	for p in players.iterate
		if not p.textBox.tree then
			TB:DisplayBox(p, scene2, true)
		end
	end
end, "TRUEEND2")

addHook("LinedefExecute", function(l, m, s)
	print('Skipping TRUEEND1 function... Don\'t forget to put things back where they were!')
end, "SKIPME")