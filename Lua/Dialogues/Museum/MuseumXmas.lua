-- SRB2 Museum podium text.
-- Proper cutscenes will be in their own scripts.

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

-- XMAS01
local springin = {
    [1] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Springin' Around: Christmas v0.90-0.96", -- The name of the speaker.
        --portrait = {"sonic", SPR2_STND, A, 8}, -- The "portrait". Basically, this shows who is speaking just above the textbox. Skin, spr2, frame, angle.
        --color = SKINCOLOR_BLUE, -- The color to use for the portrait.
        text = "Back in 1999, SRB2 was still getting its bearings. Versions 0.90 to 0.94 were very buggy and still are.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 2 -- The ID of the next textbox.
    },
	[2] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Springin' Around: Christmas v0.90-0.96", -- The name of the speaker.
        --portrait = {"sonic", SPR2_STND, A, 8}, -- The "portrait". Basically, this shows who is speaking just above the textbox. Skin, spr2, frame, angle.
        --color = SKINCOLOR_BLUE, -- The color to use for the portrait.
        text = "Springin' Around wound up being the first playable level of the Xmas series. It brought with it the first use of springs and the Crawlas.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 3 -- The ID of the next textbox.
    },
	[3] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Springin' Around: Christmas v0.90-0.96", -- The name of the speaker.
        --portrait = {"sonic", SPR2_STND, A, 8}, -- The "portrait". Basically, this shows who is speaking just above the textbox. Skin, spr2, frame, angle.
        --color = SKINCOLOR_BLUE, -- The color to use for the portrait.
        text = "This was also the first reappearance of Minus.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 0 -- The ID of the next textbox.
    }
}

-- XMAS02
local blustery = {
    [1] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Blustery Day: Christmas v0.90-0.96", -- The name of the speaker.
        text = "Blustery Day was the second level of the Christmas Demo series. This level brought with it the first use of fans to propel the player upwards.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 2 -- The ID of the next textbox.
    },
	[2] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Blustery Day: Christmas v0.90-0.96", -- The name of the speaker.
        text = "This level was also the first to show off the normal shield.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 0 -- The ID of the next textbox.
    }
}

-- XMAS03
local smount = {
    [1] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Snowy Mountain: Christmas v0.90-0.96", -- The name of the speaker.
        text = "Snow Mountain is a level that has little land to run on. The level looked like it was supposed to be on the peaks of the mountains.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 0 -- The ID of the next textbox.
    }
}

-- XMAS04
local glacier = {
    [1] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Gleaming Glacier: Christmas v0.90-0.96", -- The name of the speaker.
        text = "This level was designed around the idea of slipping around, this level also introduced us to the Elemental Shield.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 0 -- The ID of the next textbox.
    }
}

--XMAS05
local eggbase = {
    [1] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Egg Base: Christmas v0.90-0.96", -- The name of the speaker.
        text = "Egg Base is the kind of level that was not compatible with co-op mode. The reason lies with a trigger on the left path that causes the start to be smashed.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 2 -- The ID of the next textbox.
    },
	[2] = { -- The first textbox in the branch. The textbox numbering always starts at 1, and the textbox will always initialize to 1.
        name = "Egg Base: Christmas v0.90-0.96", -- The name of the speaker.
		-- this is super minor but i've gone and changed "singleplayer" to "Single Player", as Single Player
		-- refers to a gametype. "singleplayer" is also technically correct i guess, but it would keep bugging me
		-- if i didn't change it lmao. feel free to revert.
        text = "We've changed this so that it only happens in Single Player mode now.", -- The text to print into the box. Puts the "text" in "textbox".
        sound = sfx_talk0, -- The sound to play for every letter printed.
        next = 0 -- The ID of the next textbox.
    }
}

--XMAS06
local havinfun = {
    [1] = { 
        name = "Havin' Fun?/Egg Arena: Christmas v0.90-0.96", 
        text = "This level was the first boss level on the new Doom Legacy engine. It's simple in design and only contained the boss, 5 rings, and the player.",
        sound = sfx_talk0, 
        next = 0 
    }
}

-- XMAS07
local corners = {
    [1] = { 
        name = "Close Corners: Christmas v0.96", -- Fuck this level fuck this level fuck this level (its CD-OST song is good though...)
        text = "Close Corners was the first level added in Christmas version 0.96 of SRB2. This level was the first to use moving floors that weren't buttons.",
        sound = sfx_talk0, 
        next = 0 
    }
}

-- XMAS08
local xmsfact = {
    [1] = { 
        name = "Christmas Factory: Christmas v0.96", 
        text = "This level was the first to use Techno Hill's Christmas texture set and constantly moving floors near the end.",
        sound = sfx_talk0, 
        next = 0 
    }
}

-- XMAS09
local valley = {
    [1] = { 
        name = "Snow Valley: Christmas v0.96", 
        text = "Snow Valley is designed more like a canyon. This level zigs and zags and even has a hidden exit to a tropical beach!",
        sound = sfx_talk0, 
        next = 0 
    }
}

-- XMAS10
local fboss = {
    [1] = { 
        name = "Final Boss: Christmas v0.96", 
        text = "This level made heavy use of the Red Crawlas and Minuses.",
        sound = sfx_talk0, 
        next = 2 
    },
	[2] = { 
        name = "Final Boss: Christmas v0.96", 
        text = "Since development on the bosses was still very early, the battlefield was filed with both Red Crawlas and Minuses.",
        sound = sfx_talk0, 
        next = 0 
    }
}

-- XMAS11
local coast = {
    [1] = { 
        name = "Emerald Coast: Christmas v0.96", 
        text = "Emerald Coast was the second ever secret level publicly released in SRB2 history, the first being the early version of Greenflower in Christmas v0.93.",
        sound = sfx_talk0, 
        next = 2 
    },
	[2] = { 
        name = "Emerald Coast: Christmas v0.96", 
        text = "This is also the very first completed ported level for SRB2, having been sourced from Sonic Adventure on the Dreamcast.",
        sound = sfx_talk0, 
        next = 0 
    }
}

-- XMAS12
local theningtmare = {
	[1] = {
		name = "Sonic's Nightmare: Christmas v0.96",
		text = "Abandon hope all ye who play this level! Heed my word for this level lives up to the name \"Sonic's Nightmare\".",
		sound = sfx_talk0,
		next = 2
	},
	[2] = {
		name = "Sonic's Nightmare: Christmas v0.96",
		text = "The level was intended to give Sonic players the hardest time possible and it does just that, provided you didn't bring a fox with you.",
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
		if tag == 232 then -- Figure out a better way to do this. Tables are off the ______ because CF's library doesn't like those.
			TB:DisplayBox(p, springin)
		elseif tag == 235 then
			TB:DisplayBox(p, blustery)
		elseif tag == 238 then
			TB:DisplayBox(p, smount)
		elseif tag == 239 then
			TB:DisplayBox(p, glacier)
		elseif tag == 244 then
			TB:DisplayBox(p, eggbase)
		elseif tag == 245 then
			TB:DisplayBox(p, havinfun)
		elseif tag == 246 then
			TB:DisplayBox(p, corners)
		elseif tag == 247 then
			TB:DisplayBox(p, xmsfact)
		elseif tag == 256 then
			TB:DisplayBox(p, valley)
		elseif tag == 257 then
			TB:DisplayBox(p, fboss)
		elseif tag == 258 then
			TB:DisplayBox(p, coast)
		elseif tag == 259 then
			TB:DisplayBox(p, theningtmare)
		end
	end
end, "MUSEUMXM")
