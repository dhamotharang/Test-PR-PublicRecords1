import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::Event',Scrubs_Corp2_Mapping_MD_Event.layout_MD_file,flat)(trim(corp_key[1..2])= '18');
EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160706::Event_md',Scrubs_Corp2_Mapping_MD_Event.layout_MD_file,flat);