local mp = minetest.get_modpath("mobs_mese")

-- function to select the textures depending if you are running off of my fork of mobs redo which includes using different textures for a male and a female variant of a mob
local function texturelist(mesename)
	local name = mesename
	if mesename == nil then
		name = ""
	else
		name = "_"..mesename
	end
	list = {}
	if mobs.redo ~= nil then
		list = {
			male = {
				{"mobs_mese"..name..".png"},
			},
			female = {
				{"mobs_mese"..name.."_female.png"},
			},
		}
	else
		list = {
			{"mobs_mese"..name..".png"},
			{"mobs_mese"..name.."_female.png"},
		}
	end
	return list
end

print("mobs mese loaded")
dofile(mp.."/standard.lua")
dofile(mp.."/terra.lua")
dofile(mp.."/hard.lua")
dofile(mp.."/dark.lua")
dofile(mp.."/shadow.lua")
dofile(mp.."/inferno.lua")
dofile(mp.."/light.lua")
dofile(mp.."/stratus.lua")
dofile(mp.."/marine.lua")
