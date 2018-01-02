import doxie, data_services;

File_AreacodeZipRecords := gong.File_Npa_Zip;
export Key_Zip := INDEX(File_AreacodeZipRecords,{zip},{File_AreacodeZipRecords},data_services.data_location.prefix() + 'thor_data400::key::gong::' + doxie.Version_SuperKey + '::zip');