-- Mese Monster by Zeg9

mobs:register_mob("mobs_mese:mesemarine_monster", {
	type = "monster",
	passive = false,
	docile_by_day = true,
	damage = 3,
	attack_type = "shoot",
	shoot_interval = 0.5,
	arrow = "mobs_mese:mesemarine_arrow",
	shoot_offset = 2,
	hp_min = 20,
	hp_max = 50,
	armor = 38,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_mese_monster.x",
	textures = {
		male = {
			{"mobs_mese_marine.png"},
		},
		female = {
			{"mobs_mese_marine_female.png"},
		},
	},
	blood_texture = "mese_mesemarine_crystal_fragment.png",
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_mesemonster",
	},
	view_range = 20,
	walk_velocity = 0.5,
	run_velocity = 2,
	jump = true,
	jump_height = 16,
	fall_damage = 0,
	fall_speed = -8,
	stepheight = 3,
	fly = true,
	fly_in = "default:water_source",
	drops = {
		{name = "mese:mesemarine_crystal", chance = 9, min = 0, max = 2},
		{name = "mese:mesemarine_crystal_fragment", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
	follow = {"mese:mesemarine_crystal","mese:mesemarine_block","mese:mesemarine_crystal_fragment"},
  	on_rightclick = function(self, clicker, pos)
		--minetest.chat_send_player(clicker:get_player_name(),
		--self.gender)

		--are we feeding?
		if mobs:feed_tame(self, clicker, 2, true, true) then
			minetest.add_particlespawner({
				amount = 25,
				time = 0.25,
				minpos = pos,
				maxpos = pos,
				minvel = {x = -2, y = -2, z = -2},
				maxvel = {x = 2,  y = 2,  z = 2},
				minacc = {x = -5, y = -5, z = -5},
				maxacc = {x = 0, y = 0, z = 0},
				minexptime = 0.1,
				maxexptime = 1,
				minsize = 0.125,
				maxsize = 0.5,
				texture = "mese_mesemarine_crystal.png",
			})
		end

		local item = clicker:get_wielded_item()
		local itemname = item:get_name()
		local name = clicker:get_player_name()
		--are we capturing?
		mobs:capture_mob(self, clicker, 1, 5, 60, false, nil)
  end
})


mobs:spawn({
	name = "mobs_mese:mesemarine_monster",
	nodes = {"default:stone"},
	max_light = 6,
	chance = 8000,
	active_object_count = 1,
	max_height = -100,
})


mobs:register_egg("mobs_mese:mesemarine_monster", S("dark Mese Monster"), "mese_mesemarine_block.png", 1)

-- mese arrow (weapon)
mobs:register_arrow("mobs_mese:mesemarine_arrow", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"mese_mesemarine_crystal_fragment.png"},
	--textures = {"default:mese_crystal_fragment"},
	velocity = 6,
--	rotate = 180,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2},
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})