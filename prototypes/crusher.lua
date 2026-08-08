require("prototypes.item-group-production")

data:extend({
	{
		type = "item",
		icon_size = 32,
		name = "crusher",
		icon = "__"..fullModName.."__/graphics/icons/crusher.png",
		subgroup = "advanced-processing-machine",
		order = "f",
		place_result = "crusher",
		enabled = false,
		stack_size = 50
	},
	{
		type = "recipe",
		name = "crusher",
		ingredients = {
			{type="item", name="stone", amount=15},{type="item", name="electronic-circuit", amount=2},{type="item", name="iron-gear-wheel", amount=5}
		},
		enabled = false,
		results = {{type="item", name="crusher", amount=1}}
	},
	{
		type = "recipe-category",
		name = "crusher"
	},
})

-- Entity
local crusher = deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
crusher.name = "crusher"
crusher.crafting_categories = {"crusher"}
crusher.energy_usage = "80kW"
crusher.source_inventory_size = 1
crusher.result_inventory_size = 3
crusher.crafting_speed = 1
crusher.minable.result = "crusher"
crusher.energy_source.emissions = 0.005
crusher.icon_size = 32

crusher.icon =  "__"..fullModName.."__/graphics/icons/crusher.png"
crusher.graphics_set.animation = {
	filename = "__"..fullModName.."__/graphics/entity/crusher-base.png",
	line_length = 1,
	width = 129,
	height = 100,
	frame_count = 1,
	axially_symmetrical = false,
	direction_count = 1,
	shift = {0.421875, 0},
}
crusher.graphics_set.working_visualisations = deepcopy(data.raw["furnace"]["electric-furnace"].graphics_set.working_visualisations)
table.remove(crusher.graphics_set.working_visualisations,1)
table.insert(crusher.graphics_set.working_visualisations, {animation={
	filename = "__"..fullModName.."__/graphics/entity/crush-animation.png",
	priority = "high",
	line_length = 11,
	width = 23,
	height = 14,
	frame_count = 11,
	animation_speed = 0.2,
	shift = {-0.015625, 0.9375},
}})

crusher.working_sound = data.raw["furnace"]["electric-furnace"].working_sound
crusher.open_sound  = data.raw["furnace"]["electric-furnace"].open_sound
crusher.close_sound  = data.raw["furnace"]["electric-furnace"].close_sound

data:extend({ crusher })

-- technology
data:extend({
	{
		type = "technology",
		name = "crusher",
		icon = "__"..fullModName.."__/graphics/technology/crusher.png",
		icon_size = 128,
		prerequisites = {},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "crusher"
			}
		},
		unit = {
			count = 42,
			ingredients = {
				{"automation-science-pack", 1}
			},
			time = 20
		},
		order = "_hc_machines_1"
	}
})
