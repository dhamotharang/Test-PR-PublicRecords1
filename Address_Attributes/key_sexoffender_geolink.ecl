import address_attributes, doxie, ut;

sex_offenders := Address_Attributes.file_sex_offender;

clean_key_data := dedup(sort(sex_offenders(geolink !='' and st != '' and county != '' and geo_blk != ''), did, did));

export key_sexoffender_geolink := index(clean_key_data,{
														geolink},
														{clean_key_data},'~thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::sex_offender_geolink');
