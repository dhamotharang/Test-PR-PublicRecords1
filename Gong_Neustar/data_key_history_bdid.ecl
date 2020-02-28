IMPORT $, dx_Gong, Gong;

hist_in := $.File_History_Full_Prepped_for_Keys(bdid<>0);
Gong.mac_hist_full_slim_dep(hist_in, hist_out)

EXPORT data_key_history_BDID := PROJECT (hist_out, TRANSFORM(dx_Gong.layouts.i_history_bdid,
                                                             SELF := LEFT));