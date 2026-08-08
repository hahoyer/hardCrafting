entities["incinerator"]={}
entities["incinerator"].build = function(entity)
	table.insert(storage.hardCrafting.incinerators,entity)
end
entities["electric-incinerator"]={}
entities["electric-incinerator"].build = function(entity)
	table.insert(storage.hardCrafting.eincinerators,entity)
end

---------------------------------------------------
-- Tick Incinerators
---------------------------------------------------

function updateIncinerators()
	if game.tick % 120 ~= 0 then return end
	for key,entity in pairs(storage.hardCrafting.incinerators) do
		if entity.valid then
			reactivateIncineratorsInserters(entity,2)
		else
			storage.hardCrafting.incinerators[key] = nil
		end
	end
	for key,entity in pairs(storage.hardCrafting.eincinerators) do
		if entity.valid then
			reactivateIncineratorsInserters(entity,3)
		else
			storage.hardCrafting.eincinerators[key] = nil
		end
	end
end

function reactivateIncineratorsInserters(entity,r)
	if not entity.is_crafting() then
		local pos = entity.position
		local search = {{pos.x-r,pos.y-r}, {pos.x+r,pos.y+r}}
		local inserters = entity.surface.find_entities_filtered{area = search, type= "inserter"}
		for _,inserter in pairs(inserters) do
			if inserter.active then
				--quickly toggle inserter active state, will recheck whether item can be inserted
				inserter.active = false
				inserter.active = true
			end
		end
	end
end