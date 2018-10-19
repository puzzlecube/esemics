minetest.register_node("guptonium:dark_metal", {
	description = "Dark Guptonium Metal",
	tiles = {"guptonium_dark_metal.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 4},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("guptonium:light_metal", {
	description = "Light Guptonium Metal",
	tiles = {"guptonium_light_metal.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 4},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("guptonium:guptonite_glass", {
	description = "Guptonite Glass",
	tiles = {"guptonite_glass.png", "guptonite_glass_detail.png"},
	drawtype = "glasslike_framed_optional",
	is_ground_content = false,
	use_texture_alpha = true,
	groups = {cracky = 1, level = 4},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("guptonium:liquid_guptonium_source", {
	description = "Liquid Guptonium Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "guptonium_liquid_source_animated.png",
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
			name = "guptonium_liquid_source_animated.png",
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
	liquid_alternative_flowing = "guptonium:liquid_guptonium_flowing",
	liquid_alternative_source = "guptonium:liquid_guptonium_source",
    liquid_viscosity = 10,
    liquid_range = 16,
	liquid_renewable = false,
	light_source = 6,
	damage_per_second = 10,
	post_effect_color = {a = 191, r = 56, g = 4, b = 64},
	groups = {liquid_guptonium = 3, liquid = 2, igniter = 1},
})

minetest.register_node("guptonium:liquid_guptonium_flowing", {
	description = "Flowing Liquid Guptonium",
	drawtype = "flowingliquid",
	tiles = {"guptonium_liquid.png"},
	special_tiles = {
		{
			name = "guptonium_liquid_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "guptonium_liquid_flowing_animated.png",
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
	liquid_alternative_flowing = "guptonium:liquid_guptonium_flowing",
	liquid_alternative_source = "guptonium:liquid_guptonium_source",
    liquid_viscosity = 10,
    liquid_range = 16,
	liquid_renewable = false,
	light_source = 6,
	damage_per_second = 10,
	post_effect_color = {a = 191, r = 56, g = 4, b = 64},
	groups = {liquid_guptonium = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

bucket.register_liquid(
	"guptonium:liquid_guptonium_source",
	"guptonium:liquid_guptonium_flowing",
	"guptonium:bucket_guptonium",
	"bucket_guptonium.png",
	"Liquid Guptonium Bucket"
)

minetest.register_craft({
	type = "fuel",
	recipe = "guptonium:bucket_guptonium",
	burntime = 60000, -- burns for an INSANELY long time!
	replacements = {{"guptonium:bucket_guptonium", "bucket:bucket_empty", "guptonium:bucket_guptonite"}},
})

minetest.register_node("guptonium:liquid_guptonite_source", {
	description = "Liquid Guptonite Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "guptonite_liquid_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	special_tiles = {
		-- New-style liquid guptonite source material (mostly unused)
		{
			name = "guptonite_liquid_source_animated.png",
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
	liquid_alternative_flowing = "guptonium:liquid_guptonite_flowing",
	liquid_alternative_source = "guptonium:liquid_guptonite_source",
    liquid_viscosity = 3,
    liquid_range = 16,
	liquid_renewable = false,
	light_source = 3,
	damage_per_second = -1,
	post_effect_color = {a = 191, r = 56, g = 4, b = 164},
	groups = {liquid_guptonite = 3, liquid = 2, igniter = 1},
})

minetest.register_node("guptonium:liquid_guptonite_flowing", {
	description = "Flowing Liquid Guptonite",
	drawtype = "flowingliquid",
	tiles = {"guptonite_liquid.png"},
	special_tiles = {
		{
			name = "guptonite_liquid_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "guptonite_liquid_flowing_animated.png",
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
	liquid_alternative_flowing = "guptonium:liquid_guptonite_flowing",
	liquid_alternative_source = "guptonium:liquid_guptonite_source",
    liquid_viscosity = 3,
    liquid_range = 16,
	liquid_renewable = false,
	light_source = 3,
	damage_per_second = -1,
	post_effect_color = {a = 191, r = 56, g = 4, b = 164},
	groups = {liquid_guptonite = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

bucket.register_liquid(
	"guptonium:liquid_guptonite_source",
	"guptonium:liquid_guptonite_flowing",
	"guptonium:bucket_guptonite",
	"bucket_guptonite.png",
	"Liquid Guptonite Bucket"
)

minetest.register_craft({
	type = "fuel",
	recipe = "guptonium:bucket_guptonite",
	burntime = 1, -- burns for a really short time, but it can be cooked to reinvigorate it!
	replacements = {{"guptonium:bucket_guptonite", "bucket:bucket_empty"}},
})

minetest.register_craft({
	type = "cooking",
	output = "guptonium:bucket_active_guptonite",
	recipe = "guptonium:bucket_guptonite",
	cooktime = 100,
})

minetest.register_craft({
	type = "cooking",
	output = "guptonium:liquid_active_guptonite_source",
	recipe = "guptonium:liquid_guptonite_source",
	cooktime = 100,
})


minetest.register_node("guptonium:liquid_active_guptonite_source", {
	description = "Liquid Active Guptonite Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "active_guptonite_liquid_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	special_tiles = {
		-- New-style liquid active_guptonite source material (mostly unused)
		{
			name = "active_guptonite_liquid_source_animated.png",
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
	liquid_alternative_flowing = "guptonium:liquid_active_guptonite_flowing",
	liquid_alternative_source = "guptonium:liquid_active_guptonite_source",
    liquid_viscosity = 700,
    liquid_range = 16,
	liquid_renewable = false,
	light_source = 10,
	damage_per_second = 100,
	post_effect_color = {a = 191, r = 56, g = 4, b = 256},
	groups = {liquid_active_guptonite = 3, liquid = 2, igniter = 1},
})

minetest.register_node("guptonium:liquid_active_guptonite_flowing", {
	description = "Flowing Liquid Active Guptonite",
	drawtype = "flowingliquid",
	tiles = {"active_guptonite_liquid.png"},
	special_tiles = {
		{
			name = "active_guptonite_liquid_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "active_guptonite_liquid_flowing_animated.png",
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
	liquid_alternative_flowing = "guptonium:liquid_active_guptonite_flowing",
	liquid_alternative_source = "guptonium:liquid_active_guptonite_source",
    liquid_viscosity = 700,
    liquid_range = 16,
	liquid_renewable = false,
	light_source = 10,
	damage_per_second = 100,
	post_effect_color = {a = 191, r = 56, g = 4, b = 256},
	groups = {liquid_active_guptonite = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

bucket.register_liquid(
	"guptonium:liquid_active_guptonite_source",
	"guptonium:liquid_active_guptonite_flowing",
	"guptonium:bucket_active_guptonite",
	"bucket_active_guptonite.png",
	"Liquid Active Guptonite Bucket"
)

minetest.register_craft({
	type = "fuel",
	recipe = "guptonium:bucket_active_guptonite",
	burntime = 60000, -- burns for an INSANELY long time!
	replacements = {{"guptonium:bucket_active_guptonite", "guptonium:guptonite_glass"}},
})