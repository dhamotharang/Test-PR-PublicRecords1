IMPORT dx_Gong, gong_Neustar;

ds_file := gong_Neustar.File_Gong_Full_Prepped_For_Keys_1(TRIM(p_city_name) <> '');
EXPORT data_key_gong_batch_czsslf := PROJECT (ds_file, dx_Gong.layouts.i_czsslf);
