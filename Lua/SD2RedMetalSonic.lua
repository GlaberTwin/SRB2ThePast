// Sonic Doom 2 - Red Metal Sonic
// Ported by MIDIMan

freeslot(
	"sfx_sd2yse", // Borrowed from Freedoom
	"sfx_sd2ydi", // Borrowed from Freedoom
	"SPR_SDRM",
	"MT_SD2_ROCKET",
	// Make sure these three states are freeslotted beforehand
	// They are used by Red Metal Sonic's "rockets"
	//"S_SD2_BUZZBOMBER_BALL_SPAWN",
	//"S_SD2_BUZZBOMBER_BALL_STOPSOUND",
	//"S_SD2_BUZZBOMBER_BALL_DIE",
	"MT_SD2_REDMETALSONIC",
	"S_SD2_REDMETALSONIC_LOOK",
	"S_SD2_REDMETALSONIC_CHASE",
	"S_SD2_REDMETALSONIC_ATTACK1",
	"S_SD2_REDMETALSONIC_ATTACK2",
	"S_SD2_REDMETALSONIC_ATTACK3",
	"S_SD2_REDMETALSONIC_ATTACK4",
	"S_SD2_REDMETALSONIC_ATTACK5",
	"S_SD2_REDMETALSONIC_ATTACK6",
	"S_SD2_REDMETALSONIC_PAIN",
	"S_SD2_REDMETALSONIC_DIE1",
	"S_SD2_REDMETALSONIC_DIE_SCREAM",
	"S_SD2_REDMETALSONIC_DIE2",
	"S_SD2_REDMETALSONIC_DIE3",
	"S_SD2_REDMETALSONIC_DIE_FALL",
	"S_SD2_REDMETALSONIC_DIE4",
	"S_SD2_REDMETALSONIC_DIE_BOSSDEATH"
)

sfxinfo[sfx_sd2yse].caption = "Red Metal Sonic awakens"
sfxinfo[sfx_sd2ydi].caption = "Red Metal Sonic collapses"

local function SD2_CyberAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	SD2_SpawnMissile(actor, actor.target, MT_SD2_ROCKET)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_REDMETALSONIC)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_REDMETALSONIC)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_REDMETALSONIC)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_REDMETALSONIC_PAIN
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_REDMETALSONIC_CHASE then
		if mo.tics == 24 then
			S_StopSoundByID(mo, sfx_s3k9b)
			S_StartSound(mo, sfx_s3k90)
		end
		
		if mo.tics == 6 then
			S_StopSoundByID(mo, sfx_s3k90)
			S_StartSound(mo, sfx_s3k9b)
		end
		
		if mo.tics % 3 == 0 then
			SD2_Chase(mo, 0, 0)
		end
	end
end, MT_SD2_REDMETALSONIC)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_REDMETALSONIC)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_REDMETALSONIC)

// Don't let Red Metal Sonic fly away
addHook("BossDeath", function(mo)
	if not (mo and mo.valid) then return end
	return true
end, MT_SD2_REDMETALSONIC)

mobjinfo[MT_SD2_REDMETALSONIC] = {
	//$Name Red Metal Sonic (Cyberdemon)
	//$Sprite SDRMA1
	//$Category Sonic Doom 2
	doomednum = 177,
	spawnstate = S_SD2_REDMETALSONIC_LOOK,
	spawnhealth = 100,
	seestate = S_SD2_REDMETALSONIC_CHASE,
	seesound = sfx_sd2yse,
	reactiontime = 8,
	painstate = S_SD2_REDMETALSONIC_PAIN,
	painchance = 20,
	painsound = sfx_s3k8b,
	missilestate = S_SD2_REDMETALSONIC_ATTACK1,
	deathstate = S_SD2_REDMETALSONIC_DIE1,
	deathsound = sfx_sd2ydi,
	speed = 16,
	radius = 40*FRACUNIT,
	height = 110*FRACUNIT,
	mass = 1000,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_PUSHABLE
}

states[S_SD2_REDMETALSONIC_LOOK] =	{SPR_SDRM,	A,	10,	A_RadarLook,	0,	0,	S_SD2_REDMETALSONIC_LOOK}

states[S_SD2_REDMETALSONIC_CHASE] =	{SPR_SDRM,	A,	24,	nil,	0,	0,	S_SD2_REDMETALSONIC_CHASE}

states[S_SD2_REDMETALSONIC_ATTACK1] =	{SPR_SDRM,	B,	6,	A_FaceTarget,		0,	0,	S_SD2_REDMETALSONIC_ATTACK2}
states[S_SD2_REDMETALSONIC_ATTACK2] =	{SPR_SDRM,	B,	12,	SD2_CyberAttack,	0,	0,	S_SD2_REDMETALSONIC_ATTACK3}
states[S_SD2_REDMETALSONIC_ATTACK3] =	{SPR_SDRM,	B,	12,	A_FaceTarget,		0,	0,	S_SD2_REDMETALSONIC_ATTACK4}
states[S_SD2_REDMETALSONIC_ATTACK4] =	{SPR_SDRM,	B,	12,	SD2_CyberAttack,	0,	0,	S_SD2_REDMETALSONIC_ATTACK5}
states[S_SD2_REDMETALSONIC_ATTACK5] =	{SPR_SDRM,	B,	12,	A_FaceTarget,		0,	0,	S_SD2_REDMETALSONIC_ATTACK6}
states[S_SD2_REDMETALSONIC_ATTACK6] =	{SPR_SDRM,	B,	12,	SD2_CyberAttack,	0,	0,	S_SD2_REDMETALSONIC_CHASE}

states[S_SD2_REDMETALSONIC_PAIN] =	{SPR_SDRM,	C,	10,	A_Pain,	0,	0,	S_SD2_REDMETALSONIC_CHASE}

states[S_SD2_REDMETALSONIC_DIE1] =			{SPR_SDRM,	D,	10,	nil,			0,	0,	S_SD2_REDMETALSONIC_DIE_SCREAM}
states[S_SD2_REDMETALSONIC_DIE_SCREAM] =	{SPR_SDRM,	D,	10,	A_Scream,		0,	0,	S_SD2_REDMETALSONIC_DIE2}
states[S_SD2_REDMETALSONIC_DIE2] =			{SPR_SDRM,	D,	20,	nil,			0,	0,	S_SD2_REDMETALSONIC_DIE3}
states[S_SD2_REDMETALSONIC_DIE3] =			{SPR_SDRM,	E,	10,	nil,			0,	0,	S_SD2_REDMETALSONIC_DIE_FALL}
states[S_SD2_REDMETALSONIC_DIE_FALL] =		{SPR_SDRM,	E,	10,	SD2_Fall,		0,	0,	S_SD2_REDMETALSONIC_DIE4}
states[S_SD2_REDMETALSONIC_DIE4] =			{SPR_SDRM,	E,	50,	nil,			0,	0,	S_SD2_REDMETALSONIC_DIE_BOSSDEATH}
states[S_SD2_REDMETALSONIC_DIE_BOSSDEATH] =	{SPR_SDRM,	E,	-1,	A_BossDeath,	0,	0,	S_NULL}

mobjinfo[MT_SD2_ROCKET] = {
	doomednum = -1,
	spawnstate = S_SD2_BUZZBOMBER_BALL_SPAWN,
	spawnhealth = 1000,
	seesound = sfx_s3k40,
	deathstate = S_SD2_BUZZBOMBER_BALL_STOPSOUND,
	deathsound = sfx_dmpain,
	speed = 20*FRACUNIT,
	radius = 11*FRACUNIT,
	height = 8*FRACUNIT,
	mass = 100,
	damage = 20,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
