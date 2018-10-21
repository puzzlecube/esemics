mese = {}

mese.meses = {
	{"dark_mese", "Dark Mese"},
	{"shadowmese", "Shadowmese"},
	{"infernox_mese", "Infernox Mese"},
	{"mesemarine", "Mesemarine"},
	{"stratusmese", "Stratusmese"},
	{"terramese", "Terramese"},
	{"hardmese", "Hardmese"},
	{"lightmese", "Lightmese"}
}

local ecolors = { -- esem colors to use
  "red",
  "green",
  "blue",
  "yellow",
  "orange",
  "purple",
}

function mese.register_mese(mese, def) -- similar to the normal minetest.register node syntax but DO NOT WRITE ANYTHING YOU WOULD PUT BEFORE THE :
    if not def.description then
        def.description = "{nil}"
    end
    if not def.crackyness then
        def.crackyness = 1
    end
    if not def.dig_level then
        def.dig_level = 4
    end
    local mese_name = "mese:"..mese
    minetest.register_node(mese_name, {
        description = def.description,
        tiles = {"mese_"..mese.."_block.png"},
        groups = {mese = 1, immortal = 1, cracky = def.crackyness, level = def.dig_level}
    })
    minetest.register_node(mese_name.."_ore",	{
		description = "Stone With "..def.description,
		tiles =	{"default_stone.png^mese_mineral_"..mese..".png"},
		is_ground_content = true,
		drop =	{
			max_items = 1,
			items =	{ {
				rarity = 1,
				items =	{mese_name.."_crystal"},
			}}
		},
		groups =	{immortal = 1, mese = 1, cracky = def.crackyness - 1, level = def.dig_level - 1},
		sounds = default.node_sound_stone_defaults(),
    })
    minetest.register_craftitem(mese_name.."_crystal",	{
		description = mese.." Crystal",
		inventory_image = "mese_"..mese.."_crystal.png",
	})

	minetest.register_craftitem(mese_name.."_crystal_fragment",	{
		description = mese.." Crystal Fragment",
		inventory_image = "mese_"..mese.."_crystal_fragment.png",
    })
    minetest.register_craft( {
		output = mese_name..'_crystal',
        recipe =	{
            {mese_name..'_crystal_fragment', mese_name..'_crystal_fragment', mese_name..'_crystal_fragment'},
            {mese_name..'_crystal_fragment', mese_name..'_crystal_fragment', mese_name..'_crystal_fragment'},
            {mese_name..'_crystal_fragment', mese_name..'_crystal_fragment', mese_name..'_crystal_fragment'},
		}
	})
	minetest.register_craft( {
		output = mese_name..'_crystal_fragment 9',
		recipe =	{ 
            {mese_name..'_crystal'},
		}
	})
	minetest.register_craft( {
		output = mese_name..'_crystal 9',
		recipe =	{ 
            {mese_name},
		}
	})
	minetest.register_craft( {
		output = mese_name,
		recipe =	{
            {mese_name..'_crystal', mese_name..'_crystal', mese_name..'_crystal'},
            {mese_name..'_crystal', mese_name..'_crystal', mese_name..'_crystal'},
            {mese_name..'_crystal', mese_name..'_crystal', mese_name..'_crystal'},
		}
    })
end

mese.register_mese("dark_mese", {
    description = "Dark Mese",
    crackyness = 3,
    dig_level = 3,
})

mese.register_mese("shadowmese", {
    description = "Shadowmese",
    crackyness = 3,
    dig_level = 3,
})

mese.register_mese("mesemarine", {
    description = "mesemarine",
    crackyness = 3,
    dig_level = 3,
})

mese.register_mese("infernox_mese", {
    description = "Infernox Mese",
    crackyness = 3,
    dig_level = 3,
})

mese.register_mese("terramese", {
    description = "Terramese",
    crackyness = 3,
    dig_level = 4,
})

mese.register_mese("stratusmese", {
    description = "Stratusmese",
    crackyness = 3,
    dig_level = 3,
})

mese.register_mese("hardmese", {
    description = "Hardmese",
    crackyness = 3,
    dig_level = 5,
})

mese.register_mese("lightmese", {
    description = "Lightmese",
    crackyness = 3,
    dig_level = 4,
})

minetest.override_item("mese:hardmese", {
	groups = {unbreakable= 4, immortal = 4, mese = 4, cracky = 4, level = 5}
})

minetest.override_item("mese:lightmese", {
    light_source = 14
})

-- Special meses
minetest.register_node("mese:corrupt_mese", {
  description = "Corrupt Mese",
  tiles = {
    {
      name = "mese_corrupt_mese_block_animated.png",
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 3.0,
      },
    },
  },
	special_tiles = {
		{
			name = "mese_corrupt_mese_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
			backface_culling = false,
		},
	},
  groups = {mese=1, corrupt=1, cracky=3, level=3, radioactive=-10},
  --[[on_place = function(pos)
    for _,xoffset in pairs(nears) do
      for __,yoffset in pairs(nears) do
        for ___,zoffset in pairs(nears) do
          if not pos.x then pos.x = pos.x end
          if not pos.y then pos.y = pos.y end
          if not pos.z then pos.z = pos.z end
          local cpos = {pos.x + xoffset, pos.y + yoffset, pos.z + zoffset}
          if not cpos.x then cpos.x = pos.x + xoffset end
          if not cpos.y then cpos.y = pos.y + yoffset end
          if not cpos.z then cpos.z = pos.z + zoffset end
          local cnod = get_far_node(cpos)
          local cnodn = cnod.name
          if cnodn == "mese:corrupt_mese" then
            minetest.set_node(cpos, {name="mese:esem_gemblock"})
          end
        end
      end
    end
  end,]]
})

minetest.register_node("mese:stone_with_corrupt_mese", {
  description = "Corrupt mese ore",
  tiles = {"default_stone.png^mese_mineral_corrupt_mese.png"},
  groups = {cracky=3, level=3},
  drop = {
    max_items = 4,
    items = {{
      rarity = 1,
      items = {"mese:corrupt_mese_crystal"},
    }}
  },
})

minetest.register_craftitem("mese:corrupt_mese_crystal_fragment", {
  description = "Corrupt Mese Crystal Fragment",
  inventory_image = "mese_corrupt_mese_crystal_fragment.png",
})

minetest.register_craftitem("mese:corrupt_mese_crystal", {
  description = "Corrupt Mese Crystal",
  inventory_image = "mese_corrupt_mese_crystal.png",
})

minetest.register_craft({
  output = 'mese:corrupt_mese_crystal',
  recipe = {
    {'mese:corrupt_mese_crystal_fragment', 'mese:corrupt_mese_crystal_fragment', 
'mese:corrupt_mese_crystal_fragment'},
    {'mese:corrupt_mese_crystal_fragment', 'mese:corrupt_mese_crystal_fragment', 
'mese:corrupt_mese_crystal_fragment'},
    {'mese:corrupt_mese_crystal_fragment', 'mese:corrupt_mese_crystal_fragment', 
'mese:corrupt_mese_crystal_fragment'},
  }
})

minetest.register_craft({
  output = 'mese:corrupt_mese',
  recipe = {
    {'mese:corrupt_mese_crystal', 'mese:corrupt_mese_crystal', 'mese:corrupt_mese_crystal'},
    {'mese:corrupt_mese_crystal', 'mese:corrupt_mese_crystal', 'mese:corrupt_mese_crystal'},
    {'mese:corrupt_mese_crystal', 'mese:corrupt_mese_crystal', 'mese:corrupt_mese_crystal'},
  }
})

minetest.register_craft({
  output = 'mese:corrupt_mese_crystal_fragment 9',
  recipe = {
    {'mese:corrupt_mese_crystal'},
  }
})

minetest.register_node("mese:depleted_mese", {    -- very average (wink wink) mese-like node that looks super old
  description = "Depleted mese",
  tiles = {"mese_depleted_mese_block.png"},
  groups = {mese=1, depleted=1, cracky=2, level=2}
})

minetest.register_abm({
	nodenames = { "mese:corrupt_mese" },
	neighbors = { "default:mese"},
	interval = 3,
	chance = 2,
	action = function (pos, node)
    local stoppercnt = 0  -- how many nodes around it are capable of stopping the explosion
    local finished = false                  -- are we done checking nearby nodes?
    if pos.x ~= nil and pos.y ~= nil and pos.z ~= nil then
      local epos = {pos} -- position table that currently contains the position of the corrupt mese, will be filled with cpos's where there is depleted mese
      for _,xoffset in pairs(nears) do
        for __,yoffset in pairs(nears) do
          for ___,zoffset in pairs(nears) do
            if not pos.x then pos.x = pos.x end
            if not pos.y then pos.y = pos.y end
            if not pos.z then pos.z = pos.z end
            local cpos = {pos.x + xoffset, pos.y + yoffset, pos.z + zoffset}
            if not cpos.x then cpos.x = pos.x + xoffset end
            if not cpos.y then cpos.y = pos.y + yoffset end
            if not cpos.z then cpos.z = pos.z + zoffset end
            local cnod = get_far_node(cpos)
            local cnodn = cnod.name
            minetest.chat_send_all("="..cnodn)
            if cnodn == "mese:depleted_mese" then
              stoppercnt = stoppercnt + 1
              table.insert(epos, cpos)
              minetest.chat_send_all("perliminary stoppercnt="..stoppercnt)
            elseif cnodn == "default:mese" then
              table.insert(epos, cpos) -- oh yeah add this too otherwise you will just make it explode a little later once the depleted mese turns to esem
            end
            if xoffset == 1 and yoffset == 1 and zoffset == 1 then  --
              finished = true
              minetest.chat_send_all("finished")
            end
            if finished == true then      -- only do this when its done otherwise everything in this code is useless
              if stoppercnt >= 2 then
                for ____,cepos in pairs(epos) do
                  --local cenodn = get_far_node(cepos).name
                  --if cenodn == "mese:depleted_mese" or cnoden == "mese:corrupt_mese" or cnoden == "default:mese" then -- this is still here because what if the depleted mese gets removed between the time the position is checked and the checking finishes? then it is just free esem and that is not cool (or is it)
                    minetest.set_node(cepos, {name="mese:esem"})
                  --end
                end
              else
                tnt.boom(pos, {radius=16,damage_radius=20}) -- BIG FAT FLIPPIN' BANG!
                minetest.set_node(pos, {name="mese:esem"})
              end
            end
          end
        end
      end
    end
end,
})

minetest.register_abm({
	nodenames = { "mese:corrupt_mese" },
	neighbors = { "mese:esem"},
	interval = 3,
	chance = 4,
	action = function (pos, node)
		minetest.set_node(pos, {name="mese:esem"})
    for _,xoffset in pairs(nears) do
      for __,yoffset in pairs(nears) do
        for ___,zoffset in pairs(nears) do
          if not pos.x then pos.x = pos.x end
          if not pos.y then pos.y = pos.y end
          if not pos.z then pos.z = pos.z end
          local cpos = {pos.x + xoffset, pos.y + yoffset, pos.z + zoffset}
          if not cpos.x then cpos.x = pos.x + xoffset end
          if not cpos.y then cpos.y = pos.y + yoffset end
          if not cpos.z then cpos.z = pos.z + zoffset end
          local cnod = get_far_node(cpos)
          local cnodn = cnod.name
          if cnodn == "mese:esem" then
            minetest.set_node(cpos, {name="mese:dark_esem"}) -- this one is supposed to race off after setting it
          end
        end
      end
    end
	end,
})

minetest.register_abm({
	nodenames = { "mese:corrupt_mese" },
	neighbors = { "mese:dark_esem"},
	interval = 3,
	chance = 13,
	action = function (pos, node)
    local color = ecolors[math.random(1,#ecolors)]
    local enam = "mese:"..color.."_esem"
		minetest.set_node(pos, {name=enam})
    for _,xoffset in pairs(nears) do
      for __,yoffset in pairs(nears) do
        for ___,zoffset in pairs(nears) do
          if not pos.x then pos.x = pos.x end
          if not pos.y then pos.y = pos.y end
          if not pos.z then pos.z = pos.z end
          local cpos = {pos.x + xoffset, pos.y + yoffset, pos.z + zoffset}
          if not cpos.x then cpos.x = pos.x + xoffset end
          if not cpos.y then cpos.y = pos.y + yoffset end
          if not cpos.z then cpos.z = pos.z + zoffset end
          local cnod = get_far_node(cpos)
          local cnodn = cnod.name
          if cnodn == "mese:dark_esem" then
            minetest.set_node(cpos, {name=enam}) -- this one is supposed to race off after setting it
          end
        end
      end
    end
	end,
})



minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:mesemarine_ore",
    wherein        = "default:stone",
    clust_scarcity = 10 * 10 * 10,
    clust_num_ores = 7,
    clust_size     = 5,
    y_min          = -512,
    y_max          = -5,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:mesemarine_ore",
    wherein        = "default:stone",
    clust_scarcity = 64 * 64 * 64,
    clust_num_ores = 7,
    clust_size     = 5,
    y_min          = -31000,
    y_max          = -512,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:hardmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = 1025,
    y_max          = 31000,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:hardmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:hardmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:dark_mese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -1024,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:dark_mese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:dark_mese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:shadowmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = 1025,
    y_max          = 31000,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:shadowmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:shadowmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:terramese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = 1025,
    y_max          = 31000,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:terramese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:terramese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})


minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:infernox_mese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = 1025,
    y_max          = 31000,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:infernox_mese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:infernox_mese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})


minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:stratusmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = 125,
    y_max          = 31000,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:stratusmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:stratusmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})


minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:lightmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = 1025,
    y_max          = 31000,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:lightmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 18 * 18 * 18,
    clust_num_ores = 3,
    clust_size     = 2,
    y_min          = -255,
    y_max          = -64,
})
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "mese:lightmese_ore",
    wherein        = "default:stone",
    clust_scarcity = 14 * 14 * 14,
    clust_num_ores = 5,
    clust_size     = 3,
    y_min          = -31000,
    y_max          = -256,
})
