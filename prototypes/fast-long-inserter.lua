require "libs.prototypes.technology"

if settings.startup["hardcrafting-extra-inserters"].value == true then
    data:extend(
        {
            {
                type = "item",
                name = "fast-long-inserter",
                icon = "__" .. fullModName .. "__/graphics/icons/fast-long-inserter.png",
                icon_size = 32,
                subgroup = "inserter",
                order = "d[fast-inserter]-2",
                place_result = "fast-long-inserter",
                stack_size = 50,
            },
            {
                type = "recipe",
                name = "fast-long-inserter",
                enabled = "false",
                ingredients = {
                    {type="item", name="electronic-circuit", amount=2},
                    {type="item", name="iron-gear-wheel", amount=1},
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="inserter", amount=1},
                },
                results = {{type="item", name="fast-long-inserter", amount=1}},
            },
        }
    )

    addTechnologyUnlocksRecipe("logistics-2", "fast-long-inserter")

    local long = deepcopy(data.raw["inserter"]["fast-inserter"])
    overwriteContent(
        long, {
            name = "fast-long-inserter",
            icon = "__" .. fullModName .. "__/graphics/icons/fast-long-inserter.png",
            icon_size = 32,
            pickup_position = {0, -2},
            insert_position = {0, 2.2},
            extension_speed = 0.1,
        }
    )
    long.minable.result = "fast-long-inserter"
    data:extend({long})
end

data:extend{
    {
        type = "sprite",
        name = fullModName .. "_fast-long-inserter",
        filename = "__" .. fullModName .. "__/graphics/icons/fast-long-inserter.png",
        size = 32,
    },

}
