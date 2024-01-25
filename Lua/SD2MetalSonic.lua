// Sonic Doom 2 - Metal Sonic
// Ported by MIDIMan

freeslot(
	"SPR_SDMS",
	"sfx_sd2vse", // Borrowed from Freedoom
	"sfx_sd2vac", // Borrowed from Freedoom
	"sfx_sd2vtk", // Borrowed from Freedoom
	//"sfx_sd2vpn", // Replaced by sfx_s3k8b
	"sfx_sd2vdi", // Borrowed from Freedoom
	//"sfx_sd2fls", // Replaced by sfx_s3k43
	//"sfx_sd2flm", // Replaced by sfx_s3k48
	"SPR_SDFR",
	"MT_SD2_VILE_FIRE",
	"S_SD2_VILE_FIRE_START",
	"S_SD2_VILE_FIRE_BURN1",
	"S_SD2_VILE_FIRE_BURN2",
	"S_SD2_VILE_FIRE_CRACKLE1",
	"S_SD2_VILE_FIRE_BURN3",
	"S_SD2_VILE_FIRE_BURN4",
	"S_SD2_VILE_FIRE_BURN5",
	"S_SD2_VILE_FIRE_BURN6",
	"S_SD2_VILE_FIRE_BURN7",
	"S_SD2_VILE_FIRE_CRACKLE2",
	"S_SD2_VILE_FIRE_BURN8",
	"S_SD2_VILE_FIRE_BURN9",
	"S_SD2_VILE_FIRE_BURN10",
	"MT_SD2_METALSONIC",
	"S_SD2_METALSONIC_LOOK",
	"S_SD2_METALSONIC_CHASE",
	"S_SD2_METALSONIC_ATTACK_START",
	"S_SD2_METALSONIC_ATTACK1",
	"S_SD2_METALSONIC_ATTACK2",
	"S_SD2_METALSONIC_ATTACK3",
	"S_SD2_METALSONIC_ATTACK4",
	"S_SD2_METALSONIC_ATTACK5",
	"S_SD2_METALSONIC_ATTACK6",
	"S_SD2_METALSONIC_HEAL",
	"S_SD2_METALSONIC_PAIN1",
	"S_SD2_METALSONIC_PAIN2",
	"S_SD2_METALSONIC_DIE1",
	"S_SD2_METALSONIC_DIE_SCREAM",
	"S_SD2_METALSONIC_DIE_FALL",
	"S_SD2_METALSONIC_DIE2",
	"S_SD2_METALSONIC_DIE_STILL"
)

sfxinfo[sfx_sd2vse].caption = "Metal awakens"
sfxinfo[sfx_sd2vac].caption = "Metal roaming"
sfxinfo[sfx_sd2vtk].caption = "Metal summoning flames"
//sfxinfo[sfx_sd2vpn].caption = "Metal hurt"
sfxinfo[sfx_sd2vdi].caption = "Metal dead"
//sfxinfo[sfx_sd2fls].caption = "Flame ignite"
//sfxinfo[sfx_sd2flm].caption = "Flame crackle"

local function SD2_VileChase(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	if actor.movedir ~= DI_NODIR then
		local viletryx = actor.x + FixedMul(actor.info.speed*actor.scale, cos(actor.angle))
		local viletryy = actor.y + FixedMul(actor.info.speed*actor.scale, sin(actor.angle))
		
		local searchDist = 32*actor.scale*2
		local corpseHit
		
		// Check a specific "radius" around Metal Sonic's search point (using viletryx and viletryy)
		local corpseCheck = searchBlockmap("objects", function(archvile, corpse)
			if not (corpse and corpse.valid) then return end
			if not (corpse.flags & MF_ENEMY) then return end
			if corpse.tics ~= -1 then return end
			if not corpse.info.raisestate then return end
			
			// Only revive Sonic Doom 2 enemies
			if corpse.type ~= MT_SD2_GROUNDER_PISTOL
			and corpse.type ~= MT_SD2_GROUNDER_SHOTGUN
			and corpse.type ~= MT_SD2_GROUNDER_CHAINGUN
			and corpse.type ~= MT_SD2_COCONUTS
			and corpse.type ~= MT_SD2_OVASHORT
			and corpse.type ~= MT_SD2_OVASHORT_SHADOW
			and corpse.type ~= MT_SD2_OVARED
			and corpse.type ~= MT_SD2_OVAGRAY
			and corpse.type ~= MT_SD2_PSEUDOFLICKY
			and corpse.type ~= MT_SD2_BUZZBOMBER
			and corpse.type ~= MT_SD2_PSEUDOTAILS
			and corpse.type ~= MT_SD2_PSEUDOKNUCKLES
			and corpse.type ~= MT_SD2_PSEUDOSUPER then
				return
			end
			
			local maxDist = corpse.radius + archvile.radius
			
			if abs(corpse.x - viletryx) > maxDist or abs(corpse.y - viletryy) > maxDist then return end
			
			local check
			
			corpseHit = corpse
			corpseHit.momx = 0
			corpseHit.momy = 0
			
			// Functionality from the Boom source port (which SD2 was originally based off of)
			local height = corpseHit.height
			local radius = corpseHit.radius
			corpseHit.height = FixedMul(corpseHit.scale, corpseHit.info.height)
			corpseHit.radius = FixedMul(corpseHit.scale, corpseHit.info.radius)
			corpseHit.flags = $|MF_SOLID
			check = P_CheckPosition(corpseHit, corpseHit.x, corpseHit.y)
			corpseHit.height = height
			corpseHit.radius = radius
			corpseHit.flags = $ & ~MF_SOLID
			
			if not check then return end
			return true
		end, actor,
		viletryx - searchDist, viletryx + searchDist, 
		viletryy - searchDist, viletryy + searchDist)
		
		if not corpseCheck then
			local temp = actor.target
			actor.target = corpseHit
			A_FaceTarget(actor)
			actor.target = temp
			
			actor.state = S_SD2_METALSONIC_HEAL
			S_StartSound(corpseHit, sfx_pop)
			corpseHit.state = corpseHit.info.raisestate
			
			corpseHit.height = FixedMul(corpseHit.scale, corpseHit.info.height)
			corpseHit.radius = FixedMul(corpseHit.scale, corpseHit.info.radius)
			corpseHit.flags = corpseHit.info.flags
			corpseHit.health = corpseHit.info.spawnhealth
			corpseHit.target = nil
			return
		end
	end
	
	SD2_Chase(actor, var1, var2)
end

// There is a bug with A_VileTarget where it plays a sound, even when the
local function SD2_VileTarget(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	
	local fire = P_SpawnMobjFromMobj(actor.target, 0, 0, 0, MT_SD2_VILE_FIRE)
	
	actor.tracer = fire
	fire.target = actor
	fire.tracer = actor.target
	A_VileFire(fire, 0, 0)
end

local function SD2_VileAttack(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	A_FaceTarget(actor)
	
	if not P_CheckSight(actor, actor.target) then return end
	
	S_StartSound(actor, sfx_dmpain)
	P_DamageMobj(actor.target, actor, actor, 1)
	if actor.target.info.mass 
	and not (actor.target.player and actor.target.player.valid) then
		P_SetObjectMomZ(actor.target, 1000*FRACUNIT/actor.target.info.mass)
	else 
		P_SetObjectMomZ(actor.target, 10*FRACUNIT)
	end
	
	local angle = actor.angle
	local fire = actor.tracer
	
	if not (fire and fire.valid) then return end
	
	P_MoveOrigin(
		fire, 
		actor.target.x - FixedMul(24*actor.scale, cos(angle)), 
		actor.target.y - FixedMul(24*actor.scale, cos(angle)), 
		actor.target.z
	)
	
	P_RadiusAttack(fire, actor, 1, DMG_FIRE, true)
end

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_METALSONIC)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_METALSONIC)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_METALSONIC)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_METALSONIC_PAIN1,
		S_SD2_METALSONIC_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_METALSONIC_LOOK
	and mo.tics % 10 == 0 then
		A_RadarLook(mo)
	end
	
	if mo.state == S_SD2_METALSONIC_CHASE
	and mo.tics % 2 == 0 then
		SD2_VileChase(mo, 0, 0)
	end
	
	if mo.state == S_SD2_METALSONIC_ATTACK3
	and mo.tics % 8 == 0 then
		A_FaceTarget(mo)
	end
end, MT_SD2_METALSONIC)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_METALSONIC)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_METALSONIC)

mobjinfo[MT_SD2_METALSONIC] = {
	//$Name Metal Sonic (Archvile)
	//$Sprite SDMSA1D1
	//$Category Sonic Doom 2
	doomednum = 176,
	spawnstate = S_SD2_METALSONIC_LOOK,
	spawnhealth = 20,
	seestate = S_SD2_METALSONIC_CHASE,
	seesound = sfx_sd2vse,
	reactiontime = 8,
	painstate = S_SD2_METALSONIC_PAIN1,
	painchance = 10,
	painsound = sfx_s3k8b, // Originally sfx_sd2vpn
	missilestate = S_SD2_METALSONIC_ATTACK_START,
	deathstate = S_SD2_METALSONIC_DIE1,
	deathsound = sfx_sd2vdi,
	speed = 15,
	radius = 20*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 500,
	activesound = sfx_sd2vac,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_FLOAT|MF_NOGRAVITY|MF_SPECIAL|MF_PUSHABLE // Flying archviles?! Great...
}

states[S_SD2_METALSONIC_LOOK] =	{SPR_SDMS,	A|FF_ANIMATE,	20,	nil,	1,	10,	S_SD2_METALSONIC_LOOK}

states[S_SD2_METALSONIC_CHASE] =	{SPR_SDMS,	A|FF_ANIMATE,	24,	nil,	5,	4,	S_SD2_METALSONIC_CHASE}

states[S_SD2_METALSONIC_ATTACK_START] =	{SPR_SDMS,	G|FF_FULLBRIGHT,			0,	A_PlaySound,	sfx_sd2vtk,	0,	S_SD2_METALSONIC_ATTACK1}
states[S_SD2_METALSONIC_ATTACK1] =		{SPR_SDMS,	G|FF_FULLBRIGHT,			10,	A_FaceTarget,	0,			0,	S_SD2_METALSONIC_ATTACK2}
states[S_SD2_METALSONIC_ATTACK2] =		{SPR_SDMS,	H|FF_FULLBRIGHT,			8,	SD2_VileTarget,	0,			0,	S_SD2_METALSONIC_ATTACK3}
states[S_SD2_METALSONIC_ATTACK3] =		{SPR_SDMS,	I|FF_FULLBRIGHT|FF_ANIMATE,	40,	nil,			4,			8,	S_SD2_METALSONIC_ATTACK4}
states[S_SD2_METALSONIC_ATTACK4] =		{SPR_SDMS,	M|FF_FULLBRIGHT,			8,	A_FaceTarget,	0,			0,	S_SD2_METALSONIC_ATTACK5}
states[S_SD2_METALSONIC_ATTACK5] =		{SPR_SDMS,	M|FF_FULLBRIGHT,			8,	SD2_VileAttack,	0,			0,	S_SD2_METALSONIC_ATTACK6}
states[S_SD2_METALSONIC_ATTACK6] =		{SPR_SDMS,	M|FF_FULLBRIGHT,			20,	nil,			0,			0,	S_SD2_METALSONIC_CHASE}

states[S_SD2_METALSONIC_HEAL] =	{SPR_SDMS,	K|FF_FULLBRIGHT,	30,	nil,	0,	0,	S_SD2_METALSONIC_CHASE}

states[S_SD2_METALSONIC_PAIN1] =	{SPR_SDMS,	N,	5,	nil,	0,	0,	S_SD2_METALSONIC_PAIN2}
states[S_SD2_METALSONIC_PAIN2] =	{SPR_SDMS,	N,	5,	A_Pain,	0,	0,	S_SD2_METALSONIC_CHASE}

states[S_SD2_METALSONIC_DIE1] =			{SPR_SDMS,	O,	7,	nil,		0,	0,	S_SD2_METALSONIC_DIE_SCREAM}
states[S_SD2_METALSONIC_DIE_SCREAM] =	{SPR_SDMS,	O,	7,	A_Scream,	0,	0,	S_SD2_METALSONIC_DIE_FALL}
states[S_SD2_METALSONIC_DIE_FALL] =		{SPR_SDMS,	O,	7,	SD2_Fall,	0,	0,	S_SD2_METALSONIC_DIE2}
states[S_SD2_METALSONIC_DIE2] =			{SPR_SDMS,	O,	14,	nil,		0,	0,	S_SD2_METALSONIC_DIE_STILL}
states[S_SD2_METALSONIC_DIE_STILL] =	{SPR_SDMS,	P,	-1,	nil,		0,	0,	S_NULL}

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	if mo.tics % 2 == 0 then
		A_VileFire(mo, 0, 0)
	end
end, MT_SD2_VILE_FIRE)

mobjinfo[MT_SD2_VILE_FIRE] = {
	doomednum = -1,
	spawnstate = S_SD2_VILE_FIRE_START,
	spawnhealth = 1000,
	radius = 20*FRACUNIT,
	height = 16*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_NOGRAVITY//|MF_NOCLIP|MF_NOCLIPHEIGHT
}

states[S_SD2_VILE_FIRE_START] =		{SPR_SDFR,	A|FF_FULLBRIGHT,			2,	A_PlaySound,	sfx_s3k43,	0,	S_SD2_VILE_FIRE_BURN1}
states[S_SD2_VILE_FIRE_BURN1] =		{SPR_SDFR,	B|FF_FULLBRIGHT,			2,	nil,			0,			0,	S_SD2_VILE_FIRE_BURN2}
states[S_SD2_VILE_FIRE_BURN2] =		{SPR_SDFR,	A|FF_FULLBRIGHT|FF_ANIMATE,	4,	nil,			1,			2,	S_SD2_VILE_FIRE_CRACKLE1}
states[S_SD2_VILE_FIRE_CRACKLE1] =	{SPR_SDFR,	C|FF_FULLBRIGHT,			2,	A_PlaySound,	sfx_s3k48,	0,	S_SD2_VILE_FIRE_BURN3}
states[S_SD2_VILE_FIRE_BURN3] =		{SPR_SDFR,	B|FF_FULLBRIGHT|FF_ANIMATE,	8,	nil,			1,			2,	S_SD2_VILE_FIRE_BURN4}
states[S_SD2_VILE_FIRE_BURN4] =		{SPR_SDFR,	D|FF_FULLBRIGHT,			2,	nil,			0,			0,	S_SD2_VILE_FIRE_BURN5}
states[S_SD2_VILE_FIRE_BURN5] =		{SPR_SDFR,	C|FF_FULLBRIGHT|FF_ANIMATE,	8,	nil,			1,			2,	S_SD2_VILE_FIRE_BURN6}
states[S_SD2_VILE_FIRE_BURN6] =		{SPR_SDFR,	E|FF_FULLBRIGHT,			2,	nil,			0,			0,	S_SD2_VILE_FIRE_BURN7}
states[S_SD2_VILE_FIRE_BURN7] =		{SPR_SDFR,	D|FF_FULLBRIGHT|FF_ANIMATE,	8,	nil,			1,			2,	S_SD2_VILE_FIRE_CRACKLE2}
states[S_SD2_VILE_FIRE_CRACKLE2] =	{SPR_SDFR,	E|FF_FULLBRIGHT,			2,	A_PlaySound,	sfx_s3k48,	0,	S_SD2_VILE_FIRE_BURN8}
states[S_SD2_VILE_FIRE_BURN8] =		{SPR_SDFR,	F|FF_FULLBRIGHT,			2,	nil,			0,			0,	S_SD2_VILE_FIRE_BURN9}
states[S_SD2_VILE_FIRE_BURN9] =		{SPR_SDFR,	E|FF_FULLBRIGHT|FF_ANIMATE,	8,	nil,			1,			2,	S_SD2_VILE_FIRE_BURN10}
states[S_SD2_VILE_FIRE_BURN10] =	{SPR_SDFR,	G|FF_FULLBRIGHT|FF_ANIMATE,	8,	nil,			1,			2,	S_NULL}
