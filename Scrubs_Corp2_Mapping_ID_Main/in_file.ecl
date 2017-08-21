import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::main',Scrubs_Corp2_Mapping_ID_Main.layout_in_file,flat)(trim(corp_inc_state)= 'ID');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160106::main_ID',Scrubs_Corp2_Mapping_ID_Main.layout_in_file,flat);
