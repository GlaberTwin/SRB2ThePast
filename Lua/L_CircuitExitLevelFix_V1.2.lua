--Pikaspoop's bandaid patch for Circuit freezing servers
--Version 1.2, netvars baybee

--First of all, make sure this isn't already loaded.
--assuming this is loaded, we should have our namespace already.
if CircuitDnfFreezeFix == true then
	print("Wait, the Circuit patch already exists! I don't need to load.")
	return --it's not nil, that means it exists already.
else
	--Okay so it's not loaded. Let's do that.
	--lets make a namespace, just set it to be true
	rawset(_G, "CircuitDnfFreezeFix", true)
	print("Circuit DNF freeze fix is activating!")
	--that's all we gotta do, run the rest of the script now
end


--local variable to track is a stage is circuit
local isMapCircuit = false
--did any one player finish?
local didAPlayerDNF = false
--countdown variable
local finishCount = 0

local function resetCircuitVars()
	--first reset the finish check
	didAPlayerDNF = false
	--there's a global variable that tracks this, niceeeee
	isMapCircuit = false
	--reset finishCount
	finishCount = 0
end

--check on map load is the gametype is circuit
addHook("MapLoad", do
	resetCircuitVars() --my paranoid ass did this just in case
	isMapCircuit = circuitmap
end)

--this hooks does all the work.
--using postthinkframe so that mapload runs before this always
addHook("PostThinkFrame", function()
	--do not run hook if we don't need to
	if not isMapCircuit or finishCount ~= 0 then
		return
	end
	
	--Check if any player has Timed Over
	for player in players.iterate do
		if (player.pflags & PF_GAMETYPEOVER) then
			--gonna do some bullshit with this
			--We gonna exitlevel once leveltime equals or exceeds finishCount
			finishCount = leveltime + (3 * TICRATE) --3 seconds to add some time after
			--also set this to true
			didAPlayerDNF = true
			break
		end
	end
end)

addHook("ThinkFrame", do
	if isMapCircuit == true and didAPlayerDNF == true and leveltime >= finishCount then
		--reset variables to ensure we don't run more than once
		resetCircuitVars()
		--Finally exit the level
		G_ExitLevel()
	end
end)

--syncronize the variables used
addHook("NetVars", function(net)
	didAPlayerDNF = net(didAPlayerDNF)
	isMapCircuit = net(isMapCircuit)
	finishCount = net(finishCount)
end)