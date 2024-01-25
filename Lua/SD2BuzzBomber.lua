// Sonic Doom 2 - Buzz Bomber
// Ported by MIDIMan

freeslot(
	"sfx_sd2bse",
	"SPR_SDBZ",
	"MT_SD2_BUZZBOMBER_BALL",
	"S_SD2_BUZZBOMBER_BALL_SPAWN",
	"S_SD2_BUZZBOMBER_BALL_STOPSOUND",
	"S_SD2_BUZZBOMBER_BALL_DIE",
	"MT_SD2_BUZZBOMBER",
	"S_SD2_BUZZBOMBER_LOOK",
	"S_SD2_BUZZBOMBER_CHASE",
	"S_SD2_BUZZBOMBER_ATTACK1",
	"S_SD2_BUZZBOMBER_ATTACK2",
	"S_SD2_BUZZBOMBER_ATTACK3",
	"S_SD2_BUZZBOMBER_PAIN1",
	"S_SD2_BUZZBOMBER_PAIN2",
	"S_SD2_BUZZBOMBER_PAIN3",
	"S_SD2_BUZZBOMBER_DIE1",
	"S_SD2_BUZZBOMBER_DIE_SCREAM",
	"S_SD2_BUZZBOMBER_DIE2",
	"S_SD2_BUZZBOMBER_DIE_FALL",
	"S_SD2_BUZZBOMBER_DIE_STILL",
	"S_SD2_BUZZBOMBER_RAISE1",
	"S_SD2_BUZZBOMBER_RAISE2",
	"S_SD2_BUZZBOMBER_RAISE3",
	"S_SD2_BUZZBOMBER_RAISE4",
	"S_SD2_BUZZBOMBER_RAISE5",
	"S_SD2_BUZZBOMBER_RAISE6"
)

sfxinfo[sfx_sd2bse].caption = "Buzz Bomber awakens"

local function SD2_HeadAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	if P_CheckMeleeRange(actor) then // Hurt the target if they're within range
		//local damage = (P_RandomByte()%6+1)*10
		P_DamageMobj(actor.target, actor, actor, 1)
		return
	end
	SD2_SpawnMissile(actor, actor.target, MT_SD2_BUZZBOMBER_BALL)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_BUZZBOMBER)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_BUZZBOMBER)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_BUZZBOMBER)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_BUZZBOMBER_PAIN1,
		S_SD2_BUZZBOMBER_PAIN2,
		S_SD2_BUZZBOMBER_PAIN3
	})
	
	SD2_ResetSpecialFlag(mo)
end, MT_SD2_BUZZBOMBER)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_BUZZBOMBER)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_BUZZBOMBER)

mobjinfo[MT_SD2_BUZZBOMBER] = {
	//$Name Buzz Bomber
	//$Sprite SDBZA1
	//$Category Sonic Doom 2
	doomednum = 172,
	spawnstate = S_SD2_BUZZBOMBER_LOOK,
	spawnhealth = 12,
	seestate = S_SD2_BUZZBOMBER_CHASE,
	seesound = sfx_sd2bse,
	reactiontime = 8,
	painstate = S_SD2_BUZZBOMBER_PAIN1,
	painchance = 128,
	painsound = sfx_s3k8b,
	missilestate = S_SD2_BUZZBOMBER_ATTACK1,
	deathstate = S_SD2_BUZZBOMBER_DIE1,
	deathsound = sfx_pop,
	speed = 8,
	radius = 31*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 400,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_FLOAT|MF_NOGRAVITY|MF_PUSHABLE,
	raisestate = S_SD2_BUZZBOMBER_RAISE1
}

states[S_SD2_BUZZBOMBER_LOOK] =	{SPR_SDBZ,	A,	10,	A_RadarLook,	0,	0,	S_SD2_BUZZBOMBER_LOOK}

states[S_SD2_BUZZBOMBER_CHASE] =	{SPR_SDBZ,	A,	3,	SD2_Chase,	0,	0,	S_SD2_BUZZBOMBER_CHASE}

states[S_SD2_BUZZBOMBER_ATTACK1] =	{SPR_SDBZ,	B,					5,	A_FaceTarget,	0,	0,	S_SD2_BUZZBOMBER_ATTACK2}
states[S_SD2_BUZZBOMBER_ATTACK2] =	{SPR_SDBZ,	C,					5,	A_FaceTarget,	0,	0,	S_SD2_BUZZBOMBER_ATTACK3}
states[S_SD2_BUZZBOMBER_ATTACK3] =	{SPR_SDBZ,	B|FF_FULLBRIGHT,	5,	SD2_HeadAttack,	0,	0,	S_SD2_BUZZBOMBER_CHASE}

states[S_SD2_BUZZBOMBER_PAIN1] =	{SPR_SDBZ,	D,	3,	nil,	0,	0,	S_SD2_BUZZBOMBER_PAIN2}
states[S_SD2_BUZZBOMBER_PAIN2] =	{SPR_SDBZ,	D,	3,	A_Pain,	0,	0,	S_SD2_BUZZBOMBER_PAIN3}
states[S_SD2_BUZZBOMBER_PAIN3] =	{SPR_SDBZ,	E,	6,	nil,	0,	0,	S_SD2_BUZZBOMBER_CHASE}

states[S_SD2_BUZZBOMBER_DIE1] =			{SPR_SDBZ,	F,				8,	nil,		0,	0,	S_SD2_BUZZBOMBER_DIE_SCREAM}
states[S_SD2_BUZZBOMBER_DIE_SCREAM] =	{SPR_SDBZ,	G,				8,	A_Scream,	0,	0,	S_SD2_BUZZBOMBER_DIE2}
states[S_SD2_BUZZBOMBER_DIE2] =			{SPR_SDBZ,	H|FF_ANIMATE,	16,	nil,		1,	8,	S_SD2_BUZZBOMBER_DIE_FALL}
states[S_SD2_BUZZBOMBER_DIE_FALL] =		{SPR_SDBZ,	J,				8,	SD2_Fall,	0,	0,	S_SD2_BUZZBOMBER_DIE_STILL}
states[S_SD2_BUZZBOMBER_DIE_STILL] =	{SPR_NULL,	A,				-1,	nil,		0,	0,	S_NULL}

states[S_SD2_BUZZBOMBER_RAISE1] =	{SPR_NULL,	A,	8,	nil,	0,	0,	S_SD2_BUZZBOMBER_RAISE2}
states[S_SD2_BUZZBOMBER_RAISE2] =	{SPR_SDBZ,	J,	8,	nil,	0,	0,	S_SD2_BUZZBOMBER_RAISE3}
states[S_SD2_BUZZBOMBER_RAISE3] =	{SPR_SDBZ,	I,	8,	nil,	0,	0,	S_SD2_BUZZBOMBER_RAISE4}
states[S_SD2_BUZZBOMBER_RAISE4] =	{SPR_SDBZ,	H,	8,	nil,	0,	0,	S_SD2_BUZZBOMBER_RAISE5}
states[S_SD2_BUZZBOMBER_RAISE5] =	{SPR_SDBZ,	G,	8,	nil,	0,	0,	S_SD2_BUZZBOMBER_RAISE6}
states[S_SD2_BUZZBOMBER_RAISE6] =	{SPR_SDBZ,	F,	8,	nil,	0,	0,	S_NULL}

mobjinfo[MT_SD2_BUZZBOMBER_BALL] =	{
	doomednum = -1,
	spawnstate = S_SD2_BUZZBOMBER_BALL_SPAWN,
	spawnhealth = 1000,
	seesound = sfx_sd2frs,
	deathstate = S_SD2_BUZZBOMBER_BALL_STOPSOUND,
	deathsound = sfx_sd2frx,
	speed = 10*FRACUNIT,
	radius = 6*FRACUNIT,
	height = 8*FRACUNIT,
	mass = 100,
	damage = 5,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SD2_BUZZBOMBER_BALL_SPAWN] =		{SPR_SDBZ,	K|FF_ANIMATE|FF_FULLBRIGHT,	-1,	nil,			1,			4,	S_SD2_BUZZBOMBER_BALL_SPAWN}
states[S_SD2_BUZZBOMBER_BALL_STOPSOUND] =	{SPR_NULL,	A,							0,	SD2_StopSound,	sfx_s3k40,	0,	S_SD2_BUZZBOMBER_BALL_DIE}
states[S_SD2_BUZZBOMBER_BALL_DIE] =			{SPR_SDBZ,	M|FF_ANIMATE|FF_FULLBRIGHT,	18,	nil,			2,			8,	S_NULL}
