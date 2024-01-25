// Sonic Doom 2 - Pseudo Flicky
// Port and (Edited) Sprites by MIDIMan
// Sprites are based off of an image on the now-offline SD2 website

freeslot(
	"sfx_sd2ftk",
	"SPR_SDFL",
	"MT_SD2_PSEUDOFLICKY",
	"S_SD2_PSEUDOFLICKY_LOOK",
	"S_SD2_PSEUDOFLICKY_CHASE",
	"S_SD2_PSEUDOFLICKY_ATTACK1",
	"S_SD2_PSEUDOFLICKY_ATTACK2",
	"S_SD2_PSEUDOFLICKY_ATTACK3",
	"S_SD2_PSEUDOFLICKY_ATTACK4",
	"S_SD2_PSEUDOFLICKY_PAIN1",
	"S_SD2_PSEUDOFLICKY_PAIN2",
	"S_SD2_PSEUDOFLICKY_DIE",
	"S_SD2_PSEUDOFLICKY_DIE_SCREAM",
	"S_SD2_PSEUDOFLICKY_DIE2",
	"S_SD2_PSEUDOFLICKY_DIE_FALL",
	"S_SD2_PSEUDOFLICKY_DIE3"
)

sfxinfo[sfx_sd2ftk].caption = "Chirp"

rawset(_G, "SD2_SkullAttack", function(actor, var1, var2)
	if not (actor and actor.valid) then return end
	if not (actor.target and actor.target.valid) then return end
	
	local speed = 20*actor.scale
	
	local dest = actor.target
	actor.flags2 = $|MF2_SKULLFLY
	
	S_StartSound(actor, actor.info.attacksound)
	A_FaceTarget(actor)
	P_InstaThrust(actor, actor.angle, speed)
	local dist = FixedHypot(dest.x - actor.x, dest.y - actor.y)//P_AproxDistance(dest.x - actor.x, dest.y - actor.y)
	dist = $ / speed
	
	if dist < 1 then dist = 1 end
	actor.momz = (dest.z + (dest.height/2) - actor.z) / dist
end)

addHook("MapThingSpawn", SD2_MapThingSpawn, MT_SD2_PSEUDOFLICKY)
addHook("MobjLineCollide", SD2_MobjLineCollide, MT_SD2_PSEUDOFLICKY)
addHook("MobjCollide", SD2_EnemyMobjCollide, MT_SD2_PSEUDOFLICKY)

addHook("MobjMoveCollide", function(tmthing, thing)
	if not (tmthing and tmthing.valid
	and thing and thing.valid
	and (thing.flags & MF_SHOOTABLE)) then
		return
	end
	
	// If the flicky's bounding box across the z-axis goes over or below its target, 
	// don't collide with the target
	if tmthing.z > thing.z + thing.height
	or thing.z > tmthing.z + tmthing.height then
		return
	end
	
	// Attempt to go through the target if it is a player in a damaging state
	if (thing.player and thing.player.valid and P_PlayerCanDamage(thing.player, tmthing)) then 
		return false
	end
	
	if (tmthing.flags2 & MF2_SKULLFLY) then
		P_DamageMobj(thing, tmthing, tmthing, 1)
		
		tmthing.flags2 = $ & ~MF2_SKULLFLY
		tmthing.momx = 0
		tmthing.momy = 0
		tmthing.momz = 0
		
		// Fixes a bug where the Pseudo-Flicky became intangible when attacking a player with an Armageddon Shield
		if tmthing.health > 0 then tmthing.state = tmthing.info.spawnstate end
		
		return true
	end
end, MT_SD2_PSEUDOFLICKY)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) then return end
	
	SD2_EnemyPainCheck(mo, {
		S_SD2_PSEUDOFLICKY_PAIN1,
		S_SD2_PSEUDOFLICKY_PAIN2
	})
	
	SD2_ResetSpecialFlag(mo)
	
	if mo.state == S_SD2_PSEUDOFLICKY_LOOK and mo.tics % 10 == 0 then
		A_RadarLook(mo, 0, 0)
	end
	
	if mo.state == S_SD2_PSEUDOFLICKY_CHASE and mo.tics % 6 == 0 then
		SD2_Chase(mo, 0, 0)
	end
end, MT_SD2_PSEUDOFLICKY)

addHook("MobjDamage", SD2_MobjDamage, MT_SD2_PSEUDOFLICKY)
addHook("MobjDeath", SD2_MobjDeath, MT_SD2_PSEUDOFLICKY)

mobjinfo[MT_SD2_PSEUDOFLICKY] = {
	//$Name Pseudo-Flicky
	//$Sprite SDFLA1
	//$Category Sonic Doom 2
	doomednum = 169,
	spawnstate = S_SD2_PSEUDOFLICKY_LOOK,
	spawnhealth = 3,
	seestate = S_SD2_PSEUDOFLICKY_CHASE,
	reactiontime = 8,
	attacksound = sfx_sd2ftk,
	painstate = S_SD2_PSEUDOFLICKY_PAIN1,
	painchance = 256,
	painsound = sfx_s3k8b,
	missilestate = S_SD2_PSEUDOFLICKY_ATTACK1,
	deathstate = S_SD2_PSEUDOFLICKY_DIE,
	deathsound = sfx_sd2frx,
	speed = 8,
	radius = 16*FRACUNIT,
	height = 56*FRACUNIT,
	mass = 50,
	damage = 3,
	activesound = sfx_s3k78,
	flags = MF_SOLID|MF_ENEMY|MF_SHOOTABLE|MF_FLOAT|MF_NOGRAVITY|MF_SPECIAL|MF_PUSHABLE
}

states[S_SD2_PSEUDOFLICKY_LOOK] =	{SPR_SDFL,	A|FF_ANIMATE|FF_FULLBRIGHT,	20,	nil,	1,	10,	S_SD2_PSEUDOFLICKY_LOOK}

states[S_SD2_PSEUDOFLICKY_CHASE] =	{SPR_SDFL,	A|FF_ANIMATE|FF_FULLBRIGHT,	12,	nil,	1,	6,	S_SD2_PSEUDOFLICKY_CHASE}

states[S_SD2_PSEUDOFLICKY_ATTACK1] =	{SPR_SDFL,	A|FF_FULLBRIGHT,	10,	A_FaceTarget,		0,	0,	S_SD2_PSEUDOFLICKY_ATTACK2}
states[S_SD2_PSEUDOFLICKY_ATTACK2] =	{SPR_SDFL,	B|FF_FULLBRIGHT,	4,	SD2_SkullAttack,	0,	0,	S_SD2_PSEUDOFLICKY_ATTACK3}
states[S_SD2_PSEUDOFLICKY_ATTACK3] =	{SPR_SDFL,	A|FF_FULLBRIGHT,	4,	nil,				0,	0,	S_SD2_PSEUDOFLICKY_ATTACK4}
states[S_SD2_PSEUDOFLICKY_ATTACK4] =	{SPR_SDFL,	B|FF_FULLBRIGHT,	4,	nil,				0,	0,	S_SD2_PSEUDOFLICKY_ATTACK3}

states[S_SD2_PSEUDOFLICKY_PAIN1] =	{SPR_SDFL,	A|FF_FULLBRIGHT,	3,	nil,	0,	0,	S_SD2_PSEUDOFLICKY_PAIN2}
states[S_SD2_PSEUDOFLICKY_PAIN2] =	{SPR_SDFL,	A|FF_FULLBRIGHT,	3,	A_Pain,	0,	0,	S_SD2_PSEUDOFLICKY_CHASE}

states[S_SD2_PSEUDOFLICKY_DIE] =		{SPR_SDXP,	A|FF_FULLBRIGHT,	6,	nil,		0,	0,	S_SD2_PSEUDOFLICKY_DIE_SCREAM}
states[S_SD2_PSEUDOFLICKY_DIE_SCREAM] =	{SPR_SDXP,	B|FF_FULLBRIGHT,	6,	A_Scream,	0,	0,	S_SD2_PSEUDOFLICKY_DIE2}
states[S_SD2_PSEUDOFLICKY_DIE2] =		{SPR_SDXP,	C|FF_FULLBRIGHT,	6,	nil,		0,	0,	S_SD2_PSEUDOFLICKY_DIE_FALL}
states[S_SD2_PSEUDOFLICKY_DIE_FALL] =	{SPR_SDXP,	D|FF_FULLBRIGHT,	6,	SD2_Fall,	0,	0,	S_SD2_PSEUDOFLICKY_DIE3}
states[S_SD2_PSEUDOFLICKY_DIE3] =		{SPR_SDXP,	E|FF_ANIMATE,		12,	nil,		1,	6,	S_NULL}
