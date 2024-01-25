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

-- Actual levels

local goomba = {
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

local coast = {
    [1] = {
        name = "Emerald Coast (Kinkajoy)", 
        text = "An alternate take on Emerald Coast made before the Sonic Adventure remake in SRB2 Christmas. This stage is unique for using the theme instead of being a copy of the level itself.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Emerald Coast (Kinkajoy)", 
        text = "While technically an addon, it's possible this was made to show off the textures to the rest of the team.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local knothole1 = {
    [1] = {
        name = "Knothole Base: v2.0 Development", 
        text = "Knothole Base was intended to be one of 2.0's unlockable levels. While this didn't come to be, the cause was the remake of the SRB1 campaign being taken in as the unlockable instead.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Knothole Base: v2.0 Development", 
        text = "This version of Knothole Base is an early development version that ends halfway, and has been modified to be beatable.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local knothole2 = {
    [1] = {
        name = "Knothole Base: v2.0 Development", 
        text = "Knothole Base was intended to be one of 2.0's unlockable levels. While this didn't come to be, the cause was the remake of the SRB1 campaign being taken in as the unlockable instead.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Knothole Base: v2.0 Development", 
        text = "This version of Knothole Base is a more complete version of the level.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local highway = {
    [1] = {
        name = "Speed Highway: Development 98", 
        text = "A different Speed Highway map than what appeared in Beta Quest. This version was intended to based off of the highway section of the Sonic Adventure level, it's very unfinished.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Speed Highway: Development 98", 
        text = "(This map was modified to allow the stage to be completed.)", 
        sound = sfx_talk0, 
        next = 0
    }
}

-- Doomship

local dsz1 = {
    [1] = {
        name = "Doom Ship Act 1: Development 98", 
        text = "Doom Ship act 1 was barely started. The stage somewhat resembles one of the ships of the Egg Fleet from Sonic Heroes despite the fact that Sonic Heroes was made years later.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Doom Ship Act 1: Development 98", 
        text = "When being adapted for this mod, the exit was placed in the most accessible spot, the crusher room.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local dsz3 = {
    [1] = {
        name = "Doom Ship Act 3: Development 98", 
        text = "Once again you fight the old placeholder Egg Mobile. This time the battlefield is very dangerous, and very cheeseable.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Doom Ship Act 3: Development 98", 
        text = "This battlefield may also look familiar to players of version 2.0, but it is not the same battlefield.", 
        sound = sfx_talk0, 
        next = 0
    }
}

-- Lots of dark cities
-- (Is it really that dark of a future? DCZ's protos have more sidewalks combined than my town ever will.)

local dcz20 = {
    [1] = {
        name = "Dark City Zone: v2.0 Development", 
        text = "This version of Dark City was intended to be the new act 1 for the 2.0 era, but it was never finished. At the time, the zone was not high priority.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Dark City Zone: v2.0 Development", 
        text = "This was not meant to be a traditional stage, as Brak Eggman was meant to chase you down until you lose him in the subway at the end.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local dcz1 = {
    [1] = {
        name = "Dark City act 1: Development 98", 
        text = "An early concept of the stage. Act 1 shows off various ideas for the city including dark interiors, and a part with lava. Be careful with the crushers.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local dcz2 = {
    [1] = {
        name = "Dark City act 2: Development 98", 
        text = "Still pretty much a concept at this stage, Dark City act 2 takes you to the sewers.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Dark City act 2: Development 98", 
        text = "One part was intended for you to run into flamethrowers. However, flamethrowers would not show up until much later.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Dark City act 2: Development 98",
		text = "(This map was modified to allow the stage to be completed.)",
		sound = sfx_talk0,
		next = 0
	}
}

local dcz3 = {
    [1] = {
        name = "Dark City act 3: Development 98", 
        text = "Like Red Volcano, this boss throws you in without any rings. Unlike Red Volcano, this map actually had a boss placed on it in development, and places to hide.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local map01 = {
    [1] = {
        name = "MAP01 Dev Test Map", 
        text = "A small Techno Hill based dev map. It's unknown what this was meant to test exactly.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local watertop = {
    [1] = {
        name = "WATERTOP Dev Test Map", 
        text = "A Deep Sea themed test map. While the purpose for this map is unknown, it can be theorized that this was meant to test FOF based water, as water can be found on both the ceiling and floor.", 
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
			TB:DisplayBox(p, goomba)
		elseif tag == 59 then
			TB:DisplayBox(p, wood)
		elseif tag == 53 then
			TB:DisplayBox(p, coast)
		elseif tag == 101 then
			TB:DisplayBox(p, knothole1)
		elseif tag == 103 then
			TB:DisplayBox(p, knothole2)
		elseif tag == 84 then
			TB:DisplayBox(p, highway)
		elseif tag == 52 then
			TB:DisplayBox(p, dsz1)
		elseif tag == 51 then
			TB:DisplayBox(p, dsz3)
		elseif tag == 81 then
			TB:DisplayBox(p, dcz20)
		elseif tag == 49 then
			TB:DisplayBox(p, dcz1)
		elseif tag == 48 then
			TB:DisplayBox(p, dcz2)
		elseif tag == 50 then
			TB:DisplayBox(p, dcz3)
		elseif tag == 55 then
			TB:DisplayBox(p, map01)
		elseif tag == 72 then
			TB:DisplayBox(p, watertop)
		end
	end
end, "DEVPODI")
