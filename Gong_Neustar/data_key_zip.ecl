IMPORT $, dx_Gong;

File_AreacodeZipRecords := $.File_Npa_Zip;

EXPORT data_key_zip := PROJECT (File_AreacodeZipRecords, dx_Gong.layouts.i_areacode);