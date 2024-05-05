// Sonic Doom 2 - Pseudo-Knuckles
// Ported by MIDIMan

freeslot(
	"sfx_sd2rse",
	"sfx_sd2rpc",
	"sfx_sd2rac",
	"sfx_sd2rdi",
	"SPR_SDKN",
	"MT_SD2_PSEUDOKNUCKLES",
	"S_SD2_PSEUDOKNUCKLES_LOOK",
	"S_SD2_PSEUDOKNUCKLES_CHASE",
	"S_SD2_PSEUDOKNUCKLES_MELEE1",
	"S_SD2_PSEUDOKNUCKLES_MELEE2",
	"S_SD2_PSEUDOKNUCKLES_MELEE3",
	"S_SD2_PSEUDOKNUCKLES_MELEE4",
	"S_SD2_PSEUDOKNUCKLES_MISSILE1",
	"S_SD2_PSEUDOKNUCKLES_MISSILE2",
	"S_SD2_PSEUDOKNUCKLES_MISSILE3",
	"S_SD2_PSEUDOKNUCKLES_PAIN1",
	"S_SD2_PSEUDOKNUCKLES_PAIN2",
	"S_SD2_PSEUDOKNUCKLES_DIE1",
	"S_SD2_PSEUDOKNUCKLES_DIE_SCREAM",
	"S_SD2_PSEUDOKNUCKLES_DIE_FALL",
	"S_SD2_PSEUDOKNUCKLES_DIE2",
	"S_SD2_PSEUDOKNUCKLES_DIE_STILL",
	"S_SD2_PSEUDOKNUCKLES_RAISE1",
	"S_SD2_PSEUDOKNUCKLES_RAISE2",
	"S_SD2_PSEUDOKNUCKLES_RAISE3",
	"S_SD2_PSEUDOKNUCKLES_RAISE4",
	"S_SD2_PSEUDOKNUCKLES_RAISE5",
	"S_SD2_PSEUDOKNUCKLES_RAISE6",
	"MT_SD2_PSEUDOKNUCKLES_FIST",
	"S_SD2_PSEUDOKNUCKLES_FIST",
	"S_SD2_PSEUDOKNUCKLES_FIST_STOPSOUND",
	"S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE1",
	"S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE2",
	"S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE3"
)

sfxinfo[sfx_sd2rse].caption = "Hey, blue doof ball!"
sfxinfo[sfx_sd2rpc].caption = "Punch"
sfxinfo[sfx_sd2rac].caption = "How about a knuckle sandwich?!"
sfxinfo[sfx_sd2rdi].caption = "Grrrr!"

local function SD2_SkelWhoosh(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	S_StartSound(actor, sfx_s3k49)
end

local function SD2_SkelFist(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	if P_CheckMeleeRange(actor) then
		local damage = ((P_RandomByte()%10)+1)*6
		S_StartSound(actor, sfx_sd2rpc)
		P_DamageMobj(actor.target, actor, actor, damage)
	end
end

local function SD2_SkelMissile(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	actor.z = $+(P_MobjFlip(actor)*16*actor.scale)
	local fist = SD2_SpawnMissile(actor, actor.target, MT_SD2_PSEUDOKNUCKLES_FIST)
	actor.z = $-(P_MobjFlip(actor)*16*actor.scale)
	
	P_SetOrigin(fist, fist.x + fist.momx, fist.y + fist.momy, fist.z)
	fist.tracer = actor.target
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_PSEUDOKNUCKLES)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_PSEUDOKNUCKLES)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_PSEUDOKNUCKLES)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_PSEUDOKNUCKLES_PAIN1,
		S_SD2_PSEUDOKNUCKLES_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_PSEUDOKNUCKLES_CHASE
	and mo.tics % 2 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_PSEUDOKNUCKLES)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_PSEUDOKNUCKLES)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_PSEUDOKNUCKLES)

mobjinfo[MT_SD2_PSEUDOKNUCKLES] = {
	//$Name Pseudo-Knuckles
	//$Sprite SDKNA1B1
	//$Category Sonic Doom 2
	doomednum = 174,
	spawnstate = S_SD2_PSEUDOKNUCKLES_LOOK,
	spawnhealth = 10,
	seestate = S_SD2_PSEUDOKNUCKLES_CHASE,
	seesound = sfx_sd2rse,
	reactiontime = 8,
	painstate = S_SD2_PSEUDOKNUCKLES_PAIN1,
	painchance = 100,
	painsound = sfx_sd2gpn,
	meleestate = S_SD2_PSEUDOKNUCKLES_MELEE1,
	missilestate = S_SD2_PSEUDOKNUCKLES_MISSILE1,
	deathstate = S_SD2_PSEUDOKNUCKLES_DIE1,
	deathsound = sfx_sd2rdi,
	speed = 10,
	radius = 20*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 500,
	activesound = sfx_sd2rac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_SPECIAL|MF_PUSHABLE,
	raisestate = S_SD2_PSEUDOKNUCKLES_RAISE1
}

states[S_SD2_PSEUDOKNUCKLES_LOOK] =	{SPR_SDKN,	A,	10,	A_RadarLook,	0,	0,	S_SD2_PSEUDOKNUCKLES_LOOK}

states[S_SD2_PSEUDOKNUCKLES_CHASE] =	{SPR_SDKN,	A|FF_ANIMATE,	24,	nil,	1,	12,	S_SD2_PSEUDOKNUCKLES_CHASE}

states[S_SD2_PSEUDOKNUCKLES_MELEE1] =	{SPR_SDKN,	C,	0,	A_FaceTarget,	0,	0,	S_SD2_PSEUDOKNUCKLES_MELEE2}
states[S_SD2_PSEUDOKNUCKLES_MELEE2] =	{SPR_SDKN,	C,	6,	SD2_SkelWhoosh,	0,	0,	S_SD2_PSEUDOKNUCKLES_MELEE3}
states[S_SD2_PSEUDOKNUCKLES_MELEE3] =	{SPR_SDKN,	D,	6,	A_FaceTarget,	0,	0,	S_SD2_PSEUDOKNUCKLES_MELEE4}
states[S_SD2_PSEUDOKNUCKLES_MELEE4] =	{SPR_SDKN,	E,	6,	SD2_SkelFist,	0,	0,	S_SD2_PSEUDOKNUCKLES_CHASE}

states[S_SD2_PSEUDOKNUCKLES_MISSILE1] =	{SPR_SDKN,	F|FF_FULLBRIGHT,	10,	A_FaceTarget,		0,	0,	S_SD2_PSEUDOKNUCKLES_MISSILE2}
states[S_SD2_PSEUDOKNUCKLES_MISSILE2] =	{SPR_SDKN,	E,					10,	SD2_SkelMissile,	0,	0,	S_SD2_PSEUDOKNUCKLES_MISSILE3}
states[S_SD2_PSEUDOKNUCKLES_MISSILE3] =	{SPR_SDKN,	E,					10,	A_FaceTarget,		0,	0,	S_SD2_PSEUDOKNUCKLES_CHASE}

states[S_SD2_PSEUDOKNUCKLES_PAIN1] =	{SPR_SDKN,	G,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_PAIN2}
states[S_SD2_PSEUDOKNUCKLES_PAIN2] =	{SPR_SDKN,	G,	5,	A_Pain,	0,	0,	S_SD2_PSEUDOKNUCKLES_CHASE}

states[S_SD2_PSEUDOKNUCKLES_DIE1] =			{SPR_SDKN,	G|FF_ANIMATE,	14,	nil,		1,	7,	S_SD2_PSEUDOKNUCKLES_DIE_SCREAM}
states[S_SD2_PSEUDOKNUCKLES_DIE_SCREAM] =	{SPR_SDKN,	I,				7,	A_Scream,	0,	0,	S_SD2_PSEUDOKNUCKLES_DIE_FALL}
states[S_SD2_PSEUDOKNUCKLES_DIE_FALL] =		{SPR_SDKN,	J,				7,	SD2_Fall,	0,	0,	S_SD2_PSEUDOKNUCKLES_DIE2}
states[S_SD2_PSEUDOKNUCKLES_DIE2] =			{SPR_SDKN,	K,				7,	nil,		0,	0,	S_SD2_PSEUDOKNUCKLES_DIE_STILL}
states[S_SD2_PSEUDOKNUCKLES_DIE_STILL] =	{SPR_SDKN,	L,				-1,	nil,		0,	0,	S_NULL}

states[S_SD2_PSEUDOKNUCKLES_RAISE1] =	{SPR_SDKN,	L,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_RAISE2}
states[S_SD2_PSEUDOKNUCKLES_RAISE2] =	{SPR_SDKN,	K,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_RAISE3}
states[S_SD2_PSEUDOKNUCKLES_RAISE3] =	{SPR_SDKN,	J,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_RAISE4}
states[S_SD2_PSEUDOKNUCKLES_RAISE4] =	{SPR_SDKN,	I,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_RAISE5}
states[S_SD2_PSEUDOKNUCKLES_RAISE5] =	{SPR_SDKN,	H,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_RAISE6}
states[S_SD2_PSEUDOKNUCKLES_RAISE6] =	{SPR_SDKN,	G,	5,	nil,	0,	0,	S_SD2_PSEUDOKNUCKLES_CHASE}

local function SD2_Tracer(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	if (leveltime & 3) then return end // Maybe add a fix for demo desyncs
	
	SD2_SpawnPuff(actor, 0)
	
	local smoke = P_SpawnMobjFromMobj(actor, -FixedDiv(actor.momx, actor.scale), -FixedDiv(actor.momy, actor.scale), 0, MT_SD2_SMOKE)
	P_SetObjectMomZ(smoke, FRACUNIT)
	smoke.tics = $-(P_RandomByte() & 3)
	if smoke.tics < 1 then smoke.tics = 1 end
	
	local dest = actor.tracer
	
	if not (dest and dest.valid and dest.health > 0) then return end
	
	local traceAngle = FixedAngle(135*FRACUNIT/8)
	local exact = R_PointToAngle2(actor.x, actor.y, dest.x, dest.y)
	
	if exact ~= actor.angle then
		local diff = AngleFixed(exact - actor.angle)
		
		if diff > 180*FRACUNIT then
			actor.angle = $-traceAngle
			if AngleFixed(exact - actor.angle) < 180*FRACUNIT then
				actor.angle = exact
			end
		else
			actor.angle = $+traceAngle
			if AngleFixed(exact - actor.angle) > 180*FRACUNIT then
				actor.angle = exact
			end
		end
	end
	
	exact = actor.angle
	P_InstaThrust(actor, exact, FixedMul(actor.info.speed, actor.scale))
	
	local dist = FixedHypot(dest.x - actor.x, dest.y - actor.y) // Originally used P_AproxDistance
	
	dist = $ / actor.info.speed
	
	if dist < 1 then dist = 1 end
	
	local slope = (dest.z + 40*FRACUNIT - actor.z) / dist
	
	if slope < actor.momz then
		P_SetObjectMomZ(actor, -FRACUNIT/8, true)
	else
		P_SetObjectMomZ(actor, FRACUNIT/8, true)
	end
end

//addHook("MobjMoveCollide", SD2_BulletCollision, MT_SD2_PSEUDOKNUCKLES_FIST)

mobjinfo[MT_SD2_PSEUDOKNUCKLES_FIST] = {
	doomednum = -1,
	spawnstate = S_SD2_PSEUDOKNUCKLES_FIST,
	spawnhealth = 1000,
	seesound = sfx_bkpoof,
	deathstate = S_SD2_PSEUDOKNUCKLES_FIST_STOPSOUND,
	deathsound = sfx_dmpain,
	speed = 10*FRACUNIT,
	radius = 11*FRACUNIT,
	height = 8*FRACUNIT,
	mass = 100,
	damage = 10,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SD2_PSEUDOKNUCKLES_FIST] =	{SPR_SDKN,	M|FF_FULLBRIGHT,	2,	SD2_Tracer,		0,	0,	S_SD2_PSEUDOKNUCKLES_FIST}

states[S_SD2_PSEUDOKNUCKLES_FIST_STOPSOUND] =	{SPR_SDKN,	M|FF_FULLBRIGHT,	0,	SD2_StopSound,	0,	0,	S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE1}
states[S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE1] =	{SPR_SDKN,	N|FF_FULLBRIGHT,	8,	nil,			0,	0,	S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE2}
states[S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE2] =	{SPR_SDKN,	O|FF_FULLBRIGHT,	6,	nil,			0,	0,	S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE3}
states[S_SD2_PSEUDOKNUCKLES_FIST_EXPLODE3] =	{SPR_SDKN,	P|FF_FULLBRIGHT,	4,	nil,			0,	0,	S_NULL}
