// Function: A_RadarLook
//
// Description: Look for a player and set your target to them. Can see through walls too?
// If the ambush flag is set, this just executes A_Look (functionality coded by MIDIMan)
//
// var2 = If 1, only change to seestate. If 2, only play seesound. If 0, do both.
//
local function totalplayercount()
    local i = 0
    for p in players.iterate i = $+1 end
    return i
end

function A_RadarLook(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	-- If the ambush flag is set, just use A_Look
	if (actor.flags2 & MF2_AMBUSH)
		A_Look(actor, var1, var2)
		return
	end
	
	local count = totalplayercount()
	local dist = 2048*FRACUNIT -- ?
	local i = 0
	while (P_SupermanLook4Players(actor) and i < count)
		if actor.target and actor.target.valid and (P_AproxDistance(actor.x - actor.target.x, actor.y - actor.target.y) < dist)
		and abs(actor.angle - R_PointToAngle2(actor.x, actor.y, actor.target.x, actor.target.y)) < ANGLE_45 -- look only 45 degrees either way
		// go into chase state
			if (not var2)
				actor.state = S_SEESTATE
				A_PlaySeeSound(actor)
			elseif (var2 == 1) // Only go into seestate
				actor.state = S_SEESTATE
			elseif (var2 == 2) // Only play seesound
				A_PlaySeeSound(actor)-- do attack thing or something
			end
		end
	i = $ + 1
	end
end
