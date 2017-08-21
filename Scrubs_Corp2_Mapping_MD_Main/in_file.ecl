import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::main',Scrubs_Corp2_Mapping_md_Main.layout_in_file,flat)(trim(corp_inc_state)= 'MD');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160208::main_md',Scrubs_Corp2_Mapping_md_Main.layout_in_file,flat);
