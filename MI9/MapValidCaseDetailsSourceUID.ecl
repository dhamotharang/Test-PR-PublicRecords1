
 
dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapPrimOffenderToCaseDetails :=  DISTRIBUTE(MapPrimOffenderToCaseDetails,HASH32(ecl_cade_id));																		 

join_get_valid_case_details := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapPrimOffenderToCaseDetails,
                                                                  left.ecl_cade_id = right.ecl_cade_id,local);

export MapValidCaseDetailsSourceUID := join_get_valid_case_details
                                                                      : persist ('~thor_data400::persist::out::crim::cross_soff::MapValidCaseDetailsSourceUID');