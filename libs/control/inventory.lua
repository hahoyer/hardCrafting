-- Adds two get_contents()-style arrays ({name, quality, count}) together
-- Does not modify a table in place
function addContentsTables(content1,content2)
	local result = {}
	local index = {}
	for _,stack in pairs(deepcopy(content1)) do
		table.insert(result,stack)
		index[stack.name.."|"..stack.quality] = stack
	end
	for _,stack in pairs(content2) do
		local key = stack.name.."|"..stack.quality
		local existing = index[key]
		if existing then
			existing.count = existing.count + stack.count
		else
			local copy = deepcopy(stack)
			table.insert(result,copy)
			index[key] = copy
		end
	end
	return result
end

-- Moves all items from first inventory to second one
-- Returns: false if not all items could be moved
function moveInventoryToInventory(invSource,invTarget)
	for _,stack in pairs(invSource.get_contents()) do
		local itemStack = {name=stack.name, quality=stack.quality, count=stack.count}
		if invTarget.can_insert(itemStack) then
			itemStack.count = invTarget.insert(itemStack)
			itemStack.count = invSource.remove(itemStack)
		else
			return false -- couldn't move all, target chest is full
		end
		if itemStack.count ~= stack.count then return false end
	end
	return true
end

-- Deprecated, use new method below with correct name
function killItemsInInventor(inventory, itemName)
	inventory.remove({name=itemName,count=1000000})
end

-- Spills whole inventory on the surface
function spillInventory(inventory, surface, position)
	for i=1,#inventory do
		local stack = inventory[i]
		if stack and stack.valid and stack.valid_for_read then
			surface.spill_item_stack(position,stack)
		end
	end
end