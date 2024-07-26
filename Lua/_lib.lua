local act = 0
local mts = false

local function tableContainsId(table, value)
	for i = 1, #table do
		if table[i].id == value then
			return true
		end
	end
	return false
end

local function shallowcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

--------------------------------------------------------------------------------
--#region Map loading hook
--------------------------------------------------------------------------------
if mapLoadHooks ~= nil then
	print("SdasLibrary already added")
	return
end
rawset(_G, "mapLoadHooks", {})
rawset(_G, "preMapLoadHooks", {})
rawset(_G, "postMapLoadHooks", {})

local postpremapload

addHook("MapThingSpawn", function()
	if not mts then
		for _, v in ipairs(preMapLoadHooks) do
			if type(v) == "function" then
				v()
			end
		end

		postpremapload()

		mts = true
	end
end)

addHook("ThinkFrame", function()
	if act == 3 then
		for _, v in ipairs(mapLoadHooks) do
			if type(v) == "function" then
				v()
			end
		end
		for _, v in ipairs(postMapLoadHooks) do
			if type(v) == "function" then
				v()
			end
		end
		act = 10
	else
		act = act + 1
	end
end)

addHook("MapChange", function(_)
	act = 0
	mts = false
end)

--#endregion
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--#region Mobj and States temporary replacing
--------------------------------------------------------------------------------
rawset(_G, "MASTR_ReplaceTable", {})
rawset(_G, "MASTR_QueuedTable", "none");
rawset(_G, "MASTR_CurrentTable", "none");

rawset(_G, "QR_MOBJ", 1)
rawset(_G, "QR_STATE", 2)

local objects_backup = {}
local states_backup = {}
local queue = {}

rawset(_G, "MASTR_GetMobjectData", function(ty)
	if mobjinfo[ty] then
		local d = mobjinfo[ty]
		local mobj = {
			doomednum = d.doomednum,
			spawnstate = d.spawnstate,
			spawnhelath = d.spawnhealth,
			seestate = d.seestate,
			seesound = d.seesound,
			reactiontime = d.reactiontime,
			attacksound = d.attacksound,
			painstate = d.painstate,
			painchance = d.painchance,
			painsound = d.painsound,
			meleestate = d.meleestate,
			missilestate = d.missilestate,
			deathstate = d.deathstate,
			xdeathstate = d.xdeathstate,
			deathsound = d.deathsound,
			speed = d.speed,
			radius = d.radius,
			height = d.height,
			dispoffset = d.dispoffset,
			mass = d.mass,
			damage = d.damage,
			activesound = d.activesound,
			flags = d.flags,
			raisestate = d.raisestate,
		}
		return mobj
	else
		return nil
	end
end)

rawset(_G, "MASTR_GetStateData", function(ty)
	if states[ty] then
		local d = states[ty]
		local state = {
			sprite = d.sprite,
			frame = d.frame,
			tics = d.tics,
			action = d.action,
			--TODO: when mr get merged, adapt it
			var1 = d.var1,
			var2 = d.var2,
			nextstate = d.nextstate,
		}
		return state
	else
		return nil
	end
end)

---@param ty number
---@param replace table
---@return boolean
local function replace_mobj_info(ty, replace)
	local mo = MASTR_GetMobjectData(ty)

	if mo then
		objects_backup[ty] = mo
		mobjinfo[ty] = replace
		return true
	else
		return false
	end
end

---@param ty number
---@param replace table
---@return boolean
local function replace_state_info(ty, replace)
	local stt = MASTR_GetStateData(ty)

	if stt then
		states_backup[ty] = stt
		states[ty] = replace
		return true
	else
		return false
	end
end

local function replace(kind, id, data)
	-- replaced[id] = data;
	if kind == QR_MOBJ then
		replace_mobj_info(id, data)
	elseif kind == QR_STATE then
		replace_state_info(id, data)
	end
end


rawset(_G, "MASTR_QueueReplacement", function(kind, ty, data)
	table.insert(queue, {kind = kind, ty = ty, data = data});
end);

postpremapload = function()
	if (not MASTR_QueuedTable or MASTR_QueuedTable == "none") then
		if mapheaderinfo[gamemap].objecttable then
			MASTR_QueuedTable = mapheaderinfo[gamemap].objecttable;
		end

		MASTR_CurrentTable = "none"
	end

	for i, q in pairs(objects_backup) do
		mobjinfo[i] = q
	end
	objects_backup = {}

	for i, q in pairs(states_backup) do
		states[i] = q
	end
	states_backup = {}

	if MASTR_QueuedTable and type(MASTR_QueuedTable) == "string" and MASTR_QueuedTable ~= "none" then
		print(MASTR_QueuedTable);
		for _, q in ipairs(MASTR_ReplaceTable[MASTR_QueuedTable]) do
			if not tableContainsId(queue, q.ty) then
				replace(q.kind, q.ty, shallowcopy(q.data))
			end
		end

		MASTR_CurrentTable = MASTR_QueuedTable;
		MASTR_QueuedTable = "none"
	end

	for _, q in ipairs(queue) do
		replace(q.kind, q.ty, shallowcopy(q.data))
	end
	queue = {};
end

--exmaple of object replacing
-- table.insert(preMapLoadHooks, function()
-- 	local obj = MASTR_GetMobjectData(MT_RING);
-- 	obj.spawnstate = S_FAN;
-- 	MASTR_ReplaceTable["test"] = {
-- 		{
-- 			kind = QR_MOBJ,
-- 			ty = MT_RING,
-- 			data = obj
-- 		}
-- 	}
-- 	MASTR_QueuedTable = "test"
-- end)
