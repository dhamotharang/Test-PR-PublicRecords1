import doxie, gong_v2;

hist_in := Gong_v2.proc_roxie_keybuild_prep(bdid != 0);
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out)

export Key_FCRA_History_BDID := index(hist_out,{bdid},{hist_out},
                                 Gong_v2.thor_cluster+'key::gongv2_history::fcra::qa::bdid');
