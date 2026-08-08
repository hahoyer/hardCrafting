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

end