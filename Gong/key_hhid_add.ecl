import gong, doxie, data_services;
	
gong_hhid_add_base := gong.file_gong_hhid_add(hhid != 0);
	
export key_hhid_add := index(
	gong_hhid_add_base,
	{unsigned6 s_hhid := hhid}, {gong_hhid_add_base},
	data_services.data_location.prefix() + 'thor_data400::key::gong_hhid_add_' + doxie.Version_SuperKey,OPT);
