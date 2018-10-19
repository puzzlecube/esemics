-- first define the special sauce!
minetest.register_node("technic_corrupt:liquid_corrupt_mese_source", {
	description = "Liquid Corrupt mese source",
	drawtype = "liquid",
	tiles = {
		{
			name = "technic_corrupt_liquid_corrupt_mese_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	special_tiles = {
		-- New-style liquid guptonium source material (mostly unused)
		{
			name = "technic_corrupt_liquid_corrupt_mese_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
			backface_culling = false,
		},
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "technic_corrupt:liquid_corrupt_mese_flowing",
	liquid_alternative_source = "technic_corrupt:liquid_corrupt_mese_source",
    liquid_viscosity = 10,
    liquid_range = 16,
	liquid_renewable = true,
	light_source = 4,
	damage_per_second = 10,
	post_effect_color = {a = 191, r = 56, g = 4, b = 64},
	groups = {liquid_corrupt_mese = 3, liquid = 2, igniter = 1, radioactive = 200},
})

minetest.register_node("technic_corrupt:liquid_corrupt_mese_flowing", {
	description = "Flowing Liquid Corrupt mese",
	drawtype = "flowingliquid",
	tiles = {"technic_corrupt_liquid_corrupt_mese.png"},
	special_tiles = {
		{
			name = "technic_corrupt_liquid_corrupt_mese_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "technic_corrupt_liquid_corrupt_mese_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "technic_corrupt:liquid_corrupt_mese_flowing",
	liquid_alternative_source = "technic_corrupt:liquid_corrupt_mese_source",
    liquid_viscosity = 10,
    liquid_range = 16,
	liquid_renewable = true,
	light_source = 3,
	damage_per_second = 10,
	post_effect_color = {a = 191, r = 56, g = 4, b = 64},
	groups = {liquid_guptonium = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1, radioactive = 199},
})

bucket.register_liquid(
	"technic_corrupt:liquid_corrupt_mese_source",
	"technic_corrupt:liquid_corrupt_mese_flowing",
	"technic_corrupt:bucket_corrupt_mese",
	"bucket_guptonium.png",
	"Liquid Corrupt Mese Bucket"
)
local mgriefing = true

minetest.register_abm({
	label = "Liquid corrupt mese: boil-off water (sources)",
	nodenames = {"group:water"},
	neighbors = {"technic_corrupt:liquid_corrupt_mese_source", "technic_corrupt:liquid_corrupt_mese_flowing"},
	interval = 3,
	chance = 3,
	action = function(pos, node)
		minetest.remove_node(pos)
	end,
})

minetest.register_abm({
	label = "Liquid corrupt mese: boil-off water (flowing)",
	nodenames = {"technic_corrupt:liquid_corrupt_mese_source", "technic_corrupt:liquid_corrupt_mese_flowing"},
	neighbors = {"group:water"},
	interval = 3,
	chance = 3,
	action = function(pos, node)
		minetest.set_node(pos, {name="technic_corrupt:liquid_corrupt_mese_source"})
	end,
})

minetest.register_abm({
	label = "Liquid corrupt mese: become chernobylite",
	nodenames = {"technic_corrupt:liquid_corrupt_mese_flowing"},
	interval = 5,
	chance = (mgriefing and 10 or 1),
	action = function(pos, node)
		minetest.set_node(pos, {name="esem:corrupt_mese"})
	end,
})

minetest.register_abm({
	label = "Liquid corrupt mese: cleanup",
	nodenames = {"technic_corrupt:liquid_corrupt_mese_source", "technic_corrupt:liquid_corrupt_mese_flowing"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.set_node(pos, {name="esem:corrupt_mese"})
	end,
})

if mgriefing then
	minetest.register_abm({
		label = "Liquid corrupt mese: griefing",
		nodenames = {"technic_corrupt:liquid_corrupt_mese_source", "technic_corrupt:liquid_corrupt_mese_flowing"},
		interval = 2,
		chance = 2,
		action = function(pos, node)
      local catastrophic = math.random(0, 1000000)
      if catastrophic == 0 then -- its a flippin miracle
        tnt.boom(pos, {radius=16,damage_radius=32}) -- BIG FAT FLIPPIN' BANG!
        minetest.set_node(pos, {name="mese:shadowmese"})
      elseif catastrophic == 1000000 then
        minetest.remove_node(pos)
      end
      local vt = {
				vector.new(1,0,0),
				vector.new(-1,0,0),
				vector.new(0,0,1),
				vector.new(0,0,-1),
				vector.new(0,-1,0),
			}
      if math.random(1,5) == 1 then
          table.insert(vt, #vt+1, vector.new(0,1,0))
        end
			for _, offset in ipairs(vt) do
				if math.random(1,2) == 1 then
          if minetest.get_node(vector.add(pos,offset)).name == "esem:corrupt_mese" and math.random(1,10) == 10 then
            minetest.set_node(vector.add(pos,offset), {name="technic_corrupt:liquid_corrupt_mese_source"})
					else
            minetest.dig_node(vector.add(pos, offset))
          end
        else
          local undp = vector.add(pos,vector.new(0,1,0))
          local under = minetest.get_node(undp).name
          local undug = minetest.get_node_group(under, "unbreakable")
          local corrg = minetest.get_node_group(under, "corrosion_resistant")
          if under ~= "esem:corrupt_mese" and under ~= "technic_corrupt_liquid_corrupt_mese_source" and undug == 0 and corrg == 0 then
            minetest.dig_node(undp)
          end
        end
			end
		end,
	})
end


--[[
 The corrupt mese driven EU generator.
A very large, advanced, and sometimes DEADLY machine providing vast amounts of power.
Very efficient but also expensive to run as it needs corrupt mese.
Provides 10000000 HV EUs for one week (only counted when loaded).

The cprrupt mese reactor core requires a casing of water and a protective
shield to work.  This is checked now and then and if the casing is not
intact the reactor will melt down!
--]]

local burn_ticks = 7 * 24 * 60 * 60  -- Seconds
local power_supply = 100000000  -- EUs
local fuel_type = "esem:corrupt_mese"  -- The reactor burns this
local digiline_meltdown = technic.config:get_bool("enable_corrupt_reactor_digiline_selfdestruct")
local digiline_remote_path = minetest.get_modpath("digiline_remote")

local S = technic.getter

local reactor_desc = S("@1 Corrupt Mese Nuclear Reactor Core", S("HV"))
local cable_entry = "^technic_cable_connection_overlay.png"

-- FIXME: Recipe should make more sense like a rod recepticle, steam chamber, HV generator?
minetest.register_craft({
	output = 'technic_corrupt:hv_corrupt_reactor_core',
	recipe = {
		{'technic:carbon_plate',          'guptonium:guptonite_glass', 'technic:carbon_plate'},
		{'technic:composite_plate',       'technic:machine_casing',    'technic:composite_plate'},
		{'mese:hardmese',                 'technic:hv_cable',          'mese:hardmese'},
	}
})

local function make_reactor_formspec(meta)
	local f = "size[8,9]"..
	"label[0,0;"..S("Corrupt Mese Compartment").."]"..
	"list[current_name;src;2,1;3,2;]"..
	"list[current_player;main;0,5;8,4;]"..
	"listring[]"..
	"button[5.5,1.5;2,1;start;Start]"..
	"checkbox[5.5,2.5;autostart;automatic Start;"..meta:get_string("autostart").."]"
	if not digiline_remote_path then
		return f
	end
	local digiline_enabled = meta:get_string("enable_digiline")
	f = f.."checkbox[0.5,2.8;enable_digiline;Enable Digiline;"..digiline_enabled.."]"
	if digiline_enabled ~= "true" then
		return f
	end
	return f..
		"button_exit[4.6,3.69;2,1;save;Save]"..
		"field[1,4;4,1;remote_channel;Digiline Remote Channel;${remote_channel}]"
end

local SS_OFF = 0
local SS_DANGER = 1
local SS_CLEAR = 2

local reactor_siren = {}
local function siren_set_state(pos, state)
	local hpos = minetest.hash_node_position(pos)
	local siren = reactor_siren[hpos]
	if not siren then
		if state == SS_OFF then return end
		siren = {state=SS_OFF}
		reactor_siren[hpos] = siren
	end
	if state == SS_DANGER and siren.state ~= SS_DANGER then
		if siren.handle then minetest.sound_stop(siren.handle) end
		siren.handle = minetest.sound_play("technic_corrupt_reactor_siren_danger_loop",
				{pos=pos, gain=1.5, loop=true, max_hear_distance=256})
		siren.state = SS_DANGER
	elseif state == SS_CLEAR then
		if siren.handle then minetest.sound_stop(siren.handle) end
		local clear_handle = minetest.sound_play("technic_corrupt_reactor_siren_clear",
				{pos=pos, gain=1.5, loop=false, max_hear_distance=256})
		siren.handle = clear_handle
		siren.state = SS_CLEAR
		minetest.after(10, function()
			if siren.handle ~= clear_handle then return end
			minetest.sound_stop(clear_handle)
			if reactor_siren[hpos] == siren then
				reactor_siren[hpos] = nil
			end
		end)
	elseif state == SS_OFF and siren.state ~= SS_OFF then
		if siren.handle then minetest.sound_stop(siren.handle) end
		reactor_siren[hpos] = nil
	end
end

local function siren_danger(pos, meta)
	meta:set_int("siren", 1)
	siren_set_state(pos, SS_DANGER)
end

local function siren_clear(pos, meta)
	if meta:get_int("siren") ~= 0 then
		siren_set_state(pos, SS_CLEAR)
		meta:set_int("siren", 0)
	end
end

--[[
The standard reactor structure consists of a 9x9x9 cube.  A cross
section through the middle:

	CCCC CCCC
	CBBB BBBC
	CBLL LLBC
	CBLWWWLBC
	CBLW#WLBC
	CBLW|WLBC
	CBLL|LLBC
	CBBB|BBBC
	CCCC|CCCC
	C = Anything, B = Hardmese, L = Depleted Mese,
	W = water node, # = reactor core, | = HV cable

The man-hole is optional (but necessary for refueling).

For the reactor to operate and not melt down, it insists on the inner
7x7x7 portion (from the core out to the hardmese)
being intact.  Intactness only depends on the number of nodes of the
right type in each layer.  The water layer must have water in all but
at most one node; the depleated mese and hardmese concrete layers must
have the right material in all but at most two nodes.  The permitted
gaps are meant for the cable and man-hole, but can actually be anywhere
and contain anything.  For the reactor to be useful, a cable must
connect to the core, but it can go in any direction.

The outer layer of the standard structure is not required
for the reactor to operate.  It is noted here because it used to
be mandatory, and for historical reasons (that it predates the
implementation of radiation) it needs to continue being adequate
shielding of legacy reactors.  If it ever ceases to be adequate
shielding for new reactors, legacy ones should be grandfathered.

For legacy reasons, if the reactor has a stainless steel layer instead
of a lead layer it will be converted to a lead layer.
--]]
local function reactor_structure_badness(pos)
	local vm = VoxelManip()
	local pos1 = vector.subtract(pos, 3)
	local pos2 = vector.add(pos, 3)
	local MinEdge, MaxEdge = vm:read_from_map(pos1, pos2)
	local data = vm:get_data()
	local area = VoxelArea:new({MinEdge=MinEdge, MaxEdge=MaxEdge})

	local c_blast_concrete = minetest.get_content_id("mese:hardmese")
	local c_lead = minetest.get_content_id("esem:depleted_mese")
	local c_steel = minetest.get_content_id("esem:corrupt_mese") -- OOh a dangerous way to deplete mese
	local c_water_source = minetest.get_content_id("default:water_source")
	local c_water_flowing = minetest.get_content_id("default:water_flowing")

	local blast_layer, steel_layer, lead_layer, water_layer = 0, 0, 0, 0

	for z = pos1.z, pos2.z do
	for y = pos1.y, pos2.y do
	for x = pos1.x, pos2.x do
		local cid = data[area:index(x, y, z)]
		if x == pos1.x or x == pos2.x or
		   y == pos1.y or y == pos2.y or
		   z == pos1.z or z == pos2.z then
			if cid == c_blast_concrete then
				blast_layer = blast_layer + 1
			end
		elseif x == pos1.x+1 or x == pos2.x-1 or
		       y == pos1.y+1 or y == pos2.y-1 or
		       z == pos1.z+1 or z == pos2.z-1 then
			if cid == c_lead then
				lead_layer = lead_layer + 1
			elseif cid == c_steel then
				steel_layer = steel_layer + 1
			end
		elseif x == pos1.x+2 or x == pos2.x-2 or
		       y == pos1.y+2 or y == pos2.y-2 or
		       z == pos1.z+2 or z == pos2.z-2 then
			if cid == c_water_source or cid == c_water_flowing then
				water_layer = water_layer + 1
			end
		end
	end
	end
	end

	if steel_layer >= 96 then
		for z = pos1.z+1, pos2.z-1 do
		for y = pos1.y+1, pos2.y-1 do
		for x = pos1.x+1, pos2.x-1 do
			local vi = area:index(x, y, z)
			if x == pos1.x+1 or x == pos2.x-1 or
			   y == pos1.y+1 or y == pos2.y-1 or
			   z == pos1.z+1 or z == pos2.z-1 then
				if data[vi] == c_steel then
					data[vi] = c_lead
				end
			end
		end
		end
		end
		vm:set_data(data)
		vm:write_to_map()
		lead_layer = steel_layer
	end

	if water_layer > 25 then water_layer = 25 end
	if lead_layer > 96 then lead_layer = 96 end
	if blast_layer > 216 then blast_layer = 216 end
	return (25 - water_layer) + (96 - lead_layer) + (216 - blast_layer)
end


local function melt_down_reactor(pos)
	minetest.log("action", "A corrupt reactor melted down at "..minetest.pos_to_string(pos))
	minetest.sound_play("technic_corrupt_reactor_shutdown", {pos=pos, gain=1.0, loop=false, pitch=2.0, max_hear_distance=64})
	minetest.after(2, function()
		minetest.set_node(pos, {name = "technic_corrupt:liquid_corrupt_mese_source"})
	end)
end


local function start_reactor(pos, meta)
	if minetest.get_node(pos).name ~= "technic_corrupt:reactor_core" then
		return false, "not inactive"
	end
	local inv = meta:get_inventory()
	if inv:is_empty("src") then
		return false, "empty reactor fuel"
	end
	local src_list = inv:get_list("src")
	local correct_fuel_count = 0
	for _, src_stack in pairs(src_list) do
		if src_stack and src_stack:get_name() == fuel_type then
			correct_fuel_count = correct_fuel_count + 1
		end
	end
	-- Check that the reactor is complete and has the correct fuel
	if correct_fuel_count ~= 6 then
		return false, "Under 6 corrupt mese blocks in fuel, only has "..correct_fuel_count
	end
	if reactor_structure_badness(pos) ~= 0 then
		return false, "Reactor is damaged or incomplete, badness = "..reactor_structure_badness(pos)
	end
	meta:set_int("burn_time", 1)
	technic.swap_node(pos, "technic_corrupt:reactor_core_active")
	minetest.sound_play("technic_corrupt_reactor_startup", {pos=pos, gain=1.0, loop=false, max_hear_distance=64})
	meta:set_int("HV_EU_supply", power_supply)
	for idx, src_stack in pairs(src_list) do
		src_stack:take_item()
		inv:set_stack("src", idx, src_stack)
	end
	return true, "No errors "
end


minetest.register_abm({
	label = "Machines: reactor melt-down check",
	nodenames = {"technic_corrupt:reactor_core_active"},
	interval = 4,
	chance = 1,
	action = function (pos, node)
		local meta = minetest.get_meta(pos)
		local badness = reactor_structure_badness(pos)
		local accum_badness = meta:get_int("structure_accumulated_badness")
		if badness == 0 then
			if accum_badness ~= 0 then
				meta:set_int("structure_accumulated_badness", math.max(accum_badness - 4, 0))
				siren_clear(pos, meta)
			end
		else
			siren_danger(pos, meta)
			accum_badness = accum_badness + badness
			if accum_badness >= 25 then
				melt_down_reactor(pos)
			else
				meta:set_int("structure_accumulated_badness", accum_badness)
			end
		end
	end,
})

local function run(pos, node)
	local meta = minetest.get_meta(pos)
	local burn_time = meta:get_int("burn_time") or 0
	if burn_time >= burn_ticks or burn_time == 0 then
		if digiline_remote_path and meta:get_int("HV_EU_supply") == power_supply then
			digiline_remote.send_to_node(pos, meta:get_string("remote_channel"),
					"fuel used", 6, true)
		end
		if meta:get_string("autostart") == "true" then
			if start_reactor(pos, meta) then
				return
			end
		end
		meta:set_int("HV_EU_supply", 0)
		meta:set_int("burn_time", 0)
		meta:set_string("infotext", S("%s Idle"):format(reactor_desc))
		technic.swap_node(pos, "technic_corrupt:reactor_core")
		minetest.sound_play("technic_corrupt_reactor_shutdown", {pos=pos, gain=1.0, loop=false, max_hear_distance=64})
		meta:set_int("structure_accumulated_badness", 0)
		siren_clear(pos, meta)
	elseif burn_time > 0 then
		burn_time = burn_time + 1
		meta:set_int("burn_time", burn_time)
		local percent = math.floor(burn_time / burn_ticks * 100)
		meta:set_string("infotext", reactor_desc.." ("..percent.."%) DEBUG: burn_time="..burn_time.." burn_ticks="..burn_ticks.." power_supply="..power_supply)
		meta:set_int("HV_EU_supply", power_supply)
	else
		minetest.sound_play("technic_corrupt_reactor_siren_clear", {pos=pos, gain=1.0, loop=false, max_hear_distance=64,pitch=2.0})
		burn_time = burn_time + 1
		meta:set_int("burn_time", burn_time)
	end
end

local corrupt_reactor_receive_fields = function(pos, formname, fields, sender)
	local player_name = sender:get_player_name()
	if minetest.is_protected(pos, player_name) then
		minetest.chat_send_player(player_name, "You are not allowed to edit this!")
		minetest.record_protection_violation(pos, player_name)
		return
	end
	local meta = minetest.get_meta(pos)
	local update_formspec = false
	if fields.remote_channel then
		meta:set_string("remote_channel", fields.remote_channel)
	end
	if fields.start then
		local b, e = start_reactor(pos, meta)
		if b then
			minetest.chat_send_player(player_name, "Start successful")
		else
			minetest.chat_send_player(player_name, "Error: "..e)
		end
	end
	if fields.autostart then
		meta:set_string("autostart", fields.autostart)
		update_formspec = true
	end
	if fields.enable_digiline then
		meta:set_string("enable_digiline", fields.enable_digiline)
		update_formspec = true
	end
	if update_formspec then
		meta:set_string("formspec", make_reactor_formspec(meta))
	end
end

local digiline_remote_def = function(pos, channel, msg)
	local meta = minetest.get_meta(pos)
	if meta:get_string("enable_digiline") ~= "true" or
			channel ~= meta:get_string("remote_channel") then
		return
	end
	-- Convert string messages to tables:
	local msgt = type(msg)
	if msgt == "string" then
		local smsg = msg:lower()
		msg = {}
		if smsg == "get" then
			msg.command = "get"
		elseif smsg:sub(1, 13) == "self_destruct" then
			msg.command = "self_destruct"
			msg.timer = tonumber(smsg:sub(15)) or 0
		elseif smsg == "start" then
			msg.command = "start"
		end
	elseif msgt ~= "table" then
		return
	end

	if msg.command == "get" then
		local inv = meta:get_inventory()
		local invtable = {}
		for i = 1, 6 do
			local stack = inv:get_stack("src", i)
			if stack:is_empty() then
				invtable[i] = 0
			elseif stack:get_name() == fuel_type then
				invtable[i] = stack:get_count()
			else
				invtable[i] = -stack:get_count()
			end
		end
		digiline_remote.send_to_node(pos, channel, {
			burn_time = meta:get_int("burn_time"),
			enabled   = meta:get_int("HV_EU_supply") == power_supply,
			siren     = meta:get_int("siren") == 1,
			structure_accumulated_badness = meta:get_int("structure_accumulated_badness"),
			rods = invtable
		}, 6, true)
	elseif digiline_meltdown and msg.command == "self_destruct" and
			minetest.get_node(pos).name == "technic_corrupt:reactor_core_active" then
		if msg.timer ~= 0 and type(msg.timer) == "number" then
			siren_danger(pos, meta)
			minetest.after(msg.timer, s, pos)
		else
			melt_down_reactor(pos)
		end
	elseif msg.command == "start" then
		local b, e = start_reactor(pos, meta)
		if b then
			digiline_remote.send_to_node(pos, channel, "Start successful", 6, true)
		else
			digiline_remote.send_to_node(pos, channel, "Error: "..e, 6, true)
		end
	end
end

minetest.register_node("technic_corrupt:reactor_core", {
	description = reactor_desc,
	tiles = {
		"technic_corrupt_reactor_core.png",
		"technic_corrupt_reactor_core.png"..cable_entry
	},
	drawtype = "mesh",
	mesh = "technic_reactor.obj",
	groups = {cracky = 1, technic_machine = 1, technic_hv = 1, digiline_remote_receive = 1, radioactive = 1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	on_receive_fields = corrupt_reactor_receive_fields,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", reactor_desc)
		meta:set_string("formspec", make_reactor_formspec(meta))
		if digiline_remote_path then
			meta:set_string("remote_channel",
					"corrupt_reactor"..minetest.pos_to_string(pos))
		end
		local inv = meta:get_inventory()
		inv:set_size("src", 6)
	end,
	_on_digiline_remote_receive = digiline_remote_def,
	can_dig = technic.machine_can_dig,
	on_destruct = function(pos) siren_set_state(pos, SS_OFF) end,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	technic_run = run,
})

minetest.register_node("technic_corrupt:reactor_core_active", {
	tiles = {
		"technic_corrupt_reactor_core.png",
		"technic_corrupt_reactor_core.png"..cable_entry
	},
	drawtype = "mesh",
	mesh = "technic_reactor.obj",
	groups = {cracky = 1, technic_machine = 1, technic_hv = 1, radioactive = 14,
		not_in_creative_inventory = 1, digiline_remote_receive = 1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "technic_corrupt:reactor_core",
	light_source = 14,
	paramtype = "light",
	paramtype2 = "facedir",
	on_receive_fields = corrupt_reactor_receive_fields,
	_on_digiline_remote_receive = digiline_remote_def,
	can_dig = technic.machine_can_dig,
	after_dig_node = melt_down_reactor,
	on_destruct = function(pos) siren_set_state(pos, SS_OFF) end,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	technic_run = run,
	technic_on_disable = function(pos, node)
		local timer = minetest.get_node_timer(pos)
		minetest.sound_play("technic_corrupt_reactor_shutdown", {pos=pos, gain=1.0, loop=false, max_hear_distance=64,pitch=0.5})
        	timer:start(1)
        end,
	on_timer = function(pos, node)
		local meta = minetest.get_meta(pos)

		-- Connected back?
		if meta:get_int("HV_EU_timeout") > 0 then
			minetest.sound_play("technic_corrupt_reactor_shutdown", {pos=pos, pitch=3.0, gain=1.0, loop=false, max_hear_distance=64})
			minetest.sound_play("technic_corrupt_reactor_shutdown", {pos=pos, gain=1.0, loop=true, max_hear_distance=64,pitch=3.0})
			return false
		end

		local burn_time = meta:get_int("burn_time") or 0

		if burn_time >= burn_ticks or burn_time == 0 then
			minetest.sound_play("technic_corrupt_reactor_shutdown", {pos=pos, gain=1.0, loop=false, max_hear_distance=64})
			meta:set_int("HV_EU_supply", 0)
			meta:set_int("burn_time", 0)
			technic.swap_node(pos, "technic_corrupt:reactor_core")
			meta:set_int("structure_accumulated_badness", 0)
			siren_clear(pos, meta)
			return false
		end

		meta:set_int("burn_time", burn_time + 1)
		return true
	end,
})

technic.register_machine("HV", "technic_corrupt:reactor_core",        technic.producer)
technic.register_machine("HV", "technic_corrupt:reactor_core",        technic.producer)

