// Sonic Doom 2 - Black/Brak Eggman

/*
Fun Facts:

- These sprites were made for Sonic Doom 2 to replace the Spider Mastermind's, 
but they were never included with the WAD itself.
- In Sonic Doom 2, a single frame of a silver ring replaced most of the 
Spider Mastermind's sprites, but the Spider Mastermind itself was never officially 
used in any completed level.
- The death frames were recolored for SRB2TP to better match the other sprites 
that were recolored for Sonic Doom 2.
*/

freeslot(
	"sfx_sd2ese",
	"sfx_sd2edi",
	"SPR_SDBE",
	"MT_SD2_BLACKEGGMAN",
	"S_SD2_BLACKEGGMAN_LOOK",
	"S_SD2_BLACKEGGMAN_CHASE",
	"S_SD2_BLACKEGGMAN_TARGET",
	"S_SD2_BLACKEGGMAN_ATTACK",
	"S_SD2_BLACKEGGMAN_REFIRE",
	"S_SD2_BLACKEGGMAN_PAIN1",
	"S_SD2_BLACKEGGMAN_PAIN2",
	"S_SD2_BLACKEGGMAN_DIE_SCREAM",
	"S_SD2_BLACKEGGMAN_DIE_FALL",
	"S_SD2_BLACKEGGMAN_DIE",
	"S_SD2_BLACKEGGMAN_DIE_STILL",
	"S_SD2_BLACKEGGMAN_DIE_BOSSDEATH"
)

sfxinfo[sfx_sd2ese].caption = "Black Eggman awakens"
sfxinfo[sfx_sd2edi].caption = "Black Eggman collapsing"

local function SD2_SpidAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	local bangle, slope
	S_StartSound(actor, sfx_sd2shg)
	A_FaceTarget(actor)
	bangle = actor.angle
	slope = R_PointToAngle2(0, actor.z, R_PointToDist2(actor.x, actor.y, actor.target.x, actor.target.y), actor.target.z)
	
	for i = 0, 2 do
		// Offset Brak/Black Eggman's aim by a random value
		local angle = bangle + (P_RandomByte() - P_RandomByte())<<19
		//local damage = ((P_RandomByte()%5)+1)*3
		//SD2_LineAttack(actor, angle, slope, MISSILERANGE, damage)
		SD2_SpawnMissile(actor, actor.target, MT_TURRETLASER, angle, 128*FRACUNIT)
	end
end

// Checks if Black/Brak Eggman can still see his target before firing again
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

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_BLACKEGGMAN)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_BLACKEGGMAN)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_BLACKEGGMAN)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_BLACKEGGMAN_PAIN1,
		S_SD2_BLACKEGGMAN_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_BLACKEGGMAN_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_BLACKEGGMAN_CHASE then
		if mo.tics % 3 == 0 then
			SD2_Chase(mo, 0, 0)
		end
		
		if mo.tics % 12 == 0 then
			S_StopSoundByID(mo, sfx_s3k9b)
			S_StartSound(mo, sfx_s3k9b)
		end
	end
	
	if mo.state == S_SD2_BLACKEGGMAN_ATTACK then
		if mo.tics % 4 == 0 then
			SD2_SpidAttack(mo, 0, 0)
		end
	end
end, MT_SD2_BLACKEGGMAN)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_BLACKEGGMAN)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_BLACKEGGMAN)

// Don't let Black/Brak Eggman fly away
addHook("BossDeath", function(mo)
	if not (mo and mo.valid) then return end
	return true
end, MT_SD2_BLACKEGGMAN)

mobjinfo[MT_SD2_BLACKEGGMAN] = {
	//$Name Black/Brak Eggman (Spider Mastermind)
	//$Sprite SDBEA1
	//$Category Sonic Doom 2
	doomednum = 179,
	spawnstate = S_SD2_BLACKEGGMAN_LOOK,
	spawnhealth = 80,
	seestate = S_SD2_BLACKEGGMAN_CHASE,
	seesound = sfx_sd2ese,
	reactiontime = 0, // Originally 8 (Should be used as an enemy)
	attacksound = sfx_sd2shg,
	painstate = S_SD2_BLACKEGGMAN_PAIN1,
	painchance = 10, // Originally 40 (Should be used as an enemy)
	painsound = sfx_s3k8b,
	missilestate = S_SD2_BLACKEGGMAN_TARGET,
	deathstate = S_SD2_BLACKEGGMAN_DIE_SCREAM,
	deathsound = sfx_sd2edi,
	speed = 12,
	radius = 128*FRACUNIT,
	height = 176*FRACUNIT, // Originally 100*FRACUNIT
	mass = 1000,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_SHOOTABLE|MF_ENEMY|MF_PUSHABLE
}

states[S_SD2_BLACKEGGMAN_LOOK] =	{SPR_SDBE,	A|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_BLACKEGGMAN_LOOK}

states[S_SD2_BLACKEGGMAN_CHASE] =	{SPR_SDBE,	A|FF_ANIMATE,	36,	nil,	2,	6,	S_SD2_BLACKEGGMAN_CHASE}

states[S_SD2_BLACKEGGMAN_TARGET] =	{SPR_SDBE,	A|FF_FULLBRIGHT,			20,	A_FaceTarget,	0,	0,	S_SD2_BLACKEGGMAN_ATTACK}
states[S_SD2_BLACKEGGMAN_ATTACK] =	{SPR_SDBE,	D|FF_ANIMATE|FF_FULLBRIGHT,	8,	nil,			1,	4,	S_SD2_BLACKEGGMAN_REFIRE}
states[S_SD2_BLACKEGGMAN_REFIRE] =	{SPR_SDBE,	E|FF_FULLBRIGHT,			1,	SD2_SpidRefire,	0,	0,	S_SD2_BLACKEGGMAN_ATTACK}

states[S_SD2_BLACKEGGMAN_PAIN1] =	{SPR_SDBE,	A,	3,	nil,	0,	0,	S_SD2_BLACKEGGMAN_PAIN2}
states[S_SD2_BLACKEGGMAN_PAIN2] =	{SPR_SDBE,	A,	3,	A_Pain,	0,	0,	S_SD2_BLACKEGGMAN_CHASE}

states[S_SD2_BLACKEGGMAN_DIE_SCREAM] =		{SPR_SDBE,	F,	20,	A_Scream,		0,	0,	S_SD2_BLACKEGGMAN_DIE_FALL}
states[S_SD2_BLACKEGGMAN_DIE_FALL] =		{SPR_SDBE,	F,	20,	SD2_Fall,		0,	0,	S_SD2_BLACKEGGMAN_DIE}
states[S_SD2_BLACKEGGMAN_DIE] =				{SPR_SDBE,	G,	40,	nil,			0,	0,	S_SD2_BLACKEGGMAN_DIE_STILL}
states[S_SD2_BLACKEGGMAN_DIE_STILL] =		{SPR_SDBE,	H,	50,	nil,			0,	0,	S_SD2_BLACKEGGMAN_DIE_BOSSDEATH}
states[S_SD2_BLACKEGGMAN_DIE_BOSSDEATH] =	{SPR_SDBE,	H,	-1,	A_BossDeath,	0,	0,	S_NULL}


















