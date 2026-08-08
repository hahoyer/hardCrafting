require "constants"

function emptyImage()
	return {
		filename = "__"..fullModName.."__/graphics/empty.png",
		priority = "low",
		width = 1,
		height = 1,
		shift = {0,0}
  }
end

function addItem(itemName, subgroup, order, stackSize)
	data:extend({
		{
			type = "item",
			icon_size = 32,
			name = itemName,
			icon = "__"..fullModName.."__/graphics/icons/"..itemName..".png",
			subgroup = subgroup,
			order = order,
			stack_size = stackSize
		}
	})
end


-- Converts old-style shorthand entries ({"name", amount}) to the mandatory
-- table format ({type=..., name=..., amount=...}) required by recipe ingredients/results.
local function toDetailedIngredientList(list, listDescription, recipeName)
	local detailed = {}
	if not list then
		print("No "..listDescription.." found for recipe with name: "..recipeName)
		return detailed
	end
	for _,s in pairs(list) do
		if s["type"] then
			table.insert(detailed,s)
		else
			local typ = "item"
			if s[1] == "sulfuric-acid" or s[1] == "water" then
				typ = "fluid"
			end
			table.insert(detailed, {type=typ, name=s[1], amount=s[2]})
		end
	end
	return detailed
end

function addRecipe(name,category,subgroup,timeRequired,ingredients,results,order)
	local ingredientsDetailled = toDetailedIngredientList(ingredients, "ingredients", name)
	local resultsDetailled = toDetailedIngredientList(results, "results", name)
	local imageName = removeAfterSign(name,"_")
	data:extend({
	{
		type = "recipe",
	icon_size = 32,
    name = name,
    categories = {category},
		subgroup = subgroup,
    energy_required = timeRequired,
    ingredients = ingredientsDetailled,
		icon = "__"..fullModName.."__/graphics/icons/"..imageName..".png",
    results = resultsDetailled,
		order = order
	}
	})
end
