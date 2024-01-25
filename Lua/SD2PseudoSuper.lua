// Sonic Doom 2 - Pseudo-Super
// Ported by MIDIMan

freeslot(
	"sfx_sd2sse", // Borrowed from Freedoom
	"sfx_sd2sdi", // Borrowed from Freedoom
	"SPR_SDPS",
	"MT_SD2_PSEUDOSUPER_BALL",
	"S_SD2_PSEUDOSUPER_BALL_SPAWN",
	"S_SD2_PSEUDOSUPER_BALL_STOPSOUND",
	"S_SD2_PSEUDOSUPER_BALL_DIE",
	"MT_SD2_PSEUDOSUPER",
	"S_SD2_PSEUDOSUPER_LOOK",
	"S_SD2_PSEUDOSUPER_SEE",
	"S_SD2_PSEUDOSUPER_CHASE",
	"S_SD2_PSEUDOSUPER_ATTACK1",
	"S_SD2_PSEUDOSUPER_ATTACK2",
	"S_SD2_PSEUDOSUPER_ATTACK3",
	"S_SD2_PSEUDOSUPER_ATTACK4",
	"S_SD2_PSEUDOSUPER_PAIN1",
	"S_SD2_PSEUDOSUPER_PAIN2",
	"S_SD2_PSEUDOSUPER_DIE_SCREAM",
	"S_SD2_PSEUDOSUPER_DIE_FALL",
	"S_SD2_PSEUDOSUPER_DIE",
	"S_SD2_PSEUDOSUPER_DIE_BOSSDEATH",
	"S_SD2_PSEUDOSUPER_RAISE1",
	"S_SD2_PSEUDOSUPER_RAISE2",
	"S_SD2_PSEUDOSUPER_RAISE3",
	"S_SD2_PSEUDOSUPER_RAISE4",
	"S_SD2_PSEUDOSUPER_RAISE5",
	"S_SD2_PSEUDOSUPER_RAISE6",
	"S_SD2_PSEUDOSUPER_RAISE7"
)

sfxinfo[sfx_sd2sse].caption = "Charging up"
sfxinfo[sfx_sd2sdi].caption = "Powering down"

// Checks if Pseudo-Super can still see his target before firing again
local function SD2_SpidRefire(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	A_FaceTarget(actor)
	
	// Don't stop firing unless the RNG says so
	if P_RandomByte() < 10 then return end
	
	if not (actor.target and actor.target.valid 
	and actor.target.health > 0 and P_CheckSight(actor, actor.target)) then
		actor.state = actor.info.seestate
	end
end

local function SD2_BspiAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	SD2_SpawnMissile(actor, actor.target, MT_SD2_PSEUDOSUPER_BALL)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_PSEUDOSUPER)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_PSEUDOSUPER)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_PSEUDOSUPER)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_PSEUDOSUPER_PAIN1,
		S_SD2_PSEUDOSUPER_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_PSEUDOSUPER_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_PSEUDOSUPER_CHASE then
		if mo.tics % 3 == 0 then
			SD2_Chase(mo, 0, 0)
		end
		
		if mo.tics % 6 == 0 then
			S_StartSound(mo, sfx_s3k7c)
		end
	end
end, MT_SD2_PSEUDOSUPER)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_PSEUDOSUPER)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_PSEUDOSUPER)

// Don't let Pseudo-Super fly away
addHook("BossDeath", function(mo)
	if not (mo and mo.valid) then return end
	return true
end, MT_SD2_PSEUDOSUPER)

mobjinfo[MT_SD2_PSEUDOSUPER] = {
	//$Name Pseudo-Super
	//$Sprite SDPSA1D1
	//$Category Sonic Doom 2
	doomednum = 175,
	spawnstate = S_SD2_PSEUDOSUPER_LOOK,
	spawnhealth = 16,
	seestate = S_SD2_PSEUDOSUPER_SEE,
	seesound = sfx_sd2sse,
	reactiontime = 8,
	painstate = S_SD2_PSEUDOSUPER_PAIN1,
	painchance = 128,
	painsound = sfx_s3k8b,
	missilestate = S_SD2_PSEUDOSUPER_ATTACK1,
	deathstate = S_SD2_PSEUDOSUPER_DIE_SCREAM,
	deathsound = sfx_sd2sdi,
	speed = 12,
	radius = 64*FRACUNIT,
	height = 64*FRACUNIT,
	mass = 600,
	activesound = sfx_s3k79,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_PSEUDOSUPER_RAISE1
}

states[S_SD2_PSEUDOSUPER_LOOK] =	{SPR_SDPS,	A|FF_ANIMATE,	10,	nil,	1,	10,	S_SD2_PSEUDOSUPER_SEE}

states[S_SD2_PSEUDOSUPER_SEE] =		{SPR_SDPS,	A,				3,	nil,	0,	0,	S_SD2_PSEUDOSUPER_CHASE}
states[S_SD2_PSEUDOSUPER_CHASE] =	{SPR_SDPS,	A|FF_ANIMATE,	6,	nil,	5,	6,	S_SD2_PSEUDOSUPER_SEE}

states[S_SD2_PSEUDOSUPER_ATTACK1] =	{SPR_SDPS,	A|FF_FULLBRIGHT,	20,	A_FaceTarget,	0,	0,	S_SD2_PSEUDOSUPER_ATTACK2}
states[S_SD2_PSEUDOSUPER_ATTACK2] =	{SPR_SDPS,	G|FF_FULLBRIGHT,	4,	SD2_BspiAttack,	0,	0,	S_SD2_PSEUDOSUPER_ATTACK3}
states[S_SD2_PSEUDOSUPER_ATTACK3] =	{SPR_SDPS,	G|FF_FULLBRIGHT,	4,	nil,			0,	0,	S_SD2_PSEUDOSUPER_ATTACK4}
states[S_SD2_PSEUDOSUPER_ATTACK4] =	{SPR_SDPS,	G|FF_FULLBRIGHT,	1,	SD2_SpidRefire,	0,	0,	S_SD2_PSEUDOSUPER_ATTACK2}

states[S_SD2_PSEUDOSUPER_PAIN1] =	{SPR_SDPS,	H,	3,	nil,	0,	0,	S_SD2_PSEUDOSUPER_PAIN2}
states[S_SD2_PSEUDOSUPER_PAIN2] =	{SPR_SDPS,	H,	3,	A_Pain,	0,	0,	S_SD2_PSEUDOSUPER_SEE}

states[S_SD2_PSEUDOSUPER_DIE_SCREAM] =		{SPR_SDPS,	I,				20,	A_Scream,		0,	0,	S_SD2_PSEUDOSUPER_DIE_FALL}
states[S_SD2_PSEUDOSUPER_DIE_FALL] =		{SPR_SDPS,	J,				7,	SD2_Fall,		0,	0,	S_SD2_PSEUDOSUPER_DIE}
states[S_SD2_PSEUDOSUPER_DIE] =				{SPR_SDPS,	K|FF_ANIMATE,	28,	nil,			3,	7,	S_SD2_PSEUDOSUPER_DIE_BOSSDEATH}
states[S_SD2_PSEUDOSUPER_DIE_BOSSDEATH] =	{SPR_SDPS,	O,				-1,	A_BossDeath,	0,	0,	S_NULL}

states[S_SD2_PSEUDOSUPER_RAISE1] =		{SPR_SDPS,	O,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_RAISE2}
states[S_SD2_PSEUDOSUPER_RAISE2] =		{SPR_SDPS,	N,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_RAISE3}
states[S_SD2_PSEUDOSUPER_RAISE3] =		{SPR_SDPS,	M,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_RAISE4}
states[S_SD2_PSEUDOSUPER_RAISE4] =		{SPR_SDPS,	L,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_RAISE5}
states[S_SD2_PSEUDOSUPER_RAISE5] =		{SPR_SDPS,	K,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_RAISE6}
states[S_SD2_PSEUDOSUPER_RAISE6] =		{SPR_SDPS,	J,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_RAISE7}
states[S_SD2_PSEUDOSUPER_RAISE7] =		{SPR_SDPS,	I,	5,	nil,	0,	0,	S_SD2_PSEUDOSUPER_CHASE}

addHook("MobjSpawn", function(mo)
	if not (mo and mo.valid) then return end
	
	mo.blendmode = AST_ADD
end, MT_SD2_PSEUDOSUPER_BALL)

mobjinfo[MT_SD2_PSEUDOSUPER_BALL] = {
	doomednum = -1,
	spawnstate = S_SD2_PSEUDOSUPER_BALL_SPAWN,
	spawnhealth = 1000,
	seesound = sfx_rlaunc,
	deathstate = S_SD2_PSEUDOSUPER_BALL_STOPSOUND,
	deathsound = sfx_sd2frx,
	speed = 25*FRACUNIT,
	radius = 13*FRACUNIT,
	height = 8*FRACUNIT,
	mass = 100,
	damage = 5,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SD2_PSEUDOSUPER_BALL_SPAWN] =		{SPR_SDPS,	S|FF_ANIMATE|FF_FULLBRIGHT,	-1,	nil,			1,			6,	S_SD2_PSEUDOSUPER_BALL_SPAWN}
states[S_SD2_PSEUDOSUPER_BALL_STOPSOUND] =	{SPR_NULL,	A,							0,	SD2_StopSound,	sfx_rlaunc,	0,	S_SD2_PSEUDOSUPER_BALL_DIE}
states[S_SD2_PSEUDOSUPER_BALL_DIE] =		{SPR_SDPS,	P|FF_ANIMATE|FF_FULLBRIGHT,	20,	nil,			4,			4,	S_NULL}
