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