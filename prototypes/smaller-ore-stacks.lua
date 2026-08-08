local ores = {
	gravel = true,
	sand = true,
	dirt = true,
	["copper-sludge"] = true,
	["copper-dust"] = true,
	["sulfur-dust"] = true,
	["copper-sulfat"] = true,
	["iron-slag"] = true,
	["iron-nugget"] = true,
	["crushed-iron"] = true,
	["pulverized-iron"] = true,
	["steel-dust"] = true,

}

for _, resource in pairs(data.raw["resource"]) do
	if resource.minable.results ~= nil then
		for _, ore in pairs(resource.minable.results) do
			if ore ~= nil and ore.name ~= nil then
				ores[ore.name] = true
			else
				err("found invalid minable.results in: " .. serpent.block(resource))
			end
		end
	elseif resource.minable.result ~= nil then
		ores[resource.minable.result] = true
	end
end

if deadlock then
	local stacked_ores = {}
	for name, _ in pairs(ores) do
		stacked_ores["deadlock-stack-"..name] = true
	end

	for name, _ in pairs(stacked_ores) do
		ores[name] = true
	end
end

if settings.startup["hardcrafting-smaller-ore-stacks"].value ~= 1 then
	for oreName, _ in pairs(ores) do
		if data.raw.item[oreName] ~= nil then
			data.raw.item[oreName].stack_size = math.ceil(data.raw.item[oreName].stack_size *
				settings.startup["hardcrafting-smaller-ore-stacks"].value)
		end
	end
end

if deadlock then
	for name, _ in pairs(ores) do
		local stackedName = "deadlock-stack-" ..name
		if data.raw.item[stackedName] ~= nil then
			data.raw.item[stackedName].stack_size = data.raw.item[name].stack_size
		end
	end
end
