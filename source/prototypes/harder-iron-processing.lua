-- Requirement: --
require "prototypes.dirt"
require "prototypes.gravel"
require "prototypes.crusher"
require "prototypes.pulverizer"

-- Minable ressources: --
data.raw["resource"]["iron-ore"].minable.result = nil
data.raw["resource"]["iron-ore"].minable.results = {
	ressourceItemMinMaxProb("iron-ore",   1, 1, 0.9), -- 1 item at percentage 0.9 --
	ressourceItemMinMaxProb("iron-nugget",1, 1, 0.1),
	ressourceItemMinMaxProb("gravel",     1, 1, 0.45),
	ressourceItemMinMaxProb("dirt",       1, 1, 0.4)
}

-- Item groups: --
data:extend({
  {
    type = "item-subgroup",
    name = "iron",
    group = "intermediate-products",
    order = "b2"
  }
})

-- Items: --
data.raw.item["iron-ore"].subgroup = "iron"
addItem("iron-slag","iron","e[iron-ore]3",50)
addItem("crushed-iron","iron","e[iron-ore]4",50)
addItem("pulverized-iron","iron","e[iron-ore]5",50)
addItem("iron-nugget","iron","e[iron-ore]6",50)

-- Calculate ore->plate factor for Recipes
local c = data.raw["recipe"]["iron-plate"]

local function searchOreAmount(tableOfIngredients,nameToSearch)
	for _,t in pairs(tableOfIngredients) do
		if t[1] == nameToSearch then return t[2] end
	end
	return 0
end
local resultingCount = c.result_count
if not resultingCount then resultingCount=1 end
ironOreToPlateFactor = resultingCount / searchOreAmount(c.ingredients,"iron-ore")
info("1x Iron-ore = "..tostring(ironOreToPlateFactor).."x iron-plate")

local function c(amount)
	return math.ceil(amount*ironOreToPlateFactor)
end

-- Recipes: --
data.raw["recipe"]["iron-plate"] = nil
--       item Name     category   subgroup     time    ingredients     		products
-- Tier1
addRecipe("iron-plate|nugget","smelting","iron",1,{{"iron-nugget",1}},		{{"iron-plate",c(1)}},"a")
addRecipe("iron-plate","smelting","iron",3.5,{{"iron-ore",2}},						{{"iron-plate",c(1)},{"iron-slag",1}},"b")

-- Tier2
addRecipe("iron-slag","crusher","iron",8,{{"iron-slag",5}},								{{"crushed-iron",2},{"gravel",3}},"c")
data.raw["recipe"]["iron-slag"].icon = "__hardCrafting__/graphics/icons/slag-processing.png"

addTechnologyUnlocksRecipe("crusher","iron-slag")
addRecipe("crushed-iron","crusher","iron",16.5,{{"iron-ore",10}},					{{"crushed-iron",6},{"iron-nugget",3},{"stone",1}},"d")
addTechnologyUnlocksRecipe("crusher","crushed-iron")
addRecipe("iron-plate|1","smelting","iron",		3.5,{{"crushed-iron",2}},		{{"iron-plate",c(2)},{"iron-slag",1}},"e")
addTechnologyUnlocksRecipe("crusher","iron-plate|1")

-- Tier3
addRecipe("pulverized-iron","pulverizer","iron",5.5,{{"crushed-iron",3},{"gravel",4}},	{{"pulverized-iron",3},{"iron-nugget",2},{"iron-slag",2}},"f")
addTechnologyUnlocksRecipe("pulverizer","pulverized-iron")
addRecipe("iron-plate|2","smelting","iron",	1.75,{{"pulverized-iron",1}},	{{"iron-plate",c(1)}},"g")
addTechnologyUnlocksRecipe("pulverizer","iron-plate|2")