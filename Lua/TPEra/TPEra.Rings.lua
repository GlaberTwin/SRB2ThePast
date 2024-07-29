----------------------------
--SRB2:TP Era Skins: Rings-- // Barrels O' Fun
----------------------------


------Table Contents------
-- Skin # {Spawn,Death} --
--------------------------
local ringskins = { 
{S_RING,			S_SPRK1},		//1 - 2.2
{S_OLD_RING, 		S_OLD_SPARK1}, 	//2 - XMAS-2.1
{S_HALLORING,		S_DOOMPICKUP}, 	//3 - Ween
{S_SONICDOOM_RINGH, S_DOOMPICKUP}, 	//4 - SD2 Health
{S_SONICDOOM_RINGA, S_DOOMPICKUP}, 	//5 - SD2 Armor
{S_TGF_RING,		S_TGF_SPARK}	//6 - TGF
}

local teamringskins = { 
{S_20_TEAMRING, 	S_OLD_SPARK1} 	//1 - Old
}

----------------
--Do The Stuff--
----------------

local function RingItemSkin(m,mt,list)
	
	local itemskin = mt.extrainfo
	if udmf
		itemskin = mt.args[1]
	end

	if m.itemskin == nil or m.itemskin == 0
		m.itemskin = itemskin
	end

	if m.itemskin != 0
		m.skintable = list
		if m.state != list[min(m.itemskin,#list)][1]
			m.state = list[min(m.itemskin,#list)][1]
		end
	else

		if leveltime == 0 	-- Only update once at map load.
			SRB2TP_UpdateObject(m)
		else				-- If any are spawned after that update them.
			SRB2TP_UpdateObject(m,true)
		end

		m.state = mobjinfo[m.type].spawnstate
	end
end

addHook("MapThingSpawn", function(m,mt) 
RingItemSkin(m,mt,ringskins)
end, MT_RING)

addHook("MapThingSpawn", function(m,mt)
RingItemSkin(m,mt,ringskins)
end, MT_FLINGRING)

addHook("MapThingSpawn", function(m,mt) 
RingItemSkin(m,mt,teamringskins) 
end, MT_REDTEAMRING)

addHook("MapThingSpawn", function(m,mt) 
RingItemSkin(m,mt,teamringskins) 
end, MT_BLUETEAMRING)

--------------------
--Ring Skin Pickup--
--------------------
local function RingSkinDeath(mo,n,toucher)
	if toucher and toucher.player
		if toucher.player.ringtable == nil -- Initialize
			toucher.player.ringtable = {}
		end

		if #toucher.player.ringtable > 31  -- Cap at 32
			table.remove(toucher.player.ringtable,1)
		end

		table.insert(toucher.player.ringtable,mo.itemskin)
		mo.target = toucher
	end

	if mo.skintable
		mo.info.deathstate 	= mo.skintable[mo.itemskin][2]
	else 
		SRB2TP_UpdateObject(mo, true)
	end

	
end

addHook("MobjDeath", RingSkinDeath, MT_RING)
addHook("MobjDeath", RingSkinDeath, MT_FLINGRING)
addHook("MobjDeath", RingSkinDeath, MT_REDTEAMRING)
addHook("MobjDeath", RingSkinDeath, MT_BLUETEAMRING)


addHook("MobjThinker", function(m)
	if m.target and m.target.player and m.target.player.ringtable and #m.target.player.ringtable and not m.flung
		m.itemskin = m.target.player.ringtable[1]
		if m.itemskin
			m.skintable = ringskins
			m.state = ringskins[m.itemskin][1]
		else
			SRB2TP_UpdateObject(m, true)
			m.state = mobjinfo[m.type].spawnstate
		end
		m.flung = true
		table.remove(m.target.player.ringtable,1)
	end
end, MT_FLINGRING)

addHook("MapChange", do for p in players.iterate
	p.ringtable = {}
end end)


------------------------
--Count Ring as Sphere--
------------------------
local function RingSpheres(mo,toucher)	-- Special Stage misc.
	if mo and mo.valid and toucher.player and toucher.valid
	and ((mo.spawnpoint and mo.spawnpoint.valid and mo.spawnpoint.options & MTF_EXTRA) or mo.flungextra)
	toucher.player.spheres = $ + 1
	end
end
addHook("TouchSpecial", RingSpheres, MT_RING)
addHook("TouchSpecial", RingSpheres, MT_FLINGRING)

------------------
--A_AttractChase--
------------------
--[[
local function lua_LookForShield(actor)	-- Lua Conversion

	local c = 0
	local stop
	local player
	local MAXPLAYERS = #players
	local PLAYERSMASK = #players-1

	-- BP: first time init, this allow minimum lastlook changes
	if (actor.lastlook < 0)
		actor.lastlook = P_RandomByte()
	end
	
	actor.lastlook = $ % MAXPLAYERS
	stop = ((actor.lastlook - 1) & PLAYERSMASK)

	while(true)
	
		-- done looking
		if (actor.lastlook == stop)
	
			return false
		end

		if (players[actor.lastlook] == nil)
		actor.lastlook = ((actor.lastlook + 1) & PLAYERSMASK)
			continue
		end
		
		c = c+1
		if (c == 2)
			return false
		end

		player = players[actor.lastlook]

		if (not player.mo) or (player.mo.health <= 0) 
		actor.lastlook = ((actor.lastlook + 1) & PLAYERSMASK)
			continue -- dead
		end
		
		--When in CTF, don't pull rings that you cannot pick up.
		if ((actor.type == MT_REDTEAMRING and player.ctfteam != 1) or
			(actor.type == MT_BLUETEAMRING and player.ctfteam != 2))
			continue
		end
		
		if (player.powers[pw_shield] & SH_PROTECTELECTRIC)
			and (FixedHypot(FixedHypot(actor.x-player.mo.x, actor.y-player.mo.y), actor.z-player.mo.z) < FixedMul(RING_DIST, player.mo.scale))
			actor.tracer = player.mo

			if (actor.hnext)
			actor.hnext.hprev = actor.hprev
			end
			
			if (actor.hprev)
			actor.hprev.next = actor.hnext
			end
			
			--actor.attracted = true
			return true
		end
		
		 actor.lastlook = ((actor.lastlook + 1) & PLAYERSMASK)

	end

end	
]]--	
	
local function lua_AttractA(source, dest) -- Direct Pull ala Sonic Adventure, current SRB2

	if dest and dest.health and dest.valid and dest.player -- make sure destination is valid

		local dist,ndist,speedmul
	--	local vangle -- No NiGHTs
		local tx = dest.x
		local ty = dest.y
		local tz = dest.z + (dest.height/2) 
		local xydist = P_AproxDistance(tx - source.x, ty - source.y)
		
		// change angle
		source.angle = R_PointToAngle2(source.x, source.y, tx, ty)

		// change slope
		dist = P_AproxDistance(xydist, tz - source.z)

		if (dist < 1) then
			dist = 1
		end

				speedmul = P_AproxDistance(dest.momx, dest.momy) + FixedMul(source.info.speed, source.scale)


			source.momx = FixedMul(FixedDiv(tx - source.x, dist), speedmul)
			source.momy = FixedMul(FixedDiv(ty - source.y, dist), speedmul)
			source.momz = FixedMul(FixedDiv(tz - source.z, dist), speedmul)

		-- Instead of just unsetting NOCLIP like an idiot, let's check the distance to our target.	
		ndist = P_AproxDistance(P_AproxDistance(tx - (source.x+source.momx), 
												ty - (source.y+source.momy)), 
												tz - (source.z+source.momz))
		if (ndist > dist) -- gone past our target
			// place us on top of them then.
			source.momx,source.momy,source.momz = 0,0,0
			P_MoveOrigin(source, tx, ty, tz)
		end
	end	
end
		
local function lua_AttractB(source, dest) -- Demo Attract
	if dest and dest.health and dest.valid and dest.player -- make sure destination is valid

		if(source.x != dest.x and source.y != dest.y)
			P_Thrust(source, R_PointToAngle2(source.x, source.y, dest.x+dest.momx, dest.y+dest.momy), 5*FRACUNIT) -- Frankenstein some old Demo 4 code
		end

		if(source.z > dest.z)
			source.momz = $ - 5*FRACUNIT
		elseif(source.z < dest.z)
			source.momz = $ + 5*FRACUNIT
		end

	source.momx = FixedMul($,2048*31) -- Friction because it doesn't get applied elsewhere anymore and rings go flying otherwise.
	source.momy = FixedMul($,2048*31)
	source.momz = FixedMul($,2048*31)
	end
end	

		
function A_AttractChase(actor)

	if (actor.flags2 & MF2_NIGHTSPULL or actor.health == 0)
		return
	end
	
	actor.tpAttractable = true

	-- spilled rings flicker before disappearing
	if (leveltime & 1) and (actor.type == mobjinfo[actor.type].reactiontime) and (actor.fuse) and (actor.fuse < 2*TICRATE)
		actor.flags2 = $|MF2_DONTDRAW
	else
		actor.flags2 = $&~MF2_DONTDRAW
	end

	-- Turn rings into flingrings if shield is lost or out of range
	if (((actor.tracer and actor.tracer.player	-- If actor has tracer and is player,
		and (!actor.tracer.player.powers[pw_shield] & SH_PROTECTELECTRIC))  -- and player no longer has attraction,
		and actor.info.reactiontime and actor.type != mobjinfo[actor.type].reactiontime)) -- and actor has a Fling equivalent

				local newring = P_SpawnMobj(actor.x, actor.y, actor.z, actor.info.reactiontime)
					newring.momx = actor.momx
					newring.momy = actor.momy
					newring.momz = actor.momz

					if actor.itemskin
						newring.itemskin = actor.itemskin
						newring.state = actor.state
					end

					if actor.spawnpoint and actor.spawnpoint.valid and actor.spawnpoint.options & MTF_EXTRA
						newring.flungextra = true
					end

					P_RemoveMobj(actor)

		return
	end

	if (actor.type == mobjinfo[actor.type].reactiontime and actor.tracer) -- If a FlingRing gets attracted by a shield,
		 actor.type = mobjinfo[actor.type].painchance -- Directly set actor instead of spawning a new one to prevent incrementing Perfect Bonus counter.
		 actor.flags = mobjinfo[actor.type].flags
		return
	end


-- lua_LookForShield(actor) -- Go find 'em, boy!


	if not actor.tracer
		or not actor.tracer.player
		or not actor.tracer.health
		or not P_CheckSight(actor, actor.tracer) -- You have to be able to SEE it...sorta
	
		-- Lost attracted rings don't through walls anymore.
		actor.flags = $&~MF_NOCLIP
		actor.tracer = nil
		return
	end
	
	--	Keep stuff from going down inside floors and junk
	actor.flags = $&~MF_NOCLIPHEIGHT

	if actor.tracer.player.powers[pw_shield] == SH_ATTRACT and (actor.tracer.rmShieldEra == "DEMO" or actor.tracer.rmShieldEra == "XMAS")
	-- XMAS & Demo Attraction
 		actor.flags = $ &~MF_NOCLIP	-- Demo attracted rings don't get Noclip
		lua_AttractB(actor, actor.tracer)
	else
	-- Final Demo & Later Attraction
		actor.flags = $|MF_NOCLIP	-- Let attracted rings move through walls and such.
		lua_AttractA(actor, actor.tracer)
	end		
	
end

-- Move the ring attraction initialization code to a PlayerThink to reduce Lua interpreter overhead
-- Based off of TehRealSalt's implementation in the "Pretty Shield" addon
-- -MIDIMan
addHook("PlayerThink", function(player)
	if not (player and player.valid and player.mo and player.mo.valid and player.mo.health > 0) then return end
	if not (player.powers[pw_shield] & SH_PROTECTELECTRIC) then return end
	
	local ringDist = FixedMul(RING_DIST + 64*FRACUNIT, player.mo.scale)
	
	searchBlockmap("objects", function(pmo, mo)
		if not mo.tpAttractable then return end
-- 		if pmo.health <= 0 then return end
		
		-- When in CTF, don't pull rings that you cannot pick up.
		if ((mo.type == MT_REDTEAMRING and player.ctfteam != 1)
		or (mo.type == MT_BLUETEAMRING and player.ctfteam != 2)) then
			return
		end
		
-- 		if (player.powers[pw_shield] & SH_PROTECTELECTRIC)
			if (FixedHypot(FixedHypot(mo.x - player.mo.x, mo.y - player.mo.y), mo.z - player.mo.z) < FixedMul(RING_DIST, player.mo.scale))
			mo.tracer = player.mo

			if mo.hnext then
				mo.hnext.hprev = mo.hprev
			end
			
			if mo.hprev then
				mo.hprev.next = mo.hnext
			end
			
			return
 			end
		
-- 		actor.lastlook = ((actor.lastlook + 1) & PLAYERSMASK)
	end, player.mo, player.mo.x - ringDist, player.mo.x + ringDist, player.mo.y - ringDist, player.mo.y + ringDist)
end)

