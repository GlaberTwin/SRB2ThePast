// Sonic Doom 2 - Eggman

/*
Fun Facts:

- The Eggman sprites were originally meant for the Spider Mastermind before 
Brak's sprites were "finished".
- In Sonic Doom 2, Pseudo-Knuckles replaced some of the Mancubus's sprites, but 
the Mancubus itself was not officially used in any completed level.
- The death frames were newly-created for SRB2TP by MIDIMan.
- The "see sound" was also newly-created for SRB2TP. It was sourced from the 
original Japanese "dub" of the Sonic OVA, where Eggman jumps out of the corpse 
of Black Eggman and taunts Sonic. It was then processed in Audacity to sound 
similar in quality to the other OVA-sourced audio clips in Sonic Doom 2.
*/

freeslot(
	"sfx_sd2mse", // Borrowed from the Sonic OVA's second part
	"SPR_SDEG",
	"MT_SD2_EGGMAN",
	"S_SD2_EGGMAN_LOOK",
	"S_SD2_EGGMAN_CHASE",
	"S_SD2_EGGMAN_ATTACK_START",
	"S_SD2_EGGMAN_ATTACK_FIRE",
	"S_SD2_EGGMAN_ATTACK_TARGET",
	"S_SD2_EGGMAN_ATTACK_REPEAT",
	"S_SD2_EGGMAN_PAIN1",
	"S_SD2_EGGMAN_PAIN2",
	"S_SD2_EGGMAN_DIE1",
	"S_SD2_EGGMAN_DIE_SCREAM",
	"S_SD2_EGGMAN_DIE_FALL",
	"S_SD2_EGGMAN_DIE2",
	"S_SD2_EGGMAN_DIE_BOSSDEATH",
	"S_SD2_EGGMAN_RAISE1",
	"S_SD2_EGGMAN_RAISE2",
	"MT_SD2_EGGMAN_FIREBALL", // Graphics borrowed from Freedoom
	"S_SD2_EGGMAN_FIREBALL",
	"S_SD2_EGGMAN_FIREBALL_DIE1",
	"S_SD2_EGGMAN_FIREBALL_DIE2",
	"S_SD2_EGGMAN_FIREBALL_DIE3"
)

sfxinfo[sfx_sd2mse].caption = "Eggman laughs"

local SD2_FATSPREAD = ANGLE_11hh

local function SD2_FatRaise(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	actor.sd2EggmanCount = 3
	actor.extravalue2 = 0 // Reset the repeat counter
	A_FaceTarget(actor)
	S_StopSound(actor) // Attempt to stop any sounds currently playing
	S_StartSound(actor, sfx_s3kc1s)
end

// Combine all of the A_FatAttack actions into one to reduce redundancy
local function SD2_FatAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	local function SD2_FireballAngle(angleOffset)
		local mo = SD2_SpawnMissile(actor, actor.target, MT_SD2_EGGMAN_FIREBALL, 0, 56*FRACUNIT)
		
		if mo and mo.valid then
			mo.angle = $+angleOffset
			P_InstaThrust(mo, mo.angle, FixedMul(mo.scale, mo.info.speed))
		end
	end
	
	if actor.sd2EggmanCount then
		// Easy way to adjust the fireball spawn height
		// Inspired by the Revenant
		//actor.z = $+(P_MobjFlip(actor)*24*actor.scale)
		if actor.sd2EggmanCount > 1 then
			if actor.sd2EggmanCount == 3
				actor.angle = $+SD2_FATSPREAD
				SD2_SpawnMissile(actor, actor.target, MT_SD2_EGGMAN_FIREBALL, 0, 56*FRACUNIT)
				SD2_FireballAngle(SD2_FATSPREAD)
			else
				actor.angle = $-SD2_FATSPREAD
				SD2_SpawnMissile(actor, actor.target, MT_SD2_EGGMAN_FIREBALL, 0, 56*FRACUNIT)
				SD2_FireballAngle(-SD2_FATSPREAD*2)
			end
		else
			SD2_FireballAngle(-SD2_FATSPREAD/2)
			SD2_FireballAngle(SD2_FATSPREAD/2)
		end
		//actor.z = $-(P_MobjFlip(actor)*24*actor.scale)
		
		actor.sd2EggmanCount = $-1
	end
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_EGGMAN)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_EGGMAN)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_EGGMAN)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_EGGMAN_PAIN1,
		S_SD2_EGGMAN_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_EGGMAN_LOOK
	and mo.tics % 15 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_EGGMAN_CHASE then
		if mo.tics % 4 == 0 then
			SD2_Chase(mo, 0, 0)
		end
	end
	
	if mo.state == S_SD2_EGGMAN_ATTACK_TARGET then
		if mo.tics % 5 == 0 then
			A_FaceTarget(mo)
		end
	end
end, MT_SD2_EGGMAN)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_EGGMAN)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_EGGMAN)

// Don't let Eggman fly away
addHook("BossDeath", function(mo)
	if not (mo and mo.valid) then return end
	return true
end, MT_SD2_EGGMAN)

mobjinfo[MT_SD2_EGGMAN] = {
	//$Name Eggman (Mancubus)
	//$Sprite SDEGA1
	//$Category Sonic Doom 2
	doomednum = 178,
	spawnstate = S_SD2_EGGMAN_LOOK,
	spawnhealth = 64, // Originally 17 (should be used as an enemy)
	seestate = S_SD2_EGGMAN_CHASE,
	seesound = sfx_sd2mse,
	reactiontime = 0, // Originally 8 (should be used as an enemy)
	//attacksound = sfx_s3kc1s // This is shorter than the source sound, but the looped version was too long
	painstate = S_SD2_EGGMAN_PAIN1,
	painchance = 10, // Originally 80 (should be used as an enemy)
	painsound = sfx_s3k72,
	missilestate = S_SD2_EGGMAN_ATTACK_START,
	deathstate = S_SD2_EGGMAN_DIE1,
	deathsound = sfx_sd2odi,
	speed = 8,
	radius = 48*FRACUNIT,
	height = 128*FRACUNIT, // Originally 64*FRACUNIT
	mass = 1000,
	activesound = sfx_sd2gac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_PUSHABLE,
	raisestate = S_SD2_EGGMAN_RAISE1
}

states[S_SD2_EGGMAN_LOOK] =	{SPR_SDEG,	A|FF_ANIMATE,	30,	nil,	1,	15,	S_SD2_EGGMAN_LOOK}

states[S_SD2_EGGMAN_CHASE] =	{SPR_SDEG,	A|FF_ANIMATE,	24,	nil,	2,	8,	S_SD2_EGGMAN_CHASE}

states[S_SD2_EGGMAN_ATTACK_START] =		{SPR_SDEG,	D,					20,	SD2_FatRaise,	0,	0,							S_SD2_EGGMAN_ATTACK_FIRE}
states[S_SD2_EGGMAN_ATTACK_FIRE] =		{SPR_SDEG,	E|FF_FULLBRIGHT,	10,	SD2_FatAttack,	0,	0,							S_SD2_EGGMAN_ATTACK_TARGET}
states[S_SD2_EGGMAN_ATTACK_TARGET] =	{SPR_SDEG,	D,					10,	nil,			0,	0,							S_SD2_EGGMAN_ATTACK_REPEAT}
states[S_SD2_EGGMAN_ATTACK_REPEAT] =	{SPR_SDEG,	D,					0,	A_Repeat,		3,	S_SD2_EGGMAN_ATTACK_FIRE,	S_SD2_EGGMAN_CHASE}

states[S_SD2_EGGMAN_PAIN1] =	{SPR_SDEG,	A,	3,	nil,	0,	0,	S_SD2_EGGMAN_PAIN2}
states[S_SD2_EGGMAN_PAIN2] =	{SPR_SDEG,	A,	3,	A_Pain,	0,	0,	S_SD2_EGGMAN_CHASE}

states[S_SD2_EGGMAN_DIE1] =				{SPR_SDEG,	F,	6,	nil,			0,	0,	S_SD2_EGGMAN_DIE_SCREAM}
states[S_SD2_EGGMAN_DIE_SCREAM] =		{SPR_SDEG,	F,	6,	A_Scream,		0,	0,	S_SD2_EGGMAN_DIE_FALL}
states[S_SD2_EGGMAN_DIE_FALL] =			{SPR_SDEG,	F,	12,	SD2_Fall,		0,	0,	S_SD2_EGGMAN_DIE2}
states[S_SD2_EGGMAN_DIE2] =				{SPR_SDEG,	G,	30,	nil,			0,	0,	S_SD2_EGGMAN_DIE_BOSSDEATH}
states[S_SD2_EGGMAN_DIE_BOSSDEATH] =	{SPR_SDEG,	G,	-1,	A_BossDeath,	0,	0,	S_NULL}

states[S_SD2_EGGMAN_RAISE1] =	{SPR_SDEG,	G,	20,	nil,	0,	0,	S_SD2_EGGMAN_RAISE2}
states[S_SD2_EGGMAN_RAISE2] =	{SPR_SDEG,	F,	20,	nil,	0,	0,	S_SD2_EGGMAN_CHASE}

addHook("MobjSpawn", function(mo)
	if not (mo and mo.valid) then return end
	
	mo.blendmode = AST_ADD
end, MT_SD2_EGGMAN_FIREBALL)

mobjinfo[MT_SD2_EGGMAN_FIREBALL] = {
	doomednum = -1,
	spawnstate = S_SD2_EGGMAN_FIREBALL,
	spawnhealth = 1000,
	seesound = sfx_sd2frs,
	reactiontime = 8,
	deathstate = S_SD2_EGGMAN_FIREBALL_DIE1,
	deathsound = sfx_sd2frx,
	speed = 20*FRACUNIT,
	radius = 6*FRACUNIT,
	height = 8*FRACUNIT,
	damage = 8,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}

states[S_SD2_EGGMAN_FIREBALL] =	{SPR_SDEG,	H|FF_FULLBRIGHT|FF_ANIMATE,	-1,	nil,	1,	4,	S_SD2_EGGMAN_FIREBALL}

states[S_SD2_EGGMAN_FIREBALL_DIE1] =	{SPR_SDEG,	J|FF_FULLBRIGHT,	8,	nil,	0,	0,	S_SD2_EGGMAN_FIREBALL_DIE2}
states[S_SD2_EGGMAN_FIREBALL_DIE2] =	{SPR_SDEG,	K|FF_FULLBRIGHT,	6,	nil,	0,	0,	S_SD2_EGGMAN_FIREBALL_DIE3}
states[S_SD2_EGGMAN_FIREBALL_DIE3] =	{SPR_SDEG,	L|FF_FULLBRIGHT,	4,	nil,	0,	0,	S_NULL}











