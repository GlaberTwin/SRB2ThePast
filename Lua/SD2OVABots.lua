// Sonic Doom 2 - OVA Bot Variants
// Ported by MIDIMan

freeslot(
	"sfx_sd2otk",
	"sfx_sd2odi",
	"SPR_SDOV",
	"MT_SD2_OVASHORT",
	"MT_SD2_OVASHORT_SHADOW",
	"S_SD2_OVASHORT_LOOK",
	"S_SD2_OVASHORT_CHASE1",
	"S_SD2_OVASHORT_CHASE2",
	"S_SD2_OVASHORT_MELEE1",
	"S_SD2_OVASHORT_MELEE2",
	"S_SD2_OVASHORT_MELEE3",
	"S_SD2_OVASHORT_PAIN1",
	"S_SD2_OVASHORT_PAIN2",
	"S_SD2_OVASHORT_DIE",
	"S_SD2_OVASHORT_DIE_SCREAM",
	"S_SD2_OVASHORT_DIE2",
	"S_SD2_OVASHORT_DIE_FALL",
	"S_SD2_OVASHORT_DIE_STILL",
	"S_SD2_OVASHORT_RAISE1",
	"S_SD2_OVASHORT_RAISE2",
	"MT_SD2_OVASHOT",
	"S_SD2_OVASHOT",
	"S_SD2_OVASHOT_STOPSOUND",
	"S_SD2_OVASHOT_DIE",
	"MT_SD2_OVARED",
	"S_SD2_OVARED_LOOK",
	"S_SD2_OVARED_CHASE1",
	"S_SD2_OVARED_CHASE2",
	"S_SD2_OVARED_ATTACK1",
	"S_SD2_OVARED_ATTACK2",
	"S_SD2_OVARED_ATTACK3",
	"S_SD2_OVARED_PAIN1",
	"S_SD2_OVARED_PAIN2",
	"S_SD2_OVARED_DIE",
	"S_SD2_OVARED_DIE_SCREAM",
	"S_SD2_OVARED_DIE2",
	"S_SD2_OVARED_DIE_FALL",
	"S_SD2_OVARED_DIE3",
	"S_SD2_OVARED_DIE_BOSSDEATH",
	"S_SD2_OVARED_RAISE1",
	"S_SD2_OVARED_RAISE2",
	"S_SD2_OVARED_RAISE3",
	"S_SD2_OVARED_RAISE4",
	"S_SD2_OVARED_RAISE5",
	"S_SD2_OVARED_RAISE6",
	"S_SD2_OVARED_RAISE7",
	"MT_SD2_OVAGRAY",
	"S_SD2_OVAGRAY_LOOK",
	"S_SD2_OVAGRAY_CHASE",
	"S_SD2_OVAGRAY_ATTACK1",
	"S_SD2_OVAGRAY_ATTACK2",
	"S_SD2_OVAGRAY_ATTACK3",
	"S_SD2_OVAGRAY_PAIN1",
	"S_SD2_OVAGRAY_PAIN2",
	"S_SD2_OVAGRAY_DIE",
	"S_SD2_OVAGRAY_DIE_SCREAM",
	"S_SD2_OVAGRAY_DIE2",
	"S_SD2_OVAGRAY_DIE_FALL",
	"S_SD2_OVAGRAY_DIE3",
	"S_SD2_OVAGRAY_DIE_STILL",
	"S_SD2_OVAGRAY_RAISE1",
	"S_SD2_OVAGRAY_RAISE2",
	"S_SD2_OVAGRAY_RAISE3",
	"S_SD2_OVAGRAY_RAISE4",
	"S_SD2_OVAGRAY_RAISE5",
	"S_SD2_OVAGRAY_RAISE6",
	"S_SD2_OVAGRAY_RAISE7"
)

sfxinfo[sfx_sd2otk].caption = "*Boop*"
sfxinfo[sfx_sd2odi].caption = "Collapse"

// --------------------------------
// MINI-BOT
// --------------------------------

local function SD2_SargThinker(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_OVASHORT_PAIN1,
		S_SD2_OVASHORT_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	// Optimize freeslot usage by embedding this into the MobjThinker
	if mo.state == S_SD2_OVASHORT_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo, 0, 0)
	end
	
	if mo.tics % 2 == 0
	and (mo.state == S_SD2_OVASHORT_CHASE1
	or mo.state == S_SD2_OVASHORT_CHASE2) then
		SD2_Chase(mo, 0, 0)
	end
end

local function SD2_SargAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	if P_CheckMeleeRange(actor) then // Smack the target if they're within range
		//local damage = ((P_RandomByte()%10)+1)*4
		P_DamageMobj(actor.target, actor, actor, 1)
	end
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_OVASHORT)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_OVASHORT)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_OVASHORT)
addHook("MobjThinker", SD2_SargThinker, MT_SD2_OVASHORT)
addHook("MobjDamage", SD2_MobjDamage, MT_SD2_OVASHORT)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_OVASHORT)

mobjinfo[MT_SD2_OVASHORT] = {
	//$Name OVA Bot (Short)
	//$Sprite SDOVA1
	//$Category Sonic Doom 2
	doomednum = 167,
	spawnstate = S_SD2_OVASHORT_LOOK,
	spawnhealth = 5,
	seestate = S_SD2_OVASHORT_CHASE1,
	seesound = sfx_s3k9d,
	reactiontime = 8,
	attacksound = sfx_sd2otk,
	painstate = S_SD2_OVASHORT_PAIN1,
	painchance = 180,
	painsound = sfx_s3k8b,
	meleestate = S_SD2_OVASHORT_MELEE1,
	deathstate = S_SD2_OVASHORT_DIE,
	deathsound = sfx_sd2odi,
	speed = 10,
	radius = 30*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 400,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_OVASHORT_RAISE1
}

states[S_SD2_OVASHORT_LOOK] =	{SPR_SDOV,	A|FF_ANIMATE,	20,	nil,		1,	10,	S_SD2_OVASHORT_LOOK}

states[S_SD2_OVASHORT_CHASE1] =	{SPR_SDOV,	A|FF_ANIMATE,	12,	nil,	2,	4,	S_SD2_OVASHORT_CHASE2}
states[S_SD2_OVASHORT_CHASE2] =	{SPR_SDOV,	B,				4,	nil,	0,	0,	S_SD2_OVASHORT_CHASE1}

states[S_SD2_OVASHORT_MELEE1] =	{SPR_SDOV,	D,	8,	A_FaceTarget,	0,	0,	S_SD2_OVASHORT_MELEE2}
states[S_SD2_OVASHORT_MELEE2] =	{SPR_SDOV,	E,	8,	A_FaceTarget,	0,	0,	S_SD2_OVASHORT_MELEE3}
states[S_SD2_OVASHORT_MELEE3] =	{SPR_SDOV,	F,	8,	SD2_SargAttack,	0,	0,	S_SD2_OVASHORT_CHASE1}

states[S_SD2_OVASHORT_PAIN1] =	{SPR_SDOV,	G,	2,	nil,	0,	0,	S_SD2_OVASHORT_PAIN2}
states[S_SD2_OVASHORT_PAIN2] =	{SPR_SDOV,	G,	2,	A_Pain,	0,	0,	S_SD2_OVASHORT_CHASE1}

states[S_SD2_OVASHORT_DIE] =		{SPR_SDOV,	H,	8,	nil,		0,	0,	S_SD2_OVASHORT_DIE_SCREAM}
states[S_SD2_OVASHORT_DIE_SCREAM] =	{SPR_SDOV,	H,	8,	A_Scream,	0,	0,	S_SD2_OVASHORT_DIE2}
states[S_SD2_OVASHORT_DIE2] =		{SPR_SDOV,	I,	4,	nil,		0,	0,	S_SD2_OVASHORT_DIE_FALL}
states[S_SD2_OVASHORT_DIE_FALL] =	{SPR_SDOV,	I,	4,	SD2_Fall,	0,	0,	S_SD2_OVASHORT_DIE_STILL}
states[S_SD2_OVASHORT_DIE_STILL] =	{SPR_SDOV,	I,	-1,	nil,		0,	0,	S_NULL}

states[S_SD2_OVASHORT_RAISE1] =		{SPR_SDOV,	I,	20,	nil,	0,	0,	S_SD2_OVASHORT_RAISE2}
states[S_SD2_OVASHORT_RAISE2] =		{SPR_SDOV,	H,	10,	nil,	0,	0,	S_SD2_OVASHORT_CHASE1}

// --------------------------------
// SHADOW MINI-BOT
// --------------------------------

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_OVASHORT_SHADOW)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_OVASHORT_SHADOW)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_OVASHORT_SHADOW)

addHook("MobjSpawn", function(mo)
	if not (mo and mo.valid) then return end
	
	mo.blendmode = AST_MODULATE
end, MT_SD2_OVASHORT_SHADOW)

addHook("MobjThinker", SD2_SargThinker, MT_SD2_OVASHORT_SHADOW)
addHook("MobjDamage", SD2_MobjDamage, MT_SD2_OVASHORT_SHADOW)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_OVASHORT_SHADOW)

mobjinfo[MT_SD2_OVASHORT_SHADOW] = {
	//$Name OVA Bot Shadow (Short)
	//$Sprite SDOVA1
	//$Category Sonic Doom 2
	doomednum = 168,
	spawnstate = S_SD2_OVASHORT_LOOK,
	spawnhealth = 5,
	seestate = S_SD2_OVASHORT_CHASE1,
	seesound = sfx_s3k9d,
	reactiontime = 8,
	attacksound = sfx_sd2otk,
	painstate = S_SD2_OVASHORT_PAIN1,
	painchance = 180,
	painsound = sfx_s3k8b,
	meleestate = S_SD2_OVASHORT_MELEE1,
	deathstate = S_SD2_OVASHORT_DIE,
	deathsound = sfx_sd2odi,
	speed = 10,
	radius = 30*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 400,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_PUSHABLE,
	raisestate = S_SD2_OVASHORT_RAISE1
}

// --------------------------------
// OVABOT SPIKEBALL
// --------------------------------

mobjinfo[MT_SD2_OVASHOT] = {
	doomednum = -1,
	spawnstate = S_SD2_OVASHOT,
	spawnhealth = 1000,
	seesound = sfx_sd2frs,
	reactiontime = 8,
	deathstate = S_SD2_OVASHOT_STOPSOUND,
	deathsound = sfx_sd2frx,
	speed = 15*FRACUNIT,
	radius = 6*FRACUNIT,
	height = 8*FRACUNIT,
	mass = 100,
	damage = 8,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SD2_OVASHOT] =				{SPR_SDOV,	U|FF_FULLBRIGHT,			-1,	nil,			0,	0,	S_SD2_OVASHOT}
states[S_SD2_OVASHOT_STOPSOUND] =	{SPR_NULL,	A,							0,	SD2_StopSound,	0,	0,	S_SD2_OVASHOT_DIE}
states[S_SD2_OVASHOT_DIE] =			{SPR_SDOV,	V|FF_ANIMATE|FF_FULLBRIGHT,	18,	nil,			2,	6,	S_NULL}

// --------------------------------
// RED OVABOT
// --------------------------------

local function SD2_BruisAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	if P_CheckMeleeRange(actor) then // Smack the target if they're within range
		S_StartSound(actor, sfx_sd2clw)
		//local damage = (P_RandomByte()%8+1)*10
		P_DamageMobj(actor.target, actor, actor, 1)
		return
	end
	
	SD2_SpawnMissile(actor, actor.target, MT_SD2_OVASHOT)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_OVARED)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_OVARED)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_OVARED)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_OVARED_PAIN1,
		S_SD2_OVARED_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_OVARED_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo, 0, 0)
	end
	
	if (mo.state == S_SD2_OVARED_CHASE1
	or mo.state == S_SD2_OVARED_CHASE2)
	and mo.tics % 3 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_OVARED)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_OVARED)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_OVARED)

addHook("BossDeath", function(mo)
	if not (mo and mo.valid) then return end
	return true
end, MT_SD2_OVARED)

mobjinfo[MT_SD2_OVARED] = {
	//$Name OVA Bot (Red)
	//$Sprite SDOVJ1
	//$Category Sonic Doom 2
	doomednum = 170,
	spawnstate = S_SD2_OVARED_LOOK,
	spawnhealth = 28,
	seestate = S_SD2_OVARED_CHASE1,
	seesound = sfx_s3k84,
	reactiontime = 8,
	painstate = S_SD2_OVARED_PAIN1,
	painchance = 50,
	painsound = sfx_s3k8b,
	meleestate = S_SD2_OVARED_ATTACK1,
	missilestate = S_SD2_OVARED_ATTACK1,
	deathstate = S_SD2_OVARED_DIE,
	deathsound = sfx_sd2odi,
	speed = 8,
	radius = 24*FRACUNIT,
	height = 64*FRACUNIT,
	mass = 1000,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_PUSHABLE,
	raisestate = S_SD2_OVARED_RAISE1
}

states[S_SD2_OVARED_LOOK] =	{SPR_SDOV,	J|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_OVARED_LOOK}

states[S_SD2_OVARED_CHASE1] =	{SPR_SDOV,	J|FF_ANIMATE,	18,	nil,	2,	6,	S_SD2_OVARED_CHASE2}
states[S_SD2_OVARED_CHASE2] =	{SPR_SDOV,	K,				6,	nil,	0,	0,	S_SD2_OVARED_CHASE1}

states[S_SD2_OVARED_ATTACK1] =	{SPR_SDOV,	M,	8,	A_FaceTarget,	0,	0,	S_SD2_OVARED_ATTACK2}
states[S_SD2_OVARED_ATTACK2] =	{SPR_SDOV,	N,	8,	A_FaceTarget,	0,	0,	S_SD2_OVARED_ATTACK3}
states[S_SD2_OVARED_ATTACK3] =	{SPR_SDOV,	N,	8,	SD2_BruisAttack,	0,	0,	S_SD2_OVARED_CHASE1}

states[S_SD2_OVARED_PAIN1] =	{SPR_SDOV,	J,	2,	nil,	0,	0,	S_SD2_OVARED_PAIN2}
states[S_SD2_OVARED_PAIN2] =	{SPR_SDOV,	J,	2,	A_Pain,	0,	0,	S_SD2_OVARED_CHASE1}

states[S_SD2_OVARED_DIE] =				{SPR_SDOV,	Y,				8,	nil,			0,	0,	S_SD2_OVARED_DIE_SCREAM}
states[S_SD2_OVARED_DIE_SCREAM] =		{SPR_SDOV,	Z,				8,	A_Scream,		0,	0,	S_SD2_OVARED_DIE2}
states[S_SD2_OVARED_DIE2] =				{SPR_SDOV,	26,				8,	nil,			0,	0,	S_SD2_OVARED_DIE_FALL}
states[S_SD2_OVARED_DIE_FALL] =			{SPR_SDOV,	27,				8,	SD2_Fall,		0,	0,	S_SD2_OVARED_DIE3}
states[S_SD2_OVARED_DIE3] =				{SPR_SDOV,	28|FF_ANIMATE,	16,	nil,			1,	8,	S_SD2_OVARED_DIE_BOSSDEATH}
states[S_SD2_OVARED_DIE_BOSSDEATH] =	{SPR_NULL,	A,				-1,	A_BossDeath,	0,	0,	S_NULL}

states[S_SD2_OVARED_RAISE1] = {SPR_NULL,	A,	8,	nil,	0,	0,	S_SD2_OVARED_RAISE2}
states[S_SD2_OVARED_RAISE2] = {SPR_SDOV,	29,	8,	nil,	0,	0,	S_SD2_OVARED_RAISE3}
states[S_SD2_OVARED_RAISE3] = {SPR_SDOV,	28,	8,	nil,	0,	0,	S_SD2_OVARED_RAISE4}
states[S_SD2_OVARED_RAISE4] = {SPR_SDOV,	27,	8,	nil,	0,	0,	S_SD2_OVARED_RAISE5}
states[S_SD2_OVARED_RAISE5] = {SPR_SDOV,	26,	8,	nil,	0,	0,	S_SD2_OVARED_RAISE6}
states[S_SD2_OVARED_RAISE6] = {SPR_SDOV,	Z,	8,	nil,	0,	0,	S_SD2_OVARED_RAISE7}
states[S_SD2_OVARED_RAISE7] = {SPR_SDOV,	Y,	8,	nil,	0,	0,	S_SD2_OVARED_CHASE1}

// --------------------------------
// GRAY OVABOT
// --------------------------------

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_OVAGRAY)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_OVAGRAY)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_OVAGRAY)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_OVAGRAY_PAIN1,
		S_SD2_OVAGRAY_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_OVAGRAY_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo, 0, 0)
	end
	
	if mo.tics % 3 == 0
	and mo.state == S_SD2_OVAGRAY_CHASE then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_OVAGRAY)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_OVAGRAY)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_OVAGRAY)

mobjinfo[MT_SD2_OVAGRAY] = {
	//$Name OVA Bot (Gray)
	//$Sprite SDOVO1Q1
	//$Category Sonic Doom 2
	doomednum = 171,
	spawnstate = S_SD2_OVAGRAY_LOOK,
	spawnhealth = 16,
	seestate = S_SD2_OVAGRAY_CHASE,
	seesound = sfx_s3k8e,
	reactiontime = 8,
	painstate = S_SD2_OVAGRAY_PAIN1,
	painchance = 50,
	painsound = sfx_s3k8b,
	meleestate = S_SD2_OVAGRAY_ATTACK1,
	missilestate = S_SD2_OVAGRAY_ATTACK1,
	deathstate = S_SD2_OVAGRAY_DIE,
	deathsound = sfx_sd2odi,
	speed = 8,
	radius = 24*FRACUNIT,
	height = 64*FRACUNIT,
	mass = 1000,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_OVAGRAY_RAISE1
}

states[S_SD2_OVAGRAY_LOOK] =	{SPR_SDOV,	O|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_OVAGRAY_LOOK}

states[S_SD2_OVAGRAY_CHASE] =	{SPR_SDOV,	O|FF_ANIMATE,	24,	nil,	3,	6,	S_SD2_OVAGRAY_CHASE}

states[S_SD2_OVAGRAY_ATTACK1] =	{SPR_SDOV,	S,	8,	A_FaceTarget,		0,	0,	S_SD2_OVAGRAY_ATTACK2}
states[S_SD2_OVAGRAY_ATTACK2] =	{SPR_SDOV,	T,	8,	A_FaceTarget,		0,	0,	S_SD2_OVAGRAY_ATTACK3}
states[S_SD2_OVAGRAY_ATTACK3] =	{SPR_SDOV,	T,	8,	SD2_BruisAttack,	0,	0,	S_SD2_OVAGRAY_CHASE}

states[S_SD2_OVAGRAY_PAIN1] =	{SPR_SDOV,	O,	2,	nil,	0,	0,	S_SD2_OVAGRAY_PAIN2}
states[S_SD2_OVAGRAY_PAIN2] =	{SPR_SDOV,	O,	2,	A_Pain,	0,	0,	S_SD2_OVAGRAY_CHASE}

states[S_SD2_OVAGRAY_DIE] =			{SPR_SDOV,	Y,				8,	nil,		0,	0,	S_SD2_OVAGRAY_DIE_SCREAM}
states[S_SD2_OVAGRAY_DIE_SCREAM] =	{SPR_SDOV,	Z,				8,	A_Scream,	0,	0,	S_SD2_OVAGRAY_DIE2}
states[S_SD2_OVAGRAY_DIE2] =		{SPR_SDOV,	26,				8,	nil,		0,	0,	S_SD2_OVAGRAY_DIE_FALL}
states[S_SD2_OVAGRAY_DIE_FALL] =	{SPR_SDOV,	27,				8,	SD2_Fall,	0,	0,	S_SD2_OVAGRAY_DIE3}
states[S_SD2_OVAGRAY_DIE3] =		{SPR_SDOV,	28|FF_ANIMATE,	16,	nil,		1,	8,	S_SD2_OVAGRAY_DIE_STILL}
states[S_SD2_OVAGRAY_DIE_STILL] =	{SPR_NULL,	A,				-1,	nil,		0,	0,	S_NULL}

states[S_SD2_OVAGRAY_RAISE1] = {SPR_NULL,	A,	8,	nil,	0,	0,	S_SD2_OVAGRAY_RAISE2}
states[S_SD2_OVAGRAY_RAISE2] = {SPR_SDOV,	29,	8,	nil,	0,	0,	S_SD2_OVAGRAY_RAISE3}
states[S_SD2_OVAGRAY_RAISE3] = {SPR_SDOV,	28,	8,	nil,	0,	0,	S_SD2_OVAGRAY_RAISE4}
states[S_SD2_OVAGRAY_RAISE4] = {SPR_SDOV,	27,	8,	nil,	0,	0,	S_SD2_OVAGRAY_RAISE5}
states[S_SD2_OVAGRAY_RAISE5] = {SPR_SDOV,	26,	8,	nil,	0,	0,	S_SD2_OVAGRAY_RAISE6}
states[S_SD2_OVAGRAY_RAISE6] = {SPR_SDOV,	Z,	8,	nil,	0,	0,	S_SD2_OVAGRAY_RAISE7}
states[S_SD2_OVAGRAY_RAISE7] = {SPR_SDOV,	Y,	8,	nil,	0,	0,	S_SD2_OVAGRAY_CHASE}
