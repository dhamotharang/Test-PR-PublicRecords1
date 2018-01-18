import address_attributes, doxie, lib_stringlib, data_services;

colleges := address_attributes.file_colleges;

cleaned := dedup(sort(colleges, college_name, inst_type, phone), college_name, inst_type, phone);

clean_key_data := cleaned(zip 				!='' and 
													prim_range 	!='' and 
													prim_name 	!='');

export key_colleges_addr := index(clean_key_data,{
														zip, 
														prim_range, 
														prim_name
														},
														{clean_key_data},data_services.data_location.prefix() + 'thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::colleges::address');
