// Sonic Doom 2 - Singleplayer Ringslinger Stuff
// Ported from 2.2.10's source code by MIDIMan

// Feel free to remove this if the leveltype has already been freeslotted before
freeslot("TOL_DOOM")

local SD2_RingMaximums = {
	800,	// MAX_INFINITY
	400,	// MAX_AUTOMATIC
	100,	// MAX_BOUNCE
	50,		// MAX_SCATTER
	100,	// MAX_GRENADE
	50,		// MAX_EXPLOSION
	50		// MAX_RAIL
}

// Since the game doesn't allow the ringslinger HUD to be drawn when not in ringslinger mode,
// the code that draws it has to be manually ported to Lua
local function SD2_DrawWeaponSelect(v, player, xoffs, y)
	if not (player and player.valid) then return end
	
	local q = player.weapondelay
	local del = 0
	local p = 16
	while q do
		if q > p then
			del = $+p
			q = $-p
			q = $/2
			if p > 1 then p = $/2 end
		else
			del = $+q
			break
		end
	end
	
	v.drawScaled((6 + xoffs)*FRACUNIT, (y-2 - del/2)*FRACUNIT, FRACUNIT, v.cachePatch("CURWEAP"), V_PERPLAYER|V_SNAPTOBOTTOM)
end

local function SD2_DrawWeaponRing(v, player, weapon, rwflag, wepflag, xoffs, y, pat)
	if not (player and player.valid) then return end
	
	local txtflags = 0
	local patflags = 0
	
	if player.powers[weapon] then
		if SD2_RingMaximums and SD2_RingMaximums[wepflag + 1]
		and player.powers[weapon] >= SD2_RingMaximums[wepflag + 1] then
			txtflags = $|V_YELLOWMAP
		end
		
		if weapon == pw_infinityring or (player.ringweapons & rwflag) then
			// DO NOTHING
		else
			txtflags = $|V_TRANSLUCENT
			patflags = V_80TRANS
		end
		
		
		if pat and pat.valid then v.drawScaled((8 + xoffs)*FRACUNIT, y*FRACUNIT, FRACUNIT, pat, V_PERPLAYER|V_SNAPTOBOTTOM|patflags) end
		v.drawString(24 + xoffs, y+8, tostring(player.powers[weapon]), V_PERPLAYER|V_SNAPTOBOTTOM|txtflags, "thin-right")
		
		if player.currentweapon == wepflag then SD2_DrawWeaponSelect(v, player, xoffs, y) end
	elseif (player.ringweapons & rwflag) and pat and pat.valid then
		v.drawScaled((8 + xoffs)*FRACUNIT, y*FRACUNIT, FRACUNIT, pat, V_PERPLAYER|V_SNAPTOBOTTOM|V_TRANSLUCENT)
	end
end

hud.add(function(v, player)
	if not (player and player.valid) then return end
	
	// Do not run this code if the current level is not a "Doom" level
	if not (maptol & TOL_DOOM) then return end
	
	local penaltystr
	local y = 176
	local offset = (320/2) - (7 * 10) - 6 // 7 is a replacement for NUM_WEAPONS
	
	if G_TagGametype() and not (player.pflags & PF_TAGIT) then return end
	
	if player.powers[pw_infinityring] then
		SD2_DrawWeaponRing(v, player, pw_infinityring, 0, 0, offset, y, v.cachePatch("INFNIND"))
	else
		if player.rings > 0 then
			v.drawScaled((8 + offset)*FRACUNIT, y*FRACUNIT, FRACUNIT, v.cachePatch("RINGIND"), V_PERPLAYER|V_SNAPTOBOTTOM)
		else
			v.drawScaled((8 + offset)*FRACUNIT, y*FRACUNIT, FRACUNIT, v.cachePatch("RINGIND"), V_PERPLAYER|V_SNAPTOBOTTOM|V_80TRANS)
		end
	end
	
	if not player.currentweapon then SD2_DrawWeaponSelect(v, player, offset, y) end
	
	SD2_DrawWeaponRing(v, player, pw_automaticring, RW_AUTO, WEP_AUTO, offset + 20, y, v.cachePatch("AUTOIND"))
	SD2_DrawWeaponRing(v, player, pw_bouncering, RW_BOUNCE, WEP_BOUNCE, offset + 40, y, v.cachePatch("BNCEIND"))
	SD2_DrawWeaponRing(v, player, pw_scatterring, RW_SCATTER, WEP_SCATTER, offset + 60, y, v.cachePatch("SCATIND"))
	SD2_DrawWeaponRing(v, player, pw_grenadering, RW_GRENADE, WEP_GRENADE, offset + 80, y, v.cachePatch("GRENIND"))
	SD2_DrawWeaponRing(v, player, pw_explosionring, RW_EXPLODE, WEP_EXPLODE, offset + 100, y, v.cachePatch("BOMBIND"))
	SD2_DrawWeaponRing(v, player, pw_railring, RW_RAIL, WEP_RAIL, offset + 120, y, v.cachePatch("RAILIND"))
	
	if player.ammoremovaltimer and leveltime % 8 < 4 then
		penaltystr = "-"..tostring(player.ammoremoval)
		v.drawString(offset + 8 + player.ammoremovalweapon * 20, y, penaltystr, V_REDMAP|V_SNAPTOBOTTOM|V_PERPLAYER, "left")
	end
end, "game")

// For some unfathomable reason, P_SetWeaponDelay and P_DrainWeaponAmmo are not exposed to Lua, 
// so I had to port them over
local function SD2_SetWeaponDelay(player, delay)
	if not (player and player.valid) then return end
	
	player.weapondelay = delay
	
	if player.skin == 2 then
		player.weapondelay = $*2
		player.weapondelay = $/3
	end
end

local function SD2_DrainWeaponAmmo(player, power)
	if not (player and player.valid) then return end
	
	player.powers[power] = $-1
	
	if player.rings < 1 then
		player.ammoremovalweapon = player.currentweapon
		player.ammoremovaltimer = ammoremovaltics
		
		if player.powers[power] > 0 then
			player.powers[power] = $-1
			player.ammoremoval = 2
		else
			player.ammoremoval = 1
		end
	else
		player.rings = $-1
	end
end

local function SD2_FireNormal(player, mo)
	if not (player and player.valid
	and player.mo and player.mo.valid) then
		return
	end
	
	// Infinity Ring
	if player.currentweapon == 0 and player.powers[pw_infinityring] then
		SD2_SetWeaponDelay(player, TICRATE/4)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_THROWNINFINITY)
		
		player.powers[pw_infinityring] = $-1
	// Red Ring
	else
		if player.rings <= 0 then return end
		SD2_SetWeaponDelay(player, TICRATE/4)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_REDRING)
		
		if mo and mo.valid then P_ColorTeamMissile(mo, player) end
		
		player.rings = $-1
	end
end

local function SD2_DoFiring(player, cmd)
	if not (player and player.valid
	and player.mo and player.mo.valid) then
		return
	end
	
	local mo
	
	if not (cmd.buttons & (BT_ATTACK|BT_FIRENORMAL)) then
		//player.pflags = $ & ~PF_ATTACKDOWN // The game's code already handles this
		return
	end
	
	if (player.pflags & PF_ATTACKDOWN) or player.climbing or (G_TagGametype() and not (player.pflags & PF_TAGIT)) then
		return
	end
	
	// Let the game handle the fire flower powerup
	if (player.powers[pw_shield] & SH_STACK) == SH_FIREFLOWER and not player.weapondelay then return end
	
	if player.weapondelay then return end
	
	player.pflags = $|PF_ATTACKDOWN
	
	if (cmd.buttons & BT_FIRENORMAL) then // No powers, just a regular ring.
		SD2_FireNormal(player, mo)
	// Bounce ring
	elseif player.currentweapon == WEP_BOUNCE and player.powers[pw_bouncering] then
		SD2_DrainWeaponAmmo(player, pw_bouncering)
		SD2_SetWeaponDelay(player, TICRATE/4)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_THROWNBOUNCE, MF2_BOUNCERING)
		
		if mo and mo.valid then mo.fuse = 3*TICRATE end
	// Rail ring
	elseif player.currentweapon == WEP_RAIL and player.powers[pw_railring] then
		SD2_DrainWeaponAmmo(player, pw_railring)
		SD2_SetWeaponDelay(player, (3*TICRATE)/2)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_REDRING, MF2_RAILRING|MF2_DONTDRAW)
		
		// Rail has no unique thrown object, therefore its sound plays here.
		S_StartSound(player.mo, sfx_rail1)
	// Automatic
	elseif player.currentweapon == WEP_AUTO and player.powers[pw_automaticring] then
		SD2_DrainWeaponAmmo(player, pw_automaticring)
		player.pflags = $ & ~PF_ATTACKDOWN
		SD2_SetWeaponDelay(player, 2)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_THROWNAUTOMATIC, MF2_AUTOMATIC)
	// Explosion
	elseif player.currentweapon == WEP_EXPLODE and player.powers[pw_explosionring] then
		SD2_DrainWeaponAmmo(player, pw_explosionring)
		SD2_SetWeaponDelay(player, (3*TICRATE)/2)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_THROWNEXPLOSION, MF2_EXPLOSION)
	// Grenade
	elseif player.currentweapon == WEP_GRENADE and player.powers[pw_grenadering] then
		SD2_DrainWeaponAmmo(player, pw_grenadering)
		SD2_SetWeaponDelay(player, TICRATE/3)
		
		mo = P_SpawnPlayerMissile(player.mo, MT_THROWNGRENADE, MF2_EXPLOSION)
		
		if mo and mo.valid then mo.fuse = mo.info.reactiontime end
	// Scatter
	// Note: Ignores MF2_RAILRING
	elseif player.currentweapon == WEP_SCATTER and player.powers[pw_scatterring] then
		local oldz = player.mo.z
		local shotangle = player.mo.angle
		local oldaiming = player.aiming
		
		SD2_DrainWeaponAmmo(player, pw_scatterring)
		SD2_SetWeaponDelay(player, (2*TICRATE)/3)
		
		// Center
		mo = P_SpawnPlayerMissile(player.mo, MT_THROWNSCATTER, MF2_SCATTER)
		if mo and mo.valid then shotangle = R_PointToAngle2(player.mo.x, player.mo.y, mo.x, mo.y) end
		
		// Left
		mo = P_SPMAngle(player.mo, MT_THROWNSCATTER, shotangle-ANG2, 1, MF2_SCATTER)
		
		// Right
		mo = P_SPMAngle(player.mo, MT_THROWNSCATTER, shotangle+ANG2, 1, MF2_SCATTER)
		
		// Down
		player.mo.z = $+(12*player.mo.scale)
		player.aiming = $+ANG1
		mo = P_SPMAngle(player.mo, MT_THROWNSCATTER, shotangle, 1, MF2_SCATTER)
		
		// Up
		player.mo.z = $-(24*player.mo.scale)
		player.aiming = $-ANG2
		mo = P_SPMAngle(player.mo, MT_THROWNSCATTER, shotangle, 1, MF2_SCATTER)
		
		player.mo.z = oldz
		player.aiming = oldaiming
		return
	// No powers, just a regular ring.
	else
		SD2_FireNormal(player, mo)
	end
	
	if mo and mo.valid then
		if (mo.flags & MF_MISSILE) and (mo.flags2 & MF2_RAILRING) then
			local nblockmap = not (mo.flags & MF_NOBLOCKMAP)
			for i = 0, 255 do
				if nblockmap then mo.flags = $|MF_NOBLOCKMAP end
				
				// Make the spawned spark match the weapon's scale by using P_SpawnMobjFromMobj
				if (i & 1) then P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SPARK) end
				
				if P_RailThinker(mo) then break end // mobj was removed (missile hit a wall) or couldn't move
			end
			
			// Other rail sound plays at contact point
			if mo and mo.valid then S_StartSound(mo, sfx_rail2) end
		end
	end
end

addHook("PlayerSpawn", function(player)
	if not (player and player.valid) then return end
	
	if not (maptol & TOL_DOOM) then return end
	
	if player.sd2WeaponInfo then
		if player.sd2WeaponInfo.ammoBasic then player.rings = player.sd2WeaponInfo.ammoBasic end
		if player.sd2WeaponInfo.ammoInfinity then player.powers[pw_infinityring] = player.sd2WeaponInfo.ammoInfinity end
		if player.sd2WeaponInfo.ammoAutomatic then player.powers[pw_automaticring] = player.sd2WeaponInfo.ammoAutomatic end
		if player.sd2WeaponInfo.ammoBounce then player.powers[pw_bouncering] = player.sd2WeaponInfo.ammoBounce end
		if player.sd2WeaponInfo.ammoScatter then player.powers[pw_scatterring] = player.sd2WeaponInfo.ammoScatter end
		if player.sd2WeaponInfo.ammoGrenade then player.powers[pw_grenadering] = player.sd2WeaponInfo.ammoGrenade end
		if player.sd2WeaponInfo.ammoExplosion then player.powers[pw_explosionring] = player.sd2WeaponInfo.ammoExplosion end
		if player.sd2WeaponInfo.ammoRail then player.powers[pw_railring] = player.sd2WeaponInfo.ammoRail end
		
		if player.sd2WeaponInfo.weaponsHeld then player.ringweapons = player.sd2WeaponInfo.weaponsHeld end
		if player.sd2WeaponInfo.currentWeapon then player.currentweapon = player.sd2WeaponInfo.currentWeapon end
		if player.sd2WeaponInfo.shield then P_SwitchShield(player, player.sd2WeaponInfo.shield) end
	end
end)

addHook("MobjDamage", function(target, inflictor, source, damage, damagetype)
	if not (target and target.valid) then return end
	if not (target.player and target.player.valid) then return end
	
	// Do not run this code if the player is already in ringslinger mode
	//if G_RingSlingerGametype() then return end
	
	// Do not run this code if the current level is not a "Doom" level
	if not (maptol & TOL_DOOM) then return end
	//if SD2_HARDMODE then return end
	
	local player = target.player
	
	// Do not run this code if the player is in NiGHTS mode
	if player.powers[pw_carry] == CR_NIGHTSMODE then return end
	
	if damagetype and (damagetype & DMG_DEATHMASK) then return end
	if player.powers[pw_invulnerability] or player.powers[pw_flashing] or player.powers[pw_super] then return end
	if player.powers[pw_shield] then return end
	if player.powers[pw_carry] == CR_NIGHTSFALL then return end
	
	player.sd2DamageWeapons = {
		ringweapons = player.ringweapons,
		infinityring = player.powers[pw_infinityring],
		automaticring = player.powers[pw_automaticring],
		bouncering = player.powers[pw_bouncering],
		scatterring = player.powers[pw_scatterring],
		grenadering = player.powers[pw_grenadering],
		explosionring = player.powers[pw_explosionring],
		railring = player.powers[pw_railring],
		currentweapon = player.currentweapon
	}
	
	player.ringweapons = 0
	player.powers[pw_infinityring] = 0
	player.powers[pw_automaticring] = 0
	player.powers[pw_bouncering] = 0
	player.powers[pw_scatterring] = 0
	player.powers[pw_grenadering] = 0
	player.powers[pw_explosionring] = 0
	player.powers[pw_railring] = 0
end, MT_PLAYER)

addHook("PlayerThink", function(player)
	if not (player and player.valid
	and player.mo and player.mo.valid) then
		return
	end
	
	// Do not run this code if the player is already in ringslinger mode
	if G_RingSlingerGametype() then return end
	
	// Do not run this code if the current level is not a "Doom" level
	if not (maptol & TOL_DOOM) then
		// Clear the player's sd2WeaponInfo if not in a "Doom" level
		if player.sd2WeaponInfo then player.sd2WeaponInfo = nil end
		if player.sd2DamageWeapons then player.sd2DamageWeapons = nil end
		return
	end
	
	// Do not let the player shoot rings if post-goal free roaming is disabled 
	if player.exiting then return end
	
	// Ported directly from P_DoFiring in 2.2.10's code
	SD2_DoFiring(player, player.cmd)
	
	// Don't let the player's post-goal behavior influence their inventory
	if (player.pflags & PF_FINISHED) then return end
	
	//if not SD2_HARDMODE then
		if player.sd2DamageWeapons then
			local damageWeapons = player.sd2DamageWeapons
			
			player.ringweapons = damageWeapons.ringweapons
			player.powers[pw_infinityring] = damageWeapons.infinityring
			player.powers[pw_automaticring] = damageWeapons.automaticring
			player.powers[pw_bouncering] = damageWeapons.bouncering
			player.powers[pw_scatterring] = damageWeapons.scatterring
			player.powers[pw_grenadering] = damageWeapons.grenadering
			player.powers[pw_explosionring] = damageWeapons.explosionring
			player.powers[pw_railring] = damageWeapons.railring
			player.currentweapon = damageWeapons.currentweapon
			
			player.sd2DamageWeapons = nil
		end
	//end
	
	// Let the player keep their inventory of rings between "Doom" levels
	if not player.sd2WeaponInfo then player.sd2WeaponInfo = {} end
	
	player.sd2WeaponInfo.ammoBasic = player.rings
	player.sd2WeaponInfo.ammoInfinity = player.powers[pw_infinityring]
	player.sd2WeaponInfo.ammoAutomatic = player.powers[pw_automaticring]
	player.sd2WeaponInfo.ammoBounce = player.powers[pw_bouncering]
	player.sd2WeaponInfo.ammoScatter = player.powers[pw_scatterring]
	player.sd2WeaponInfo.ammoGrenade = player.powers[pw_grenadering]
	player.sd2WeaponInfo.ammoExplosion = player.powers[pw_explosionring]
	player.sd2WeaponInfo.ammoRail = player.powers[pw_railring]
	
	player.sd2WeaponInfo.weaponsHeld = player.ringweapons
	player.sd2WeaponInfo.currentWeapon = player.currentweapon
	player.sd2WeaponInfo.shield = player.powers[pw_shield]
end)
