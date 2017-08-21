import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::main',Scrubs_Corp2_Mapping_SD_Main.layout_in_file,flat)(trim(corp_inc_state)= 'SD');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160322::main_sd',Scrubs_Corp2_Mapping_SD_Main.layout_in_file,flat);
