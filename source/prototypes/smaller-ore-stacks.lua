if settings.startup["hardcrafting-smaller-ore-stacks"].value == true then

	local ores = {}
	for _,resource in pairs(data.raw["resource"]) do
		if resource.minable.result ~= nil then
			ores[resource.minable.result] = true
		else
			for _,ore in pairs(resource.minable.results) do
				if ore ~= nil and ore.name ~= nil then
					ores[ore.name] = true
				else
					err("found invalid minable.results in: "..serpent.block(resource))
				end
			end
		end
	end
	
	for oreName,_ in pairs(ores) do
		if data.raw.item[oreName] ~= nil then
			data.raw.item[oreName].stack_size = data.raw.item[oreName].stack_size / 2
		end
	end
end