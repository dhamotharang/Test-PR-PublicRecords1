IMPORT $, dx_Gong;

ds_file := $.File_Npa_Zip;

EXPORT data_key_npa := PROJECT (ds_file, dx_Gong.layouts.i_areacode);