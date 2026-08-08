require("prototypes.antenna")
require("prototypes.rotor")
require("prototypes.electro-magnet")

-- Engine unit
data.raw["recipe"]["engine-unit"].energy_required = 10
data.raw["recipe"]["engine-unit"].ingredients = {
	{type="fluid", name= "lubricant", amount = 2},
	{type="item", name="pipe", amount=1},
	{type="item", name="iron-gear-wheel", amount=1},
	{type="item", name="steel-plate", amount=1}
}

-- Electric engine unit
data.raw["recipe"]["electric-engine-unit"].energy_required = 10
data.raw["recipe"]["electric-engine-unit"].categories = {"crafting"}
data.raw["recipe"]["electric-engine-unit"].ingredients = {
	{type="item", name="electro-magnet", amount=2},
	{type="item", name="electronic-circuit", amount=1},
	{type="item", name="copper-cable", amount=1},
	{type="item", name="steel-plate", amount=1}
}

-- Robot frame
data.raw["recipe"]["flying-robot-frame"].energy_required = 10
data.raw["recipe"]["flying-robot-frame"].ingredients = {
	{type="item", name="electric-engine-unit", amount=1},
  {type="item", name="battery", amount=2},
  {type="item", name="rotor", amount=4},
  {type="item", name="copper-cable", amount=4}
}

-- Robots
data.raw["recipe"]["logistic-robot"].energy_required = 5
data.raw["recipe"]["logistic-robot"].ingredients = {
	{type="item", name="flying-robot-frame", amount=1},
  {type="item", name="advanced-circuit", amount=1},
	{type="item", name="antenna", amount=1}
}
data.raw["recipe"]["construction-robot"].energy_required = 5
data.raw["recipe"]["construction-robot"].ingredients = {
	{type="item", name="flying-robot-frame", amount=1},
  {type="item", name="electronic-circuit", amount=1},
	{type="item", name="antenna", amount=1}
}
