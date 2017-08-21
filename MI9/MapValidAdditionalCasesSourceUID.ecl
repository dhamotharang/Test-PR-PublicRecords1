

dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapCreateAddCasesKeys :=  DISTRIBUTE(MapCreateAddCasesKeys,HASH32(ecl_cade_id));																		 

join_get_valid_add_cases := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapCreateAddCasesKeys,
                                                                  left.ecl_cade_id = right.ecl_cade_id,local);

export MapValidAdditionalCasesSourceUID := join_get_valid_add_cases
                                                                         : persist ('~thor_data400::persist::out::crim::cross_soff::MapValidAdditionalCasesSourceUID');


