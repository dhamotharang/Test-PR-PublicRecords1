import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::stock',layout_in_file,flat)(trim(corp_inc_state)= 'KY');

EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160520::stock_ky',layout_in_file,flat);