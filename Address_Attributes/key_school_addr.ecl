import address_attributes, doxie, lib_stringlib,  data_services;

schools := address_attributes.file_schools;

clean_key_data := schools(zip 		!='' and 
													prim_range 	!='' and 
													prim_name 	!='');

export key_school_addr := index(clean_key_data,{
														zip, 
														prim_range, 
														prim_name
														},
														{clean_key_data},data_services.data_location.prefix() + 'thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::schools::address');
