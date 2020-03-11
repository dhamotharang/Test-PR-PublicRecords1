IMPORT $, dx_Gong, gong;

hist_in := $.File_History_Full_Prepped_for_Keys(name_last<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

EXPORT data_key_history_wild_name_zip := 
           PROJECT(hist_out, TRANSFORM(dx_Gong.layouts.i_history_wild_name_zip,
                                       SELF.zip5 := (integer4)LEFT.z5,
                                       SELF := LEFT));