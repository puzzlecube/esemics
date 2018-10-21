local esems = {
	"",
	"dark",
	"blue",
	"red",
	"green",
	"yellow",
	"orange",
	"purple",
	"light",
}

dofile(minetest.get_modpath("esem").."/prism.lua")

local nears = { -1, 0, 1 } -- for easier writing of the esem checking abm

local function get_far_node(pos)
	local node = minetest.get_node(pos)
	if node.name == "ignore" then
		minetest.get_voxel_manip():read_from_map(pos, pos)
		node = minetest.get_node(pos)
	end
	return node
end

local function capitalize(name)
  first = string.sub(name, 1, 1)
  other = string.sub(name, 2)
  return string.upper(first)..other
end

-- register the esem item stuff

for _, name in pairs(esems) do
	if name ~= "" then
		local itemname = "esem:" .. name .. "_esem"
		minetest.register_node(itemname, {
			description = capitalize(name).." Esem",
			tiles = {"esem_"..name.."_esem_block.png"},
			is_ground_content = true,
			drop = {
				max_items = 4,
				items = {{
					rarity = 1,
					items = {itemname},
				}}
			},
			groups = {immortal=1,esem=1,cracky=3,level=3},
			sounds = default.node_sound_stone_defaults(),
		})
		minetest.register_node(itemname.."_gem_block", {
			description = capitalize(name).." Esem Gem Block",
			tiles = {"esem_"..name.."_esem_gemblock.png"},
			is_ground_content = false,
			light_source = 4,
			use_texture_alpha = true,
			drawtype = "glasslike",
			backface_culling = true,
			drop = {
				max_items = 6,
				items = {{
					rarity = 1,
					items = {itemname},--{itemname.."_gem_fragment", itemname.."gem"},
				}}
			},
			groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2},
			sounds = default.node_sound_glass_defaults(),
		})
		minetest.register_craftitem(itemname.."_crystal", {
			description = capitalize(name).." Esem Crystal",
			inventory_image = "esem_"..name.."_esem_crystal.png",
		})
	
		minetest.register_craftitem(itemname.."_crystal_fragment", {
			description = capitalize(name).." Esen Crystal Fragment",
			inventory_image = "esem_"..name.."_esem_crystal_fragment.png",
		})
	
		minetest.register_craftitem(itemname.."_gem", {
			description = capitalize(name).." Esem Gem",
			inventory_image = "esem_"..name.."_esem_gem.png",
		})
	
		minetest.register_craftitem(itemname.."_gem_fragment", {
			description = capitalize(name).." Esem Gem Fragment",
			inventory_image = "esem_"..name.."_esem_gem_fragment.png",
		})
		minetest.register_craft({
			output = itemname..'_crystal',
			recipe = {
				{itemname..'_crystal_fragment', itemname..'_crystal_fragment'},
				{itemname..'_crystal_fragment', itemname..'_crystal_fragment'},
			}
		})
		minetest.register_craft({
			output = itemname..'_crystal_fragment 4',
			recipe = {
				{itemname..'_crystal'},
			}
		})
		minetest.register_craft({
			output = itemname..'_crystal 4',
			recipe = {
				{itemname},
			}
		})
		minetest.register_craft({
			output = itemname..'_gem_fragment',
			recipe = {
				{itemname..'_crystal', itemname..'_crystal', itemname..'_crystal'},
				{itemname..'_crystal_fragment', itemname..'_crystal', itemname..'_crystal_fragment'},
				{'', itemname..'_crystal_fragment', ''},
			}
		})
		minetest.register_craft({
			output = itemname..'_gem',
			recipe = {
				{itemname..'_crystal_fragment',	itemname..'_crystal',	itemname..'_crystal_fragment'},
				{itemname..'_gem_fragment',	itemname..'_crystal_fragment',	itemname..'_gem_fragment'},
				{			'',				itemname..'_gem_fragment',				''			},
			}
		})
		minetest.register_craft({
			output = itemname,
			recipe = {
				{itemname..'_crystal', itemname..'_crystal'},
				{itemname..'_crystal', itemname..'_crystal'},
			}
		})
		minetest.register_craft({
			output = itemname..'_gem_block 4',
			recipe = {
				{itemname..'_gem',	itemname..'_gem',	itemname..'_gem'},
				{itemname..'_gem',	itemname..'_gem',	itemname..'_gem'},
				{itemname..'_gem',	itemname..'_gem',	itemname..'_gem'},
			}
		})
	else
		local itemname = "esem:esem"
		minetest.register_node(itemname, {
			description = "Esem",
			tiles = {"esem_block.png"},
			is_ground_content = true,
			drop = {
				max_items = 4,
				items = {{
					rarity = 1,
					items = {itemname},
				}}
			},
			groups = {immortal=1,esem=1,cracky=3,level=3},
			sounds = default.node_sound_stone_defaults(),
		})
		minetest.register_node(itemname.."_gem_block", {
			description = "Esem Gem Block",
			tiles = {"esem_gemblock.png"},
			is_ground_content = false,
			light_source = 4,
			use_texture_alpha = true,
			drawtype = "glasslike",
			backface_culling = true,
			drop = {
				max_items = 6,
				items = {{
					rarity = 1,
					items = {itemname},
				}}
			},
			groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2},
			sounds = default.node_sound_glass_defaults(),
		})
		minetest.register_craftitem(itemname.."_crystal", {
			description = "Esem Crystal",
			inventory_image = "esem_crystal.png",
		})
	
		minetest.register_craftitem(itemname.."_crystal_fragment", {
			description = "Esen Crystal Fragment",
			inventory_image = "esem_crystal_fragment.png",
		})
	
		minetest.register_craftitem(itemname.."_gem", {
			description = "Esem Gem",
			inventory_image = "esem_gem.png",
		})
	
		minetest.register_craftitem(itemname.."_gem_fragment", {
			description = "Esem Gem Fragment",
			inventory_image = "esem_gem_fragment.png",
		})
		minetest.register_craft({
			output = itemname..'_crystal',
			recipe = {
				{itemname..'_crystal_fragment', itemname..'_crystal_fragment'},
				{itemname..'_crystal_fragment', itemname..'_crystal_fragment'},
			}
		})
		minetest.register_craft({
			output = itemname..'_crystal_fragment 4',
			recipe = {
				{itemname..'_crystal'},
			}
		})
		minetest.register_craft({
			output = itemname..'_crystal 4',
			recipe = {
				{itemname},
			}
		})
		minetest.register_craft({
			output = itemname..'_gem_fragment',
			recipe = {
				{itemname..'_crystal', itemname..'_crystal', itemname..'_crystal'},
				{itemname..'_crystal_fragment', itemname..'_crystal', itemname..'_crystal_fragment'},
				{'', itemname..'_crystal_fragment', ''},
			}
		})
		minetest.register_craft({
			output = itemname..'_gem',
			recipe = {
				{itemname..'_crystal_fragment',	itemname..'_crystal',	itemname..'_crystal_fragment'},
				{itemname..'_gem_fragment',	itemname..'_crystal_fragment',	itemname..'_gem_fragment'},
				{			'',				itemname..'_gem_fragment',				''			},
			}
		})
		minetest.register_craft({
			output = itemname,
			recipe = {
				{itemname..'_crystal', itemname..'_crystal'},
				{itemname..'_crystal', itemname..'_crystal'},
			}
		})
		minetest.register_craft({
			output = itemname..'_gem_block 4',
			recipe = {
				{itemname..'_gem',	itemname..'_gem',	itemname..'_gem'},
				{itemname..'_gem',	itemname..'_gem',	itemname..'_gem'},
				{itemname..'_gem',	itemname..'_gem',	itemname..'_gem'},
			}
		})
	end
end

-- now override them to make them have their own groups based on the esem color type and gem

minetest.override_item("esem:dark_esem", {
	groups = {immortal=1,esem=1,cracky=3,level=3, darkesem=1, mesecon = 2},
	mesecons = {receptor = {
		state = mesecon.state.on
	}}
})
minetest.override_item("esem:dark_esem_gem_block", {
	groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2, darkesem=1, mesecon = 2},
	mesecons = {receptor = {
		state = mesecon.state.on
	}}
})
minetest.override_item("esem:dark_esem_crystal", {
	groups = {esem=1, darkesem=1}
})

minetest.override_item("esem:dark_esem_crystal_fragment", {
	groups = {esem=1, darkesem=1}
})

minetest.override_item("esem:dark_esem_gem", {
	groups = {esem=1, darkesem=1}
})

minetest.override_item("esem:dark_esem_gem_fragment", {
	groups = {esem=1, darkesem=1}
})

minetest.override_item("esem:blue_esem", {
	groups = {immortal=1,esem=1,cracky=3,level=3, blueesem=1, mesecon = 2},
	mesecons = {receptor = {
		state = mesecon.state.on
	}}
})
minetest.override_item("esem:blue_esem_gem_block", {
	groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2, blueesem=1, mesecon = 2},
	mesecons = {receptor = {
		state = mesecon.state.on
	}}
})
minetest.override_item("esem:blue_esem_crystal", {
	groups = {esem=1, blueesem=1}
})

minetest.override_item("esem:blue_esem_crystal_fragment", {
	groups = {esem=1, blueesem=1}
})

minetest.override_item("esem:blue_esem_gem", {
	groups = {esem=1, blueesem=1}
	
})

minetest.override_item("esem:blue_esem_gem_fragment", {
	groups = {esem=1, blueesem=1}
})

minetest.override_item("esem:green_esem", {
	groups = {immortal=1,esem=1,cracky=3,level=3, greenesem=1},
})
minetest.override_item("esem:green_esem_gem_block", {
	groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2, greenesem=1},
})
minetest.override_item("esem:green_esem_crystal", {
	groups = {esem=1, greenesem=1}
})

minetest.override_item("esem:green_esem_crystal_fragment", {
	groups = {esem=1, greenesem=1}
})

minetest.override_item("esem:green_esem_gem", {
	groups = {esem=1, greenesem=1}
})

minetest.override_item("esem:green_esem_gem_fragment", {
	groups = {esem=1, greenesem=1}
})

minetest.override_item("esem:yellow_esem", {
	groups = {immortal=1,esem=1,cracky=3,level=3, yellowesem=1},
})
minetest.override_item("esem:yellow_esem_gem_block", {
	groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2, yellowesem=1},
})
minetest.override_item("esem:yellow_esem_crystal", {
	groups = {esem=1, yellowesem=1}
})

minetest.override_item("esem:yellow_esem_crystal_fragment", {
	groups = {esem=1, yellowesem=1}
})

minetest.override_item("esem:yellow_esem_gem", {
	groups = {esem=1, yellowesem=1}
})

minetest.override_item("esem:yellow_esem_gem_fragment", {
	groups = {esem=1, yellowesem=1}
})

minetest.override_item("esem:red_esem", {
	groups = {immortal=1,esem=1,cracky=3,level=3, redesem=1},
})
minetest.override_item("esem:red_esem_gem_block", {
	groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2, redesem=1},
})
minetest.override_item("esem:red_esem_crystal", {
	groups = {esem=1, redesem=1}
})

minetest.override_item("esem:red_esem_crystal_fragment", {
	groups = {esem=1, redesem=1}
})

minetest.override_item("esem:red_esem_gem", {
	groups = {esem=1, redesem=1}
})

minetest.override_item("esem:red_esem_gem_fragment", {
	groups = {esem=1, redesem=1}
})

minetest.override_item("esem:light_esem", {
	groups = {immortal=1,esem=1,cracky=3,level=3, lightesem=1},
})
minetest.override_item("esem:light_esem_gem_block", {
	groups = {immortal=1,esem=1,esemgem=1,cracky=2,level=2, lightesem},
})
minetest.override_item("esem:light_esem_crystal", {
	groups = {esem=1, lightesem=1}
})

minetest.override_item("esem:light_esem_crystal_fragment", {
	groups = {esem=1, lightesem=1}
})

minetest.override_item("esem:light_esem_gem", {
	groups = {esem=1, lightesem=1}
})

minetest.override_item("esem:light_esem_gem_fragment", {
	groups = {esem=1, lightesem=1}
})

minetest.register_tool("esem:legeond_pick", {
    description = "Legeondary Esem pickaxe",
    inventory_image = "esem_pick.png",
	tool_capabilities = {
		max_drop_level=300,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=300},
      cracky={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=0, maxlevel=300},
			choppy={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=0, maxlevel=300},
      crumbly={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=0, maxlevel=300},
			immortal={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=0, maxlevel=300},
      oddly_breakable_by_hand={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=0, maxlevel=3},
      not_in_creative_inventory={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=0, maxlevel=300},
      esem={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=-1, maxlevel=300},
      mese={times={[1]=0, [2]=0, [3]=0, [4]=0, [5]=1}, uses=-1, maxlevel=300},
		},
    damage_groups = {fleshy=2000},
	},
})

minetest.register_tool("esem:esem_pick", {
	description = "Esem pickaxe",
	inventory_image = "esem_pickaxe.png",
tool_capabilities = {
	max_drop_level=30,
	groupcaps={
		unbreakable={times={[1]=15, [2]=30, [3]=40, [4]=60}, uses=1, maxlevel=4},
		cracky={times={[1]=5, [2]=1, [3]=2, [4]=5, [4]=20}, uses=.1, maxlevel=4},
		choppy={times={[1]=5, [2]=2, [3]=40, [4]=10}, uses=.1, maxlevel=4},
		crumbly={times={[1]=5, [2]=1, [3]=3, [4]=5}, uses=.1, maxlevel=4},
		immortal={times={[1]=5, [2]=10, [3]=20, [4]=30}, uses=.1, maxlevel=4},
		oddly_breakable_by_hand={times={[1]=.001, [2]=.02, [3]=.3, [4]=4}, uses=0, maxlevel=4},
		--not_in_creative_inventory={times={[1]=5, [2]=10, [3]=20, [4]=50}, uses=0, maxlevel=300},
		esem={times={[1]=.5, [2]=1.0, [3]=2.0, [4]=5.0}, uses=-0.1, maxlevel=4},
	},
	damage_groups = {fleshy=20},
},
})

local nears = { -1, 0, 1 } -- for easier writing of the esem checking abm

local function get_far_node(pos)
	local node = minetest.get_node(pos)
	if node.name == "ignore" then
		minetest.get_voxel_manip():read_from_map(pos, pos)
		node = minetest.get_node(pos)
	end
	return node
end
    

--[[abms
minetest.register_abm({
	nodenames = { "esem:dark_esem" },
	neighbors = { "default:dirt_with_grass"}
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2 or 0
			nfdir = dirs2[fdir+1]
		minetest.add_node(pos, {name = "advanced:pillar", param2 = nfdir})
	end,
]]

minetest.register_abm({
	nodenames = { "esem:dark_esem" },
	neighbors = { "esem:esem_gem_block"},
	interval = 1,
	chance = 258,
	action = function (pos, node)
		minetest.set_node(pos, {name="esem:esem"})
	end,
})--]]

minetest.register_node("esem:stone_with_esem", {
  description = "Esem ore",
  tiles = {"default_stone.png^esem_mineral_esem.png"},
  groups = {cracky=3, level=3},
  drop = {
    max_items = 4,
    items = {{
      rarity = 1,
      items = {"esem:esem_crystal"},
    }}
  },
})

minetest.register_craft({
	output = 'esem:legeond_pick',
	recipe = {
		{'esem:esem_crystal', 'default:mese_crystal', 'esem:esem_crystal'},
		{'esem:red_esem_crystal', 'default:pick_mese', 'esem:red_esem_crystal'},
		{'esem:orange_esem_crystal', 'esem:yellow_esem_crystal', 'esem:purple_esem_crystal'},
	}
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "esem:stone_with_esem",
  wherein        = "default:stone",
  clust_scarcity = 24 * 24 * 24,
  clust_num_ores = 4,
  clust_size     = 5,
  y_min          = -31000,
  y_max          = -640,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "esem:stone_with_corrupt_mese",
  wherein        = "default:stone",
  clust_scarcity = 8 * 8 * 8,
  clust_num_ores = 16,
  clust_size     = 8,
  y_min          = -31000,
  y_max          = -512,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "esem:dark_esem",
  wherein        = "default:stone",
  clust_scarcity = 32 * 32 * 32,
  clust_num_ores = 32,
  clust_size     = 64,
  y_min          = -31000,
  y_max          = -2048,
})

minetest.register_abm({
	nodenames = { "esem:esem" },
	neighbors = { "default:obsidian"},
	interval = 3,
	chance = 1,
	action = function (pos, node)
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
          if cnodn == "default:mese" then
            minetest.set_node(cpos, {name="mese:depleted_mese"})
          elseif cnodn == "esem:esem" then
            minetest.set_node(cpos, {name="mese:depleted_mese"})
          end
        end
      end
    end
	end,
})

minetest.register_abm({
	nodenames = { "esem:dark_esem" },
	neighbors = { "default:mese"},
	interval = 2,
	chance = 3,
	action = function (pos, node)
    --local fourcols = {"red","yellow","green","blue"}
		--minetest.set_node(pos, {name="esem:esem"})
		local colsnear = {
			red = false,
			yellow = false,
			green = false,
			blue = false,
			dark = false,
			-- TODO: remove this, fix the prism, and add orange and purple into the mix
			orange = false,
			purple = false,
		}
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
					if cnodn == "esem:red_esem" then
						colsnear.red=true
					elseif cnodn == "esem:yellow_esem" then
						colsnear.yellow=true
					elseif cnodn == "esem:green_esem" then
						colsnear.green=true
					elseif cnodn == "esem:blue_esem" then
						colsnear.blue=true
					elseif cnodn == "esem:dark_esem" then
						colsnear.dark=true
					end
        end
      end
		end
		if colsnear.red == true and colsnear.yellow == true and colsnear.green == true and colsnear.blue == true and colsnear.dark == true then
			-- Needs a cool sound to make
			minetest.set_node(pos, {name="esem:light_esem"}) -- this one is supposed to race off after setting it
		end
	end,
})

local rods = { --esemic rods
	"core",
	"base",
	"unfinished",
	"finished"
}

for _,rod in pairs(rods) do
	minetest.register_craftitem("esem:esemic_rod_"..rod, {
		description = "Esemic rod "..rod,
		inventory_image = "esem_esemic_rod_"..rod..".png",
		groups = {esemic=1}
	})
end

minetest.register_craft({
  output = 'esem:esemic_rod_core',
  recipe = {
    {"esem:esem_gem", "esem:esem_crystal", "esem:esem_gem"},
    {"esem:esem_gem", "esem:dark_esem_crystal", "esem:esem_gem"},
    {"esem:esem_gem", "esem:esem_crystal", "esem:esem_gem"},
  }
})

minetest.register_craft({
	output = "esem:esemic_rod_base",
	recipe = {
		{"default:mese_crystal_fragment", "esem:esemic_rod_core", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "esem:esemic_rod_core", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "esem:esemic_rod_core", "default:mese_crystal_fragment"}
	}
})

minetest.register_craft({
	output = "esem:esemic_rod_unfinished",
	recipe = {
		{"", "esem:light_esem_crystal", ""},
		{"esem:light_esem_crystal_fragment", "esem:esemic_rod_base", "esem:light_esem_crystal_fragment"},
		{"esem:light_esem_crystal_fragment", "esem:esemic_rod_base", "esem:light_esem_crystal_fragment"}
	}
})

minetest.register_craft({
	output = "esem:esemic_rod_finished",
	recipe = {
		{"esem:dark_esem_crystal_fragment", "esem:esemic_rod_unfinished", "esem:dark_esem_crystal_fragment"},
		{"esem:dark_esem_crystal_fragment", "esem:dark_esem_gem", "esem:dark_esem_crystal_fragment"},
		{"esem:dark_esem_crystal_fragment", "esem:dark_esem_crystal", "esem:dark_esem_crystal_fragment"}
	}
})

minetest.register_craft({
  output = 'esem:esem_pick',
  recipe = {
    {'esem:yellow_esem_crystal', 'esem:red_esem_crystal', 'esem:yellow_esem_crystal'},
    {'esem:blue_esem_crystal', 'mese:corrupt_mese_crystal', 'esem:blue_esem_crystal'},
    {'default:mese_crystal', 'esem:esemic_rod_finished', 'default:mese_crystal'},
  }
})

minetest.register_craft({
	output = "esem:prism",
	recipe = {
		{'esem:esemic_rod_unfinished', 'mese:corrupt_mese_crystal', 'esem:esemic_rod_unfinished'},
		{'esem:light_esem_crystal','esem:light_esem','esem:light_esem_crystal'},
		{'esem:esemic_rod_unfinished', 'mese:corrupt_mese_crystal', 'esem:esemic_rod_unfinished'},
	}
})

esemics.register_prism_recipe({
	result = "esem:light_esem_gem",
	recipe = "esem:dark_esem_crystal",
	time = 3,
	catalyst = "default:sand"
})