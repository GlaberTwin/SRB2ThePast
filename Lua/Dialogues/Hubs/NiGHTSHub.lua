-- NiGHTS hub dialogues.

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

local sh101 = {
    [1] = {
        name = "Spring Hill: v1.01-1.04", 
        text = "This is the premiere version of Spring Hill.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Spring Hill: v1.01-1.04", 
        text = "It was the first NiGHTS map publicly released and as such was missing quite a few things (like bumpers and bonus items) that would come in later updates.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local sh108 = {
    [1] = {
        name = "Spring Hill: v1.08", 
        text = "In this edition of the stage, NiGHTS bonus items were brought online for the first time.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Spring Hill: v1.08", 
        text = "You could find a helper, refill your drill dash, extend your paraloop's reach, or even get extra time!", 
        sound = sfx_talk0, 
        next = 0
    }
}

local sh109 = {
    [1] = {
        name = "Spring Hill: v1.09.4-2.0.7", 
        text = "Welcome to Spring Hill!\nChances are that this will be the first version you play thanks to its low emblem requirement.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Spring Hill: v1.09.4-2.0.7", 
        text = "In 1.09.4, this stage would only require 10 emblems, and in 2.0 it would require more. Despite this, the stage remained the same.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
        name = "Spring Hill: v1.09.4-2.0.7", 
        text = "This stage was also the first to introduce the bumpers.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local sh21 = {
    [1] = {
        name = "Spring Hill: v2.1-2.1.25", 
        text = "This version of the stage received the most changes. With nothing new to introduce to NiGHTS game play, this time the stage itself was modified for on-foot exploration.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Spring Hill: v2.1-2.1.25", 
        text = "New emblems were also placed in several spots in the map.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local nightsdev = {
    [1] = {
        name = "NiGHTS Dev", 
        text = "During the development of NiGHTS mode, this map was created. According to SSNTails, you were supposed to fly around the flower.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "NiGHTS Dev", 
        text = "While the map itself lacked any way to do this, it has been modified to work as stated and was given a way to complete it.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local floral = {
    [1] = {
        name = "Floral Field: v2.1-2.1.25", 
        text = "The first Special Stage of the 2.1 era. Floral Field was simple in design, but hid within it an intent to let you explore on foot. This intent was never realized.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local toxic = {
    [1] = {
        name = "Toxic Plateau: v2.1-2.1.25", 
        text = "Special Stage 2 of 2.1 was THZ themed. Unlike the stage today, a lot of pipes were missing and the emblem was not in plain sight.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local cove = {
    [1] = {
        name = "Flooded Cove: v2.1-2.1.25", 
        text = "Special Stage 3 of 2.1. Themed after Deep Sea, this stage too hid the designs that indicated you were once meant to be able to explore on foot.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Flooded Cove: v2.1-2.1.25",
		text = "Unlike the other Special Stages, this one is the only one to have an Emerald Token hidden in it.",
		sound = sfx_talk0,
		next = 0
	}
}

local fortress = {
    [1] = {
        name = "Cavern Fortress: v2.1-2.1.25", 
        text = "Special Stage 4 for 2.1 wound up being mostly a reskin of the racetrack Slumber Circuit with the addition of more hazards from Castle Eggman.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Cavern Fortress: v2.1-2.1.25",
		text = "Unlike Slumber Circuit, Cavern Fortress was much more organized.",
		sound = sfx_talk0,
		next = 0
	}
}

local wasteland = {
    [1] = {
        name = "Dusty Wasteland: v2.1-2.1.25", 
        text = "Special Stage 5 at first may look like a reskin of Spring Hill, but it's also a cut down version of the track with a tighter time limit and a retheme to Arid Canyon.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local magma = {
    [1] = {
        name = "Magma Caves: v2.1-2.1.25", 
        text = "Special Stage 6 wouldn't see much change from the 2.1 era to now. However, if you weren't careful, you could hit the wrong bumper and get detached from the track.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local satellite = {
    [1] = {
        name = "Egg Satellite: v2.1-2.1.25", 
        text = "Special Stage 7 received just a few changes between 2.1 and now.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Egg Satellite: v2.1-2.1.25",
		text = "Back then, parts were longer, the yoku block section existed, and some of the laser traps at the end didn't exist yet.",
		sound = sfx_talk0,
		next = 3
	},
	[3] = {
		name = "Egg Satellite: v2.1-2.1.25",
		text = "(This version of the stage has its emblem.)",
		sound = sfx_talk0,
		next = 0
	},
}

local slumber = {
    [1] = {
        name = "Slumber Circuit: v1.09.4-2.0.7", 
        text = "Slumber Circuit was not accessible in Singleplayer, but it did provide the base for a stage that was. This stage was actually a Circuit mode NiGHTS track.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Slumber Circuit: v1.09.4-2.0.7",
		text = "Unfortunately this stage doesn't work all that well for a race due to how NiGHTS mode plays.",
		sound = sfx_talk0,
		next = 0
	}
}

local blackhole = {
    [1] = {
        name = "Black Hole: v2.1-2.1.25", 
        text = "If you thought Sonic's Nightmare was bad, this stage is the REAL |wavNightmare|rst. If you could obtain all A's on all 7 NiGHTS Special Stages, you would unlock this stage.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Black Hole: v2.1-2.1.25",
		text = "Back then, it only had 1 emblem. Today it has 2, and several other changes.",
		sound = sfx_talk0,
		next = 0
	}
}

local shxms = {
    [1] = {
        name = "Spring Hill: v1.09.4 Christmas", 
        text = "Welcome to Christmas Chime!\nWait|del15...|del1 1.09.4?",
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Spring Hill: v1.09.4 Christmas",
		text = "Oh right, this is Spring Hill in Christmas mode.",
		sound = sfx_talk0,
		next = 3
	},
	[3] = {
		name = "Spring Hill: v1.09.4 Christmas",
		text = "Spring Hill's Christmas mode variant appeared in the Final Demos, but would resurface in 2.2 as Christmas Chime.",
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
		if tag == 59 then
			TB:DisplayBox(p, sh101)
		elseif tag == 62 then
			TB:DisplayBox(p, sh108)
		elseif tag == 63 then
			TB:DisplayBox(p, sh109)
		elseif tag == 64 then
			TB:DisplayBox(p, sh21)
		elseif tag == 53 then
			TB:DisplayBox(p, nightsdev)
		elseif tag == 66 then
			TB:DisplayBox(p, floral)
		elseif tag == 67 then
			TB:DisplayBox(p, toxic)
		elseif tag == 68 then
			TB:DisplayBox(p, cove)
		elseif tag == 69 then --hehe nice
			TB:DisplayBox(p, fortress)
		elseif tag == 70 then
			TB:DisplayBox(p, wasteland)
		elseif tag == 71 then
			TB:DisplayBox(p, magma)
		elseif tag == 72 then
			TB:DisplayBox(p, satellite)
		elseif tag == 65 then
			TB:DisplayBox(p, slumber)
		elseif tag == 57 then
			TB:DisplayBox(p, blackhole)
		elseif tag == 55 then
			TB:DisplayBox(p, shxms)
		end
	end
end, "NGHTPODI")
