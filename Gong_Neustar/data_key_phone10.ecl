// based on doxie_cbrs.key_phone_gong

IMPORT $, dx_Gong;

f := $.File_Gong_Full_Prepped_For_Keys_1(phone10 <> '' and (integer)phone10 <> 0);

EXPORT data_key_phone10 := PROJECT (f, dx_Gong.layouts.i_phone10);