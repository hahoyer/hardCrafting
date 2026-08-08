

if mods["methane-processing"] then
	info("added some recipes to chemistry for compatibility with methane-processing")
	if data.raw.technology["chemistry"] then
		addTechnologyUnlocksRecipe("chemistry","copper-plate_sulfat")
		addTechnologyUnlocksRecipe("chemistry","copper-sulfat")
	end
	
	if data.raw.item["oxalic-acid"] then
		recipeReplaceResult("sulfur_dust","sulfur","oxalic-acid")
		data.raw.recipe["sulfur_dust"].icon = data.raw.item["oxalic-acid"].icon
	end
	
	recipeReplaceResult("copper-plate_sulfat","sulfuric-acid","gas-methane")
	recipeReplaceResult("copper-plate_sulfat-big","sulfuric-acid","gas-methane")
end