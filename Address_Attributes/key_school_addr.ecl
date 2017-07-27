import address, address_attributes, doxie, lib_stringlib, ut;

schools := address_attributes.file_schools;

clean_key_data := schools(zip 		!='' and 
													prim_range 	!='' and 
													prim_name 	!='');

export key_school_addr := index(clean_key_data,{
														zip, 
														prim_range, 
														prim_name
														},
														{clean_key_data},'~thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::schools::address');
