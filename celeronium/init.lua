minetest.register_node("celeronium:celeronium_block", {
	description = "Block Of Celeronium",
	tiles = {"celeronium_block.png"},
	groups = {cracky = 3, bouncy = 173, fall_damage_add_percent = -99},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("celeronium:stone_with_celeronium", {
	description = "Celeronium Ore",
	tiles = {"default_stone.png^celeronium_ore.png"},
    groups = {cracky = 2, level = 2},
    drop = {
        max_items = 6,
        min_items = 1,
        items = {{
            rarity = 1,
            items = {"celeronium:celeronium_chunk"},
        }}
    },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "celeronium:stone_with_celeronium",
    wherein        = "default:stone",
    clust_scarcity = 16 * 16 * 16,
    clust_num_ores = 7,
    clust_size     = 4,
    y_min          = -31000,
    y_max          = -143,
})

minetest.register_craftitem("celeronium:celeronium_chunk", {
	description = "Celeronium Chunk",
	inventory_image = "celeronium_chunk.png",
})

local cchunk = "celeronium:celeronium_chunk"
minetest.register_craft({
	output = 'celeronium:celeronium_block',
	recipe = {
		{cchunk, cchunk, cchunk},
		{cchunk, cchunk, cchunk},
		{cchunk, cchunk, cchunk},
	}
})