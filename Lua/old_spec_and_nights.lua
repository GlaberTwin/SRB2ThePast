-- SRB2 Old Special Stage System - Created by sdas, edited for SRB2TP by MIDIMan
-- TODO: Rework this to support TPEra instead of its own object/state replacement system
-- Note to self: Pre-2.2 NiGHTS stages made players collect rings and emblems, instead of chips and stars,
-- whereas NiGHTS Special Stages made players collect blue spheres and rings.

--this script is done by @sdas813
--it 'ports' old special stages and nights systems from 2.1
--
--it also adds some of the level header options:
--Lua.OldSpecial = [0/1] - enable old special stage gameplay for this map
--Lua.OldNights = [0/1] - enable old nights gameplay for this map
--Lua.AllowRings = [0/1] - allow already placed ring things to be in level (so it won't remove them)

local changed_objs = false
local loaded_hud = false

--pre map loading hook (runs before spawning the second map thing)
-- TODO: Figure out why a pre-MapLoad hook is needed
-- table.insert(preMapLoadHooks, function()
addHook("MapLoad", function(id)
	--change ui
	if mapheaderinfo[gamemap].oldspecial then
		if not loaded_hud then
			hud.disable("rings")
			hud.disable("nightslink")
			hud.disable("nightsdrill")
			hud.disable("nightsrings")
			hud.disable("nightsscore")
			hud.disable("nightstime")
			--!2191 mr gonna fix that :/
			--rn it completely useless
			--05.02.24: yay they finally merged that mr and it will work in 2.2.14 :)
			hud.disable("nightsrecords")
			loaded_hud = true
		end
		stagefailed = true -- Assume level is failed unless someone beats the Special Stage

		--reset players
		-- for p in players.iterate do
		--
		-- end
	else
		if loaded_hud then
			hud.enable("rings")
			hud.enable("nightslink")
			hud.enable("nightsdrill")
			hud.enable("nightsrings")
			hud.enable("nightsscore")
			hud.enable("nightstime")
			hud.enable("nightsrecords")
			loaded_hud = false
		end
	end
end)

hudinfo[HUD_SS_TOTALRINGS].x = 112
hudinfo[HUD_SS_TOTALRINGS].y = 56

local function giveaway_rings(self)
	for p in players.iterate do
		--if player alive and not self then giveaway them all rings that died player had
		if p.valid and not p.spectator and p.playerstate == PST_LIVE and self ~= p then
			p.spheres = p.spheres + self.spheres
			self.spheres = 0;
		end
	end
end

local function stop_player(p)
	p.exiting = (14 * TICRATE) / 5 + 1
	p.nightstime = -32769
	p.mo.momx = 0
	p.mo.momy = 0
	--i dindn't saw this line in srb2 fd code but i added it just for fix the accidental emerald pickuping
	p.mo.momz = 0
end

--ring collecting
addHook("TouchSpecial", function(ring, t)
	if not (mapheaderinfo[gamemap].oldspecial or (mapheaderinfo[gamemap].oldnights and not G_IsSpecialStage())) then
		return
	end

	if t.valid and t.player and t.player.valid then
		--don't run this if player cannot pickup the rings
		if t.player.powers[pw_flashing] then
			return true
		end

		--if we are picking up a ring then add sphere and reset rings
		if ring and ring.valid then
			t.player.spheres = t.player.spheres + 1
			t.player.rings = 0
		end
	end
end, MT_RING)

addHook("MapThingSpawn", function(mobj, thing)
	--replace bluespheres with rings when needed
	if mapheaderinfo[gamemap].oldspecial or (mapheaderinfo[gamemap].oldnights and not G_IsSpecialStage(gamemap)) then
		--replace bluespheres or nigths chips with rings
		if mobj.type == MT_BLUESPHERE or mobj.type == MT_NIGHTSCHIP then
-- 			P_SpawnMobj(mobj.x, mobj.y, mobj.z, MT_RING)
			P_SpawnMobjFromMobj(mobj, 0, 0, 0, MT_RING)
			P_RemoveMobj(mobj)
			return true
			--if we are not allowing any other rings to be in the level then remove them
		elseif mobj.type == MT_RING and not mapheaderinfo[gamemap].allowrings then
			P_RemoveMobj(mobj)
			--remove thing if we are allowing the other rings on the level
		elseif mapheaderinfo[gamemap].allowrings then
			thing.type = 0
		end
	end

	--in nights, replace stars/rings into 'emblems'
	if mapheaderinfo[gamemap].oldnights then
		if not changed_objs then
			states[S_NIGHTSSTAR] = {
				sprite = SPR_NSTR,
				frame = Q,
				var1 = 0,
				var2 = 0,
				duration = -1,
				nextstate = S_NIGHTSSTAR,
			}

			states[S_NIGHTSSTARXMAS] = {
				sprite = SPR_NSTR,
				frame = Q,
				var1 = 0,
				var2 = 0,
				duration = -1,
				nextstate = S_NIGHTSSTARXMAS,
			}
			changed_objs = true
		end
	else
		if changed_objs then
			states[S_NIGHTSSTAR] = {
				sprite = SPR_NSTR,
				frame = FF_ANIMATE,
				var1 = 14,
				var2 = 2,
				duration = -1,
				nextstate = S_NIGHTSSTAR,
			}

			states[S_NIGHTSSTARXMAS] = {
				sprite = SPR_NSTR,
				frame = 15,
				var1 = 0,
				var2 = 0,
				duration = -1,
				nextstate = S_NIGHTSSTARXMAS,
			}
			changed_objs = false
		end
	end
end)

addHook("PlayerSpawn", function(p)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() or not p.valid then
		return
	end

	p.nightstime = mapheaderinfo[gamemap].sstimer * TICRATE
	p.deadtimer = 0

	if p.special_died == nil then
		p.special_died = false
	elseif p.special_died then
		p.spectator = true
	end
end)

--#region player quit/death
addHook("MobjDeath", function(mo)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end

	if mo.player then
		mo.player.special_died = true
		giveaway_rings(mo.player)
		mo.player.deadtimer = 1
	end
end)

addHook("PlayerQuit", function(plr, _)
	giveaway_rings(plr)
end)
--#endregion

--#region anti cheat
local anti_cheat_kill = CV_RegisterVar({
	name = "ss_anti_cheat_kill",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff,
})

addHook("ShieldSpawn", function(p)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end
	if p.valid and p.mo and p.mo.valid then
		if p.powers[pw_shield] then
			if p.powers[pw_shield] == SH_ATTRACT or p.powers[pw_shield] == SH_THUNDERCOIN then
				if p.special_cheater == nil then
					p.special_cheater = 1
					CONS_Printf(p, "are you thinking that i'll let you do that?")
				elseif p.special_cheater == 1 then
					p.rings = 0
					if anti_cheat_kill.value then
						p.special_cheater = 2
					end
					CONS_Printf(p, "please, stop")
				elseif p.special_cheater >= 2 and anti_cheat_kill.value then
					p.rings = 0
					if p.special_cheater == 2 then
						print(p.name .. " tried to cheat too much")
					end
					P_KillMobj(p.mo)
					p.powers[pw_shield] = 0
					p.special_cheater = 3
					return true
				end
			end
			p.powers[pw_shield] = 0
			p.powers[pw_invulnerability] = 0

			P_DoPlayerPain(p)
			return true
		end
	end
end)
--#endregion

addHook("MobjDamage", function(mo, _, _, t)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end

	if t < 128 and mo and mo.valid and mo.player and mo.player.valid then
		--TODO: it's not really that behaviour which old special stages had... idk, i think it should be replaced tbh
		P_DoPlayerPain(mo.player)
		P_PlayRinglossSound(mo, mo.player)
		return true
	end
end)

addHook("ThinkFrame", function()
	local alive = 0
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end

	--count the spheres
	local total_spheres = 0
	for p in players.iterate do
		total_spheres = total_spheres + p.spheres
	end

	for p in players.iterate do
		if not p and p.valid then
			return
		end
		--reset player (three times cuz think frame are broken)
		if leveltime == 0 then
			p.spheres = 0
			p.special_died = false
			p.spectator = false
			p.deadtimer = 0
			return
		end

		if p.special_died and not p.deadtimer then
			p.spectator = true
			p.nightstime = -32769

			--delay your death by 3 seconds
			if p.powers[pw_flashing] then
				alive = alive + 1
			else
				p.special_died = false
			end
		else
			alive = alive + 1
		end

		if p.mo and p.mo.valid then
			if p.nightstime <= 0 and p.nightstime > -32768 then
				stop_player(p)
			elseif p.nightstime > 0 then
				local rmtic = 1

				--if player is SOMEHOW in the water.. even if they just touching a little bit of it then speed up the timer
				if
					(p.mo.z < p.mo.watertop and p.mo.z + p.mo.height >= p.mo.watertop)
					or (p.mo.z + p.mo.height > p.mo.waterbottom and p.mo.z <= p.mo.waterbottom)
					or (p.mo.z >= p.mo.waterbottom and p.mo.z + p.mo.height <= p.mo.watertop)
				then
					rmtic = 6
				end
				p.nightstime = p.nightstime - rmtic

				if total_spheres >= mapheaderinfo[gamemap].ssspheres then
					--p.pflags = p.pflags|PF_FINISHED;
					stop_player(p)
					local award

					if not (emeralds & EMERALD1) then
						--emeralds = emeralds|EMERALD1;
						award = MT_CHAOS_GREEN
					elseif not (emeralds & EMERALD2) then
						--emeralds = emeralds|EMERALD2;
						award = MT_CHAOS_ORANGE
					elseif not (emeralds & EMERALD3) then
						--emeralds = emeralds|EMERALD3;
						award = MT_CHAOS_PINK
					elseif not (emeralds & EMERALD4) then
						--emeralds = emeralds|EMERALD4;
						award = MT_CHAOS_BLUE
					elseif not (emeralds & EMERALD5) then
						--emeralds = emeralds|EMERALD5;
						award = MT_CHAOS_RED
					elseif not (emeralds & EMERALD6) then
						--emeralds = emeralds|EMERALD6;
						award = MT_CHAOS_CYAN
					elseif not (emeralds & EMERALD7) then
						--emeralds = emeralds|EMERALD7;
						award = MT_CHAOS_GREY
					else
						award = MT_CHAOS_BLACK
					end
					P_SpawnMobj(p.realmo.x, p.realmo.y, p.realmo.z + (4 * FRACUNIT) + p.realmo.info.height, award)
					S_StartSound(nil, sfx_cgot)
					p.nightstime = -32770
					stagefailed = false -- Stage has been beaten if enough rings have been collected
				end
			end
		end
	end

	if not alive or alive < 0 then
		-- do not save death status lol
		G_ExitLevel()
	end
end)
local cv_timetic = CV_FindVar("timerres")

hud.add(function(v, p, _)
	if mapheaderinfo[gamemap].oldspecial then
		local sborings = v.cachePatch("STTRINGS")
		if not p.spectator and G_IsSpecialStage() then
			local sboscore = v.cachePatch("STTSCORE")
			local sbotime = v.cachePatch("STTTIME")
			local sbocolon = v.cachePatch("STTCOLON")
			local sboperiod = v.cachePatch("STTPERIO")
			local livesback = v.cachePatch("STLIVEBK")
			local stlivex = v.cachePatch("STLIVEX")

			local tics = p.realtime
			local minutes = G_TicsToMinutes(tics, true)
			local seconds = G_TicsToSeconds(tics)
			local tictrn = G_TicsToCentiseconds(tics)

			--just cuz I CAN'T enable rings, scores and lives hud I HAVE TO DRAW IT HERE >:(

			v.draw(hudinfo[HUD_SCORE].x, hudinfo[HUD_SCORE].y, sboscore, hudinfo[HUD_SCORE].f | V_HUDTRANS)
			v.drawNum(hudinfo[HUD_SCORENUM].x, hudinfo[HUD_SCORENUM].y, p.score, hudinfo[HUD_SCORENUM].f | V_HUDTRANS)

			v.draw(hudinfo[HUD_TIME].x, hudinfo[HUD_TIME].y, sbotime, hudinfo[HUD_TIME].f | V_HUDTRANS)

			if cv_timetic.value == 3 then
				v.drawNum(hudinfo[HUD_SECONDS].x, hudinfo[HUD_SECONDS].y, tics, hudinfo[HUD_SECONDS].f | V_HUDTRANS)
			else
				v.drawNum(hudinfo[HUD_MINUTES].x, hudinfo[HUD_MINUTES].y, minutes, hudinfo[HUD_MINUTES].f | V_HUDTRANS)
				v.draw(
					hudinfo[HUD_TIMECOLON].x,
					hudinfo[HUD_TIMECOLON].y,
					sbocolon,
					hudinfo[HUD_TIMECOLON].f | V_HUDTRANS
				)
				v.drawPaddedNum(
					hudinfo[HUD_SECONDS].x,
					hudinfo[HUD_SECONDS].y,
					seconds,
					2,
					hudinfo[HUD_SECONDS].f | V_HUDTRANS
				)
				if cv_timetic.value == 2 then
					v.draw(
						hudinfo[HUD_TIMETICCOLON].x,
						hudinfo[HUD_TIMETICCOLON].y,
						sboperiod,
						hudinfo[HUD_TIMETICCOLON].f | V_HUDTRANS
					)
					v.drawPaddedNum(
						hudinfo[HUD_TICS].x,
						hudinfo[HUD_TICS].y,
						tictrn,
						2,
						hudinfo[HUD_TICS].f | V_HUDTRANS
					)
				end
			end

			--lifes!!!
			v.drawScaled(
				hudinfo[HUD_LIVES].x * FRACUNIT,
				hudinfo[HUD_LIVES].y * FRACUNIT,
				FRACUNIT / 2,
				livesback,
				hudinfo[HUD_LIVES].f | V_HUDTRANS | V_PERPLAYER
			)
			local colormap = v.getColormap(p.skin, p.mo.color)
			local face = v.getSprite2Patch(p.skin, "XTRA", false, 0, 0, 0)
			v.drawScaled(
				hudinfo[HUD_LIVES].x * FRACUNIT,
				hudinfo[HUD_LIVES].y * FRACUNIT,
				FRACUNIT / 2,
				face,
				hudinfo[HUD_LIVES].f | V_HUDTRANS | V_PERPLAYER,
				colormap
			)
			v.draw(
				hudinfo[HUD_LIVES].x + 22,
				hudinfo[HUD_LIVES].y + 10,
				stlivex,
				hudinfo[HUD_LIVES].f | V_PERPLAYER | V_HUDTRANS
			)

			if p.lives == INFLIVES then
				v.drawString(
					(hudinfo[HUD_LIVES].x + 50),
					(hudinfo[HUD_LIVES].y + 8),
					"\x16",
					hudinfo[HUD_LIVES].f | V_PERPLAYER | V_HUDTRANS
				)
			else
				v.drawString(
					(hudinfo[HUD_LIVES].x + 58),
					(hudinfo[HUD_LIVES].y + 8),
					tostring(p.lives),
					hudinfo[HUD_LIVES].f | V_PERPLAYER | V_HUDTRANS,
					"right"
				)
			end

			v.drawString(
				(hudinfo[HUD_LIVES].x + 18),
				hudinfo[HUD_LIVES].y,
				skins[p.skin].hudname,
				hudinfo[HUD_LIVES].f | V_PERPLAYER | V_YELLOWMAP | V_HUDTRANS
			)
		end

		v.draw(hudinfo[HUD_RINGS].x, hudinfo[HUD_RINGS].y, sborings, hudinfo[HUD_RINGS].f | V_HUDTRANS | V_PERPLAYER)

		--TODO: remove code duplication
		--count the spheres (again)
		local total_spheres = 0
		for p in players.iterate do
			total_spheres = total_spheres + p.spheres
		end
		--draw spheres as rings!
		v.drawNum(hudinfo[HUD_RINGSNUM].x, hudinfo[HUD_RINGSNUM].y, total_spheres, hudinfo[HUD_RINGSNUM].f | V_HUDTRANS | V_PERPLAYER)

		--AND FINALLY!!!
		--OLD SPECIAL STAGE HUD!!!!
		local sstimer = p.nightstime
		local getall = v.cachePatch("GETALL")
		local timeup = v.cachePatch("TIMEUP")
		local total = mapheaderinfo[gamemap].ssspheres

		if total > 0 then
			v.drawNum(
				hudinfo[HUD_SS_TOTALRINGS].x,
				hudinfo[HUD_SS_TOTALRINGS].y,
				total,
				hudinfo[HUD_SS_TOTALRINGS].f | V_HUDTRANS | V_PERPLAYER
			)
		end

		if leveltime < 5 * TICRATE and total > 0 and not p.special_died then
			v.draw(hudinfo[HUD_GETRINGS].x, hudinfo[HUD_GETRINGS].y, getall, hudinfo[HUD_GETRINGS].f | V_HUDTRANS | V_PERPLAYER)
			v.drawNum(
				hudinfo[HUD_GETRINGSNUM].x,
				hudinfo[HUD_GETRINGSNUM].y,
				total,
				hudinfo[HUD_GETRINGSNUM].f | V_HUDTRANS | V_PERPLAYER
			)
		end

		if sstimer ~= -32770 then
			if sstimer > 0 then
				v.drawString(
					hudinfo[HUD_TIMELEFT].x,
					hudinfo[HUD_TIMELEFT].y,
					"TIME LEFT",
					hudinfo[HUD_TIMELEFT].f | V_HUDTRANS | V_PERPLAYER
				)
				v.drawNum(
					hudinfo[HUD_TIMELEFTNUM].x,
					hudinfo[HUD_TIMELEFTNUM].y,
					sstimer / TICRATE,
					hudinfo[HUD_TIMELEFT].f | V_HUDTRANS | V_PERPLAYER
				)
			else
				v.draw(hudinfo[HUD_TIMEUP].x, hudinfo[HUD_TIMEUP].y, timeup, hudinfo[HUD_TIMEUP].f | V_HUDTRANS | V_PERPLAYER)
			end
		end
	end
end)
