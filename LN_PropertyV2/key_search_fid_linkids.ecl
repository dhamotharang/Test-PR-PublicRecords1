Import doxie, ut, Data_Services;

KeyName		:= 'thor_data400::key::ln_propertyv2::';

key_name	:= Data_services.Data_location.Prefix('Property') + KeyName + doxie.Version_SuperKey + '::search.fid_linkids';

base_file	:= DISTRIBUTE(LN_PropertyV2.file_search_building_bip(ln_fares_id <> ''), HASH(ln_fares_id));

EXPORT key_search_fid_linkids := INDEX(base_file,{ln_fares_id, which_orig, source_code_2 := source_code[2], source_code_1 := source_code[1]},
																		 {base_file},
																		 key_name);

	
