import corp2_mapping;

//EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::sprayed::main',Corp2_Mapping.LayoutsCommon.Main,flat)(trim(corp_inc_state)= 'IN');

EXPORT In_File := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160119::main_in',Corp2_Mapping.LayoutsCommon.Main,flat);