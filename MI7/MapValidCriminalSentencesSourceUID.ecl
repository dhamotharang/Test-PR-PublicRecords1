


dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapCreateCrimSentencesKeys :=  DISTRIBUTE(MapCreateCrimSentencesKeys,HASH32(ecl_cade_id));																		 

join_get_valid_crim_sentences := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapCreateCrimSentencesKeys,
                                                                  left.ecl_cade_id = right.ecl_cade_id,local);

export MapValidCriminalSentencesSourceUID := join_get_valid_crim_sentences
                                                                         : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapValidCriminalSentencesSourceUID');

