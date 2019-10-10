import doxie;

export key_codes_v3 := index(file_codes_v3_in,{file_name,field_name,field_name2,code,long_desc,__fpos},'~thor_data400::key::codes_v3_'+doxie.Version_SuperKey, HINT(forceRemoteDisabled(true)));  // adding hint to help with performance on thor jobs