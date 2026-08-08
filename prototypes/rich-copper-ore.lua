if settings.startup["hardcrafting-rich-ores"].value == true then
	require "prototypes.demo-resources"

	data:extend({
		{
			type = "autoplace-control",
			category = "resource",
			localised_name = {"", "[entity=rich-copper-ore] ", {"entity-name.rich-copper-ore"}},
			name = "rich-copper-ore",
			richness = true,
			order = "b-b2"
		},
		{
			type = "item",
			icon_size = 32,
			name = "rich-copper-ore",
			icon = "__"..fullModName.."__/graphics/icons/rich-copper-ore.png",
			subgroup = "copper",
			order = "f[copper-ore]2",
			stack_size = 50
		},
		resource(
			{
				name = "rich-copper-ore",
				order = "b-b1",
				map_color = {r=1, g=0.6, b=0.35},
				mining_time = 1
			},
			{
				base_density = 4.5,
				regular_rq_factor_multiplier = 0.90,
				starting_rq_factor_multiplier = 1.05
			}
		)
	})

	-- 2.0 requires every autoplaced resource to be explicitly whitelisted in the
	-- planet's own map_gen_settings, or map generation ignores it entirely, no
	-- matter how correct its own autoplace expression is.
	data.raw.planet.nauvis.map_gen_settings.autoplace_controls["rich-copper-ore"] = {}
	data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["rich-copper-ore"] = {}

	data.raw.resource["rich-copper-ore"].minable.mining_particle = "copper-ore-particle"
	data.raw["resource"]["rich-copper-ore"].minable.results = {
		ressourceItemMinMaxProb("rich-copper-ore",	 1, 1, 0.8), -- 1 item at percentage 0.8 --
		ressourceItemMinMaxProb("gravel",				1, 1, 0.09),
		ressourceItemMinMaxProb("copper-sludge",1, 1, 0.06),
	}
end

data:extend{
    {
        type = "sprite",
        name = fullModName .. "_rich-copper-ore",
        filename = "__" .. fullModName .. "__/graphics/icons/rich-copper-ore.png",
        size = 32,
    },

}
