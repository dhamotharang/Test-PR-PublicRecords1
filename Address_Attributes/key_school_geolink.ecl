import address, address_attributes, doxie, lib_stringlib, ut;

schools := address_attributes.file_schools;

clean_key_data := schools(geolink !='');

export key_school_geolink := index(clean_key_data,{
														geolink},
														{clean_key_data},'~thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::schools::geolink');
