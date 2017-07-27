import doxie;

hist_in := Gong.File_History_Full_Prepped_for_Keys(bdid != 0);
gong.mac_hist_full_slim_dep(hist_in, hist_out)

export Key_History_BDID := index(hist_out,{bdid},{hist_out},
                                 '~thor_data400::key::gong_hist_bdid_' + doxie.Version_SuperKey);
