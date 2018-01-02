import address_attributes, doxie, lib_stringlib, data_services;

colleges := address_attributes.file_colleges;

cleaned := dedup(sort(colleges, college_name, Inst_type, phone), college_name, Inst_type, phone);

clean_key_data := cleaned(geolink !='');

export key_colleges_geolink := index(clean_key_data,{
														geolink},
														{clean_key_data},data_services.data_location.prefix() + 'thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::colleges::geolink');