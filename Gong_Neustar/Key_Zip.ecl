import Data_Services, doxie;

File_AreacodeZipRecords := File_Npa_Zip;
export Key_Zip := INDEX(File_AreacodeZipRecords,{zip},{File_AreacodeZipRecords},
					Data_Services.Data_location.Prefix('Gong')+'thor_data400::key::gong::' + doxie.Version_SuperKey + '::zip');