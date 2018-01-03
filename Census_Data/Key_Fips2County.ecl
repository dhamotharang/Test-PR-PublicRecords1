import doxie, data_services;
base_file := file_Fips2County;
export Key_Fips2County := index(base_file,{state_code,county_fips},{county_name},data_services.data_location.prefix() + 'thor_data400::key::fips2county_'+doxie.Version_SuperKey);