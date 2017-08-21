import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::event',layout_in_file,flat)(trim(corp_inc_state)= 'OH');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150828::event_oh',layout_in_file,flat);
