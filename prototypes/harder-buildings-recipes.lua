if settings.startup["hardcrafting-complex-crafting-byproduct"].value == true then
	-- Requirement: --

	local recipeWhiteList = table.set({
		"splitter", "fast-splitter", "express-splitter", "filter-inserter","stack-inserter","stack-filter-inserter",
		"logistic-robot", "construction-robot", "roboport",
		"logistic-chest-active-provider", "logistic-chest-passive-provider", "logistic-chest-requester", "logistic-chest-storage", "logistic-chest-buffer",
		"big-electric-pole", "substation", "train-stop", "locomotive", "tank",
		"solar-panel", "accumulator",
		"pumpjack", "electric-furnace", "electric-incinerator", "pulverizer", "assembling-machine-2",
		"assembling-machine-3", "oil-refinery", "chemical-plant", "lab", "beacon", "centrifuge",
		"nuclear-reactor", "heat-exchanger", "heat-pipe",
		"gun-turret", "laser-turret", "radar", "rocket-silo"
	})

	-- Recipes: --
	--           n                ame     category   subgroup     time    ingredients     			products		order
	addRecipe("scrap-metal-processing","hc-pulverizer","by-products",8,{{"scrap-metal",5}},{{"pulverized-iron",3},{"copper-dust",2}},"z[scrap-metal]")

	for recipeName,recipe in pairs(data.raw["recipe"]) do
		if recipeWhiteList[recipeName] then
			local resultItem = recipe.results and recipe.results[1] and recipe.results[1].name
			local item = resultItem and data.raw["item"][resultItem]
			if item and item.place_result then
				table.insert(recipe.results, { type="item", name="scrap-metal",amount=1})
				if not recipe.icon then
					recipe.icon = item.icon
    				recipe.icon_size = item.icon_size
				end
				if not recipe.subgroup then
					recipe.subgroup = item.subgroup
				end
				if not recipe.order then
					recipe.order = item.order
				end
			end
		end
	end
end