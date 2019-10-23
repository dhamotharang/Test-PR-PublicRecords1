import doxie_build, Data_Services;

d:=dataset([], doxie_build.Layout_D2C_Lookup);

EXPORT key_D2C_lookup(unsigned1 data_env = data_services.data_env.iNonFCRA) := 
         index(d,{did},{d},data_services.data_location.Prefix()+'thor_data400::key::D2C_lookups_' + doxie.Version_SuperKey);