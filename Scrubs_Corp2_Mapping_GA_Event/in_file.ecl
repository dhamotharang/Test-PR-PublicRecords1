import corp2_mapping;

EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::event',Scrubs_Corp2_Mapping_GA_event.layout_in_file,flat)(trim(corp_inc_state)= 'GA');
