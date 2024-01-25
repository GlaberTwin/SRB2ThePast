// Sonic Doom 2 - Psuedo-Tails
// Port and (Edited) Sprites by MIDIMan
// Sprites are based off of an image on the now-offline SD2 website

freeslot(
	"sfx_sd2pse",
	"sfx_sd2ppn",
	"sfx_sd2pdi",
	"SPR_SDPT",
	"MT_SD2_PSEUDOTAILS",
	"S_SD2_PSEUDOTAILS_LOOK",
	"S_SD2_PSEUDOTAILS_CHASE",
	"S_SD2_PSEUDOTAILS_ATTACK1",
	"S_SD2_PSEUDOTAILS_ATTACK2",
	"S_SD2_PSEUDOTAILS_ATTACK3",
	"S_SD2_PSEUDOTAILS_PAIN1",
	"S_SD2_PSEUDOTAILS_PAIN2",
	"S_SD2_PSEUDOTAILS_DIE1",
	"S_SD2_PSEUDOTAILS_DIE_SCREAM",
	"S_SD2_PSEUDOTAILS_DIE2",
	"S_SD2_PSEUDOTAILS_DIE_FLICKIES"
	// No raise states, because they are only used in very rare instances
)

sfxinfo[sfx_sd2pse].caption = "Bye, Sonic!"
sfxinfo[sfx_sd2ppn].caption = "Ow!"
sfxinfo[sfx_sd2pdi].caption = "AHHHH!"

local function SD2_PainShootSkull(actor, var1, var2)
	if not (actor and actor.valid) then return end
	// Make sure the Pseudo-Flicky has been freeslotted before attempting to spawn it
	if not SD2_CheckFreeslot("MT_SD2_PSEUDOFLICKY")
		print("Unable to spawn MT_SD2_PSEUDOFLICKY!")
		return
	end
	
	local angle = actor.angle
	if var1 then angle = var1 end
	
	local prestep = 4*FRACUNIT + 3*(actor.info.radius + mobjinfo[MT_SD2_PSEUDOFLICKY].radius)/2
	
	local offset = {
		x = FixedMul(prestep, cos(angle)),
		y = FixedMul(prestep, sin(angle)),
		z = 8*FRACUNIT
	}
	
	local flicky = P_SpawnMobjFromMobj(actor, offset.x, offset.y, offset.z, MT_SD2_PSEUDOFLICKY)
	
	// Kill the flicky immediately if it can't move at the current location
	if not P_TryMove(flicky, flicky.x, flicky.y, false) then
		//P_DamageMobj(flicky, actor, actor, 10000)
		P_KillMobj(flicky, actor, actor)
		return
	end
	
	flicky.target = actor.target
	SD2_SkullAttack(flicky, 0, 0)
end

// Shoots a Pseudo-Flicky at the target
local function SD2_PainAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	SD2_PainShootSkull(actor, actor.angle, 0)
end

// Shoots three Pseudo-Flickies at the target
local function SD2_PainDie(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	SD2_Fall(actor, 0, 0)
	SD2_PainShootSkull(actor, actor.angle + ANGLE_90, 0)
	SD2_PainShootSkull(actor, actor.angle + ANGLE_180, 0)
	SD2_PainShootSkull(actor, actor.angle + ANGLE_270, 0)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_PSEUDOTAILS)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_PSEUDOTAILS)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_PSEUDOTAILS)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_PSEUDOTAILS_PAIN1,
		S_SD2_PSEUDOTAILS_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_PSEUDOTAILS_CHASE
	and mo.tics % 3 == 0 then
		SD2_Chase(mo, 0, 0)
	end
	
	if mo.state == S_SD2_PSEUDOTAILS_ATTACK1
	and mo.tics % 5 == 0 then
		A_FaceTarget(mo)
	end
end, MT_SD2_PSEUDOTAILS)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_PSEUDOTAILS)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_PSEUDOTAILS)

mobjinfo[MT_SD2_PSEUDOTAILS] = {
	//$Name Pseudo-Tails
	//$Sprite SDPTA1
	//$Category Sonic Doom 2
	doomednum = 173,
	spawnstate = S_SD2_PSEUDOTAILS_LOOK,
	spawnhealth = 12,
	seestate = S_SD2_PSEUDOTAILS_CHASE,
	seesound = sfx_sd2pse,
	reactiontime = 8,
	painstate = S_SD2_PSEUDOTAILS_PAIN1,
	painchance = 128,
	painsound = sfx_sd2ppn,
	missilestate = S_SD2_PSEUDOTAILS_ATTACK1,
	deathstate = S_SD2_PSEUDOTAILS_DIE1,
	deathsound = sfx_sd2pdi,
	speed = 8,
	radius = 31*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 400,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_FLOAT|MF_NOGRAVITY|MF_SPECIAL|MF_PUSHABLE
}

states[S_SD2_PSEUDOTAILS_LOOK] =	{SPR_SDPT,	A,	10,	A_RadarLook,	0,	0,	S_SD2_PSEUDOTAILS_LOOK}

states[S_SD2_PSEUDOTAILS_CHASE] =	{SPR_SDPT,	A|FF_ANIMATE,	18,	nil,	1,	6,	S_SD2_PSEUDOTAILS_CHASE}

states[S_SD2_PSEUDOTAILS_ATTACK1] =	{SPR_SDPT,	C,					5,	A_FaceTarget,	0,	0,	S_SD2_PSEUDOTAILS_ATTACK2}
states[S_SD2_PSEUDOTAILS_ATTACK2] =	{SPR_SDPT,	C|FF_FULLBRIGHT,	5,	A_FaceTarget,	0,	0,	S_SD2_PSEUDOTAILS_ATTACK3}
states[S_SD2_PSEUDOTAILS_ATTACK3] =	{SPR_SDPT,	C|FF_FULLBRIGHT,	0,	SD2_PainAttack,	0,	0,	S_SD2_PSEUDOTAILS_CHASE}

states[S_SD2_PSEUDOTAILS_PAIN1] =	{SPR_SDPT,	C,	6,	nil,	0,	0,	S_SD2_PSEUDOTAILS_PAIN2}
states[S_SD2_PSEUDOTAILS_PAIN2] =	{SPR_SDPT,	C,	6,	A_Pain,	0,	0,	S_SD2_PSEUDOTAILS_CHASE}

states[S_SD2_PSEUDOTAILS_DIE1] =			{SPR_SDPT,	D|FF_FULLBRIGHT,			8,	nil,			0,	0,	S_SD2_PSEUDOTAILS_DIE_SCREAM}
states[S_SD2_PSEUDOTAILS_DIE_SCREAM] =		{SPR_SDPT,	E|FF_FULLBRIGHT,			8,	A_Scream,		0,	0,	S_SD2_PSEUDOTAILS_DIE2}
states[S_SD2_PSEUDOTAILS_DIE2] =			{SPR_SDPT,	F|FF_FULLBRIGHT|FF_ANIMATE,	16,	nil,			1,	8,	S_SD2_PSEUDOTAILS_DIE_FLICKIES}
states[S_SD2_PSEUDOTAILS_DIE_FLICKIES] =	{SPR_SDPT,	H|FF_FULLBRIGHT|FF_ANIMATE,	16,	SD2_PainDie,	1,	8,	S_NULL}
