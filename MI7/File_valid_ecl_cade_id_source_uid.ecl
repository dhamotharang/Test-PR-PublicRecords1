
// valid_ecl_cade_id :=  dataset('~thor_data400::persist::out::crim::cross::case_master_aoc_source_uid_validation', mi7.Layout_case_master_cp, flat)
												                         // (REGEXFIND('Error',SOURCE_UID_C,NOCASE)=false);		
																								 
valid_ecl_cade_id := MapValidCaseMasterSourceUID;																								 

ds_dist_valid_ecl_cade_id :=   DISTRIBUTE(valid_ecl_cade_id,HASH32(old_record_supplier_cd_c));											 

export File_valid_ecl_cade_id_source_uid := 
                                                    table(ds_dist_valid_ecl_cade_id, {ecl_cade_id, count1_ := count(group)}, ecl_cade_id,local)
							                                                           : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::File_valid_ecl_cade_id_source_uid');
																																		