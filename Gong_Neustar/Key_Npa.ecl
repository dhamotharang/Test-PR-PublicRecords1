import Data_Services, doxie;

File_AreacodeZipRecords := File_Npa_Zip;
export Key_Npa := INDEX(File_AreacodeZipRecords,{areacode},{File_AreacodeZipRecords},
				Data_Services.Data_location.Prefix('Gong')+'thor_data400::key::gong::' + doxie.Version_SuperKey + '::npa');