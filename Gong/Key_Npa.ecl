import doxie, data_services;

File_AreacodeZipRecords := gong.File_Npa_Zip;
export Key_Npa := INDEX(File_AreacodeZipRecords,{areacode},{File_AreacodeZipRecords},data_services.data_location.prefix() + 'thor_data400::key::gong::' + doxie.Version_SuperKey + '::npa');