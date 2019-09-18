import gong, doxie, data_Services; 

layout_key_did := RECORD
	gong.File_Gong_Did;
	//CCPA-22 CCPA new fields
	UNSIGNED4 global_sid := 0;
	UNSIGNED8 record_sid := 0;
END;

export key_did := index(gong.File_Gong_Did(did<>0),
                             {unsigned6 l_did := did},{layout_key_did},
                             data_services.data_location.prefix() + 'thor_data400::key::gong_did_'+doxie.Version_SuperKey);
