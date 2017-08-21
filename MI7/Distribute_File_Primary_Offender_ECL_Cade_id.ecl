

export Distribute_File_Primary_Offender_ECL_Cade_id := 
                 DISTRIBUTE(File_Primary_Offender_ECL_Cade_id,HASH32(offender_key))
								         : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::Distribute_File_Primary_Offender_ECL_Cade_id');