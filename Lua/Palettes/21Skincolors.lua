-- Retro Skincolors - 2.1 Skincolors
-- Accurate invcolors and invshades from 2.1 have been commented out for some colors.
-- To re-enable them, comment out the uncommented invcolors and invshades and vice versa.

freeslot(
	"SKINCOLOR_21WHITE", -- Same as 2.0 White
	"SKINCOLOR_21SILVER",
	"SKINCOLOR_21GREY",
	"SKINCOLOR_21BLACK",
	"SKINCOLOR_21CYAN",
	"SKINCOLOR_21TEAL",
	"SKINCOLOR_21STEELBLUE", -- Same as 2.0 Steel_Blue
	"SKINCOLOR_21BLUE",
	"SKINCOLOR_21PEACH", -- Same as 2.0 Peach
	"SKINCOLOR_21TAN",
	"SKINCOLOR_21PINK", -- Same as 2.0 Pink
	"SKINCOLOR_21LAVENDER", -- Same as 2.0 Lavender
	"SKINCOLOR_21PURPLE", -- Same as 2.0 Purple
	"SKINCOLOR_21ORANGE",
	"SKINCOLOR_21ROSEWOOD",
	"SKINCOLOR_21BEIGE", -- Same as 2.0 Beige
	"SKINCOLOR_21BROWN", -- Same as Ween Brown
	"SKINCOLOR_21RED", -- Same as 2.0 Red
	"SKINCOLOR_21DARKRED",
	"SKINCOLOR_21NEONGREEN",
-- 	"SKINCOLOR_21GREEN", -- Basically the same as 2.2's Green
	"SKINCOLOR_21ZIM",
	"SKINCOLOR_21OLIVE",
	"SKINCOLOR_21YELLOW",
	"SKINCOLOR_21GOLD", -- Same as 2.0 Gold
	"SKINCOLOR_21SUPER1",
	"SKINCOLOR_21SUPER2",
	"SKINCOLOR_21SUPER3",
	"SKINCOLOR_21SUPER4",
	"SKINCOLOR_21SUPER5",
	"SKINCOLOR_21TSUPER1",
	"SKINCOLOR_21TSUPER2",
	"SKINCOLOR_21TSUPER3",
	"SKINCOLOR_21TSUPER4",
	"SKINCOLOR_21TSUPER5",
	"SKINCOLOR_21KSUPER1",
	"SKINCOLOR_21KSUPER2",
	"SKINCOLOR_21KSUPER3",
	"SKINCOLOR_21KSUPER4",
	"SKINCOLOR_21KSUPER5"
)

-- Normal Skincolors

skincolors[SKINCOLOR_21WHITE] = {
	name = "Old_White",
	ramp = {1,1,2,2,3,3,3,3,4,4,5,5,6,6,7,7},
	invcolor = SKINCOLOR_21BLACK,
	invshade = 5,
	chatcolor = 0,
	accessible = true
}

skincolors[SKINCOLOR_21SILVER] = {
	name = "Old_Silver",
	ramp = {3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18},
	invcolor = SKINCOLOR_21GREY,
	invshade = 11,
	chatcolor = 0,
	accessible = true
}

skincolors[SKINCOLOR_21GREY] = {
	name = "Old_Grey",
	ramp = {8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23},
	invcolor = SKINCOLOR_21SILVER,
	invshade = 3,
	chatcolor = V_GRAYMAP,
	accessible = true
}

skincolors[SKINCOLOR_21BLACK] = {
	name = "Old_Black",
	ramp = {24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31},
	invcolor = SKINCOLOR_21WHITE,
	invshade = 7,
	chatcolor = V_GRAYMAP,
	accessible = true
}

skincolors[SKINCOLOR_21CYAN] = {
	name = "Old_Cyan",
	ramp = {128,128,128,129,129,129,130,131,132,132,133,135,135,135,136,137},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_SANDY,
	invshade = 1,
	chatcolor = V_BLUEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21TEAL] = {
	name = "Old_Teal",
	ramp = {255,255,255,255,141,141,141,142,142,142,143,143,143,138,138,138},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_PEACHY,
	invshade = 7,
	chatcolor = V_BLUEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21STEELBLUE] = {
	name = "Old_Steel_Blue",
	ramp = {144,144,145,145,170,170,171,171,172,172,173,173,174,174,199,199},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_21PINK,
	invshade = 5,
	chatcolor = V_BLUEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21BLUE] = {
	name = "Old_Blue",
	ramp = {146,147,148,149,150,151,152,153,154,155,156,157,158,159,159,253},
	invcolor = SKINCOLOR_21ORANGE,
	invshade = 6,
	chatcolor = V_BLUEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21PEACH] = {
	name = "Old_Peach",
	ramp = {208,208,48,216,216,217,217,218,218,219,220,221,221,222,223,223},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_RUST,
	invshade = 7,
	chatcolor = V_ORANGEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21TAN] = {
	name = "Old_Tan",
	ramp = {218,219,220,221,221,222,223,223,224,225,226,227,228,229,230,231},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_BLUEBELL,
	invshade = 7,
	chatcolor = V_REDMAP,
	accessible = true
}

skincolors[SKINCOLOR_21PINK] = {
	name = "Old_Pink",
	ramp = {209,209,210,210,211,211,211,211,212,212,213,213,214,214,215,215},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_21STEELBLUE,
	invshade = 9,
	chatcolor = V_REDMAP,
	accessible = true
}

skincolors[SKINCOLOR_21LAVENDER] = {
	name = "Old_Lavender",
	ramp = {192,192,193,193,194,194,195,195,196,196,197,197,198,198,199,199},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_21GOLD,
	invshade = 4,
	chatcolor = V_PURPLEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21PURPLE] = {
	name = "Old_Purple",
	ramp = {179,179,181,181,182,182,183,183,184,184,185,185,186,186,187,187},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_LIME,
	invshade = 6,
	chatcolor = V_PURPLEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21ORANGE] = {
	name = "Old_Orange",
	ramp = {49,50,51,52,53,54,55,55,56,57,58,59,60,60,61,61},
	invcolor = SKINCOLOR_21BLUE,
	invshade = 3,
	chatcolor = V_ORANGEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21ROSEWOOD] = {
	name = "Old_Rosewood",
	ramp = {58,58,59,60,60,60,61,61,62,62,63,63,45,45,45,71},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_YOGURT,
	invshade = 8,
	chatcolor = V_ORANGEMAP,
	accessible = true
}

skincolors[SKINCOLOR_21BEIGE] = {
	name = "Old_Beige",
	ramp = {240,240,241,242,242,243,243,244,245,246,247,248,249,250,251,237},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_MOSS,
	invshade = 5,
	chatcolor = V_REDMAP,
	accessible = true
}

skincolors[SKINCOLOR_21BROWN] = {
	name = "Old_Brown",
	ramp = {224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_TAN,
	invshade = 2,
	chatcolor = V_REDMAP,
	accessible = true
}

skincolors[SKINCOLOR_21RED] = {
	name = "Old_Red",
	ramp = {33,34,35,35,36,37,38,39,40,41,42,43,44,45,71,46},
	invcolor = SKINCOLOR_GREEN,
	invshade = 10,
	chatcolor = V_REDMAP,
	accessible = true
}

skincolors[SKINCOLOR_21DARKRED] = {
	name = "Old_Dark_Red",
	ramp = {40,40,41,41,42,42,43,43,44,44,45,45,71,71,46,46},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_ICY,
	invshade = 10,
	chatcolor = V_REDMAP,
	accessible = true
}

skincolors[SKINCOLOR_21NEONGREEN] = {
	name = "Old_Neon_Green",
	ramp = {96,112,112,112,113,113,114,114,114,115,115,116,116,116,117,117},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_RUBY,
	invshade = 4,
	chatcolor = V_GREENMAP,
	accessible = true
}

skincolors[SKINCOLOR_21ZIM] = {
	name = "Old_Zim",
	ramp = {88,88,89,89,90,90,91,91,92,92,93,93,94,94,95,95},
	invcolor = SKINCOLOR_21PURPLE,
	invshade = 12,
	chatcolor = V_GREENMAP,
	accessible = true
}

skincolors[SKINCOLOR_21OLIVE] = {
	name = "Old_Olive",
	ramp = {75,75,75,76,76,77,77,78,78,78,79,79,239,239,111,111},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_DUSK,
	invshade = 3,
	chatcolor = V_GREENMAP,
	accessible = true
}

skincolors[SKINCOLOR_21YELLOW] = {
	name = "Old_Yellow",
	ramp = {73,73,73,73,75,75,76,76,77,77,78,78,79,79,239,239},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_CORNFLOWER,
	invshade = 8,
	chatcolor = V_YELLOWMAP,
	accessible = true
}

skincolors[SKINCOLOR_21GOLD] = {
	name = "Old_Gold",
	ramp = {83,83,64,64,65,65,66,66,67,67,68,68,69,69,70,70},
-- 	invcolor = SKINCOLOR_GREEN,
-- 	invshade = 7,
	invcolor = SKINCOLOR_21LAVENDER,
	invshade = 10,
	chatcolor = V_YELLOWMAP,
	accessible = true
}

-- Super Skincolors

skincolors[SKINCOLOR_21SUPER1] = {
	name = "Super Old_Super 1",
	ramp = {0,0,0,0,0,0,0,0,0,0,80,80,81,82,83,72}
}

skincolors[SKINCOLOR_21SUPER2] = {
	name = "Super Old_Super 2",
	ramp = {80,80,81,82,83,83,72,72,72,72,73,73,73,73,64,65}
}

skincolors[SKINCOLOR_21SUPER3] = {
	name = "Super Old_Super 3",
	ramp = {81,82,83,83,72,72,72,72,73,73,73,73,64,65,66,67}
}

skincolors[SKINCOLOR_21SUPER4] = {
	name = "Super Old_Super 4",
	ramp = {83,72,72,72,72,73,73,73,73,64,65,66,67,68,69,70}
}

skincolors[SKINCOLOR_21SUPER5] = {
	name = "Super Old_Super 5",
	ramp = {72,72,72,72,73,73,73,73,64,65,66,67,68,69,70,63}
}

skincolors[SKINCOLOR_21TSUPER1] = {
	name = "Super Old_Super_Tails 1",
	ramp = {0,0,0,0,0,0,0,0,0,0,208,48,49,50,51,52}
}

skincolors[SKINCOLOR_21TSUPER2] = {
	name = "Super Old_Super_Tails 2",
	ramp = {0,0,0,0,208,208,48,48,49,49,50,50,51,51,52,52}
}

skincolors[SKINCOLOR_21TSUPER3] = {
	name = "Super Old_Super_Tails 3",
	ramp = {0,0,208,208,48,48,49,49,50,50,51,51,52,52,53,53}
}

skincolors[SKINCOLOR_21TSUPER4] = {
	name = "Super Old_Super_Tails 4",
	ramp = {0,208,48,49,50,51,52,53,54,66,66,67,68,68,69,70}
}

skincolors[SKINCOLOR_21TSUPER5] = {
	name = "Super Old_Super_Tails 5",
	ramp = {208,48,49,50,51,52,53,54,66,66,67,67,68,69,69,70}
}

skincolors[SKINCOLOR_21KSUPER1] = {
	name = "Super Old_Super_Knux 1",
	ramp = {0,0,0,0,208,208,208,208,209,209,209,209,210,210,210,210}
}

skincolors[SKINCOLOR_21KSUPER2] = {
	name = "Super Old_Super_Knux 2",
	ramp = {0,0,0,208,208,208,209,209,210,210,210,32,32,32,33,33}
}

skincolors[SKINCOLOR_21KSUPER3] = {
	name = "Super Old_Super_Knux 3",
	ramp = {0,0,208,208,209,209,210,210,32,32,33,33,34,34,35,35}
}

skincolors[SKINCOLOR_21KSUPER4] = {
	name = "Super Old_Super_Knux 4",
	ramp = {208,208,209,209,210,210,32,32,33,33,34,34,35,35,35,35}
}

skincolors[SKINCOLOR_21KSUPER5] = {
	name = "Super Old_Super_Knux 5",
	ramp = {209,209,210,210,32,32,33,33,34,34,35,35,35,35,36,36}
}
