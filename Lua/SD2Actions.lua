// Sonic Doom 2 - SOC Actions

rawset(_G, "SD2_StopSound", function(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	if var1 then S_StopSoundByID(actor, var1)
	else S_StopSound(actor) end
end)

// Makes enemies non-solid when called
rawset(_G, "SD2_Fall", function(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	// Make the enemy non-solid so players can move through it
	actor.flags = $ & ~MF_SOLID
end)

// Version of A_Chase that plays the enemy's "active sound" at random intervals, 
// just like in Doom
rawset(_G, "SD2_Chase", function(actor, var1, var2)
	if not (actor and actor.valid) then return end
	
	A_Chase(actor, var1, var2)
	
	if actor.info.activesound and P_RandomByte() < 3
		S_StartSound(actor, actor.info.activesound)
	end
end)
