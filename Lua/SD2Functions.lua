// Sonic Doom 2 - Functions
// Some Code Ported by MIDIMan
// Special Thanks to Golden for the basis of the "SD2_CheckFreeslot" function

// Helper function to reset the MF_SPECIAL flag on an enemy when not in its pain state
rawset(_G, "SD2_ResetSpecialFlag", function(mo)
	if not (mo and mo.valid) then return end
	
	if not (mo.flags2 & MF2_FRET) then
		if (mo.flags & MF_SPECIAL) then mo.flags = $ & ~MF_SPECIAL end
		if mo.health > 0 then
			if not (mo.flags & MF_PUSHABLE) then mo.flags = $|MF_PUSHABLE end
		else
			// Attempts to fixes a bug where crushers don't quite work properly
			if (mo.flags & MF_PUSHABLE) then mo.flags = $ & ~MF_PUSHABLE end
		end
	end
end)

// Helper function to reset the MF2_FRET flag on an enemy when not in any of its pain states
rawset(_G, "SD2_EnemyPainCheck", function(mo, painStates)
	if not (mo and mo.valid) then return end
	if not painStates then painStates = {mo.painstate} end
	
	if (mo.flags2 & MF2_FRET) then
		// Check the painStates table to make sure the enemy's state does not equal any of the table's states
		for _, painState in ipairs(painStates) do
			if mo.state == painState then return end
		end
		
		if mo.sd2FretDelay then
			mo.sd2FretDelay = $-1
		else
			mo.flags2 = $ & ~MF2_FRET
		end
	end
end)

// If the player is in a state where they can attack enemies, allow them to hit them
rawset(_G, "SD2_EnemyMobjCollide", function(thing, tmthing)
	if not (thing and thing.valid
	and tmthing and tmthing.valid) then
		return
	end
	
	if tmthing.z + tmthing.momz <= thing.z + thing.height
	or thing.z <= tmthing.z + tmthing.height + tmthing.momz then
		// Fixes a bug where SD2 enemies can be pushed by other objects, 
		// causing them to continuously play their activesound if they get stuck inside each other
		if (thing.flags & MF_PUSHABLE) then thing.flags = $ & ~MF_PUSHABLE end
		
		if not (tmthing.player and tmthing.player.valid) then return end
		
		if P_PlayerCanDamage(tmthing.player, thing) then
			if not (thing.flags & MF_SPECIAL) then thing.flags = $|MF_SPECIAL end
		else
			if (thing.flags & MF_SPECIAL) then thing.flags = $ & ~MF_SPECIAL end
		end
	end
end)

rawset(_G, "SD2_CheckMissileSpawn", function(mo)
	if not (mo and mo.valid) then return end
	
	// Offset the missile's animation by a random value
	mo.tics = $ - (P_RandomByte() & 3)
	if mo.tics < 1 then mo.tics = 1 end
	
	P_MoveOrigin(mo, mo.x + mo.momx/2, mo.y + mo.momy/2, mo.z + mo.momz/2)
	
	if not P_TryMove(mo, mo.x, mo.y, false) then P_ExplodeMissile(mo) end
end)

rawset(_G, "SD2_SpawnMissile", function(source, dest, motype, targAngle, zOffset)
	if not (source and source.valid
	and dest and dest.valid)
		return
	end
	
	if not zOffset then zOffset = 32*FRACUNIT end
	
	local bullet = P_SpawnMobjFromMobj(source, 0, 0, zOffset, motype)
	
	if bullet.info.seesound then S_StartSound(bullet, bullet.info.seesound) end
	
	bullet.target = source
	local angle = R_PointToAngle2(source.x, source.y, dest.x, dest.y)
	if targAngle then angle = targAngle end
	
	// This will probably not be implemented in SRB2TP, but I could be wrong
	if dest.sd2Shadow then
		angle = $ + (P_RandomByte() - P_RandomByte())<<19
	end
	
	bullet.angle = angle
	P_InstaThrust(bullet, bullet.angle, FixedMul(bullet.scale, bullet.info.speed))
	
	local dist = FixedHypot(dest.x - source.x, dest.y - source.y)//P_AproxDistance(dest.x - source.x, dest.y - source.y)
	if bullet.info.speed then dist = $ / bullet.info.speed end
	
	if dist < 1 then dist = 1 end
	
	if zOffset == 32*FRACUNIT then zOffset = 0 end
	bullet.momz = (dest.z - source.z - (P_MobjFlip(source)*FixedMul(zOffset, source.scale))) / dist
	//bullet.momz = (dest.z - source.z) / dist
	SD2_CheckMissileSpawn(bullet)
	
	return bullet
end)

// Thanks to Golden on the SRB2 Discord for the basis of this function
rawset(_G, "SD2_CheckFreeslot", function(item)
    local function CheckItem(item)
        return _G[item]
    end
    return pcall(CheckItem, item)
end)

rawset(_G, "SD2_SpawnPuff", function(mo, range)
	if not (mo and mo.valid) then return end
	if not range then range = MISSILERANGE end
	
	local zOffset = (P_RandomByte() - P_RandomByte())<<10
	
	local puff = P_SpawnMobjFromMobj(mo, 0, 0, zOffset, MT_SD2_PUFF)
	P_SetObjectMomZ(puff, FRACUNIT)
	puff.tics = $-(P_RandomByte()&3)
	
	if puff.tics < 1 then puff.tics = 1 end
	
	if range <= MELEERANGE then puff.state = S_SD2_PUFF_ANIMATE end
end)

rawset(_G, "SD2_MapThingSpawn", function(mo, mthing)
	if not (mo and mo.valid) then return end
	
	// Offset the enemy's looking animation
	if mo.tics > 0 then mo.tics = 1 + (P_RandomByte() % mo.tics) end
end)

rawset(_G, "SD2_MobjLineCollide", function(mo, line)
	if not (mo and mo.valid
	and line and line.valid) then
		return
	end
	
	P_LinedefExecute(line.tag, mo)
end)

local function SD2_EnemyDamage(target, inflictor, source, damage, damagetype, painstate)
	if not (target and target.valid) then return end
	
	if damagetype and (damagetype & DMG_DEATHMASK) then
		target.health = 0
	else
		target.health = $-damage
	end
	
	if target.health <= 0 then
		P_KillMobj(target, inflictor, source, damagetype)
		return true
	end
	
	if painstate then 
		target.state = target.info.painstate
	elseif target.state == target.info.spawnstate and target.info.seestate then
		target.state = target.info.seestate
	end
	
	target.reactiontime = 0
	
	if source and source.valid and source ~= target then
		target.target = source
	end
	
	return true
end

rawset(_G, "SD2_MobjDamage", function(target, inflictor, source, damage, damagetype)
	if not (target and target.valid) then return end
	
	if inflictor and inflictor.valid then
		if (inflictor.flags2 & MF2_AUTOMATIC) then
			if target.info.spawnhealth <= 12 then damage = 2 end
		end
		if (inflictor.flags2 & MF2_RAILRING) then damage = 6 end
		if (inflictor.flags2 & MF2_SCATTER) then damage = 3 end
		if (inflictor.flags2 & MF2_EXPLOSION) then
			damage = 7
			if SD2_CheckFreeslot("MT_EGGBOMB") and inflictor.type == MT_EGGBOMB then damage = 12 end
			if inflictor.type == MT_THROWNGRENADE then damage = 4 end
			
			local dist = FixedHypot(FixedHypot(target.x - inflictor.x, target.y - inflictor.y), target.z - inflictor.z)
			dist = $ - target.radius
			//print(dist/FRACUNIT)
			dist = $ - inflictor.radius
			//print(dist/FRACUNIT)
			
			if dist < 0 then dist = 0 end
			
			local maxDist = FixedMul(inflictor.info.painchance, inflictor.scale)
			if not maxDist then maxDist = 1 end
			
			local enemyDist = maxDist - dist
			if enemyDist < 1 then enemyDist = 1 end
			
			damage = (FixedRound($*FixedDiv(enemyDist, maxDist)))/FRACUNIT
			if damage < 1 then damage = 1 end
			//print(damage)
		end
	end
	
	// Imitate Doom's painchance
	if P_RandomByte() >= target.info.painchance then
		if target.health - damage > 1 then
			target.sd2FretDelay = 6
			if target.info.spawnhealth > 12 then target.sd2FretDelay = $+2 end
			target.flags2 = $|MF2_FRET
		end
		
		SD2_EnemyDamage(target, inflictor, source, damage, damagetype, false)
		
		return true
	end
	
	// Attempt to stop any sounds the target is playing
	S_StopSound(target)
	
	if target.health - damage > 0 then
		target.flags2 = $|MF2_FRET
	end
	
	SD2_EnemyDamage(target, inflictor, source, damage, damagetype, true)
	
	return true
end)

rawset(_G, "SD2_MobjDeath", function(target, inflictor, source, damagetype)
	if not (target and target.valid) then return end
	
	local item = MT_RING
	local mo
	
	// Attempt to stop any sounds the target is playing
	S_StopSound(target)
	
	//target.flags = $ & ~(MF_SHOOTABLE|MF_FLOAT|MF_NOCLIPHEIGHT)
	target.flags = $ & ~(MF_NOCLIP|MF_NOCLIPHEIGHT|MF_SOLID|MF_PUSHABLE)
	//target.flags2 = $ & ~MF2_SKULLFLY
	
	if not SD2_CheckFreeslot("MT_SD2_PSEUDOFLICKY") or target.type ~= MT_SD2_PSEUDOFLICKY then
		target.flags = $ & ~MF_NOGRAVITY
	end
	
	target.height = $/4
	
	//if target.health < -target.info.spawnhealth and target.info.xdeathstate
		//target.state = target.info.xdeathstate
	//else
		target.state = target.info.deathstate
	//end
	
	if not (target and target.valid) return true end
	
	target.tics = $ - P_RandomByte() & 3
	if target.tics < 1 then target.tics = 1 end
	
	if SD2_CheckFreeslot("MT_SD2_GROUNDER_PISTOL") and target.type == MT_SD2_GROUNDER_PISTOL then
		item = MT_RING
	elseif SD2_CheckFreeslot("MT_SD2_GROUNDER_SHOTGUN") and target.type == MT_SD2_GROUNDER_SHOTGUN then
		item = MT_SCATTERPICKUP
	elseif SD2_CheckFreeslot("MT_SD2_GROUNDER_CHAINGUN") and target.type == MT_SD2_GROUNDER_CHAINGUN then
		item = MT_AUTOPICKUP
	else
		return true
	end
	
	mo = P_SpawnMobjFromMobj(target, 0, 0, 0, item)
	
	return true
end)
