-- SRB2TP - TPEra Main
-- Created by Barrels O' Fun and MIDIMan

-- Just use NoSSMusic for maps from the XMAS and Demo eras

-- local SRB2TP_ERA_INFO = {}

local TP_NODROWNING 	= 1		// Infinite Air (Ween)
local TP_XMASWATER 		= 2		// Slow and Sloshy Water, Bloopy Sounds, No Jump Abilities, Green Water Fade
local TP_WEENWATER 		= 3     // Water Fade only checks view height + XMAS Water & No Drowning
local TP_DEMOWATER 		= 4		// Slow Movement, Regular Gravity, Surface Ability Speeds, Blue Water Fade
local TP_DEMO1WATER		= 6		// Slow and Sloshy Water, Bloopy Sounds,Surface Ability Speeds, Blue Water Fade
local TP_SHALLOWSPRING 	= 8    	// Acknowledge surfacing while Sprung in shallow water
local TP_BUBBLESOUNDS 	= 16	// Bubbles Make Sounds
local TP_SPRINGCOLLIDE 	= 32	// Touch Springs if you would've otherwise if you didn't hit a wall
local TP_NOSNEAKERMUSIC = 64	// No Speed Shoes Music
local TP_CONVEYORSPEED	= 128	// Spinning on a Conveyor builds momentum
local TP_MATCHSUPER		= 256	// Power Stones allow you to go super instead of granting Invincibility+Shoes

local XMAS = 1
local DEMO123 = 2
local DEMO4 = 4

//Copying Tables

local function shallowClone(table1)
    local table2 = {}
    for k, v in pairs(table1) do
        table2[k] = v
    end
    return table2
end

local function deepClone(table1)
    local table2
    if type(table1) == 'table' then
        table2 = {}
        for k, v in next, table1, nil do
            table2[deepClone(k)] = deepClone(v)
        end
        setmetatable(table2, deepClone(getmetatable(table1)))
    else -- number, string, boolean, etc
        table2 = table1
    end
    return table2
end



--------------------
--SRB2:TP Era Info-- // MIDIMan
--------------------

if not SRB2TP_ERA_INFO then
	rawset(_G, "SRB2TP_ERA_INFO", {})
end

SRB2TP_ERA_INFO["DEFAULT"] = {
	era = nil,

/////////
//MOBJS//
/////////
	mobjs = {
		[MT_RING] = {
			spawnstate = "S_RING",
			deathstate = "S_SPRK1"
		},
		[MT_FLINGRING] = {
			spawnstate = "S_RING",
			deathstate = "S_SPRK1"
		},
		[MT_SPARK] = {
			spawnstate = "S_SPRK1"
		},
		[MT_REDRING] = {
			spawnstate = "S_RRNG1",
			deathstate = "S_SPRK1"
		},
		[MT_REDTEAMRING] = {
			spawnstate = "S_TEAMRING"
		},
		[MT_BLUETEAMRING] = {
			spawnstate = "S_TEAMRING"
		},


		[MT_STARPOST] = {
			spawnstate = "S_STARPOST_IDLE",
			seestate = "S_STARPOST_FLASH",
			painstate = "S_STARPOST_STARTSPIN"
		},

		[MT_YELLOWSPRING] = {
			spawnstate = "S_YELLOWSPRING",
			raisestate = "S_YELLOWSPRING2",
			mass = 20*FRACUNIT,
			damage = 0,
			painsound = "sfx_spring",
			meleestate = 0
		},
		[MT_REDSPRING] = {
			spawnstate = "S_REDSPRING",
			raisestate = "S_REDSPRING2",
			mass = 32*FRACUNIT,
			damage = 0,
			painsound = "sfx_spring",
			meleestate = 0
		},
		[MT_BLUESPRING] = {
			spawnstate = "S_BLUESPRING",
			raisestate = "S_BLUESPRING2",
			painsound = "sfx_spring",
			mass = 11*FRACUNIT,
			damage = 0,
			painsound = "sfx_spring",
			meleestate = 0			
		},
		[MT_YELLOWDIAG] = {
			spawnstate = "S_YDIAG1",
			raisestate = "S_YDIAG2",
			mass = 20*FRACUNIT,
			damage = 20*FRACUNIT,
			painsound = "sfx_spring",
			meleestate = 0
		},
		[MT_REDDIAG] = {
			spawnstate = "S_RDIAG1",
			raisestate = "S_RDIAG2",
			mass = 32*FRACUNIT,
			damage = 32*FRACUNIT,
			painsound = "sfx_spring",
			meleestate = 0
		},
		[MT_BLUEDIAG] = {
			spawnstate = "S_BDIAG1",
			raisestate = "S_BDIAG2",
			painsound = "sfx_spring",
			mass = 11*FRACUNIT,
			damage = 11*FRACUNIT,
			painsound = "sfx_spring",
			meleestate = 0			
		},

		[MT_PITY_ORB] = {
			spawnstate = "S_PITY1"
		},
		[MT_REDFLAG] = {
			spawnstate = "S_REDFLAG"
		},
		[MT_BLUEFLAG] = {
			spawnstate = "S_BLUEFLAG"
		}
	},
	shields = nil,
	ringcolors = nil,
	music = nil,
	tweaks = 0
}

SRB2TP_ERA_INFO["TGF"] = {
	era = "TGF",
	mobjs = {
		[MT_RING] = {
			spawnstate = "S_TGF_RING",
			deathstate = "S_TGF_RING_SPARK"
		},
		[MT_FLINGRING] = {
			spawnstate = "S_TGF_RING",
			deathstate = "S_TGF_RING_SPARK"
		},
		[MT_PITY_ORB] = {
			spawnstate = "S_TGF_PITY"
		}
	},
	music = {
		["_1UP"] = "_DM1UP",
		["_INV"] = "_XMINV",
		["_DROWN"] = "_DMDRN",
		["_GOVER"] = "_DMGOV"
	},

	tweaks = TP_NOSNEAKERMUSIC

}

SRB2TP_ERA_INFO["WEEN"] = {
	era = "WEEN",
	mobjs = {
		[MT_RING] = {
			spawnstate = "S_HALLORING",
			deathstate = "S_DOOMPICKUP"
		},
		[MT_FLINGRING] = {
			spawnstate = "S_HALLORING",
			deathstate = "S_DOOMPICKUP"
		}
	},
	music = {
		["_1UP"] = "_DM1UP",
		["_INV"] = "_XMINV",
		["_DROWN"] = "_DMDRN",
		["_GOVER"] = "_DMGOV"
	},

	tweaks = TP_WEENWATER|TP_NOSNEAKERMUSIC|TP_CONVEYORSPEED

}

SRB2TP_ERA_INFO["XMAS"] = {
	era = "XMAS",

	mobjs = {

		[MT_RING] = {
			spawnstate = "S_OLD_RING",
			deathstate = "S_OLD_SPARK1"
		},

		[MT_FLINGRING] = {
			spawnstate = "S_OLD_RING",
			deathstate = "S_OLD_SPARK1"
		},

		[MT_YELLOWSPRING] = {
			spawnstate = "S_OLD_YELLOWSPRING",
			raisestate = "S_OLD_YELLOWSPRING2",
			mass = 18*FRACUNIT,
			damage = 0,
			painsound = "sfx_s24c",
			meleestate = DEMO4
		},

		[MT_REDSPRING] = {
			spawnstate = "S_OLD_REDSPRING",
			raisestate = "S_OLD_REDSPRING2",
			mass = 30*FRACUNIT,
			damage = 0,
			painsound = "sfx_s24c",
			meleestate = DEMO4
		},

		[MT_YELLOWDIAG] = {
			spawnstate = "S_OLD_YDIAG1",
			raisestate = "S_OLD_YDIAG2",
			mass = 18*FRACUNIT,
			damage = 3*512000,
			painsound = "sfx_s24c",
			meleestate = XMAS
		},

	},

	shields = {
		[SH_PITY] = SKINCOLOR_BLUE,
		[SH_BUBBLEWRAP] = SKINCOLOR_GREEN,
		[SH_ATTRACT] = SKINCOLOR_GOLD,
		[SH_ARMAGEDDON] = SKINCOLOR_GREY
	},
	music = {
		["_1UP"] = "_DM1UP",
		["_INV"] = "_XMINV",
		["_DROWN"] = "_DMDRN",
		["_GOVER"] = "_DMGOV"
	},

	tweaks = TP_XMASWATER|TP_SPRINGCOLLIDE|TP_NOSNEAKERMUSIC|TP_CONVEYORSPEED
	
}

SRB2TP_ERA_INFO["DEMO1"] = {
	era = "DEMO",
	mobjs = {
		[MT_RING] = SRB2TP_ERA_INFO["XMAS"].mobjs[MT_RING],
		[MT_FLINGRING] = SRB2TP_ERA_INFO["XMAS"].mobjs[MT_FLINGRING],
		[MT_SPARK] = {
			spawnstate = "S_OLD_SPARK1"
		},

		[MT_YELLOWSPRING] = SRB2TP_ERA_INFO["XMAS"].mobjs[MT_YELLOWSPRING],
	
		[MT_REDSPRING] = SRB2TP_ERA_INFO["XMAS"].mobjs[MT_REDSPRING],

		[MT_YELLOWDIAG] = shallowClone(SRB2TP_ERA_INFO["XMAS"].mobjs[MT_YELLOWDIAG]),



		[MT_REDRING] = {
			spawnstate = "S_DEMO_RRNG",
			deathstate = "S_OLD_SPARK1"
		},
		[MT_REDFLAG] = {
			spawnstate = "S_DEMO_REDFLAG"
		},
		[MT_BLUEFLAG] = {
			spawnstate = "S_DEMO_BLUEFLAG"
		}
	},
	shields = SRB2TP_ERA_INFO["XMAS"].shields,
	ringcolors = {
		[SKINCOLOR_SALMON] = {"SKINCOLOR_FINALRED", "SKINCOLOR_RED"},
		[SKINCOLOR_CORNFLOWER] = {"SKINCOLOR_FINALBLUE", "SKINCOLOR_RED"}
	},
	music = {
		["_1UP"] = "_DM1UP",
		["_INV"] = "_XMINV",
		["_DROWN"] = "_DMDRN",
		["_GOVER"] = "_DMGOV"
	},

	tweaks = 	TP_DEMO1WATER|TP_SHALLOWSPRING|TP_SPRINGCOLLIDE|TP_NOSNEAKERMUSIC|TP_CONVEYORSPEED
}
SRB2TP_ERA_INFO["DEMO1"].mobjs[MT_YELLOWDIAG].damage = 30*FRACUNIT
SRB2TP_ERA_INFO["DEMO1"].mobjs[MT_YELLOWDIAG].meleestate = DEMO123


SRB2TP_ERA_INFO["DEMO23"] = shallowClone(SRB2TP_ERA_INFO["DEMO1"])
SRB2TP_ERA_INFO["DEMO23"].tweaks = 	TP_DEMOWATER|TP_SHALLOWSPRING|TP_SPRINGCOLLIDE|TP_NOSNEAKERMUSIC|TP_CONVEYORSPEED

SRB2TP_ERA_INFO["DEMO4"] = deepClone(SRB2TP_ERA_INFO["DEMO23"])
SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_YELLOWDIAG].meleestate = DEMO4
SRB2TP_ERA_INFO["DEMO4"].tweaks = TP_SHALLOWSPRING|TP_SPRINGCOLLIDE|TP_NOSNEAKERMUSIC|TP_CONVEYORSPEED


SRB2TP_ERA_INFO["1.01"] = {
	era = "FINALDEMO",
	mobjs = {
		[MT_RING] = SRB2TP_ERA_INFO["XMAS"].mobjs[MT_RING],
		[MT_FLINGRING] = SRB2TP_ERA_INFO["XMAS"].mobjs[MT_FLINGRING],
		[MT_SPARK] = SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_SPARK],
		[MT_REDRING] = {
			spawnstate = "S_FD_RRNG",
			deathstate = "S_FD_RING_SPARK1"
		},

		[MT_STARPOST] = {
			spawnstate = "S_FD_STARPOST_IDLE",
			seestate = "S_FD_STARPOST_FLASH",
			painstate = "S_FD_STARPOST_SPIN"
		},


		[MT_YELLOWSPRING] = shallowClone(SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_YELLOWSPRING]),
		[MT_REDSPRING] = shallowClone(SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_REDSPRING]),
		[MT_YELLOWDIAG] = shallowClone(SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_YELLOWDIAG]),


		[MT_REDDIAG] = {
			spawnstate = "S_OLD_RDIAG1",
			raisestate = "S_OLD_RDIAG2",
			mass = 32*FRACUNIT,
			damage = 32*FRACUNIT,
			painsound = "sfx_s24c",
			meleestate = 0
		},

		[MT_REDFLAG] = SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_REDFLAG],
		[MT_BLUEFLAG] = SRB2TP_ERA_INFO["DEMO4"].mobjs[MT_BLUEFLAG]
	},
	shields = {
		[SH_PITY] = SKINCOLOR_BLUE,
		[SH_BUBBLEWRAP] = SKINCOLOR_GREEN,
		[SH_ATTRACT] = SKINCOLOR_GOLD,
		[SH_FLAMEAURA] = SKINCOLOR_RED,
		[SH_ARMAGEDDON] = SKINCOLOR_GREY
	},
	ringcolors = SRB2TP_ERA_INFO["DEMO4"].ringcolors,
	music = {
		["_1UP"] = "_FD1UP",
		["_SHOES"] = "_FDSHO",
		["_INV"] = "_FDINV",
		["_MINV"] = "_FDMNV",
		["_DROWN"] = "_FDDRN",
		["_GOVER"] = "_FDGOV",
		["_SUPER"] = "_FDSPR"
	},

	tweaks = TP_SHALLOWSPRING|TP_BUBBLESOUNDS|TP_CONVEYORSPEED

}
SRB2TP_ERA_INFO["1.01"].mobjs[MT_YELLOWSPRING].mass = 20*FRACUNIT
SRB2TP_ERA_INFO["1.01"].mobjs[MT_YELLOWSPRING].meleestate = 0

SRB2TP_ERA_INFO["1.01"].mobjs[MT_REDSPRING].mass = 32*FRACUNIT
SRB2TP_ERA_INFO["1.01"].mobjs[MT_REDSPRING].meleestate = 0

SRB2TP_ERA_INFO["1.01"].mobjs[MT_YELLOWDIAG].mass = 20*FRACUNIT
SRB2TP_ERA_INFO["1.01"].mobjs[MT_YELLOWDIAG].damage = 20*FRACUNIT
SRB2TP_ERA_INFO["1.01"].mobjs[MT_YELLOWDIAG].meleestate = 0



SRB2TP_ERA_INFO["1.04"] = SRB2TP_ERA_INFO["1.01"]
SRB2TP_ERA_INFO["1.08"] = SRB2TP_ERA_INFO["1.04"]

SRB2TP_ERA_INFO["1.09"] = {
	era = "FINALDEMO",
	mobjs = {
		[MT_RING] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_RING],
		[MT_FLINGRING] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_FLINGRING],
		[MT_SPARK] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_SPARK],
		[MT_REDRING] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_REDRING],

		[MT_STARPOST] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_STARPOST],

		[MT_YELLOWSPRING] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_YELLOWSPRING],
		[MT_REDSPRING] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_REDSPRING],
		[MT_BLUESPRING] = {
			spawnstate = "S_OLD_BLUESPRING",
			raisestate = "S_OLD_BLUESPRING2",
			mass = 11*FRACUNIT,
			damage = 0,
			painsound = "sfx_s24c",
			meleestate = 0
		},	
		[MT_YELLOWDIAG] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_YELLOWDIAG],
		[MT_REDDIAG] = SRB2TP_ERA_INFO["1.08"].mobjs[MT_REDDIAG],
		[MT_BLUEDIAG] = {
			spawnstate = "S_OLD_BDIAG1",
			raisestate = "S_OLD_BDIAG2",
			mass = 11*FRACUNIT,
			damage = 11*FRACUNIT,
			painsound = "sfx_s24c",
			meleestate = 0
		},

		[MT_REDFLAG] = {
			spawnstate = "S_FD_REDFLAG"
		},
		[MT_BLUEFLAG] = {
			spawnstate = "S_FD_BLUEFLAG"
		}
	},
	shields = {
		[SH_BUBBLEWRAP] = SKINCOLOR_BLUE,
		[SH_ATTRACT] = SKINCOLOR_GOLD,
		[SH_FLAMEAURA] = SKINCOLOR_RED,
		[SH_ARMAGEDDON] = SKINCOLOR_GREY,
		[SH_WHIRLWIND] = SKINCOLOR_WHITE
	},
	ringcolors = SRB2TP_ERA_INFO["1.08"].ringcolors,
	music = {
		["_1UP"] = "_FD1UP",
		["_SHOES"] = "_FDSHO",
		["_INV"] = "_FDINV",
		["_MINV"] = "_FDMNV",
		["_DROWN"] = "_FDDRN",
		["_GOVER"] = "_FDGOV",
		["_SUPER"] = "_19SPR"
	},

	tweaks = TP_CONVEYORSPEED

}

SRB2TP_ERA_INFO["1.09.2"] = {
	era = "FINALDEMO",
	mobjs = SRB2TP_ERA_INFO["1.09"].mobjs,
	shields = SRB2TP_ERA_INFO["1.09"].shields,
	ringcolors = SRB2TP_ERA_INFO["1.09"].ringcolors,
	music = {
		["_1UP"] = "_FD1UP",
		["_SHOES"] = "_FDSHO",
		["_INV"] = "_FDINV",
		["_MINV"] = "_FDMNV",
		["_DROWN"] = "_FDDRN",
		["_GOVER"] = "_FDGOV",
		["_SUPER"] = "_20SPR"
	},
	tweaks = SRB2TP_ERA_INFO["1.09"].tweaks
}

SRB2TP_ERA_INFO["1.09.4"] = {
	era = "FINALDEMO",
	mobjs = SRB2TP_ERA_INFO["1.09.2"].mobjs,
	shields = SRB2TP_ERA_INFO["1.09.2"].shields,
	ringcolors = SRB2TP_ERA_INFO["1.09.2"].ringcolors,
	music = {
		["_1UP"] = "_201UP",
		["_SHOES"] = "_FDSHO",
		["_INV"] = "_20INV",
		["_MINV"] = "_FDMNV",
		["_DROWN"] = "_FDDRN",
		["_GOVER"] = "_FDGOV",
		["_SUPER"] = "_20SPR"
	},
	tweaks = SRB2TP_ERA_INFO["1.09.2"].tweaks
}

SRB2TP_ERA_INFO["2.0"] = {
	era = "2.0",
	mobjs = {
		[MT_RING] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_RING],
		[MT_FLINGRING] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_FLINGRING],
		[MT_SPARK] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_SPARK],
		[MT_REDTEAMRING] = {
			spawnstate = "S_20_TEAMRING"
		},
		[MT_BLUETEAMRING] = {
			spawnstate = "S_20_TEAMRING"
		},
		[MT_REDRING] = {
			spawnstate = "S_20_RRNG",
			deathstate = "S_FD_RING_SPARK1"
		},

		[MT_STARPOST] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_STARPOST],

		[MT_YELLOWSPRING] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_YELLOWSPRING],
		[MT_REDSPRING] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_REDSPRING],
		[MT_BLUESPRING] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_BLUESPRING],
		[MT_YELLOWDIAG] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_YELLOWDIAG],
		[MT_REDDIAG] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_REDDIAG],
		[MT_BLUEDIAG] = SRB2TP_ERA_INFO["1.09.4"].mobjs[MT_BLUEDIAG]
	},
	shields = {
		[SH_ELEMENTAL] = SKINCOLOR_GREEN,
		[SH_ATTRACT] = SKINCOLOR_GOLD,
		[SH_FORCE] = SKINCOLOR_BLUE,
		[SH_ARMAGEDDON] = SKINCOLOR_RED,
		[SH_WHIRLWIND] = SKINCOLOR_WHITE
	},
	ringcolors = {
		[SKINCOLOR_SALMON] = {"SKINCOLOR_LEGACYRED", "SKINCOLOR_RED"},
		[SKINCOLOR_CORNFLOWER] = {"SKINCOLOR_LEGACYSTEELBLUE", "SKINCOLOR_AZURE"}
	},
	music = SRB2TP_ERA_INFO["1.09.4"].music,
	tweaks = TP_CONVEYORSPEED|TP_MATCHSUPER
}

SRB2TP_ERA_INFO["2.1"] = {
	era = "2.1",
	mobjs = {
		[MT_RING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_RING],
		[MT_FLINGRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_FLINGRING],
		[MT_SPARK] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_SPARK],
		[MT_REDTEAMRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_REDTEAMRING],
		[MT_BLUETEAMRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_BLUETEAMRING],
		[MT_REDRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_REDRING],
		[MT_STARPOST] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_STARPOST],
		[MT_YELLOWSPRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_YELLOWSPRING],
		[MT_REDSPRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_REDSPRING],
		[MT_BLUESPRING] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_BLUESPRING],
		[MT_YELLOWDIAG] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_YELLOWDIAG],
		[MT_REDDIAG] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_REDDIAG],
		[MT_BLUEDIAG] = SRB2TP_ERA_INFO["2.0"].mobjs[MT_BLUEDIAG],
		[MT_PITY_ORB] = {
			spawnstate = "S_21_PITY1"
		}
	},
	shields = nil,
	ringcolors = SRB2TP_ERA_INFO["2.0"].ringcolors,
	music = SRB2TP_ERA_INFO["2.0"].music,
	tweaks = TP_MATCHSUPER
}	

rawset(_G, "SRB2TP_GetEraInfo", function(nextmap)
	if nextmap and mapheaderinfo[nextmap].tpera then
		return SRB2TP_ERA_INFO[tostring(mapheaderinfo[nextmap].tpera):upper()]
	elseif mapheaderinfo[gamemap].tpera and not nextmap then
		return SRB2TP_ERA_INFO[tostring(mapheaderinfo[gamemap].tpera):upper()]
	else
		return SRB2TP_ERA_INFO["DEFAULT"]
	end
end)

-- Thanks to Golden on the SRB2 Discord for the basis of this function
local function CheckFreeslot(item)
    local function CheckItem(item)
        return _G[item]
    end
    return pcall(CheckItem, item)
end


local SRB2TPE_UniqueObjects = {}
addHook("MapChange", function()
	SRB2TPE_UniqueObjects = {}
end)

addHook("NetVars", function(network)
	SRB2TPE_UniqueObjects = network(SRB2TPE_UniqueObjects)
end)


rawset(_G, "SRB2TP_UpdateObject", function(mo, renew)
	if renew == nil and SRB2TPE_UniqueObjects then
		for i,uobj in ipairs(SRB2TPE_UniqueObjects) do
			if mo.type == uobj then return end -- Don't come back unless renewing for a state change
		end
		SRB2TPE_UniqueObjects[#SRB2TPE_UniqueObjects+1]=mo.type
	end
	local eraInfo = SRB2TP_GetEraInfo()
	
	if not (eraInfo and eraInfo.mobjs and eraInfo.mobjs[mo.type]) then
		for index, newitem in pairs(SRB2TP_ERA_INFO["DEFAULT"].mobjs[mo.type]) do
			local changeditem = newitem
			if type(changeditem) == "string" then
				if not CheckFreeslot(changeditem) then continue end
				changeditem = _G[$]
			end
			mo.info[index] = changeditem
		end
	else
		local newmoinfo = eraInfo.mobjs[mo.type]
		for index, newitem in pairs(newmoinfo) do
			local changeditem = newitem
			if newmoinfo[index] then changeditem = newmoinfo[index] end
			if type(changeditem) == "string" then
				if not CheckFreeslot(changeditem) then continue end
				changeditem = _G[$]
			end
			--print(motype)
			--print(changeditem)
			mo.info[index] = changeditem
		end
	end
end
)

--addHook("MapChange", function(nextmap)
--	SRB2TP_ChangeObjects(nextmap)
--end)
--This is not the most ideal way to do this, but at least it works in multiplayer...hopefully

--addHook("MapLoad", function()
	--SRB2TP_ChangeObjects()
--end)



addHook("MusicChange", function(oldname, newname, mflags, looping, position, prefadems, fadeinms)
	if not mapheaderinfo[gamemap].tpera then return end
	
	newname = $:upper()
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo then return end
	
	if eraInfo.music and eraInfo.music[newname] then
		local musicToPlay = eraInfo.music[newname]
		
		if type(musicToPlay) == "boolean" then return end
		
		return musicToPlay, mflags, looping, position, prefadems, fadeinms
	end
end)

/*states[S_TGF_RING] =		{SPR_GRNG,	A|FF_ANIMATE,	12,	nil,	3,	3,	S_TGF_RING2}
states[S_TGF_RING2] =		{SPR_GRNG,	C,				3,	nil,	0,	0,	S_TGF_RING3}
states[S_TGF_RING3] =		{SPR_GRNG,	B,				3,	nil,	0,	0,	S_TGF_RING}
states[S_TGF_RING_SPARK] =	{SPR_GRNG,	E|FF_ANIMATE,	5,	nil,	4,	1,	S_NULL}

states[S_WEEN_RING] =		{SPR_WRNG,	A|FF_ANIMATE,	-1,	nil,	15,	2,	S_WEEN_RING}
states[S_WEEN_RING_DIE] =	{SPR_NULL,	A,				35,	nil,	0,	0,	S_NULL}

states[S_FD_RING] =			{SPR_ORNG,	A|FF_ANIMATE,				-1,	nil,	23,	1,	S_FD_RING}
states[S_FD_RING_SPARK1] =	{SPR_ORNG,	Y|FF_TRANS40,				1,	nil,	0,	0,	S_FD_RING_SPARK2}
states[S_FD_RING_SPARK2] =	{SPR_ORNG,	Z|FF_TRANS50|FF_ANIMATE,	3,	nil,	2,	1,	S_FD_RING_SPARK3}
states[S_FD_RING_SPARK3] =	{SPR_ORNG,	Y|FF_TRANS60|FF_ANIMATE,	3,	nil,	2,	1,	S_FD_RING_SPARK4}
states[S_FD_RING_SPARK4] =	{SPR_ORNG,	27|FF_TRANS70,				1,	nil,	0,	0,	S_FD_RING_SPARK5}
states[S_FD_RING_SPARK5] =	{SPR_ORNG,	Y|FF_TRANS70|FF_ANIMATE,	2,	nil,	1,	1,	S_FD_RING_SPARK6}
states[S_FD_RING_SPARK6] =	{SPR_ORNG,	26|FF_TRANS80|FF_ANIMATE,	2,	nil,	1,	1,	S_FD_RING_SPARK7}
states[S_FD_RING_SPARK7] =	{SPR_ORNG,	Y|FF_TRANS80,				1,	nil,	0,	0,	S_FD_RING_SPARK8}
states[S_FD_RING_SPARK8] =	{SPR_ORNG,	Z|FF_TRANS90|FF_ANIMATE,	3,	nil,	2,	1,	S_NULL}

states[S_FD_RDIAG_IDLE] =		{SPR_RSPN,	A,				-1,	nil,	0,	0,	S_NULL}
states[S_FD_RDIAG_SPRING] =		{SPR_RSPN,	B|FF_ANIMATE,	4,	A_Pain,	3,	1,	S_FD_RDIAG_SPRING2}
states[S_FD_RDIAG_SPRING2] =	{SPR_RSPN,	D,				1,	nil,	0,	0,	S_FD_RDIAG_SPRING3}
states[S_FD_RDIAG_SPRING3] =	{SPR_RSPN,	C,				1,	nil,	0,	0,	S_FD_RDIAG_SPRING4}
states[S_FD_RDIAG_SPRING4] =	{SPR_RSPN,	B,				1,	nil,	0,	0,	S_FD_RDIAG_IDLE}


states[S_FD_STARPOST] =			{SPR_FSPT,	B,				-1,	nil,	0,	0,	S_FD_STARPOST}
states[S_FD_STARPOST_SPIN] =	{SPR_FSPT,	B|FF_ANIMATE,	32,	nil,	15,	1,	S_FD_STARPOST_FLASH1}
states[S_FD_STARPOST_FLASH1] =	{SPR_FSPT,	B,				2,	nil,	0,	0,	S_FD_STARPOST_FLASH2}
states[S_FD_STARPOST_FLASH2] =	{SPR_FSPT,	A,				2,	nil,	0,	0,	S_FD_STARPOST_FLASH1}
*/
