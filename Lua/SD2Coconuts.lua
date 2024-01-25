// Sonic Doom 2 - Coconuts
// Ported by MIDIMan

freeslot(
	"sfx_sd2cse",
	"sfx_sd2cac",
	"SPR_SDCO",
	"MT_SD2_COCONUTS",
	"S_SD2_COCONUTS_LOOK",
	"S_SD2_COCONUTS_CHASE1",
	"S_SD2_COCONUTS_CHASE2",
	"S_SD2_COCONUTS_ATTACK1",
	"S_SD2_COCONUTS_ATTACK2",
	"S_SD2_COCONUTS_ATTACK3",
	"S_SD2_COCONUTS_PAIN1",
	"S_SD2_COCONUTS_PAIN2",
	"S_SD2_COCONUTS_DIE1",
	"S_SD2_COCONUTS_DIE_SCREAM",
	"S_SD2_COCONUTS_DIE2",
	"S_SD2_COCONUTS_DIE_FALL",
	"S_SD2_COCONUTS_DIE_STILL",
	// No xdeath states, because they're nearly indistinguishable from the normal death states during normal gameplay anyway
	"S_SD2_COCONUTS_RAISE1",
	"S_SD2_COCONUTS_RAISE2",
	"S_SD2_COCONUTS_RAISE3",
	"S_SD2_COCONUTS_RAISE4",
	"S_SD2_COCONUTS_RAISE5",
	"MT_SD2_COCONUT",
	"S_SD2_COCONUT_SPAWN",
	"S_SD2_COCONUT_STOPSOUND",
	"S_SD2_COCONUT_DIE"
)

sfxinfo[sfx_sd2cse].caption = "Coconuts awakens"
sfxinfo[sfx_sd2cac].caption = "Snarl"

local function SD2_TroopAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) return end
	
	A_FaceTarget(actor)
	if P_CheckMeleeRange(actor) then // "Claw" at the target if they're within range
		S_StartSound(actor, sfx_sd2clw)
		//local damage = (P_RandomByte()%8 + 1)*3
		P_DamageMobj(actor.target, actor, actor, 1)
		return
	end
	
	SD2_SpawnMissile(actor, actor.target, MT_SD2_COCONUT)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_COCONUTS)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_COCONUTS)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_COCONUTS)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_COCONUTS_PAIN1,
		S_SD2_COCONUTS_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_COCONUTS_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if (mo.state == S_SD2_COCONUTS_CHASE1
	or mo.state == S_SD2_COCONUTS_CHASE2)
	and mo.tics % 3 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_COCONUTS)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_COCONUTS)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_COCONUTS)

mobjinfo[MT_SD2_COCONUTS] = {
	//$Name Coconuts
	//$Sprite SDCOA1
	//$Category Sonic Doom 2
	doomednum = 166,
	spawnstate = S_SD2_COCONUTS_LOOK,
	spawnhealth = 3,
	seestate = S_SD2_COCONUTS_CHASE1,
	seesound = sfx_sd2cse,
	reactiontime = 8,
	painstate = S_SD2_COCONUTS_PAIN1,
	painchance = 200,
	painsound = sfx_sd2gpn,
	missilestate = S_SD2_COCONUTS_ATTACK1,
	meleestate = S_SD2_COCONUTS_ATTACK1,
	deathstate = S_SD2_COCONUTS_DIE1,
	deathsound = sfx_pop,//sfx_sd2cdi,
	speed = 8,
	radius = 20*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 100,
	activesound = sfx_sd2cac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_PUSHABLE,
	raisestate = S_SD2_COCONUTS_RAISE1
}

states[S_SD2_COCONUTS_LOOK] =	{SPR_SDCO,	A|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_COCONUTS_LOOK}

states[S_SD2_COCONUTS_CHASE1] =	{SPR_SDCO,	A|FF_ANIMATE,	24,	nil,	2,	6,	S_SD2_COCONUTS_CHASE2}
states[S_SD2_COCONUTS_CHASE2] =	{SPR_SDCO,	B,				6,	nil,	0,	0,	S_SD2_COCONUTS_CHASE1}

states[S_SD2_COCONUTS_ATTACK1] =	{SPR_SDCO,	D,	8,	A_FaceTarget,		0,	0,	S_SD2_COCONUTS_ATTACK2}
states[S_SD2_COCONUTS_ATTACK2] =	{SPR_SDCO,	E,	8,	A_FaceTarget,		0,	0,	S_SD2_COCONUTS_ATTACK3}
states[S_SD2_COCONUTS_ATTACK3] =	{SPR_SDCO,	F,	6,	SD2_TroopAttack,	0,	0,	S_SD2_COCONUTS_CHASE1}

states[S_SD2_COCONUTS_PAIN1] =	{SPR_SDCO,	G,	2,	nil,	0,	0,	S_SD2_COCONUTS_PAIN2}
states[S_SD2_COCONUTS_PAIN2] =	{SPR_SDCO,	G,	2,	A_Pain,	0,	0,	S_SD2_COCONUTS_CHASE1}

states[S_SD2_COCONUTS_DIE1] =		{SPR_SDXP,	B,	8,	nil,		0,	0,	S_SD2_COCONUTS_DIE_SCREAM}
states[S_SD2_COCONUTS_DIE_SCREAM] =	{SPR_SDXP,	C,	8,	A_Scream,	0,	0,	S_SD2_COCONUTS_DIE2}
states[S_SD2_COCONUTS_DIE2] =		{SPR_SDXP,	D,	8,	nil,		0,	0,	S_SD2_COCONUTS_DIE_FALL}
states[S_SD2_COCONUTS_DIE_FALL] =	{SPR_SDXP,	E,	8,	SD2_Fall,	0,	0,	S_SD2_COCONUTS_DIE_STILL}
states[S_SD2_COCONUTS_DIE_STILL] =	{SPR_NULL,	A,	-1,	nil,		0,	0,	S_NULL}

states[S_SD2_COCONUTS_RAISE1] =	{SPR_NULL,	A,	8,	nil,	0,	0,	S_SD2_COCONUTS_RAISE2}
states[S_SD2_COCONUTS_RAISE2] =	{SPR_SDXP,	E,	8,	nil,	0,	0,	S_SD2_COCONUTS_RAISE3}
states[S_SD2_COCONUTS_RAISE2] =	{SPR_SDXP,	E,	8,	nil,	0,	0,	S_SD2_COCONUTS_RAISE3}
states[S_SD2_COCONUTS_RAISE2] =	{SPR_SDXP,	E,	8,	nil,	0,	0,	S_SD2_COCONUTS_RAISE3}
states[S_SD2_COCONUTS_RAISE2] =	{SPR_SDXP,	E,	8,	nil,	0,	0,	S_SD2_COCONUTS_CHASE1}

mobjinfo[MT_SD2_COCONUT] = {
	doomednum = -1,
	spawnstate = S_SD2_COCONUT_SPAWN,
	spawnhealth = 1000,
	seesound = sfx_sd2frs,
	deathstate = S_SD2_COCONUT_STOPSOUND,
	deathsound = sfx_sd2frx,
	speed = 10*FRACUNIT,
	radius = 6*FRACUNIT,
	height = 8*FRACUNIT,
	damage = 3,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SD2_COCONUT_SPAWN] =		{SPR_SDCO,	H|FF_FULLBRIGHT,			-1,		nil,			0,	0,	S_SD2_COCONUT_SPAWN}
states[S_SD2_COCONUT_STOPSOUND] =	{SPR_NULL,	A,							0,		SD2_StopSound,	0,	0,	S_SD2_COCONUT_DIE}
states[S_SD2_COCONUT_DIE] =			{SPR_SDCO,	I|FF_ANIMATE|FF_FULLBRIGHT,	18,		nil,			2,	6,	S_NULL}
