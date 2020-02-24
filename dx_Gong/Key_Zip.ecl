//former: Gong_Neustar.Key_Zip

IMPORT data_services;
IMPORT $;

rec := $.layouts.i_areacode;

// keyed_fields := RECORD
//   rec.zip;
// END;


EXPORT key_zip (integer data_category = 0) := 
         INDEX ({rec.zip}, rec, $.names().i_zip);

// import Data_Services, doxie;

// File_AreacodeZipRecords := File_Npa_Zip;
// export Key_Zip := INDEX(File_AreacodeZipRecords,{zip},{File_AreacodeZipRecords},
// 					Data_Services.Data_location.Prefix('Gong')+'thor_data400::key::gong::' + doxie.Version_SuperKey + '::zip');