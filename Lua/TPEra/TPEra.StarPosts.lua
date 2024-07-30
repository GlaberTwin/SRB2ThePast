---------------------------------
--SRB2:TP Era Skins: Star Posts-- // Barrels O' Fun (Edited by MIDIMan)
---------------------------------


---------Table Contents---------
--Skin # {Idle,Spin,Flashing} --
--------------------------------
local starpost = {
	{S_STARPOST_IDLE,		S_STARPOST_SPIN,		S_STARPOST_FLASH},		//1 - 2.2
	{S_FD_STARPOST_IDLE,	S_FD_STARPOST_SPIN,		S_FD_STARPOST_FLASH} 	//2 - Final Demo
}

----------------
--Do The Stuff--
----------------

local starposts = {} 
addHook("NetVars", function(network) //Sync table in Netgame
	starposts = network(starposts)
end)

addHook("MobjSpawn", SRB2TP_UpdateObject, MT_STARPOST)

addHook("MapLoad", function() --Starpost Skins Map Load
	starposts = {} -- Clear Table on Map Load
	for m in mobjs.iterate() do
		if not (m and m.valid) then continue end
		
		if m.type == MT_STARPOST then
			if udmf then
				m.itemskin = m.spawnpoint.args[2]
			elseif m.spawnpoint.options & MTF_EXTRA then -- Enable Starpost skins if Extra is ticked. and rotations aren't negative.
				if m.spawnpoint.options & MTF_AMBUSH then -- If Ambush is ticked, use extrainfo for post order, and rotation for skins
					m.itemskin = (FixedAngle(m.spawnpoint.angle)>>FRACBITS)
					m.health = m.spawnpoint.extrainfo+1
				else					-- Otherwise use rotations for post order, and use extrainfo for skins
					m.itemskin = m.spawnpoint.extrainfo
					m.health = ((FixedAngle(m.spawnpoint.angle)>>FRACBITS))+1
				end
			end
			
			if m.itemskin then
				starposts[#starposts+1]=m -- Append to table for each valid itemskin starpost
				
				if not multiplayer and consoleplayer.starpostnum >= m.health then -- If you die in Singleplayer restore flashing on map reload.
					m.state = starpost[min(m.itemskin,#starpost)][3]
				end			
			else	
				m.state = m.info.spawnstate
				if not multiplayer and consoleplayer.starpostnum >= m.health then -- If you die in Singleplayer restore flashing on map reload.
					m.state = m.info.seestate
				end	
			end
		end
	end
end)

addHook("PostThinkFrame", function() --Starpost Skins Animations
	for _,m in ipairs(starposts) do -- Only iterate those in starposts list
		if m and m.valid
			if m.state == m.info.spawnstate then
				m.state = starpost[min(m.itemskin,#starpost)][1]
			elseif m.state == m.info.painstate then
				m.state = starpost[min(m.itemskin,#starpost)][2]
			elseif m.state == m.info.seestate then
				m.state = starpost[min(m.itemskin,#starpost)][3]
			end
		end
	end
end)

