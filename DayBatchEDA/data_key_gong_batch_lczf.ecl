IMPORT gong_Neustar, dx_Gong;

ds_file := gong_Neustar.File_Gong_Full_Prepped_For_Keys_1(trim(name_last) <> '');
EXPORT data_key_gong_batch_lczf := PROJECT(ds_file, dx_Gong.layouts.i_lczf);
