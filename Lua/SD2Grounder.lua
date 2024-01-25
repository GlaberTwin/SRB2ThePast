// Sonic Doom 2 - Grounder Variants
// Ported by MIDIMan

freeslot(
	"sfx_sd2gse",
	"sfx_sd2gac",
	// The following sound already has a counterpart in SRB2 as sfx_s3kd7s, 
	// but this version has more of a punch to it
	"sfx_sd2ptl",
	"SPR_SDGR",
	"MT_SD2_GROUNDER_PISTOL",
	"S_SD2_GROUNDER_PISTOL_LOOK",
	"S_SD2_GROUNDER_PISTOL_CHASE",
	"S_SD2_GROUNDER_PISTOL_SHOOT1",
	"S_SD2_GROUNDER_PISTOL_SHOOT2",
	"S_SD2_GROUNDER_PISTOL_SHOOT3",
	"S_SD2_GROUNDER_PISTOL_PAIN1",
	"S_SD2_GROUNDER_PISTOL_PAIN2",
	"S_SD2_GROUNDER_PISTOL_DIE1",
	"S_SD2_GROUNDER_PISTOL_DIE_SCREAM",
	"S_SD2_GROUNDER_PISTOL_DIE_FALL",
	"S_SD2_GROUNDER_PISTOL_DIE2",
	"S_SD2_GROUNDER_PISTOL_DIE_STILL",
	// No xdeath states, because they're nearly indistinguishable from the regular death states during normal gameplay anyway
	"S_SD2_GROUNDER_PISTOL_RAISE1",
	"S_SD2_GROUNDER_PISTOL_RAISE2",
	"S_SD2_GROUNDER_PISTOL_RAISE3",
	"S_SD2_GROUNDER_PISTOL_RAISE4",
	"sfx_sd2shg",
	"MT_SD2_GROUNDER_SHOTGUN",
	"S_SD2_GROUNDER_SHOTGUN_LOOK",
	"S_SD2_GROUNDER_SHOTGUN_CHASE",
	"S_SD2_GROUNDER_SHOTGUN_SHOOT1",
	"S_SD2_GROUNDER_SHOTGUN_SHOOT2",
	"S_SD2_GROUNDER_SHOTGUN_SHOOT3",
	"S_SD2_GROUNDER_SHOTGUN_PAIN1",
	"S_SD2_GROUNDER_SHOTGUN_PAIN2",
	"S_SD2_GROUNDER_SHOTGUN_RAISE1",
	"S_SD2_GROUNDER_SHOTGUN_RAISE2",
	"S_SD2_GROUNDER_SHOTGUN_RAISE3",
	"S_SD2_GROUNDER_SHOTGUN_RAISE4",
	"S_SD2_GROUNDER_SHOTGUN_RAISE5",
	"MT_SD2_GROUNDER_CHAINGUN",
	"S_SD2_GROUNDER_CHAINGUN_LOOK",
	"S_SD2_GROUNDER_CHAINGUN_CHASE",
	"S_SD2_GROUNDER_CHAINGUN_SHOOT1",
	"S_SD2_GROUNDER_CHAINGUN_SHOOT2",
	"S_SD2_GROUNDER_CHAINGUN_SHOOT3",
	"S_SD2_GROUNDER_CHAINGUN_REFIRE",
	"S_SD2_GROUNDER_CHAINGUN_PAIN1",
	"S_SD2_GROUNDER_CHAINGUN_PAIN2",
	"S_SD2_GROUNDER_CHAINGUN_DIE1",
	"S_SD2_GROUNDER_CHAINGUN_DIE_SCREAM",
	"S_SD2_GROUNDER_CHAINGUN_DIE_FALL",
	"S_SD2_GROUNDER_CHAINGUN_DIE2",
	"S_SD2_GROUNDER_CHAINGUN_DIE_STILL",
	"S_SD2_GROUNDER_CHAINGUN_RAISE1",
	"S_SD2_GROUNDER_CHAINGUN_RAISE2",
	"S_SD2_GROUNDER_CHAINGUN_RAISE3",
	"S_SD2_GROUNDER_CHAINGUN_RAISE4",
	"S_SD2_GROUNDER_CHAINGUN_RAISE5",
	"S_SD2_GROUNDER_CHAINGUN_RAISE6"
)

sfxinfo[sfx_sd2gse].caption = "Aha! This time I'm ready for ya" // Couldn't fit all of this under the captions character limit
sfxinfo[sfx_sd2gac].caption = "Tread squeak"

sfxinfo[sfx_sd2ptl].caption = "Pistol fire"
sfxinfo[sfx_sd2shg].caption = "Shotgun fire"

// --------------------------------
// GROUNDER (PISTOL)
// --------------------------------

local function SD2_PosAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	local angle, damage, slope
	A_FaceTarget(actor)
	angle = actor.angle
	slope = R_PointToAngle2(0, actor.z, R_PointToDist2(actor.x, actor.y, actor.target.x, actor.target.y), actor.target.z)
	S_StartSound(actor, sfx_sd2ptl)
	
	// Offset Grounder's aim by a random value
	angle = $ + (P_RandomByte() - P_RandomByte())<<19
	//damage = (P_RandomByte()%5 + 1)*3
	//SD2_LineAttack(actor, angle, slope, MISSILERANGE, damage)
	SD2_SpawnMissile(actor, actor.target, MT_TURRETLASER, angle)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_GROUNDER_PISTOL)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_GROUNDER_PISTOL)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_GROUNDER_PISTOL)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_GROUNDER_PISTOL_PAIN1,
		S_SD2_GROUNDER_PISTOL_PAIN2
	})
	
	if mo.state == S_SD2_GROUNDER_PISTOL_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_GROUNDER_PISTOL_CHASE
	and mo.tics % 4 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_GROUNDER_PISTOL)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_GROUNDER_PISTOL)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_GROUNDER_PISTOL)

mobjinfo[MT_SD2_GROUNDER_PISTOL] = {
	//$Name Grounder (Pistol)
	//$Sprite SDGRA1
	//$Category Sonic Doom 2
	doomednum = 163,
	spawnstate = S_SD2_GROUNDER_PISTOL_LOOK,
	spawnhealth = 2,
	seestate = S_SD2_GROUNDER_PISTOL_CHASE,
	seesound = sfx_sd2gse,
	reactiontime = 8,
	attacksound = sfx_sd2ptl,
	painstate = S_SD2_GROUNDER_PISTOL_PAIN1,
	painchance = 200,
	painsound = sfx_sd2gpn,
	missilestate = S_SD2_GROUNDER_PISTOL_SHOOT1,
	deathstate = S_SD2_GROUNDER_PISTOL_DIE1,
	deathsound = sfx_pop,
	speed = 8,
	radius = 20*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 100,
	activesound = sfx_sd2gac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_GROUNDER_PISTOL_RAISE1
}

states[S_SD2_GROUNDER_PISTOL_LOOK] =	{SPR_SDGR,	A|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_GROUNDER_PISTOL_LOOK}

states[S_SD2_GROUNDER_PISTOL_CHASE] =	{SPR_SDGR,	A|FF_ANIMATE,	16,	nil,	1,	8,	S_SD2_GROUNDER_PISTOL_CHASE}

states[S_SD2_GROUNDER_PISTOL_SHOOT1] =	{SPR_SDGR,	C,					10,	A_FaceTarget,	0,	0,	S_SD2_GROUNDER_PISTOL_SHOOT2}
states[S_SD2_GROUNDER_PISTOL_SHOOT2] =	{SPR_SDGR,	D|FF_FULLBRIGHT,	8,	SD2_PosAttack,	0,	0,	S_SD2_GROUNDER_PISTOL_SHOOT3}
states[S_SD2_GROUNDER_PISTOL_SHOOT3] =	{SPR_SDGR,	C,					8,	nil,			0,	0,	S_SD2_GROUNDER_PISTOL_CHASE}

states[S_SD2_GROUNDER_PISTOL_PAIN1] =	{SPR_SDGR,	A,	3,	nil,	0,	0,	S_SD2_GROUNDER_PISTOL_PAIN2}
states[S_SD2_GROUNDER_PISTOL_PAIN2] =	{SPR_SDGR,	A,	3,	A_Pain,	0,	0,	S_SD2_GROUNDER_PISTOL_CHASE}

states[S_SD2_GROUNDER_PISTOL_DIE1] =		{SPR_SDXP,	C,	5,	nil,		0,	0,	S_SD2_GROUNDER_PISTOL_DIE_SCREAM}
states[S_SD2_GROUNDER_PISTOL_DIE_SCREAM] =	{SPR_SDXP,	D,	5,	A_Scream,	0,	0,	S_SD2_GROUNDER_PISTOL_DIE_FALL}
states[S_SD2_GROUNDER_PISTOL_DIE_FALL] =	{SPR_SDXP,	E,	5,	SD2_Fall,	0,	0,	S_SD2_GROUNDER_PISTOL_DIE2}
states[S_SD2_GROUNDER_PISTOL_DIE2] =		{SPR_SDXP,	F,	5,	nil,		0,	0,	S_SD2_GROUNDER_PISTOL_DIE_STILL}
states[S_SD2_GROUNDER_PISTOL_DIE_STILL] =	{SPR_NULL,	A,	-1,	nil,		0,	0,	S_NULL}

states[S_SD2_GROUNDER_PISTOL_RAISE1] =	{SPR_SDXP,	F,	5,	nil,	0,	0,	S_SD2_GROUNDER_PISTOL_RAISE2}
states[S_SD2_GROUNDER_PISTOL_RAISE2] =	{SPR_SDXP,	E,	5,	nil,	0,	0,	S_SD2_GROUNDER_PISTOL_RAISE3}
states[S_SD2_GROUNDER_PISTOL_RAISE3] =	{SPR_SDXP,	D,	5,	nil,	0,	0,	S_SD2_GROUNDER_PISTOL_RAISE4}
states[S_SD2_GROUNDER_PISTOL_RAISE4] =	{SPR_SDXP,	C,	5,	nil,	0,	0,	S_SD2_GROUNDER_PISTOL_CHASE}

// --------------------------------
// GROUNDER (SHOTGUN)
// --------------------------------

local function SD2_SPosAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	local bangle, slope
	S_StartSound(actor, sfx_sd2shg)
	A_FaceTarget(actor)
	bangle = actor.angle
	slope = R_PointToAngle2(0, actor.z, R_PointToDist2(actor.x, actor.y, actor.target.x, actor.target.y), actor.target.z)
	
	for i = 0, 2 do
		// Offset Grounder's aim by a random value
		local angle = bangle + (P_RandomByte() - P_RandomByte())<<19
		//local damage = ((P_RandomByte()%5)+1)*3
		//SD2_LineAttack(actor, angle, slope, MISSILERANGE, damage)
		SD2_SpawnMissile(actor, actor.target, MT_TURRETLASER, angle)
	end
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_GROUNDER_SHOTGUN)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_GROUNDER_SHOTGUN)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_GROUNDER_SHOTGUN)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_GROUNDER_SHOTGUN_PAIN1,
		S_SD2_GROUNDER_SHOTGUN_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_GROUNDER_SHOTGUN_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_GROUNDER_SHOTGUN_CHASE
	and mo.tics % 3 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_GROUNDER_SHOTGUN)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_GROUNDER_SHOTGUN)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_GROUNDER_SHOTGUN)

mobjinfo[MT_SD2_GROUNDER_SHOTGUN] = {
	//$Name Grounder (Shotgun)
	//$Sprite SDGRE1
	//$Category Sonic Doom 2
	doomednum = 164,
	spawnstate = S_SD2_GROUNDER_SHOTGUN_LOOK,
	spawnhealth = 2,
	seestate = S_SD2_GROUNDER_SHOTGUN_CHASE,
	seesound = sfx_sd2gse,
	reactiontime = 8,
	attacksound = sfx_sd2shg,
	painstate = S_SD2_GROUNDER_SHOTGUN_PAIN1,
	painchance = 170,
	painsound = sfx_sd2gpn,
	missilestate = S_SD2_GROUNDER_SHOTGUN_SHOOT1,
	deathstate = S_SD2_GROUNDER_PISTOL_DIE1,
	deathsound = sfx_pop,
	speed = 8,
	radius = 20*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 100,
	activesound = sfx_sd2gac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_GROUNDER_SHOTGUN_RAISE1
}

states[S_SD2_GROUNDER_SHOTGUN_LOOK] =	{SPR_SDGR,	E|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_GROUNDER_SHOTGUN_LOOK}

states[S_SD2_GROUNDER_SHOTGUN_CHASE] =	{SPR_SDGR,	E|FF_ANIMATE,	12,	nil,	1,	6,	S_SD2_GROUNDER_SHOTGUN_CHASE}

states[S_SD2_GROUNDER_SHOTGUN_SHOOT1] =	{SPR_SDGR,	G,					10,	A_FaceTarget,	0,	0,	S_SD2_GROUNDER_SHOTGUN_SHOOT2}
states[S_SD2_GROUNDER_SHOTGUN_SHOOT2] =	{SPR_SDGR,	H|FF_FULLBRIGHT,	10,	SD2_SPosAttack,	0,	0,	S_SD2_GROUNDER_SHOTGUN_SHOOT3}
states[S_SD2_GROUNDER_SHOTGUN_SHOOT3] =	{SPR_SDGR,	G,					10,	nil,			0,	0,	S_SD2_GROUNDER_SHOTGUN_CHASE}

states[S_SD2_GROUNDER_SHOTGUN_PAIN1] =	{SPR_SDGR,	E,	3,	nil,	0,	0,	S_SD2_GROUNDER_SHOTGUN_PAIN2}
states[S_SD2_GROUNDER_SHOTGUN_PAIN2] =	{SPR_SDGR,	E,	3,	A_Pain,	0,	0,	S_SD2_GROUNDER_SHOTGUN_CHASE}

states[S_SD2_GROUNDER_SHOTGUN_RAISE1] =	{SPR_NULL,	A,	5,	nil,	0,	0,	S_SD2_GROUNDER_SHOTGUN_RAISE2}
states[S_SD2_GROUNDER_SHOTGUN_RAISE2] =	{SPR_SDXP,	F,	5,	nil,	0,	0,	S_SD2_GROUNDER_SHOTGUN_RAISE3}
states[S_SD2_GROUNDER_SHOTGUN_RAISE3] =	{SPR_SDXP,	E,	5,	nil,	0,	0,	S_SD2_GROUNDER_SHOTGUN_RAISE4}
states[S_SD2_GROUNDER_SHOTGUN_RAISE4] =	{SPR_SDXP,	D,	5,	nil,	0,	0,	S_SD2_GROUNDER_SHOTGUN_RAISE5}
states[S_SD2_GROUNDER_SHOTGUN_RAISE5] =	{SPR_SDXP,	C,	5,	nil,	0,	0,	S_SD2_GROUNDER_SHOTGUN_CHASE}

// --------------------------------
// GROUNDER (CHAINGUN)
// --------------------------------

local function SD2_CPosAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	local angle, damage, slope
	A_FaceTarget(actor)
	angle = actor.angle
	slope = R_PointToAngle2(0, actor.z, R_PointToDist2(actor.x, actor.y, actor.target.x, actor.target.y), actor.target.z)
	S_StartSound(actor, sfx_sd2shg)
	
	// Offset Grounder's aim by a random value
	angle = $ + (P_RandomByte() - P_RandomByte())<<19
	SD2_SpawnMissile(actor, actor.target, MT_TURRETLASER, angle)
	//local bullet = P_SpawnMissile(actor, actor.target, MT_JETTBULLET)
	//if bullet and bullet.valid then S_StopSound(bullet) end
end

// Checks if Grounder can still see his target before firing again
local function SD2_CPosRefire(actor, var1, var2)
	if not (actor and actor.valid) then return end
	A_FaceTarget(actor)
	
	// Don't stop firing unless the RNG says so
	if P_RandomByte() < 40 then return end
	
	if not (actor.target and actor.target.valid) or actor.target.health <= 0
	or not P_CheckSight(actor, actor.target) then
		actor.state = actor.info.seestate
	end
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_GROUNDER_CHAINGUN)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_GROUNDER_CHAINGUN)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_GROUNDER_CHAINGUN)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_GROUNDER_CHAINGUN_PAIN1,
		S_SD2_GROUNDER_CHAINGUN_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_GROUNDER_CHAINGUN_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_GROUNDER_CHAINGUN_CHASE
	and mo.tics % 3 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_GROUNDER_CHAINGUN)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_GROUNDER_CHAINGUN)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_GROUNDER_CHAINGUN)

mobjinfo[MT_SD2_GROUNDER_CHAINGUN] = {
	//$Name Grounder (Chaingun)
	//$Sprite SDGRI1
	//$Category Sonic Doom 2
	doomednum = 165,
	spawnstate = S_SD2_GROUNDER_CHAINGUN_LOOK,
	spawnhealth = 3,
	seestate = S_SD2_GROUNDER_CHAINGUN_CHASE,
	seesound = sfx_sd2gse,
	reactiontime = 8,
	attacksound = sfx_sd2shg,
	painstate = S_SD2_GROUNDER_CHAINGUN_PAIN1,
	painchance = 170,
	painsound = sfx_sd2gpn,
	missilestate = S_SD2_GROUNDER_CHAINGUN_SHOOT1,
	deathstate = S_SD2_GROUNDER_CHAINGUN_DIE1,
	deathsound = sfx_pop,
	speed = 8,
	radius = 20*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 100,
	activesound = sfx_sd2gac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_GROUNDER_CHAINGUN_RAISE1
}

states[S_SD2_GROUNDER_CHAINGUN_LOOK] =	{SPR_SDGR,	I|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_GROUNDER_CHAINGUN_LOOK}

states[S_SD2_GROUNDER_CHAINGUN_CHASE] =	{SPR_SDGR,	I|FF_ANIMATE,	12,	nil,	1,	6,	S_SD2_GROUNDER_CHAINGUN_CHASE}

states[S_SD2_GROUNDER_CHAINGUN_SHOOT1] =	{SPR_SDGR,	K,					10,	A_FaceTarget,	0,	0,	S_SD2_GROUNDER_CHAINGUN_SHOOT2}
states[S_SD2_GROUNDER_CHAINGUN_SHOOT2] =	{SPR_SDGR,	L|FF_FULLBRIGHT,	4,	SD2_CPosAttack,	0,	0,	S_SD2_GROUNDER_CHAINGUN_SHOOT3}
states[S_SD2_GROUNDER_CHAINGUN_SHOOT3] =	{SPR_SDGR,	K|FF_FULLBRIGHT,	4,	SD2_CPosAttack,	0,	0,	S_SD2_GROUNDER_CHAINGUN_REFIRE}
states[S_SD2_GROUNDER_CHAINGUN_REFIRE] =	{SPR_SDGR,	L,					1,	SD2_CPosRefire,	0,	0,	S_SD2_GROUNDER_CHAINGUN_SHOOT2}

states[S_SD2_GROUNDER_CHAINGUN_PAIN1] =	{SPR_SDGR,	I,	3,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_PAIN2}
states[S_SD2_GROUNDER_CHAINGUN_PAIN2] =	{SPR_SDGR,	I,	3,	A_Pain,	0,	0,	S_SD2_GROUNDER_CHAINGUN_CHASE}

states[S_SD2_GROUNDER_CHAINGUN_DIE1] =			{SPR_SDXP,	A,				5,	nil,		0,	0,	S_SD2_GROUNDER_CHAINGUN_DIE_SCREAM}
states[S_SD2_GROUNDER_CHAINGUN_DIE_SCREAM] =	{SPR_SDXP,	A,				5,	A_Scream,	0,	0,	S_SD2_GROUNDER_CHAINGUN_DIE_FALL}
states[S_SD2_GROUNDER_CHAINGUN_DIE_FALL] =		{SPR_SDXP,	B,				5,	SD2_Fall,	0,	0,	S_SD2_GROUNDER_CHAINGUN_DIE2}
states[S_SD2_GROUNDER_CHAINGUN_DIE2] =			{SPR_SDXP,	C|FF_ANIMATE,	15,	nil,		2,	5,	S_SD2_GROUNDER_CHAINGUN_DIE_STILL}
states[S_SD2_GROUNDER_CHAINGUN_DIE_STILL] =		{SPR_NULL,	A,				-1,	nil,		0,	0,	S_NULL}

states[S_SD2_GROUNDER_CHAINGUN_RAISE1] =	{SPR_NULL,	A,	5,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_RAISE2}
states[S_SD2_GROUNDER_CHAINGUN_RAISE2] =	{SPR_SDXP,	E,	5,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_RAISE3}
states[S_SD2_GROUNDER_CHAINGUN_RAISE3] =	{SPR_SDXP,	D,	5,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_RAISE4}
states[S_SD2_GROUNDER_CHAINGUN_RAISE4] =	{SPR_SDXP,	C,	5,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_RAISE5}
states[S_SD2_GROUNDER_CHAINGUN_RAISE5] =	{SPR_SDXP,	B,	5,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_RAISE6}
states[S_SD2_GROUNDER_CHAINGUN_RAISE6] =	{SPR_SDXP,	A,	10,	nil,	0,	0,	S_SD2_GROUNDER_CHAINGUN_CHASE}
