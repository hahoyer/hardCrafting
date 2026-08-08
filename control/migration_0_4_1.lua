function migration_0_4_1()
	entities_migration_V2()
	local hc = storage.hardCrafting
	hc.entityData = nil
	hc.playerData = nil
	hc.schedule = nil
	
	storage.entities_cleanup_required = true
	storage.gui = nil
	storage.itemSelection = nil
	
	hc.version = "0.4.1"
end