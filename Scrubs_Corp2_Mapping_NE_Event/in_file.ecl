import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::event',layout_in_file,flat)(trim(corp_inc_state)= 'NE');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160906::event_ne',layout_in_file,flat);
