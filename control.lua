require "libs.all"
require "constants"
require "libs.control.entities"

require "control.incinerators"
require "control.migration_0_4_1"

local railloader = require "interfaces.railloader"

-- storage data used:
-- hardCrafting.version = $version
-- hardCrafting.incinerators = { $incinerator:LuaEntity, ... }
-- hardCrafting.eincinerators = { $incinerator:LuaEntity, ... }

-- Init --
script.on_init(function()
	init()
end)

script.on_load(function()
	railloader.AddBulkItems()
end)

script.on_configuration_changed(function()
	local hc = storage.hardCrafting
	local previousVersion = hc.version
	if hc.version < "0.4.1" then migration_0_4_1() end
	if hc.version ~= previousVersion then
		info("Previous storage data version: "..previousVersion)
		info("Migrated to version "..hc.version)
	end
	railloader.AddBulkItems()
end)

function init()
	if not storage.hardCrafting then storage.hardCrafting = {} end
	local hc = storage.hardCrafting
	if not hc.version then hc.version = modVersion end

	if hc.incinerators == nil then hc.incinerators = {} end
	if hc.eincinerators == nil then hc.eincinerators = {} end

	entities_init()
	info("storage after init: "..serpent.block(storage))
	railloader.AddBulkItems()
end

script.on_event(defines.events.on_tick, function(event)
	updateIncinerators()
	entities_tick()
end)


---------------------------------------------------
-- Building Entities
---------------------------------------------------
script.on_event(defines.events.on_built_entity, function(event)
	entityBuilt(event)
end)
script.on_event(defines.events.on_robot_built_entity, function(event)
	entityBuilt(event)
end)

function entityBuilt(event)
	entities_build(event)
end


