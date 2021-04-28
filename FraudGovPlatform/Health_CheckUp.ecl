import STD;
export Health_CheckUp(string pVersion) := module 

export All:=PARALLEL(
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::config::customermappings')>0,'Unit Test Failed on ~fraudgov::config::customermappings',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::config::customersettings')>0,'Unit Test Failed on ~fraudgov::config::customersettings',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::bypassed_deltabase')>0,'Unit Test Failed on ~fraudgov::in::sprayed::bypassed_deltabase',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::bypassed_identitydata')>0,'Unit Test Failed on ~fraudgov::in::sprayed::bypassed_identitydata',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::bypassed_knownfraud')>0,'Unit Test Failed on ~fraudgov::in::sprayed::bypassed_knownfraud',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::deltabase')>0,'Unit Test Failed on ~fraudgov::in::sprayed::deltabase',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::identitydata')>0,'Unit Test Failed on ~fraudgov::in::sprayed::identitydata',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::knownfraud')>0,'Unit Test Failed on ~fraudgov::in::sprayed::knownfraud',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbs')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbs',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbscolvaldesc')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbscolvaldesc',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbsdemodata')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbsdemodata',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbsfdnccid')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbsfdnccid',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbsfdnhhid')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbsfdnhhid',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbsfdnindtype')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbsfdnindtype',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbsfdnmasteridindtypeinclusion')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbsfdnmasteridindtypeinclusion',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbsproductinclude')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbsproductinclude',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::mbstablecol')>0,'Unit Test Failed on ~fraudgov::in::sprayed::mbstablecol',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::configattributes')>0,'Unit Test Failed on ~fraudgov::in::sprayed::configattributes',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::configrules')>0,'Unit Test Failed on ~fraudgov::in::sprayed::configrules',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::sprayed::configrisklevel')>0,'Unit Test Failed on ~fraudgov::in::sprayed::configrisklevel',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::base::qa::main')>0,'Unit Test Failed on ~fraudgov::base::qa::main',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::base::qa::main_orig')>0,'Unit Test Failed on ~fraudgov::base::qa::main_orig',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::base::main_demo_anon')>0,'Unit Test Failed on ~fraudgov::base::main_demo_anon',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~nac::base::consortium')>0,'Unit Test Failed on ~nac::base::consortium',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~thor::base::nid::repository::current')>0,'Unit Test Failed on ~thor::base::nid::repository::current',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~thor::key::new_suppression::qa::opt_out')>0,'Unit Test Failed on ~thor::key::new_suppression::qa::opt_out',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~thor_data400::key::bank_routing::qa::rtn')>0,'Unit Test Failed on ~thor_data400::key::bank_routing::qa::rtn',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~thor_data400::key::advo::qa::addr_search1')>0,'Unit Test Failed on ~thor_data400::key::advo::qa::addr_search1',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~thor_data400::key::ip_metadata_ipv4_qa')>0,'Unit Test Failed on ~thor_data400::key::ip_metadata_ipv4_qa',FAIL);
	ASSERT(STD.File.GetSuperFileSubCount('~thor_data400::key::phones_type_qa')>0,'Unit Test Failed on ~thor_data400::key::phones_type_qa',FAIL);
	
	//OPTIONAL
	// ASSERT(STD.File.GetSuperFileSubCount('~thor_data400::key::address_clean::clean_qa')>0,'Unit Test Failed on ~thor_data400::key::address_clean::clean_qa',FAIL);	
	// ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::passed::identitydata')>0,'Unit Test Failed on ~fraudgov::in::passed::identitydata');
	// ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::passed::knownfraud')>0,'Unit Test Failed on ~fraudgov::in::passed::knownfraud');
	// ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::passed::inquirylogs')>0,'Unit Test Failed on ~fraudgov::in::passed::inquirylogs');
	// ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::passed::deltabase')>0,'Unit Test Failed on ~fraudgov::in::passed::deltabase',FAIL);
	// ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::passed::nac')>0,'Unit Test Failed on ~fraudgov::in::passed::nac',FAIL);
	// ASSERT(STD.File.GetSuperFileSubCount('~fraudgov::in::passed::rdp')>0,'Unit Test Failed on ~fraudgov::in::passed::rdp',FAIL);

);


end;