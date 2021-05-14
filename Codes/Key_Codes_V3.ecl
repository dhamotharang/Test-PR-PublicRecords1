import doxie, data_services, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_codes_v3 := vault.Codes.Key_Codes_V3;
#ELSE
export key_codes_v3 := index(file_codes_v3_in,
                             {file_name,field_name,field_name2,code,long_desc,__fpos},
                             data_services.data_location.prefix() + 'thor_data400::key::codes_v3_'+doxie.Version_SuperKey,  HINT(forceRemoteDisabled(true)));
#END;


