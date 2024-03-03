
local TP_NODROWNING 	= 1		// Infinite Air (Ween)
local TP_XMASWATER 		= 2		// Slow and Sloshy Water, Bloopy Sounds, No Jump Abilities, Green Water Fade
local TP_WEENWATER 		= 3     // Water Fade only checks view height + XMAS Water & No Drowning
local TP_DEMOWATER 		= 4		// Slow Movement, Regular Gravity, Surface Ability Speeds, Blue Water Fade
local TP_DEMO1WATER		= 6		// Slow and Sloshy Water, Bloopy Sounds,Surface Ability Speeds, Blue Water Fade
local TP_SHALLOWSPRING 	= 8    	// Acknowledge surfacing while Sprung in shallow water
local TP_BUBBLESOUNDS 	= 16	// Bubbles Make Sounds
local TP_SPRINGCOLLIDE 	= 32	// Touch Springs if you would've otherwise if you didn't hit a wall
local TP_NOSNEAKERMUSIC = 64	// No Speed Shoes Music
local TP_CONVEYORSPEED	= 128	// Spinning on a Conveyor builds momentum
local TP_MATCHSUPER		= 256	// Power Stones allow you to go super instead of granting Invincibility+Shoes

//Recreations of early version quirks

-----------------------
--Hacky Water Garbage-- // Barrels O' Fun
-----------------------

addHook("PreThinkFrame", do for p in players.iterate()
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo.tweaks then return end
	if p and p.valid
		p.dx = p.mo.x
		p.dy = p.mo.y
		p.dz = p.mo.z
		p.dmomz = p.mo.momz
		p.prevwatertop = p.mo.watertop
		p.preveflags = p.mo.eflags
	end
end end)


addHook("PlayerThink", function(p)
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo or not eraInfo.tweaks then return end

	if eraInfo.tweaks & TP_NODROWNING
		p.powers[pw_underwater] = 0
	end


	if p.mo.eflags & MFE_SPRUNG then
//Just throw stuff at the wall until it works.
		if eraInfo.tweaks & TP_SHALLOWSPRING
		and ((p.prevwatertop != p.mo.watertop
		and p.prevwatertop > p.mo.z-(900*FRACUNIT)
		or (p.mo.momz == p.dmomz and (p.prevwatertop == p.mo.watertop
		or (p.prevwatertop < p.mo.watertop) and p.mo.watertop > p.mo.z-(900*FRACUNIT))))
		and !p.mo.eflags & MFE_UNDERWATER) 
//Give the Boost if Demo 4 or Final Demo 1.01-1.08
			if !eraInfo.tweaks & TP_DEMOWATER
				p.mo.momz = FixedMul($,FixedDiv(780*FRACUNIT,457*FRACUNIT))
			end

//Spawn the Splish
			local splish = P_SpawnMobj(p.dx,p.dy,p.prevwatertop,MT_SPLISH)
			S_StartSound(p.mo,sfx_splish)
			local bubblecount = min(FixedDiv(abs(p.dmomz), p.mo.scale)>>(FRACBITS-1),128)

			// Create tons of bubbles

			for i=1,bubblecount do
			
				// P_RandomByte()s are called individually to allow consistency
				// across various compilers, since the order of function calls
				// in C is not part of the ANSI specification.
				local prandom = {}
				prandom[0] = P_RandomByte()
				prandom[1] = P_RandomByte()
				prandom[2] = P_RandomByte()
				prandom[3] = P_RandomByte()

				local bubbletype = MT_SMALLBUBBLE
				if (not (prandom[0] & 0x3)) // medium bubble chance up to 64 from 32
					bubbletype = MT_MEDIUMBUBBLE
				end

				local dirx = 1
				local diry = 1

				if (prandom[0]&0x80)
					dirx = -1
				end
				if (prandom[0]&0x40)
					diry = -1
				end

				local bubble = P_SpawnMobj(
					p.dx + FixedMul((prandom[1]<<(FRACBITS-3)) * dirx, p.mo.scale),
					p.dy + FixedMul((prandom[2]<<(FRACBITS-3)) * diry, p.mo.scale),
					p.dz + FixedMul((prandom[3]<<(FRACBITS-2)), p.mo.scale), bubbletype)

				if (bubble)
				
					if (P_MobjFlip(p.mo)*p.dmomz < 0)
						bubble.momz = p.dmomz >> 4
					else
						bubble.momz = 0
					end

					bubble.destscale = p.mo.scale
					P_SetScale(bubble, p.mo.scale)
				end
			end
		end
	end

//Restore Demo23 Water Gravity
	if eraInfo.tweaks & TP_DEMOWATER

		if p.mo.eflags & MFE_UNDERWATER
			if p.mo.momz != 0
				p.mo.momz = $ - P_GetMobjGravity(p.mo) + (FixedMul(P_GetMobjGravity(p.mo),3*FRACUNIT))
			end
			if p.charability == CA_THOK // Restore fast thok underwater
				p.actionspd = skins[p.mo.skin].actionspd<<1
			end
		else
			if p.charability == CA_THOK // Restore fast thok underwater
				p.actionspd = skins[p.mo.skin].actionspd
			end
		end
		
		if ((!p.mo.eflags & MFE_UNDERWATER and p.preveflags & MFE_UNDERWATER and p.mo.eflags & MFE_TOUCHWATER)
			or (p.mo.eflags & MFE_UNDERWATER and !p.preveflags & MFE_UNDERWATER and !p.mo.eflags & MFE_TOUCHWATER)) and P_MobjFlip(p.mo)*p.mo.momz > 0
				p.mo.momz = FixedDiv($,FixedDiv(780*FRACUNIT,457*FRACUNIT))//Negate Normal Boost
				p.mo.momz = $+114688 //Pre Demo4 only added slightly less than 2 FRACUNITS to your momentum. (Had to Decomp to figure this out)
		end
	end
end)

addHook("MapLoad", do for p in players.iterate // Reset Thok speed when leaving a level.
	local eraInfo = SRB2TP_GetEraInfo()
	if (not eraInfo.tweaks or !eraInfo.tweaks & TP_DEMOWATER)
	and p.charability == CA_THOK // Restore fast thok underwater
			p.actionspd = skins[p.mo.skin].actionspd
	end
end end)

//Restore Jump Height 
addHook("MobjThinker", function(m)
	
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo.tweaks or !eraInfo.tweaks & TP_DEMOWATER then return end

	local p = m.player

if P_IsObjectOnGround(m)
	p.jumped = nil
end
	if m.eflags & MFE_UNDERWATER and p.pflags & PF_STARTJUMP and not p.jumped
		if p.climbing and not p.powers[pw_super]
			m.momz = 15*(FRACUNIT/4) - (FixedMul(P_GetMobjGravity(p.mo),3*FRACUNIT)) 
		else
		m.momz = FixedMul($,FixedDiv(780*FRACUNIT,457*FRACUNIT)) - (FixedMul(P_GetMobjGravity(p.mo),3*FRACUNIT))
		p.jumped = true
		end
	end

end,MT_PLAYER)



//TP_BUBBLESOUNDS
local function BubbleSounds(m)
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo.tweaks or !eraInfo.tweaks & TP_BUBBLESOUNDS then return end
	if (m.threshold != 42) // Don't make pop sound if threshold is 42.
		local bubblesounds = P_SpawnMobjFromMobj(m,0,0,0,MT_UNKNOWN)
		bubblesounds.nullaudioplayer = true
		S_StartSound(bubblesounds, sfx_bubbl1 + P_RandomKey(5))	
		return true
	end
end

addHook("MobjRemoved", BubbleSounds, MT_SMALLBUBBLE)
addHook("MobjRemoved", BubbleSounds, MT_MEDIUMBUBBLE)
addHook("MobjRemoved", BubbleSounds, MT_EXTRALARGEBUBBLE)

addHook("MobjThinker", function(m) 
	if m.nullaudioplayer == true
		m.state = S_INVISIBLE
		if not S_OriginPlaying(m)
			P_RemoveMobj(m)
		end
	end
end, MT_UNKNOWN)	//Why waste a freeslot when we have a perfectly usable Mobj right here?..


----------------------------------
--Hacky Spring Collision Garbage-- // Barrels O' Fun
----------------------------------
//TP_SPRINGCOLLIDE
//Still collide with old springs even though the line said no.
addHook("MobjLineCollide", function(m,l)
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo.tweaks or !eraInfo.tweaks & TP_SPRINGCOLLIDE then return end
	
	local collide = nil


	local mLEFT = m.x-m.radius+m.momx+m.momx
	local mTOP = m.y+m.radius+m.momy+m.momy
	local mRIGHT = m.x+m.radius+m.momx+m.momx
	local mBOTTOM = m.y-m.radius+m.momy+m.momy


	searchBlockmap("objects", function(m, obj)
		local objLEFT = obj.x-obj.radius
		local objTOP = obj.y+obj.radius
		local objRIGHT = obj.x+obj.radius
		local objBOTTOM = obj.y-obj.radius

		if obj.flags & MF_SPRING
		and (m.z <= obj.z+obj.height and m.z+m.height >= obj.z) -- Height Check
		and not ( ( (mTOP < objBOTTOM) and (mBOTTOM - m.momy < objTOP) )  or ( (objTOP < mBOTTOM) and (objBOTTOM < mTOP - m.momy) ) )
		and not ( ( (mLEFT < objRIGHT) and (mRIGHT < objLEFT) )  or ( (objLEFT < mRIGHT) and (objRIGHT < mLEFT) ) ) -- Jank Collision CHeck
			collide = false

		end
    end, m, mLEFT-m.momx, mRIGHT-m.momx, mTOP-m.momy, mBOTTOM-m.momy)

	return collide

end, MT_PLAYER)


-------------------------------------------------------------------------------
-- Prevent A_SuperSneakers from playing music if the era doesn't allow for it-- // MIDIMan
-------------------------------------------------------------------------------
function A_SuperSneakers(actor, var1, var2)
	local eraInfo = SRB2TP_GetEraInfo()
		if not eraInfo.tweaks or !eraInfo.tweaks & TP_NOSNEAKERMUSIC then
		super(actor, var1, var2)
		return
	end
	
	
	local player
	
	if not (actor.target and actor.target.valid and actor.target.player and actor.target.player.valid) then
		super(actor, var1, var2)
		return
	end
	
	player = actor.target.player
	player.powers[pw_sneakers] = sneakertics + 1
end


------------------------------------------
-- Conveyor Spin Bug Reimplementation-- // MIDIMan
------------------------------------------

-- Make sure this function isn't already initialized
if not Valid then
	-- Helper function for checking validity of objects, sectors, etc.
	rawset(_G, "Valid", function(thing)
		return thing and thing.valid
	end)
end

-- These variables are not exposed to Lua, so they have been redefined here
local TP_ORIG_FRICTION = 0xE8 << (FRACBITS - 8)
local TP_CARRYFACTOR = (3*FRACUNIT)/32
local TP_SCROLL_SHIFT = 5

addHook("PlayerThink", function(player)
	if not Valid(player) then return end
	if not Valid(player.mo) then return end
	
	-- Make sure the map specifies the use of the conveyor spin bug
	local eraInfo = SRB2TP_GetEraInfo()
	if not eraInfo.tweaks or !eraInfo.tweaks & TP_CONVEYORSPEED then return end
	
	local cfactor = 0
	
	local conveyorsector = P_MobjTouchingSectorSpecialFlag(player.mo, SSF_CONVEYOR)
	local dx, dy = 0, 0
	
	if Valid(conveyorsector) then
		for line in lines.iterate do
			if line.special ~= 510 then continue end
			
			-- Check both Binary and UDMF methods just in case
			if line.args[0] ~= conveyorsector.tag then
				continue
			end
			
			-- Make sure the player is on the right surface before attempting to carry them
			if line.args[1] == 0 and P_MobjFlip(player.mo) < 0 then continue end
			if line.args[1] == 1 and P_MobjFlip(player.mo) > 0 then continue end
			
			local length = R_PointToDist2(line.v2.x, line.v2.y, line.v1.x, line.v1.y)
			local speed = line.args[3] << FRACBITS
			dx = FixedMul(FixedDiv(line.dx, length), speed) / (2^TP_SCROLL_SHIFT)
			dy = FixedMul(FixedDiv(line.dy, length), speed) / (2^TP_SCROLL_SHIFT)
			
			dx = FixedMul($, TP_CARRYFACTOR)
			dy = FixedMul($, TP_CARRYFACTOR)
		end
		conveyorsector = nil
	end
	
	if not P_IsObjectOnGround(player.mo) then return end
	if not (dx or dy) then return end
	
	if player and (player.pflags & PF_SPINNING) and (player.rmomx or player.rmomy) and not (player.pflags & PF_STARTDASH) then
		cfactor = FixedDiv(549*TP_ORIG_FRICTION, 500*FRACUNIT)
	else
		cfactor = player.mo.friction
	end
	
	if cfactor then
		local origdx, origdy = dx, dy
		
		dx = FixedMul($, FRACUNIT - cfactor)
		dy = FixedMul($, FRACUNIT - cfactor)
		
		dx = FixedDiv($, TP_CARRYFACTOR)
		dy = FixedDiv($, TP_CARRYFACTOR)
		
		dx = origdx - $
		dy = origdy - $
		
		player.mo.momx = $ + dx
		player.mo.momy = $ + dy
		
		player.rmomx = player.mo.momx - player.cmomx
		player.rmomy = player.mo.momy - player.cmomy
	end
end)