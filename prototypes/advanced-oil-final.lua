if settings.startup["hardcrafting-hard-oil"].value == true then
	local assembler_pictures = require("__base__/prototypes/entity/assembler-pictures")
	local crudeOil = data.raw.resource["crude-oil"]

	crudeOil.minable.fluid_amount = 10
	crudeOil.minable.required_fluid = "water"

	data.raw["mining-drill"].pumpjack.input_fluid_box = {
		production_type = "input",
		pipe_picture = assembler_pictures.assembler2pipepictures,
		pipe_covers = pipecoverspictures(),
		volume = 1000,
		pipe_connections =
		{
			{ flow_direction = "input", direction = defines.direction.west, position = {-1.2, 0} },
			{ flow_direction = "input", direction = defines.direction.south, position = {0, 1.2} },
			{ flow_direction = "input", direction = defines.direction.east, position = {1.2, 0} },
		}
	}

	for t, technology in pairs(data.raw.technology) do
		if technology.effects then
			for _, value in ipairs(technology.effects) do
				if value.type == "unlock-recipe" then
					local recipe = data.raw.recipe[value.recipe]
					if recipe.results then
						for _, result in ipairs(recipe.results) do
							if result.type == 'item' and result.name == 'pumpjack' then
								table.insert(technology.effects, { type = "mining-with-fluid", modifier = true })
							end
						end
					end
				end
			end
		end
	end
end
