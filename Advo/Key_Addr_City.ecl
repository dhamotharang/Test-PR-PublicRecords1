import doxie;

File_ZipCityRecords := Advo.File_City_Zip;
export Key_Addr_City := INDEX(File_ZipCityRecords,{city},{File_ZipCityRecords},'~thor_data400::key::advo::' + doxie.Version_SuperKey + '::city');


