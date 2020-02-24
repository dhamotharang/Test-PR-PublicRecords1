IMPORT $, dx_Gong;

ds_file := $.file_gong_hhid(hhid<>0);

EXPORT data_key_hhid := PROJECT(ds_file, TRANSFORM(dx_Gong.layouts.i_hhid,
                                             SELF.s_hhid := LEFT.hhid,
                                             SELF := LEFT));