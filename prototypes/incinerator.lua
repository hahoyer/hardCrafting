require("prototypes.item-group-production")
require("prototypes.incinerator-recipe-category")

-- Item and recipe
data:extend({
  {
    type = "item",
    name = "incinerator",
    icon = "__"..fullModName.."__/graphics/icons/incinerator.png",
		icon_size = 32,
     subgroup = "advanced-processing-machine",
    order = "a",
    place_result = "incinerator",
    stack_size = 50
  },
	{
    type = "recipe",
    name = "incinerator",
    ingredients = {
			{type="item", name="stone", amount=25},{type="item", name="steel-plate", amount=15},{type="item", name="iron-gear-wheel", amount=10},{type="item", name="steel-furnace", amount=2}
		},
		enabled = false,
		energy_required = 1,
    results = {{type="item", name="incinerator", amount=1}}
  }
})

-- incinerator Entity
local incinerator = deepcopy(data.raw["furnace"]["stone-furnace"])
incinerator.name = "incinerator"
incinerator.crafting_categories = {"incinerator"}
incinerator.energy_usage = "300kW"
incinerator.source_inventory_size = 1
incinerator.result_inventory_size = 1
incinerator.minable.result = "incinerator"
data:extend({ incinerator })

-- technology
data:extend({
  {
    type = "technology",
    name = "incinerator",
    icon = "__"..fullModName.."__/graphics/technology/incinerator.png",
    icon_size = 128,
    prerequisites = { "advanced-material-processing" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "incinerator"
      }
    },
    unit = {
      count = 80,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 30
    },
    order = "_incinerator"
  }
})
