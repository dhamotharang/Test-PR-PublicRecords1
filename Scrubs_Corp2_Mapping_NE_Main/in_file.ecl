import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::main',Scrubs_Corp2_Mapping_NE_Main.layout_in_file,flat)(trim(corp_inc_state)= 'NE');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20190904::main_ne',Scrubs_Corp2_Mapping_NE_Main.layout_in_file,flat);
