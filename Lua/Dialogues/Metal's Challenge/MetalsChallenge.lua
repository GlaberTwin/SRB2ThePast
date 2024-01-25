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

local metlgreet = {
	[1] = {
        name = "Metal Sonic", 
		portrait = 'METLTK',
        text = "Player detected. I have a challenge for you.", 
        sound = sfx_talk0, 
        next = 2
    },
    [2] = {
        name = "Metal Sonic", 
		portrait = 'MTLMAD',
        text = "I challenge you to race against me\nin various maps from SRB2's past.\n4 Tiers, 5 races each.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "Complete all 4 and I'll challenge\nyou to my best race.",
		sound = sfx_talk0,
		next = 4
	},
	[4] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "No one has ever beaten me at it, and no one ever will!",
		sound = sfx_talk0,
		next = 0
	}
}

local metlmulti = {
    [1] = {
        name = "Metal Sonic", 
		portrait = 'METLTK',
        text = "|wavPlayers|rst detected. Group challenges are not intended. Issues may arise.", 
        sound = sfx_talk0, 
        next = 2
    },
    [2] = {
        name = "Metal Sonic", 
		portrait = 'MTLMAD',
        text = "I challenge you to race against me\nin various maps from SRB2's past.\n4 Tiers, 5 races each.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "Complete all 4 and I'll challenge\nyou to my best race.",
		sound = sfx_talk0,
		next = 4
	},
	[4] = {
		name = "Metal Sonic",
		portrait = 'MTLMAD',
		text = "No one has ever beaten me at it, and no one ever will!",
		sound = sfx_talk0,
		next = 0
	}
}

-- Glaber dialogue (post-final challenge)

local glabgreet = {
	[1] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "Hi Player. Metal Sonic is unfit for hosting duties after he threw a tantrum and nearly destroyed our systems.", 
        sound = sfx_talk0, 
        next = 2
    },
    [2] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "However, he is still available to race. Rules are the same as before.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "Compete against Metal in 21 tracks. Tracks follow simple rules that are posted in each of the 4 tier rooms.",
		sound = sfx_talk0,
		next = 4
	},
	[4] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "Metal will also behave in the final challenge now too.",
		sound = sfx_talk0,
		next = 0
	}
}

local glabmulti = {
	[1] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "Hi Players. Group challenges may have issues, so please race in Single Player or Circuit maps.", 
        sound = sfx_talk0, 
        next = 2
    },
    [2] = {
        name = "Glaber", 
		portrait = 'SSNGLABT',
        text = "Anyway, Metal Sonic is still available to race. Rules are the\nsame as before.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "Compete against Metal in 21 tracks. Tracks follow simple rules that are posted in each of the 4 tier rooms.",
		sound = sfx_talk0,
		next = 4
	},
	[4] = {
		name = "Glaber",
		portrait = 'SSNGLABT',
		text = "Metal will also behave in the final challenge now too.",
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
		if tag == 30 then
			if multiplayer then
				TB:DisplayBox(p, metlmulti)
			else
				TB:DisplayBox(p, metlgreet)
			end
		elseif tag == 35 then
			if multiplayer then
				TB:DisplayBox(p, glabmulti)
			else
				TB:DisplayBox(p, glabgreet)
			end
		end
	end
end, "METLDIAG")
