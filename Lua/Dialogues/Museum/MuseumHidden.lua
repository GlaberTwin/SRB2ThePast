-- SRB2 Museum template dialogues.
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
-- Shouldn't need to use any of ^^those^^ but I'm keeping them for possibly using with the proper cutscene dialog later.

local hidden1 = {
    [1] = {
        name = "BOSSBACK: Demo 1", 
        text = "Unseen in SRB2, this image was previously used in SRB2 Xmas for when you beat Emerald Coast.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "BOSSBACK: Demo 1", 
        text = "It's included in Demo 1 as BOSSBACK for fun, and likely to ensure the game does not crash upon completing level 30.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden2 = {
    [1] = {
        name = "HELP: Demo 1", 
        text = "This image comes from a Don Camillo book. It was included for fun by SSNTails as he's a big fan.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "HELP: Demo 1", 
        text = "It also served the purpose of preventing the game from crashing without a HELP image lump.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden3 = {
	[1] = {
        name = "DEM3QUIT: Demo 3", 
        text = "Used exclusively in Demo 3, this image was created for the Sonic Amateur Games Expo, or SAGE for short.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "DEM3QUIT: Demo 3", 
        text = "Its purpose was to advertise the next version in line, Demo 4, when exiting the game through the main menu.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden4 = {
    [1] = {
        name = "BOSSBACK: Demo 4", 
        text = "Unseen in SRB2, this image poked fun at what was then the latest Batman animated series, \"Batman Beyond\".", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "BOSSBACK: Demo 4", 
        text = "The inclusion of this image is for fun and likely to prevent crashes should someone beat a level in map slot 30.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden5 = {
    [1] = {
        name = "CONSBACK: Halloween Tech - Christmas v0.93", 
        text = "This image isn't exactly hidden as it was used as the splash screen for when the Halloween Tech Demo was booting up. Despite the name, it does not show up when using the console to cheat.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "CONSBACK: Halloween Tech - Christmas v0.93", 
        text = "Fun Fact: This image originates from an animated cutscene intended for the TGF version of SRB2, being the transition from Mine Maze to Rocky Mountain.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden6 = {
    [1] = {
        name = "CONSBACK: Christmas v0.94 - Demo 4", 
        text = "This image isn't exactly hidden as it was used as the splash screen for when the Christmas Demo was booting up, all the way through to Demo 4.35.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "CONSBACK: Christmas v0.94 - Demo 4", 
        text = "Despite the name, it does not show up when using the console to cheat.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden7 = {
    [1] = {
        name = "CONSBACK: Final Demo-2.1.25", 
        text = "This image isn't exactly hidden as it was used as the splash screen for when the \"Final\" Demo was booting up, all the way through to v2.1.25. ", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "CONSBACK: Final Demo-2.1.25", 
        text = "Despite the name, it does not show up when using the console to cheat.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden8 = {
    [1] = {
        name = "BKLUMP: Final Demo", 
        text = "An image of Jackel from NiGHTS into Dreams.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "BKLUMP: Final Demo", 
        text = "At first glance it appears to have only been included for fun, but it also contained some of the code for RedXVI's secret in Castle Eggman 2.", 
        sound = sfx_talk0, 
        next = 3
    },	
	[3] = {
		name = "BKLUMP: Final Demo",
		text = "This code may have been lost from the image in the porting process.",
		sound = sfx_talk0,
		next = 0
	}
}

local hidden9 = {
    [1] = {
        name = "BULMER: Final Demo-2.0.7", 
        text = "*B^D *B^D *B^D *B^D *B^D *B^D *B^D *B^D", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "BULMER: Final Demo-2.0.7", 
        text = "Included possibly just for the fun of people discovering it, as it's kinda like finding the Majin Sonic image from Sonic CD.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
		name = "BULMER: Final Demo-2.0.7",
		text = "Except with David Bulmer's OC, and his face.\n*B^D.",
		sound = sfx_talk0,
		next = 0
	}
}

local hidden10 = {
    [1] = {
        name = "HELP: Halloween Tech", 
        text = "Included in the Halloween Tech Demo possibly because the game would crash if the player were to press F1 without it present. It's very blunt.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden11 = {
    [1] = {
        name = "HELP: Christmas v0.92-0.93", 
        text = "A goofy image that looks like something right out of the 90's Archie and Sonic.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "HELP: Christmas v0.92-0.93", 
        text = "In truth, it's a modified image where Sonic and Knuckles are replacing Reggie and Archie.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
        name = "HELP: Christmas v0.92-0.93", 
        text = "It's included in the Christmas demo for fun and because the game would crash without a HELP lump present. ", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden12 = {
    [1] = {
        name = "HELP: Christmas v0.94", 
        text = "A goofy image featuring Sonic and an unused frame of Brak Eggman intended for Sonic Doom 2. This image was included for fun and to prevent the game crashing.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden13 = {
    [1] = {
        name = "HELP: Christmas v0.96", 
        text = "A goofy sketch seeing SSNTails getting fired by Sonikku. This sketch was included for a bit of fun while also making sure the game doesn't crash.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden14 = {
    [1] = {
        name = "HELP: Demo 2 and 3", 
        text = "Blunt, and a little threatening thanks to Bass aiming his buster at you.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "HELP: Demo 2 and 3", 
        text = "This image was drawn by SSNTails, and was included to direct people to the readme.txt file if they needed help.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden15 = {
    [1] = {
        name = "HELP: Demo 4", 
        text = "A sketch of Earthworm Jim telling players to check the readme.txt for help.", 
        sound = sfx_talk0, 
        next = 2
    }
}

local hidden16 = {
    [1] = {
        name = "SEGALOGO: Demo 2 and 3", 
        text = "A picture of A.J.'s dog at the time, well isn't it cute?", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "SEGALOGO: Demo 2 and 3", 
        text = "The SEGALOGO lump wound up unused for some reason and might have lasted to Demo 4 because SRB2 was checking for it now.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden17 = {
    [1] = {
        name = "SEGALOGO: Demo 4", 
        text = "A silly image of Sonic water skiing with Tails pulling him in Hydrocity.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "SEGALOGO: Demo 4", 
        text = "This was the last time a SEGALOGO lump was included as Final Demo did away with this lump.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden18 = {
    [1] = {
        name = "SEGALOGO: Demo 1", 
        text = "Literally the SEGA logo, this image was a holdover from Sonic Doom 2 and went unused in game.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "SEGALOGO: Demo 1", 
        text = "The demos afterwards replaced this image with others you see on the wall behind you.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden19 = {
    [1] = {
        name = "TITLEPIC: Demo 2 and 3", 
        text = "This lump was once intended to be the image you see on the main menu before the animated title screen was put in place.", 
        sound = sfx_talk0, 
        next = 2
    },
	[2] = {
        name = "TITLEPIC: Demo 2 and 3", 
        text = "Since then, this lump was replaced with placeholder images until SRB2 no longer needed it.", 
        sound = sfx_talk0, 
        next = 3
    },
	[3] = {
        name = "TITLEPIC: Demo 2 and 3", 
        text = "The image you see here may have just been an easter egg for people who open up the srb file. Demo 1's title picture can be found in the hall by the hint room.", 
        sound = sfx_talk0,  
        next = 0
    }
}

local hidden20 = {
    [1] = {
        name = "TITLEPIC: Demo 4", 
        text = "This lump was once been intended to be the image you see on the main menu before the animated title screen was put in place. The image here is a joke about Hidden Palace.", 
        sound = sfx_talk0, 
        next = 0
    }
}

local hidden21 = {
    [1] = {
        name = "HELP: Final Demo at Christmas", 
        text = "Final Demo did have a proper help screen, but at Christmas when the special mode kicks in, the help image was replaced with this one.", 
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
		if tag == 279 then
			TB:DisplayBox(p, hidden1)
		elseif tag == 280 then
			TB:DisplayBox(p, hidden2)
		elseif tag == 281 then
			TB:DisplayBox(p, hidden3)
		elseif tag == 282 then
			TB:DisplayBox(p, hidden4)
		elseif tag == 284 then
			TB:DisplayBox(p, hidden5)
		elseif tag == 286 then
			TB:DisplayBox(p, hidden6)
		elseif tag == 288 then
			TB:DisplayBox(p, hidden7)
		elseif tag == 290 then
			TB:DisplayBox(p, hidden8)
		elseif tag == 292 then
			TB:DisplayBox(p, hidden9)
		elseif tag == 283 then
			TB:DisplayBox(p, hidden10)
		elseif tag == 285 then
			TB:DisplayBox(p, hidden11)
		elseif tag == 287 then
			TB:DisplayBox(p, hidden12)
		elseif tag == 289 then
			TB:DisplayBox(p, hidden13)
		elseif tag == 291 then
			TB:DisplayBox(p, hidden14)
		elseif tag == 293 then
			TB:DisplayBox(p, hidden15)
		elseif tag == 294 then
			TB:DisplayBox(p, hidden16)
		elseif tag == 295 then
			TB:DisplayBox(p, hidden17)
		elseif tag == 296 then
			TB:DisplayBox(p, hidden18)
		elseif tag == 297 then
			TB:DisplayBox(p, hidden19)
		elseif tag == 298 then
			TB:DisplayBox(p, hidden20)
		elseif tag == 299 then
			TB:DisplayBox(p, hidden21)
		end
	end
end, "MUSEUMSC")
