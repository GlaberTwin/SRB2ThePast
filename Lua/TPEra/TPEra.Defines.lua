-- SRB2TP - TPEra Freeslots
-- Created by Barrels O' Fun and MIDIMan

freeslot(
//RINGS
--TGF Ring
	"SPR_GRNG",
	"S_TGF_RING", "S_TGF_RING2", "S_TGF_RING3", "S_TGF_SPARK",
--Sonic Doom Rings
	"SPR_SDRI",	
	"S_SONICDOOM_RINGH", "S_SONICDOOM_RINGA",
	"S_DOOMPICKUP",
--Halloween Ring
	"SPR_HLRN",
	"S_HALLORING",
--Xmas-2.1 Ring
	"SPR_ORNG", "SPR_OTRG",
	"S_OLD_RING", "S_20_TEAMRING",

	"SPR_OSPK",
	"S_OLD_SPARK1","S_OLD_SPARK2","S_OLD_SPARK3","S_OLD_SPARK4","S_OLD_SPARK5","S_OLD_SPARK6","S_OLD_SPARK7","S_OLD_SPARK8","S_OLD_SPARK9",


//WEAPON RINGS
--Infinity
	"SPR_ORGI",
	"S_OLD_INFINITYRINGAMMO", "S_OLD_THROWNINFINITY",
--Automatic
	"SPR_ORGA", "SPR_OTAR", "SPR_OPNA",
	"S_OLD_AUTOMATICAMMO", "S_OLD_THROWNAUTOMATIC", 
	"S_OLD_AUTOPICKUP", "S_OLD_AUTOPICKUPFADE", 
--Homing
/*	"SPR_ORGH", "SPR_OTHR", 
	"S_HOMINGRINGAMMO", "S_THROWNHOMING", */
--Bounce
	"SPR_ORGB", "SPR_OPNB",
	"S_OLD_BOUNCERINGAMMO", "S_OLD_THROWNBOUNCE", 
	"S_OLD_BOUNCEPICKUP", "S_OLD_BOUNCEPICKUPFADE", 
--Scatter
	"SPR_ORGS", "SPR_OTAR", "SPR_OPNS",
	"S_OLD_SCATTERRINGAMMO", "S_OLD_THROWNSCATTER", 
	"S_OLD_SCATTERPICKUP", "S_OLD_SCATTERPICKUPFADE", 
--Explosion
	"SPR_ORGE", "SPR_OPNE",
	"S_OLD_EXPLOSIONRINGAMMO", "S_OLD_THROWNEXPLOSION", 
	"S_OLD_EXPLODEPICKUP", "S_OLD_EXPLODEPICKUPFADE", 
--Rail
	"SPR_ORGR", "SPR_OPNR",
	"S_OLD_RAILRINGRINGAMMO",
	"S_OLD_RAILPICKUP", "S_OLD_RAILPICKUPFADE", 
--Grenade
	"SPR_ORGG", "SPR_OTGR", "SPR_OPNG",
	"S_OLD_GRENADERINGAMMO", "S_OLD_THROWNGRENADE",
	"S_OLD_GRENADEPICKUP", "S_OLD_GRENADEPICKUPFADE", 
--Combination
/*	"SPR_OTCR",
	"S_THROWN_AUTO_EXPLODE_HOME",
	"S_THROWN_AUTO_EXPLODE",
	"S_THROWN_AUTO_HOME",
	"S_THROWN_EXPLODE_HOME", */


//SPRINGS
--Old Yellow	
	"S_OLD_YELLOWSPRING", "S_OLD_YELLOWSPRING2", "S_OLD_YELLOWSPRING3", "S_OLD_YELLOWSPRING4", "S_OLD_YELLOWSPRING5",
	"S_OLD_YDIAG1", "S_OLD_YDIAG2", "S_OLD_YDIAG3", "S_OLD_YDIAG4", "S_OLD_YDIAG5",
--Old Red
	"S_OLD_REDSPRING", "S_OLD_REDSPRING2", "S_OLD_REDSPRING3", "S_OLD_REDSPRING4", "S_OLD_REDSPRING5",
	"S_OLD_RDIAG1", "S_OLD_RDIAG2", "S_OLD_RDIAG3", "S_OLD_RDIAG4", "S_OLD_RDIAG5",
--Old Blue
	"S_OLD_BLUESPRING", "S_OLD_BLUESPRING2", "S_OLD_BLUESPRING3", "S_OLD_BLUESPRING4", "S_OLD_BLUESPRING5",
	"S_OLD_BDIAG1", "S_OLD_BDIAG2", "S_OLD_BDIAG3", "S_OLD_BDIAG4", "S_OLD_BDIAG5",


//FLAGS
	"SPR_OFLG",
	"S_DEMO_REDFLAG", "S_DEMO_BLUEFLAG",
	"S_FD_REDFLAG", "S_FD_BLUEFLAG",


//STARPOST
	"SPR_FDSP",
	"S_FD_STARPOST_IDLE", "S_FD_STARPOST_SPIN", "S_FD_STARPOST_FLASH"







)


//Doom Pickup for S_DOOMPICKUP
function A_DoomPickup(m)
	if not (m and m.valid) then return end
	
	if m.target and m.target.valid and m.target.player and m.target.player.valid then
		m.target.player.bonuscount = $ + 6
	end
end

addHook("PlayerSpawn", function(p)
	if not (p and p.valid) then return end
	
	p.bonuscount = 0
end)

addHook("PlayerThink", function(p)
    if p.bonuscount then
		if CV_FindVar("renderer").string != "OpenGL" then
			P_FlashPal(p,7+min(4,(p.bonuscount+7)>>3),1)
		end

		p.bonuscount = $ - 1
    end
end)

hud.add(function(v)
	if not (v and displayplayer and displayplayer.valid) then return end
	
    if displayplayer.bonuscount and CV_FindVar("renderer").string == "OpenGL" then
        v.fadeScreen(65, min(4,(displayplayer.bonuscount+7)>>3))
    end
end)

-- SRB2TP - TPEra States

//RINGS
--TGF
states[S_TGF_RING]  =		{SPR_GRNG,	A|FF_ANIMATE,	12,	nil,	3,	3,	S_TGF_RING2}
states[S_TGF_RING2] =		{SPR_GRNG,	C,				3,	nil,	0,	0,	S_TGF_RING3}
states[S_TGF_RING3] =		{SPR_GRNG,	B,				3,	nil,	0,	0,	S_TGF_RING}

states[S_TGF_SPARK] =		{SPR_GRNG,	E|FF_ANIMATE,	5,	nil,	4,	1,	S_NULL}

--Sonic Doom/Halloween Ring
states[S_SONICDOOM_RINGH] = {SPR_SDRI, 	FF_ANIMATE|FF_RANDOMANIM, 	-1, 	nil, 	5, 	6,	 S_SONICDOOM_RINGH}
states[S_SONICDOOM_RINGA] = {SPR_SDRI,	G|FF_ANIMATE|FF_RANDOMANIM, -1, 	nil, 	5,	6,	 S_SONICDOOM_RINGA}
states[S_HALLORING] = 		{SPR_HLRN, 	FF_ANIMATE|FF_GLOBALANIM, 	-1, 	nil, 	15,	2,	 S_HALLORING}

states[S_DOOMPICKUP] = 		{SPR_NULL, A,	0,	A_DoomPickup,	0,	0,	S_NULL}

--Xmas-2.1 Ring
states[S_OLD_RING] 		= {SPR_ORNG,	FF_ANIMATE|FF_GLOBALANIM,	-1,	nil,	23,	1,	S_OLD_RING}
states[S_20_TEAMRING] 	= {SPR_OTRG,	FF_ANIMATE|FF_GLOBALANIM,	-1,	nil,	24,	1,	S_20_TEAMRING}

states[S_OLD_SPARK1] =	{SPR_ORNG,	Y|FF_TRANS40,				1,	nil,	0,	0,	S_OLD_SPARK2}
states[S_OLD_SPARK2] =	{SPR_ORNG,	Z|FF_TRANS50|FF_ANIMATE,	3,	nil,	2,	1,	S_OLD_SPARK3}
states[S_OLD_SPARK3] =	{SPR_ORNG,	Y|FF_TRANS60|FF_ANIMATE,	3,	nil,	2,	1,	S_OLD_SPARK4}
states[S_OLD_SPARK4] =	{SPR_ORNG,	27|FF_TRANS70,				1,	nil,	0,	0,	S_OLD_SPARK5}
states[S_OLD_SPARK5] =	{SPR_ORNG,	Y|FF_TRANS70|FF_ANIMATE,	2,	nil,	1,	1,	S_OLD_SPARK6}
states[S_OLD_SPARK6] =	{SPR_ORNG,	26|FF_TRANS80|FF_ANIMATE,	2,	nil,	1,	1,	S_OLD_SPARK7}
states[S_OLD_SPARK7] =	{SPR_ORNG,	Y|FF_TRANS80,				1,	nil,	0,	0,	S_OLD_SPARK8}
states[S_OLD_SPARK8] =	{SPR_ORNG,	Z|FF_TRANS90|FF_ANIMATE,	3,	nil,	2,	1,	S_NULL}


//WEAPON RINGS



//SPRINGS
--Yellow
states[S_OLD_YELLOWSPRING]  = {SPR_SPRY,	F, 	-1,	nil,	0,	0,	S_NULL}
states[S_OLD_YELLOWSPRING2] = {SPR_SPRY,	J,	4,	A_Pain,	0,	0,	S_OLD_YELLOWSPRING3}
states[S_OLD_YELLOWSPRING3] = {SPR_SPRY,	I,	1,	nil,	0,	0,	S_OLD_YELLOWSPRING4}
states[S_OLD_YELLOWSPRING4] = {SPR_SPRY,	H,	1,	nil,	0,	0,	S_OLD_YELLOWSPRING5}
states[S_OLD_YELLOWSPRING5] = {SPR_SPRY,	G,	1,	nil,	0,	0,	S_OLD_YELLOWSPRING}

states[S_OLD_YDIAG1] 	= {SPR_YSPR, 	F, 				-1,	nil,	0,	0,	S_NULL}
states[S_OLD_YDIAG2] 	= {SPR_YSPR, 	G|FF_ANIMATE,	4,	A_Pain,	3,	1,	S_OLD_YDIAG3}
states[S_OLD_YDIAG3] 	= {SPR_YSPR, 	I, 				1,	nil,	0,	0,	S_OLD_YDIAG4}
states[S_OLD_YDIAG4] 	= {SPR_YSPR, 	H, 				1,	nil,	0,	0,	S_OLD_YDIAG5}
states[S_OLD_YDIAG5] 	= {SPR_YSPR, 	G, 				1,	nil,	0,	0,	S_OLD_YDIAG1}


--Red
states[S_OLD_REDSPRING]  = {SPR_SPRR,	F, 	-1,	nil,	0,	0,	S_NULL}
states[S_OLD_REDSPRING2] = {SPR_SPRR,	J,	4,	A_Pain,	0,	0,	S_OLD_REDSPRING3}
states[S_OLD_REDSPRING3] = {SPR_SPRR,	I,	1,	nil,	0,	0,	S_OLD_REDSPRING4}
states[S_OLD_REDSPRING4] = {SPR_SPRR,	H,	1,	nil,	0,	0,	S_OLD_REDSPRING5}
states[S_OLD_REDSPRING5] = {SPR_SPRR,	G,	1,	nil,	0,	0,	S_OLD_REDSPRING}

states[S_OLD_RDIAG1] 	= {SPR_RSPR, 	F, 				-1,	nil,	0,	0,	S_NULL}
states[S_OLD_RDIAG2] 	= {SPR_RSPR, 	G|FF_ANIMATE,	4,	A_Pain,	3,	1,	S_OLD_RDIAG3}
states[S_OLD_RDIAG3] 	= {SPR_RSPR, 	I, 				1,	nil,	0,	0,	S_OLD_RDIAG4}
states[S_OLD_RDIAG4] 	= {SPR_RSPR, 	H, 				1,	nil,	0,	0,	S_OLD_RDIAG5}
states[S_OLD_RDIAG5] 	= {SPR_RSPR, 	G, 				1,	nil,	0,	0,	S_OLD_RDIAG1}

--Blue
states[S_OLD_BLUESPRING]  = {SPR_SPRB,	F, 	-1,	nil,	0,	0,	S_NULL}
states[S_OLD_BLUESPRING2] = {SPR_SPRB,	J,	4,	A_Pain,	0,	0,	S_OLD_BLUESPRING3}
states[S_OLD_BLUESPRING3] = {SPR_SPRB,	I,	1,	nil,	0,	0,	S_OLD_BLUESPRING4}
states[S_OLD_BLUESPRING4] = {SPR_SPRB,	H,	1,	nil,	0,	0,	S_OLD_BLUESPRING5}
states[S_OLD_BLUESPRING5] = {SPR_SPRB,	G,	1,	nil,	0,	0,	S_OLD_BLUESPRING}

states[S_OLD_BDIAG1] 	= {SPR_BSPR, 	F, 				-1,	nil,	0,	0,	S_NULL}
states[S_OLD_BDIAG2] 	= {SPR_BSPR, 	G|FF_ANIMATE,	4,	A_Pain,	3,	1,	S_OLD_BDIAG3}
states[S_OLD_BDIAG3] 	= {SPR_BSPR, 	I, 				1,	nil,	0,	0,	S_OLD_BDIAG4}
states[S_OLD_BDIAG4] 	= {SPR_BSPR, 	H, 				1,	nil,	0,	0,	S_OLD_BDIAG5}
states[S_OLD_BDIAG5] 	= {SPR_BSPR, 	G, 				1,	nil,	0,	0,	S_OLD_BDIAG1}


//STARPOST
states[S_FD_STARPOST_IDLE]	= {SPR_FDSP, A, 			-1,	nil,	0,	0,	S_NULL}
states[S_FD_STARPOST_SPIN]	= {SPR_FDSP, FF_ANIMATE|C,	31,	nil,	15,	1,	S_FD_STARPOST_FLASH}
states[S_FD_STARPOST_FLASH]	= {SPR_FDSP, FF_ANIMATE|A,	-1,	nil,	1,	2,	S_NULL}


//FLAGS
states[S_DEMO_REDFLAG] 	=	{SPR_OFLG,	A,	-1,	nil,	0,	0,	S_NULL}
states[S_DEMO_BLUEFLAG] =	{SPR_OFLG,	B,	-1,	nil,	0,	0,	S_NULL}
states[S_FD_REDFLAG] 	=	{SPR_OFLG,	C,	-1,	nil,	0,	0,	S_NULL}
states[S_FD_BLUEFLAG] 	=	{SPR_OFLG,	D,	-1,	nil,	0,	0,	S_NULL}

/*
///SHIELD
states[S_TGF_PITY] =	{SPR_TPTY,	A|FF_ANIMATE|FF_TRANS40|FF_FULLBRIGHT,	5,	nil,	4,	1,	S_TGF_PITY2}
states[S_TGF_PITY2] =	{SPR_TPTY,	D|FF_TRANS40|FF_FULLBRIGHT,				1,	nil,	0,	0,	S_TGF_PITY3}
states[S_TGF_PITY3] =	{SPR_TPTY,	C|FF_TRANS40|FF_FULLBRIGHT,				1,	nil,	0,	0,	S_TGF_PITY4}
states[S_TGF_PITY4] =	{SPR_TPTY,	B|FF_TRANS40|FF_FULLBRIGHT,				1,	nil,	0,	0,	S_TGF_PITY}
*/


/*
freeslot(

	-- TGF Shield Orb
	"SPR_TPTY",
	"S_TGF_PITY",
	"S_TGF_PITY2",
	"S_TGF_PITY3",
	"S_TGF_PITY4",
	-- Pre-2.1 Shield Orb
	"SPR_FSHL",
	"MT_FD_SHIELDORB",
	"S_FD_SHIELDORB",
	-- 2.1 Pity Shield
	"SPR_OPTY",
	"S_21_PITY1",
	"S_21_PITY2",
	"S_21_PITY3",
	"S_21_PITY4",
	"S_21_PITY5",
	"S_21_PITY6",
	"S_21_PITY7",
	"S_21_PITY8",
	"S_21_PITY9",
	"S_21_PITY10",
)
*/