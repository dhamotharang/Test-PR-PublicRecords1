import doxie, data_services;

export key_codes_v3 := index(file_codes_v3_in,
                             {file_name,field_name,field_name2,code,long_desc,__fpos},
                             data_services.data_location.prefix() + 'thor_data400::key::codes_v3_'+doxie.Version_SuperKey);