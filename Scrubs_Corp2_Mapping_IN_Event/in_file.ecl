import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::Event',Scrubs_Corp2_Mapping_IN_Event.layout_in_file,flat)(trim(corp_key[1..2])= '24');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160322::Event_in',Scrubs_Corp2_Mapping_IN_Event.layout_in_file,flat);