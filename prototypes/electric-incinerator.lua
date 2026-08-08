require("prototypes.item-group-production")
require("prototypes.incinerator-recipe-category")

-- Item and recipe
data:extend({
	{
		type = "item",
		name = "electric-incinerator",
		icon = "__"..fullModName.."__/graphics/icons/electric-incinerator.png",
		icon_size = 32,
		subgroup = "advanced-processing-machine",
		order = "b",
		place_result = "electric-incinerator",
		stack_size = 50
	},
	{
		type = "recipe",
		name = "electric-incinerator",
		ingredients = {
			{type="item", name="stone", amount=25},{type="item", name="steel-plate", amount=15},{type="item", name="iron-gear-wheel", amount=10},{type="item", name="electric-furnace", amount=2}
		},
		enabled = false,
		energy_required = 5,
		results = {{type="item", name="electric-incinerator", amount=1}}
	}
})

-- incinerator Entity
local incinerator = deepcopy(data.raw["furnace"]["electric-furnace"])
incinerator.name = "electric-incinerator"
incinerator.crafting_categories = {"incinerator"}
incinerator.energy_usage = "450kW"
incinerator.source_inventory_size = 1
incinerator.result_inventory_size = 1
incinerator.minable.result = "electric-incinerator"
incinerator.module_slots = 1
data:extend({ incinerator })

-- technology
local prerequisites = { "advanced-material-processing-2"}
if data.raw["technology"]["incinerator"] ~= nil then
	table.insert(prerequisites, "incinerator")
end

data:extend({
	{
		type = "technology",
		name = "electric-incinerator",
		icon = "__"..fullModName.."__/graphics/technology/electric-incinerator.png",
		icon_size = 128,
		prerequisites = prerequisites,
		effects = {
			{
				type = "unlock-recipe",
				recipe = "electric-incinerator"
			}
		},
		unit = {
			count = 60,
			ingredients = {
				{"automation-science-pack", 3},
				{"logistic-science-pack", 1}
			},
			time = 30
		},
		order = "_incinerator-2"
	}
})
