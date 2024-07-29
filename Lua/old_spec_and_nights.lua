-- SRB2 Old Special Stage System - Created by sdas, slightly reworked for SRB2TP by MIDIMan

--i fucking hate srb2's code
--IT DOESN'T HAVE AN OPTION TO DISABLE THE: Get n spheres! TEXT IN OLD SPECIAL STAGES WTF

local changed_objs = false
local loaded_hud = false
rawset(_G, "total_spheres", 0) -- Turned into a global variable so the TGF ring item can use it -- MIDIMan

addHook("MapLoad", function(id)
-- table.insert(preMapLoadHooks, function()
	total_spheres = 0;
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
			hud.disable("nightsrecords")
			loaded_hud = true
		end
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

addHook("NetVars", function(net)
	total_spheres = net(total_spheres);
end)

addHook("TouchSpecial", function(ring, t)
	if mapheaderinfo[gamemap].oldspecial or (mapheaderinfo[gamemap].oldnights and not G_IsSpecialStage()) then
		if t.valid and t.player and t.player.valid then
			if t.player.powers[pw_flashing] then
				return true
			end
			if ring and t and ring.valid then

				if G_IsSpecialStage() or mapheaderinfo[gamemap].oldnights then
					t.player.spheres = t.player.spheres + 1
				else
					t.player.rings = 0
				end
				total_spheres = total_spheres + 1;
			end
		end
	end
end, MT_RING)

addHook("MapThingSpawn", function(mobj, thing)
	if mapheaderinfo[gamemap].oldspecial or (mapheaderinfo[gamemap].oldnights and not G_IsSpecialStage(gamemap)) then
		if mobj.type == MT_BLUESPHERE or mobj.type == MT_NIGHTSCHIP then
			P_SpawnMobj(mobj.x, mobj.y, mobj.z, MT_RING)
			P_RemoveMobj(mobj)
			return true
		elseif mobj.type == MT_RING and not mapheaderinfo[gamemap].allowrings then
			P_RemoveMobj(mobj)
		elseif mapheaderinfo[gamemap].allowrings then
			thing.type = 0
		end
	end

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

local award = nil
addHook("PlayerSpawn", function(p)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() or not p.valid then
		return
	end

	p.nightstime = mapheaderinfo[gamemap].sstimer * TICRATE

	award = nil
	if p.special_died == nil then
		p.special_died = false
	elseif p.special_died then
		p.spectator = true
	end
end)

addHook("MobjDeath", function(mo)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end

	if mo.player then
		mo.player.special_died = true
		mo.player.deadtimer = 1
	end
end)

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

addHook("MobjDamage", function(mo, _, _, t)
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end

	if t < 128 and mo and mo.valid and mo.player and mo.player.valid then
		P_DoPlayerPain(mo.player)
		P_PlayRinglossSound(mo)
		return true
	end
end)

addHook("ThinkFrame", function()
	local alive = 0
	if not mapheaderinfo[gamemap].oldspecial or G_IsSpecialStage() then
		return
	end

	for p in players.iterate do
		if p and p.valid and p.special_died and not p.deadtimer then
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
		if p.valid and p.mo and p.mo.valid then
			if p.nightstime <= 0 and p.nightstime > -32768 then
				p.exiting = (14 * TICRATE) / 5 + 1
				p.nightstime = -32769
				p.mo.momx = 0
				p.mo.momy = 0
				--i dindn't saw this line in srb2 fd code but i added it just for fix the accidental emerald pickuping
				p.mo.momz = 0
			elseif p.nightstime > 0 then
				local rmtic = 1

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
					p.exiting = (14 * TICRATE) / 5 + 1
					p.mo.momx = 0
					p.mo.momy = 0
					--i dindn't saw this line in srb2 fd code but i added it just for fix the accidental emerald pickuping
					p.mo.momz = 0
					if award == nil then
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
					end
					P_SpawnMobj(p.realmo.x, p.realmo.y, p.realmo.z + (4 * FRACUNIT) + p.realmo.info.height, award)
					S_StartSound(nil, sfx_cgot)
					p.nightstime = -32770
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

hud.add(function(v, p, cam)
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

		v.draw(hudinfo[HUD_RINGS].x, hudinfo[HUD_RINGS].y, sborings, hudinfo[HUD_RINGS].f | V_HUDTRANS)
		--draw spheres as rings!
		v.drawNum(hudinfo[HUD_RINGSNUM].x, hudinfo[HUD_RINGSNUM].y, total_spheres, hudinfo[HUD_RINGSNUM].f | V_HUDTRANS)

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
				hudinfo[HUD_SS_TOTALRINGS].f | V_HUDTRANS
			)
		end

		if leveltime < 5 * TICRATE and total > 0 and not p.special_died then
			v.draw(hudinfo[HUD_GETRINGS].x, hudinfo[HUD_GETRINGS].y, getall, hudinfo[HUD_GETRINGS].f | V_HUDTRANS)
			v.drawNum(
				hudinfo[HUD_GETRINGSNUM].x,
				hudinfo[HUD_GETRINGSNUM].y,
				total,
				hudinfo[HUD_GETRINGSNUM].f | V_HUDTRANS
			)
		end

		if sstimer ~= -32770 then
			if sstimer > 0 then
				v.drawString(
					hudinfo[HUD_TIMELEFT].x,
					hudinfo[HUD_TIMELEFT].y,
					"TIME LEFT",
					hudinfo[HUD_TIMELEFT].f | V_HUDTRANS
				)
				v.drawNum(
					hudinfo[HUD_TIMELEFTNUM].x,
					hudinfo[HUD_TIMELEFTNUM].y,
					sstimer / TICRATE,
					hudinfo[HUD_TIMELEFT].f | V_HUDTRANS
				)
			else
				v.draw(hudinfo[HUD_TIMEUP].x, hudinfo[HUD_TIMEUP].y, timeup, hudinfo[HUD_TIMEUP].f | V_HUDTRANS)
			end
		end
	end
end)
