Import doxie, ut, Data_Services, LN_PropertyV2;

EXPORT key_search_fid_linkids(boolean isFast = false) := FUNCTION

keyPrefix := if(isFast,'property_fast','ln_propertyv2');

KeyName		:= 'thor_data400::key::'+keyPrefix+'::';

key_name	:= Constants.keyServerPointer+ KeyName + doxie.Version_SuperKey + '::search.fid_linkids';

file_in0	:= LN_PropertyV2_Fast.file_search_building_Bip(LN_PropertyV2.File_Search_DID,false);
file_in1	:= LN_PropertyV2_Fast.file_search_building_Bip(LN_PropertyV2_Fast.Files.base.search_prp,true);
file_in		:= if(isFast,file_in1,file_in0);

base_file	:= DISTRIBUTE(file_in(ln_fares_id <> ''), HASH(ln_fares_id));

RETURN INDEX(base_file,{ln_fares_id, which_orig, source_code_2 := source_code[2], source_code_1 := source_code[1]},
																		 {base_file},
																		 key_name);

	
END;