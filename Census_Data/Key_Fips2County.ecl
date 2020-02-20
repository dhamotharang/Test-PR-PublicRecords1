import doxie, data_services, vault, _control;
base_file := file_Fips2County;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Fips2County := vault.Census_Data.Key_Fips2County;
#ELSE
export Key_Fips2County := index(base_file,{state_code,county_fips},{county_name},data_services.data_location.prefix() + 'thor_data400::key::fips2county_'+doxie.Version_SuperKey);
#END;

