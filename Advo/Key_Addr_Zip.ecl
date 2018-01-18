import doxie, data_services;

File_ZipCityRecords := Advo.File_City_Zip;
export Key_Addr_Zip := INDEX(File_ZipCityRecords,{Zip},{File_ZipCityRecords},data_services.data_location.prefix() + 'thor_data400::key::advo::' + doxie.Version_SuperKey + '::zip');