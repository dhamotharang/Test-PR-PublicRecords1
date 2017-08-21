

dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapOffenderToCriminalSupplimental :=  DISTRIBUTE(MapOffenderToCriminalSupplimental,HASH32(ecl_cade_id));																		 

join_get_valid_crim_supp := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapOffenderToCriminalSupplimental,
                                                                  left.ecl_cade_id = right.ecl_cade_id,local);

export MapValidCriminalSupplimentalSourceUID := join_get_valid_crim_supp
                                                                              : persist ('~thor_data400::persist::out::crim::cross_soff::MapValidCriminalSupplimentalSourceUID');


