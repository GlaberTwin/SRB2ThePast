-- SRB2 Museum badnik text.
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

local crawla = {
    [1] = {
        name = "Crawla", 
        text = "Stupid, Very poor aim. Shoots tiny little slow bullet.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local scrawla = {
    [1] = {
        name = "Super Crawla", 
        text = "Mostly \"walks\" in Sonic's direction, same bullets as Crawla I.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local flybot = {
    [1] = {
        name = "Flybot", 
        text = "Hovers around Sonic. Slightly quicker bullets aimed at Sonic.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local deton = {
    [1] = {
        name = "Deton", 
        text = "Flies into Sonic and explodes. Doesn't take walls into account and blows up if it hits them.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local skim = {
    [1] = {
        name = "Skim", 
        text = "Hovers over the water and drops bombs on Sonic.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local blub = {
    [1] = {
        name = "Blub-blub (crap name)", 
        text = "Rams himself into Sonic.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local drillakilla = {
    [1] = {
        name = "Drillakilla", 
        text = "Puts drill down and rams into Sonic.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local minus = {
    [1] = {
        name = "Minus", 
        text = "Surprises Sonic from the earth and attacks him.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local cappela = {
    [1] = {
        name = "Cappela", 
        text = "Cute on the outside, mean on the inside.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local egghead = {
    [1] = {
        name = "Egghead", 
        text = "Destroy it quickly... or eat its yolk?", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local lagun = {
    [1] = {
        name = "Lagun", 
        text = "Pops out of the lava to shoot lasers at Sonic.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local rockbot = {
    [1] = {
        name = "Rockbot", 
        text = "Once it sees Sonic, it destroys its outer layer and chases after him.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local commander = {
    [1] = {
        name = "Crawla Commander", 
        text = "Super fast version of the Crawla. First hit destroys its conveyor belt, meaning it hops around.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local swatbot = {
    [1] = {
        name = "Swatbot", 
        text = "Same old Badnik, same old AI.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local lazer = {
    [1] = {
        name = "Lazer", 
        text = "CAUTION! Not a real Badnik, but a considerable threat. Hovers above Sonic and shoots a big laser.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local ratbot = {
    [1] = {
        name = "Ratbot", 
        text = "Scurries along the floor and shoots Sonic with a very big gun.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local minibrak = {
    [1] = {
        name = "MiniBrak", 
        text = "A miniature Brak Eggman. Takes about three hits and has a much weaker laser and glue attack.", 
        sound = sfx_talk0, 
        next = 0 
    }
}

local bouncer = {
    [1] = {
        name = "Bouncer", 
        text = "Bounces around, swings, and shoots his spikeball hands.", 
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
		if tag == 31 then
			TB:DisplayBox(p, crawla)
		elseif tag == 33 then
			TB:DisplayBox(p, scrawla)
		elseif tag == 40 then
			TB:DisplayBox(p, flybot)
		elseif tag == 43 then
			TB:DisplayBox(p, deton)
		elseif tag == 49 then
			TB:DisplayBox(p, skim)
		elseif tag == 14 then
			TB:DisplayBox(p, blub)
		elseif tag == 54 then
			TB:DisplayBox(p, drillakilla)
		elseif tag == 55 then
			TB:DisplayBox(p, minus)
		elseif tag == 56 then
			TB:DisplayBox(p, cappela)
		elseif tag == 57 then
			TB:DisplayBox(p, egghead)
		elseif tag == 61 then
			TB:DisplayBox(p, lagun)
		elseif tag == 63 then
			TB:DisplayBox(p, rockbot)
		elseif tag == 64 then
			TB:DisplayBox(p, commander)
		elseif tag == 65 then
			TB:DisplayBox(p, swatbot)
		elseif tag == 67 then
			TB:DisplayBox(p, lazer)
		elseif tag == 68 then
			TB:DisplayBox(p, ratbot)
		elseif tag == 69 then
			TB:DisplayBox(p, minibrak)
		elseif tag == 70 then
			TB:DisplayBox(p, bouncer)
		end
	end
end, "MUSEUMBN")
