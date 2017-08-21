Import Data_Services, doxie;

File_ZipCityRecords := Advo.File_City_Zip;
export Key_Addr_Zip := INDEX(File_ZipCityRecords,{Zip},{File_ZipCityRecords},Data_Services.Data_location.Prefix('advo')+'thor_data400::key::advo::' + doxie.Version_SuperKey + '::zip');