mobs:register_mob("mobs_mese:terramese_monster", {
	type = "monster",
	passive = false,
	docile_by_day = true,
	damage = 5,
	attack_type = "shoot",
	shoot_interval = 0.6,
	arrow = "mobs_mese:terramese_arrow",
	shoot_offset = 2,
	hp_min = 40,
	hp_max = 75,
	armor = 280,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_mese_monster.x",
	textures = {
		male = {
			{"mobs_mese_terra.png"},
		},
		female = {
			{"mobs_mese_terra_female.png"},
		},
	},
	blood_texture = "mese_terramese_crystal_fragment.png",
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_mesemonster",
	},
	view_range = 10,
	walk_velocity = 0.3,
	run_velocity = 1.4,
	jump = true,
	jump_height = 8,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 2.1,
	fly = true,
	fly_in = "air",
	drops = {
		{name = "mese:terramese_crystal", chance = 9, min = 0, max = 2},
		{name = "mese:terramese_crystal_fragment", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 1,
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
	follow = {"mese:terramese_crystal","mese:terramese_block","mese:terramese_crystal_fragment"},
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
				texture = "mese_terramese_crystal.png",
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
	name = "mobs_mese:terramese_monster",
	nodes = {"default:stone"},
	max_light = 6,
	chance = 8000,
	active_object_count = 1,
	max_height = -100,
})


mobs:register_egg("mobs_mese:terramese_monster", S("Earth Mese Monster"), "mese_terramese_block.png", 1)


mobs:alias_mob("mobs:mese_monster", "mobs_monster:mese_monster") -- compatiblity


-- mese arrow (weapon)
mobs:register_arrow("mobs_mese:terramese_arrow", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"mese_terramese_crystal_fragment.png"},
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