// Sonic Doom 2 - Miscellaneous Objects
// Ported by MIDIMan

freeslot(
	"SPR_SDPF", // Borrowed from Freedoom
	"MT_SD2_PUFF",
	"S_SD2_PUFF_SPAWN1",
	"S_SD2_PUFF_SPAWN2",
	"S_SD2_PUFF_ANIMATE",
	"MT_SD2_SMOKE",
	"S_SD2_SMOKE_SPAWN",
	"S_SD2_SMOKE_DIE"
)

mobjinfo[MT_SD2_PUFF] = {
	doomednum = -1,
	spawnstate = S_SD2_PUFF_SPAWN1,
	spawnhealth = 1000,
	radius = 20*FRACUNIT,
	height = 16*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_NOGRAVITY|MF_NOCLIP|MF_NOCLIPHEIGHT
}

states[S_SD2_PUFF_SPAWN1] =		{SPR_SDPF,	A|FF_FULLBRIGHT,	4,	nil,	0,	0,	S_SD2_PUFF_SPAWN2}
states[S_SD2_PUFF_SPAWN2] =		{SPR_SDPF,	B|FF_FULLBRIGHT,	4,	nil,	0,	0,	S_SD2_PUFF_ANIMATE}
states[S_SD2_PUFF_ANIMATE] =	{SPR_SDPF,	C|FF_ANIMATE,		8,	nil,	2,	4,	S_NULL}

mobjinfo[MT_SD2_SMOKE] = {
	doomednum = -1,
	spawnstate = S_SD2_SMOKE_SPAWN,
	spawnhealth = 1000,
	radius = 20*FRACUNIT,
	height = 16*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_NOGRAVITY
}

states[S_SD2_SMOKE_SPAWN] =	{SPR_SDPF,	A|FF_ANIMATE,	16,	nil,	1,	4,	S_SD2_SMOKE_DIE}
states[S_SD2_SMOKE_DIE] =	{SPR_SDPF,	C,				4,	nil,	0,	0,	S_NULL}
