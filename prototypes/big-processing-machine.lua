require "libs.prototypes.prototypes"
require "libs.prototypes.technology"
require "prototypes.item-group-production"
local assembler_pictures = require("__base__/prototypes/entity/assembler-pictures")

-- Item and recipe
data:extend({
	{
		type = "item",
		icon_size = 32,
		name = "big-processing-machine",
		icon = "__"..fullModName.."__/graphics/icons/big-processing-machine.png",
		subgroup = "advanced-processing-machine",
		order = "h",
		place_result = "big-processing-machine",
		stack_size = 50
	},
	{
		type = "recipe",
		name = "big-processing-machine",
		ingredients = {
			{type="item", name="crusher", amount=2},{type="item", name="pulverizer", amount=2},{type="item", name="steel-plate", amount=20},{type="item", name="advanced-circuit", amount=20}
		},
		energy_required = 10,
		results = {{type="item", name="big-processing-machine", amount=1}}
	},
})

-- Entity
local processer = deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
overwriteContent(processer, {
	name = "big-processing-machine",
	max_health = 1500,
	crafting_categories = {"big-processing-machine"},
	energy_usage = "400kW",
	source_inventory_size = 3,
	result_inventory_size = 4,
	crafting_speed = 4,
	collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
	selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
	icon =  "__"..fullModName.."__/graphics/icons/big-processing-machine.png",
	icon_size = 32,
	working_sound = data.raw["furnace"]["electric-furnace"].working_sound,
	open_sound  = data.raw["furnace"]["electric-furnace"].open_sound,
	close_sound  = data.raw["furnace"]["electric-furnace"].close_sound,
})
processer.graphics_set.animation = {
	filename = "__"..fullModName.."__/graphics/entity/big-processing-machine/big-processing-machine-base.png",
	line_length = 1,
	width = 184,
	height = 188,
	frame_count = 1,
	axially_symmetrical = false,
	direction_count = 1,
	shift = {0.515625, -0.40625},
}


processer.graphics_set.working_visualisations = deepcopy(data.raw["furnace"]["electric-furnace"].graphics_set.working_visualisations)
table.remove(processer.graphics_set.working_visualisations,1)
processer.graphics_set.working_visualisations[1].animation.shift = {-1.4375, 0.328125}
processer.graphics_set.working_visualisations[2].animation.shift = {-0.703125, -0.890625}
table.insert(processer.graphics_set.working_visualisations,deepcopy(processer.graphics_set.working_visualisations[2]))
processer.graphics_set.working_visualisations[3].animation.shift = {1.078125, -1.234375}
table.insert(processer.graphics_set.working_visualisations, {animation={
	filename = "__"..fullModName.."__/graphics/entity/crush-animation.png",
	priority = "high",
	line_length = 11,
	width = 23,
	height = 14,
	frame_count = 11,
	animation_speed = 0.5,
	shift = {-0.78125, 1.90625}
}})
table.insert(processer.graphics_set.working_visualisations, {animation={
	filename = "__"..fullModName.."__/graphics/entity/wheel2.png",
	priority = "high",
	line_length = 4,
	width = 33,
	height = 25,
	frame_count = 4,
	animation_speed = 0.5,
	shift = {1.1875, 0.859375}
}})

processer.fluid_boxes = {}
-- deepcopy: assembler2pipepictures is a shared table also used by vanilla
-- assembling-machine-2 and pumpjack; mutating it in place corrupted their pipe sprites too.
local processer_pipe_picture = deepcopy(assembler_pictures.assembler2pipepictures)
processer_pipe_picture.north.filename = "__"..fullModName.."__/graphics/entity/big-processing-machine/pipe-north.png"
processer_pipe_picture.north.width = 41
processer_pipe_picture.north.height = 40
table.insert(processer.fluid_boxes,{
	production_type = "input",
	pipe_picture = processer_pipe_picture,
	pipe_covers = pipecoverspictures(),
	volume = 1000,
	pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -2.2} }}
})
table.insert(processer.fluid_boxes,{
	production_type = "output",
	pipe_picture = processer_pipe_picture,
	pipe_covers = pipecoverspictures(),
	volume = 1000,
	pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 2.2} }}
})
processer.minable.result = "big-processing-machine"
processer.fast_replaceable_group = nil
processer.next_upgrade = nil
processer.module_slots = 4

data:extend({ processer })

-- technology
data:extend({
	{
		type = "technology",
		name = "big-processing-machine",
		icon = "__"..fullModName.."__/graphics/technology/big-processing-machine.png",
		icon_size = 128,
		prerequisites = { "pulverizer", "advanced-circuit"},
		unit = {
			count = 500,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1}
			},
			time = 30
		},
		order = "_hc_machines_3"
	}
})
addTechnologyUnlocksRecipe("big-processing-machine", "big-processing-machine")

-- Copy recipes for processing machine
addRecipeCategory("big-processing-machine")
local m1 = {
	ingredients={ {type="fluid",name="water",amount=10} },
	results={ {type="item",name="dirt",amount=1} }
}
local recipes = {}
if settings.startup["hardcrafting-rich-ores"].value == true then
	recipes = {["iron-slag"]=m1, ["crushed-iron"]=m1, ["crushed-iron_rich"]=m1, ["pulverized-iron"]=m1,
	["copper-sludge"]=m1, ["copper-dust"]=m1, ["copper-dust_rich"]=m1, ["copper-plate_sulfat"]=m1}
else
	recipes = {["iron-slag"]=m1, ["crushed-iron"]=m1, ["pulverized-iron"]=m1,
	["copper-sludge"]=m1, ["copper-dust"]=m1, ["copper-plate_sulfat"]=m1}
end

for name,mod in pairs(recipes) do
	local recipe = deepcopy(data.raw.recipe[name])
	recipe.name = recipe.name .. "-big"
	recipe.order = recipe.order .. "2"
	recipe.categories = {"big-processing-machine"}
	recipe.icon = recipe.icon:gsub(".png$", "-big.png")
	if name == "crushed-iron" then
		recipe.energy_required = 11
	end

	for _,item in pairs(mod.ingredients) do
		recipeAddIngredient(recipe,item)
	end
	for _,item in pairs(mod.results) do
		table.insert(recipe.results,item)
	end
	data:extend({recipe})
	addTechnologyUnlocksRecipe("big-processing-machine", recipe.name)
end

