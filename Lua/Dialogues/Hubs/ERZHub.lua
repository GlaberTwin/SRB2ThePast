-- ERZ hub dialogues.
-- Currently placeholder. If i forget to remove this line feel free to come bash a deton over my head or something

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

// Devmaps and SRB2TP stuff

local erz1beta = {
    [1] = {
        name = "Egg Rock Zone act 1: v2.0 Various Development", 
        text = "Egg Rock act 1 betas. These 3 levels each show off Egg Rock act 1 in different stages of development.",
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 1: v2.0 Various Development", 
        text = "The right entrance is the earliest, left is the latest, and center is a special mid point version containing a long lost opening sequence.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local erbcut = {
    [1] = {
        name = "Egg Rock Zone act 3: v2.2 Development", 
        text = "Made for Egg Rock Zone by FuriousFox, this boss wound up being cut because the other developers felt that the end of the game had enough bosses already.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 3: v2.2 Development", 
        text = "Still, this boss got to see release as a reusable addon shortly after v2.2's release.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local thegantlet = {
    [1] = {
        name = "Egg Rock Zone Gauntlet", 
        text = "Welcome to the Egg Rock Gauntlet. Unlike Greenflower, this gauntlet pits you against 1 version of each unique boss for the zone including those from Black Core.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone Gauntlet", 
        text = "It may seem unfair, but those who beat the gauntlet will meet with a |wavspecial guest|rst.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local dev98 = {
    [1] = {
        name = "Egg Rock Zone: Development 98", 
        text = "Egg Rock started development back in 1998. Back then, the stage was very primitive and only contained 1 unfinished enemy. This was the only known use of the Egghead.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone: Development 98", 
        text = "Egg Rock would be publically known as Robotnirock at this time thanks to the old CD Soundtrack download available on the main website.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Egg Rock Zone: Development 98",
		text = "The name wouldn't be publically locked in until version 2.0 where the zone was finally revealed.",
		sound = sfx_talk0,
		next = 0
	}
}

// 2.0-era maps

local act120 = {
    [1] = {
        name = "Egg Rock Zone act 1: v2.0-2.0.4", 
        text = "Premiering in version 2.0, Egg Rock Zone act 1 had no enemies in it at all. The stage would heavily feature gravity based gimmicks and hazards.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 1: v2.0-2.0.4", 
        text = "The stage however, is actually incomplete as if you were able to go past the sign post you could find an unused room.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local act220 = {
    [1] = {
        name = "Egg Rock Zone act 2: v2.0-2.0.4", 
        text = "Egg Rock act 2 would be a gauntlet of hazards and puzzles. It's the only act of Egg Rock to have enemies at the time and featured heavy use of the new Polyobjects.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 2: v2.0-2.0.4", 
        text = "Future versions of this level would actually remove sections instead of building upon them.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local act1205 = {
    [1] = {
        name = "Egg Rock Zone act 1: v2.0.5-2.0.7", 
        text = "In v2.0.5, Egg Rock act 1 added in a few Eggman monitors near the end as well as another air pocket. This map also marks the first use of the character restriction textures.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local act2205 = {
    [1] = {
        name = "Egg Rock Zone act 2: v2.0.5-2.0.7", 
        text = "In the v2.0.5 update, Egg Rock act 2 was updated to make the air locks more obvious by adding in blue highlights.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 2: v2.0.5-2.0.7", 
        text = "A ceiling in a disappearing block room was made lower and a set of stairs was even placed in the shrink room.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local brak20 = {
    [1] = {
        name = "Egg Rock Zone act 3: v2.0-2.0.4", 
        text = "It's Metal Robotnik!\nBrak Eggman's first real appearance outside of Zero Ring has you fighting him in space on top of 4 towers and 4 collapsible platforms.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 3: v2.0-2.0.4", 
        text = "This fight would prove to be a serious challenge as he could not be damaged by normal means.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Egg Rock Zone act 3: v2.0-2.0.4",
		text = "Like the OVA he's from, Brak can be damaged by making him hit himself and riding his missiles into him. Don't forget to jump off!",
		sound = sfx_talk0,
		next = 0
	}
}

-- Feel free to revert the second line of this one if you'd like, I just figured it'd be nice to not have redundant text
-- (especially when the text in question is *right next to this textbox* lol)
local brak207 = {
    [1] = {
        name = "Egg Rock Zone act 2: v2.0.5-2.0.7", 
        text = "While the boss itself wasn't changed, the arena was. Now there are walls behind each tower and the platforms are gone. Plus, there's lava falling around the arena too.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone act 2: v2.0.5-2.0.7", 
        text = "Brak can be damaged the same way as before, so watch your step and don't try catching your breath on his head!",
        sound = sfx_talk0, 
        next = 0
    }
}

// 2.1-era maps

local act121 = {
    [1] = {
        name = "Egg Rock Zone act 1: v2.1-2.1.25", 
        text = "In version 2.1, Egg Rock act 1 was mostly the same as 2.0.7, except now there were enemies throughout the level.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local act221 = {
    [1] = {
        name = "Egg Rock Zone act 2: v2.1-2.1.25", 
        text = "In version 2.1, Egg Rock act 2 was mostly the same as 2.0.7 with one very big exception.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
		name = "Egg Rock Zone act 2: v2.1-2.1.25",
		text = "The space station had ejected its first section from the map, no more would players be sliding down a trap-ridden air tunnel.",
		sound = sfx_talk0,
		next = 0
	}
}

local metal21 = {
    [1] = {
        name = "Egg Rock - VS. Metal Sonic: v2.1-2.1.25", 
        text = "Time to race against Metal Sonic. This stage marks the very first time Metal Sonic could be raced against and then fought at the end.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock - VS. Metal Sonic: v2.1-2.1.25", 
        text = "Though at one point emblems were made for this level, they were scrapped. Even if they were to be restored, the last emblem would have been inaccessible.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local brak21 = {
    [1] = {
        name = "Egg Rock Zone - VS. Brak Eggman: v2.1-2.1.25", 
        text = "Brak Eggman has a new boss attack pattern and arena! Though now, he is no longer as hard as he once was as there's plenty of space to run around.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Egg Rock Zone - VS. Brak Eggman: v2.1-2.1.25",
		// Minor correction made to account for the fact that Brak actually sources his attacks from multiple enemies:
		// Movement patterns and rocket attack are from the Cyberdemon, the lockon explosion attack is from the Archvile,
        text = "His movement and attacks are based on a few old Doom enemies, giving him the nickname \"Cybrakdemon\".", 
        sound = sfx_talk0, 
        next = 0
    }
}

-- Summon the textbox with a linedef executor.
-- This is gonna suck.
// Prototype and SRB2TP maps
addHook("LinedefExecute", function(l, m, s)
	if not m.player then return end
	local p = m.player
	if not p.textBox.tree then
		local tag = s.tag
		if tag == 77 then
			TB:DisplayBox(p, erz1beta)
		elseif tag == 70 then
			TB:DisplayBox(p, erbcut)
		elseif tag == 74 then
			TB:DisplayBox(p, thegantlet)
		elseif tag == 230 then
			TB:DisplayBox(p, dev98)
		end
	end
end, "ERZHUB1")

// 2.0-era maps
addHook("LinedefExecute", function(l, m, s)
	if not m.player then return end
	local p = m.player
	if not p.textBox.tree then
		local tag = s.tag
		if tag == 60 then
			TB:DisplayBox(p, act120)
		elseif tag == 59 then
			TB:DisplayBox(p, act220)
		elseif tag == 68 then
			TB:DisplayBox(p, act1205)
		elseif tag == 66 then
			TB:DisplayBox(p, act2205)
		elseif tag == 62 then
			TB:DisplayBox(p, brak20)	
		elseif tag == 64 then
			TB:DisplayBox(p, brak207)
		end
	end
end, "ERZHUB20")

// 2.1-era maps
addHook("LinedefExecute", function(l, m, s)
	if not m.player then return end
	local p = m.player
	if not p.textBox.tree then
		local tag = s.tag
		if tag == 80 then
			TB:DisplayBox(p, act121)
		elseif tag == 83 then
			TB:DisplayBox(p, act221)
		elseif tag == 86 then
			TB:DisplayBox(p, metal21)
		elseif tag == 89 then
			TB:DisplayBox(p, brak21)
		end
	end
end, "ERZHUB21")