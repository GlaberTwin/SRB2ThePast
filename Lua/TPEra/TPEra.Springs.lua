------------------------------
--SRB2:TP Era Skins: Springs-- // Barrels O' Fun
------------------------------

sfxinfo[sfx_s24c].caption = "Spring"

local XMAS = 1
local DEMO123 = 2
local DEMO4 = 4

---------------Table Contents---------------
-- Skin # {Idle, Bounce Anim, --------------
-- Vertical Momentum, Horizontal Momentum,-- 
-- Sound, Era Mode} ------------------------
--------------------------------------------

//BLUE
local bluespring = {
//2.2
{S_BLUESPRING, S_BLUESPRING2,
11*FRACUNIT, 0,
sfx_spring, 0},

//FINALDEMO-2.1
{S_OLD_BLUESPRING, S_OLD_BLUESPRING2,
11*FRACUNIT, 0,
sfx_s24c, 0}
}

local bluediag = {
//2.2
{S_BDIAG1, S_BDIAG2,
11*FRACUNIT, 11*FRACUNIT,
sfx_spring, 0},

//2.0-2.1
{S_OLD_BDIAG1, S_OLD_BDIAG2,
11*FRACUNIT, 11*FRACUNIT,
sfx_s24c, 0}
}




//YELLOW
local yellowspring = {
//2.2
{S_YELLOWSPRING, S_YELLOWSPRING2, 
20*FRACUNIT, 0,
sfx_spring, 0},

//FINALDEMO-2.1
{S_OLD_YELLOWSPRING, S_OLD_YELLOWSPRING2, 
20*FRACUNIT, 0,
sfx_s24c, 0},

//XMAS-DEMO
{S_OLD_YELLOWSPRING, S_OLD_YELLOWSPRING2,
18*FRACUNIT, 0,
sfx_s24c, DEMO4},
}

local yellowdiag = {
//2.2
{S_YDIAG1, S_YDIAG2, 
20*FRACUNIT, 20*FRACUNIT, 
sfx_spring, 0},

//FINALDEMO-2.1
{S_OLD_YDIAG1, S_OLD_YDIAG2, 
20*FRACUNIT, 20*FRACUNIT, 
sfx_s24c, 0},

//DEMO4 //Same as Demo123 except you face the direction you're sprung.
{S_OLD_YDIAG1, S_OLD_YDIAG2, 
18*FRACUNIT, 30*FRACUNIT,
sfx_s24c, 0},

//DEMO123
{S_OLD_YDIAG1, S_OLD_YDIAG2, 
18*FRACUNIT, 30*FRACUNIT,
sfx_s24c, DEMO123},

//XMAS 
{S_OLD_YDIAG1, S_OLD_YDIAG2,
18*FRACUNIT, 3*512000, 
sfx_s24c, XMAS}
}




//RED
local redspring = {
//2.2
{S_REDSPRING, S_REDSPRING2, 
32*FRACUNIT, 0,
sfx_spring, 0},

//FINALDEMO-2.1
{S_OLD_REDSPRING, S_OLD_REDSPRING2, 
32*FRACUNIT, 0,
sfx_s24c, 0},

//XMAS-DEMO
{S_OLD_REDSPRING, S_OLD_REDSPRING2,
30*FRACUNIT, 0,
sfx_s24c, DEMO4},
}

local reddiag = {
//2.2
{S_RDIAG1, S_RDIAG2, 
32*FRACUNIT, 32*FRACUNIT, 
sfx_spring, 0},

//FINALDEMO-2.1
{S_OLD_RDIAG1, S_OLD_RDIAG2, 
32*FRACUNIT, 32*FRACUNIT, 
sfx_s24c, 0},
}

----------------
--Do The Stuff--
----------------
local function SetItemSkin(m,mt,list)

	local itemskin = mt.extrainfo
	if udmf
		if m.info.doomednum < 555
			itemskin = mt.args[0]
		else
			itemskin = mt.args[1] //Diagonals have an Arg beforehand, so offset
		end
	end

	if m.itemskin == nil or m.itemskin == 0
		m.itemskin = itemskin
	end

	if m.itemskin and m.itemskin <= #list
		m.skintable = list
		if m.state == mobjinfo[m.type].spawnstate
			m.state = list[min(m.itemskin,#list)][1]
		end
	else
		m.itemskin = 0
		if leveltime == 0 	-- Only update once at map load.
			SRB2TP_UpdateObject(m)
		else				-- If any are spawned after that update them.
			SRB2TP_UpdateObject(m,true)
		end
		m.state = mobjinfo[m.type].spawnstate
	end
end

addHook("MapThingSpawn", function(m,mt) 
SetItemSkin(m,mt,bluespring)
end, MT_BLUESPRING)

addHook("MapThingSpawn", function(m,mt) 
SetItemSkin(m,mt,bluediag)
end, MT_BLUEDIAG)

addHook("MapThingSpawn", function(m,mt) 
SetItemSkin(m,mt,yellowspring)
end, MT_YELLOWSPRING)

addHook("MapThingSpawn", function(m,mt) 
SetItemSkin(m,mt,yellowdiag)
end, MT_YELLOWDIAG)

addHook("MapThingSpawn", function(m,mt) 
SetItemSkin(m,mt,redspring)
end, MT_REDSPRING)

addHook("MapThingSpawn", function(m,mt) 
SetItemSkin(m,mt,reddiag)
end, MT_REDDIAG)

local function L_InstaThrustEvenIn2D(mo, angle, move)//Why the hell hasn't this been exposed yet?
	mo.momx = FixedMul(move, cos(angle))
	mo.momy = FixedMul(move, sin(angle))
end

local function L_ThrustEvenIn2D(mo, angle, move)
	mo.momx = $ + FixedMul(move, cos(angle))
	mo.momy = $ + FixedMul(move, sin(angle))
end

// Stripped down version of current P_DoSpring with modifiers to make the spring work more like in Demo/XMAS
local function P_RetroDoSpring(spring, object, mode) 
	local vertispeed = spring.info.mass
	local horizspeed = spring.info.damage
	local strong = 0

	// Object was already sprung this tic
	if (object.eflags & MFE_SPRUNG)
		return
	end

	// Spectators don't trigger springs.
	if (object.player and object.player.spectator)
		return
	end

	// "Even in Death" is a song from Volume 8, not a command.
	if (spring.health == 0 or object.health == 0)
		return
	end

	// Does nothing?
	if (vertispeed == 0 and horizspeed == 0)
		return
	end
	
	if (object.player.powers[pw_strong] & STR_SPRING)
			strong = 1
	end

	if (spring.eflags & MFE_VERTICALFLIP)
		vertispeed = $*-1
	end

	if strong
	
		if (horizspeed)
			horizspeed = FixedMul(horizspeed, (4*FRACUNIT)/3)
		end
		if (vertispeed)
			vertispeed = FixedMul(vertispeed, (6*FRACUNIT)/5) // aprox square root of above
		end
	end

	object.eflags = $ | MFE_SPRUNG
	spring.flags = $ &~ (MF_SPRING|MF_SPECIAL) // De-solidify	

	if (object.player)
		object.player.pflags = $ &~ PF_APPLYAUTOBRAKE

		object.player.powers[pw_justsprung] = 15
		if (horizspeed)
			object.player.powers[pw_noautobrake] = ((horizspeed*TICRATE)>>(FRACBITS+3))/9 // TICRATE at 72*FRACUNIT
		else
			if (abs(object.player.rmomx) > object.scale 
			or abs(object.player.rmomy) > object.scale)
				object.player.drawangle = R_PointToAngle2(0, 0, object.player.rmomx, object.player.rmomy)
			end

			if (P_MobjFlip(object) == P_MobjFlip(spring))
				object.player.powers[pw_justsprung] = $ | (1<<15)
			end
		end
//#endif
	end

	if (horizspeed and vertispeed)
		object.momx = 0
		object.momy = 0
		if !mode & 1 -- XMAS does not snap you to spring center.
			local eraInfo = SRB2TP_GetEraInfo()
			if eraInfo.tweaks & 32  then 
				P_MoveOrigin(object, spring.x, spring.y, object.z) -- Pre-Final Demo automatically sets your position to a spring without checking
			else
				P_TryMove(object, spring.x, spring.y, true)
			end
		end
	end

	if !mode & 1 -- XMAS does not snap you to spring center.
	
		if (vertispeed > 0)
			object.z = spring.z + spring.height + 1
		elseif (vertispeed < 0)
			object.z = spring.z - object.height - 1
		end
	end

	if (vertispeed)
		object.momz = FixedMul(vertispeed,FixedSqrt(FixedMul(object.scale, spring.scale)))
	end

	if (horizspeed)
		if mode & 1 -- XMAS Uses Thrust not InstaThrust
		L_ThrustEvenIn2D(object, spring.angle, FixedMul(horizspeed,FixedSqrt(FixedMul(object.scale, spring.scale))))
		else
		L_InstaThrustEvenIn2D(object, spring.angle, FixedMul(horizspeed,FixedSqrt(FixedMul(object.scale, spring.scale))))
		end
	end


	// Re-solidify
	spring.flags = $|(spring.info.flags & (MF_SPRING|MF_SPECIAL))

	if (object.player)

		local pflags
		local secondjump
		local washoming

		if (horizspeed) and not (mode & 3) //XMAS and DEMO123 do not change your facing angle.
			object.angle = spring.angle
			object.player.drawangle = spring.angle
		end

		if (object.player.pflags & PF_GLIDING)
			object.state = S_PLAY_FALL
		end

		local wasSpindashing = (object.player.dashspeed > 0) and (object.player.charability2 == CA2_SPINDASH)

		pflags = object.player.pflags & (PF_STARTJUMP | PF_JUMPED | PF_NOJUMPDAMAGE | PF_SPINNING | PF_THOKKED | PF_BOUNCING) // I still need these.

		if (wasSpindashing) // Ensure we're in the rolling state, and not spindash.
			object.state = S_PLAY_ROLL
		end

		if (object.player.charability == CA_GLIDEANDCLIMB and object.player.skidtime and (pflags & PF_JUMPED))
			object.player.skidtime = 0 // No skidding should be happening, either.
			pflags = $ &~PF_JUMPED
		end
	
		secondjump = object.player.secondjump
		washoming = object.player.homing
		P_ResetPlayer(object.player)

		if (vertispeed == 0)
		
			if (pflags & (PF_JUMPED|PF_SPINNING))
			
				object.player.pflags = $ | pflags
				object.player.secondjump = secondjump
			
			elseif (object.player.dashmode >= DASHMODE_THRESHOLD)
				object.state = S_PLAY_DASH
			elseif (P_IsObjectOnGround(object))

				if horizspeed >= FixedMul(object.player.runspeed, object.scale)
					object.state = S_PLAY_RUN
				else
					object.state = S_PLAY_WALK	
				end

			else

				if object.momz > 0
					object.state = S_PLAY_SPRING
				else
					object.state = S_PLAY_FALL
				end

			end

		elseif (P_MobjFlip(object)*vertispeed > 0)
			object.state = S_PLAY_SPRING
		else
			object.state = S_PLAY_FALL
		end

	end

	if spring.state < spring.info.raisestate
	
		
		spring.state = spring.info.raisestate

		if (strong)
		
--			if (object.player.charability == CA_TWINSPIN or object.player.charability2 == CA2_MELEE)
--				P_TwinSpinRejuvenate(object.player, (object.player.charability == CA_TWINSPIN ? object.player.thokitem : object.player.revitem))
			S_StartSound(object, sfx_sprong) // strong spring. sprong.
		end

	end

end

local function SpringItemSkin(m,tm)
	if (m.z <= tm.z+tm.height and m.z+m.height >= tm.z) -- Height Check
	and ( (tm.player and tm.health) or tm.type == MT_ROLLOUTROCK or tm.flags & MF_PUSHABLE ) -- Only these things activate springs
		if m.skintable
			m.info.raisestate 	= m.skintable[m.itemskin][2]
			m.info.mass			= m.skintable[m.itemskin][3]
			m.info.damage		= m.skintable[m.itemskin][4]
			m.info.painsound	= m.skintable[m.itemskin][5]
			m.info.meleestate 	= m.skintable[m.itemskin][6] -- New Variable to Decide P_DoSpring.
		else 
			--SRB2TP_ChangeObjects(nil,m.type)
			SRB2TP_UpdateObject(m,true)
		end
			if m.info.meleestate != 0
				if (P_RetroDoSpring(m,tm,m.info.meleestate))
					return false
				end
				return true
			end		

	end
end

addHook("MobjCollide", SpringItemSkin, MT_BLUESPRING)
addHook("MobjCollide", SpringItemSkin, MT_BLUEDIAG)
addHook("MobjCollide", SpringItemSkin, MT_YELLOWSPRING)
addHook("MobjCollide", SpringItemSkin, MT_YELLOWDIAG)
addHook("MobjCollide", SpringItemSkin, MT_REDSPRING)
addHook("MobjCollide", SpringItemSkin, MT_REDDIAG)


addHook("MapThingSpawn", function(m,mt)
if m.info.doomednum >= 546
and m.info.doomednum <= 549
//m.colorized = true
//m.color = SKINCOLOR_CRIMSON
//m.renderflags = RF_FULLBRIGHT
print("Thing #"..#mt.." is using a deprecated spring object ("..m.info.doomednum.."); replace with regular spring equivalent.")
end
end)




