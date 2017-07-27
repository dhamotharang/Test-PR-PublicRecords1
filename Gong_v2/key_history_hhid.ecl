import gong_v2, doxie; 

hist_in := Gong_v2.proc_roxie_keybuild_prep(hhid<>0);
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out)

export Key_History_HHID := index(hist_out,
                                 {unsigned6 s_hhid := hhid,
						    boolean current_flag := if(current_record_flag='Y',true,false),
						    boolean business_flag := if(listing_type_bus='B',true,false)},
						    {hist_out},
                            Gong_v2.thor_cluster+'key::gongv2_history_hhid_'+doxie.Version_SuperKey);