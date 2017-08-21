


dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapCreateAddInfoKeys :=  DISTRIBUTE(MapCreateAddInfoKeys,HASH32(ecl_cade_id));																		 

join_get_valid_add_info := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapCreateAddInfoKeys,
                                                                  left.ecl_cade_id = right.ecl_cade_id,local);

export MapValidAdditionalInformationSourceUID := join_get_valid_add_info
                                                                         : persist ('~thor_data400::persist::out::crim::cross_soff::MapValidAdditionalInformationSourceUID');


