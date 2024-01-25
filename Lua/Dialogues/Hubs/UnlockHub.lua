-- Unlockables hub dialogues.

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

local mario = { -- the "mario" and "luigi" tags for the originals were cute im keeping them
    [1] = {
        name = "Mario Goomba Blast: Demo 4", 
        text = "Mario Goomba Blast was a single stage unlockable that first appeared in Demo 4.",
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Mario Goomba Blast: Demo 4", 
        text = "It was early for the mode as ? Blocks don't work yet, and Fire Flowers haven't been implemented either.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local luigi = {
    [1] = {
        name = "Mario Koopa Blast: v1.01-2.0.7", 
        text = "Mario Koopa Blast finished what Goomba Blast started and brought 2 more stages with it.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Mario Koopa Blast: v1.01-2.0.7", 
        text = "The 2 new stages also helped to show off the new 2D mode!", 
        sound = sfx_talk0, 
        next = 0
    }
}

local xmashunt = {
    [1] = {
        name = "Christmas Hunt: Demo 4 - v1.09.4", 
        text = "Premiering in Demo 4, Christmas Hunt was the first of the Emerald Hunt levels.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Christmas Hunt: Demo 4 - v1.09.4", 
        text = "In Demo 4, completing it would reward you with the Snowball Shooter. In Final Demo it was just a standard emerald hunt stage.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "Christmas Hunt: Demo 4 - v1.09.4",
		text = "The version included here is from v1.09.4.",
		sound = sfx_talk0,
		next = 0
	}
}

local saexample = {
    [1] = {
        name = "Adventure Example: v1.01-1.09.4", 
        text = "The Adventure Example stage was built to show off Adventure mode. The stage worked by using analog mode and giving the player the Homing Attack and Light Dash.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Adventure Example: v1.01-1.09.4", 
        text = "Adventure mode has since been remade and expanded as a reusable addon, allowing the level to now be played.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local nagz = {
    [1] = {
        name = "Neo Aerial Garden: v2.0-2.0.7", 
        text = "This zone originated long ago in the year 2002.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Neo Aerial Garden: v2.0-2.0.7", 
        text = "From there, the level would continue to grow and develop in the mod \"Mystic Realm\", before finally becoming a part of SRB2 itself and testing the limits of the engine.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
        name = "Neo Aerial Garden: v2.0-2.0.7", 
        text = "Due to the size of this stage, it has caused various visual bugs.", 
        sound = sfx_talk0, 
        next = 4
    },
	[4] = {
        name = "Neo Aerial Garden: v2.0-2.0.7", 
        text = "These bugs have unfortunately existed since version 2.0 with no fix in sight.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local agz = {
    [1] = {
        name = "Aerial Garden: v2.1-2.1.25", 
        text = "Losing the Neo prefix, Aerial Garden would continue to grow and change. Several rooms were remodeled and made harder.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Aerial Garden: v2.1-2.1.25", 
        text = "BASH bots from Arid Canyon were added in alongside Emblems too.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local atz = {
    [1] = {
        name = "Azure Temple: v2.1-2.1.25", 
        text = "Also known as |esc\x84|wavThe Phantasm|rst|esc\x80, Azure Temple is the gauntlet of water stages.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "Azure Temple: v2.1-2.1.25", 
        text = "Unlike other stages of its time, this stage would feature a bubble variant of the Buzz and be entirely underwater.", 
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
		if tag == 17 then
			TB:DisplayBox(p, mario)
		elseif tag == 63 then
			TB:DisplayBox(p, luigi)
		elseif tag == 67 then
			TB:DisplayBox(p, xmashunt)
		elseif tag == 18 then
			TB:DisplayBox(p, saexample)
		elseif tag == 64 then
			TB:DisplayBox(p, nagz)
		elseif tag == 65 then
			TB:DisplayBox(p, agz)
		elseif tag == 66 then
			TB:DisplayBox(p, atz)
		end
	end
end, "UNLKPODI")
