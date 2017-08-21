import corp2_mapping;

//EXPORT File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::main',Scrubs_Corp2_Mapping_SD_Main.layout_in_file,flat)(trim(corp_inc_state)= 'RI');
EXPORT in_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160224::main_RI',Scrubs_Corp2_Mapping_RI_Main.layout_in_file,flat);
