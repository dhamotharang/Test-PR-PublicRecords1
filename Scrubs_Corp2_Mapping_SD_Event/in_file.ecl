import corp2_mapping;

EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::Event',Scrubs_Corp2_Mapping_SD_Event.layout_in_file,flat)(trim(corp_key[1..2])= '46');
//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150406::Event_sd',Scrubs_Corp2_Mapping_SD_Event.layout_in_file,flat);