import gong_v2, doxie; 

hist_in := Gong_v2.proc_roxie_keybuild_prep(did<>0);
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out)

export key_FCRA_history_did := index(hist_out,
                                {unsigned6 l_did := did, 
						  boolean current_flag := if(current_record_flag='Y',true,false),
						  boolean business_flag := if(listing_type_bus='B',true,false)},
						  {hist_out},
                          Gong_v2.thor_cluster+'key::gongv2_history::fcra::qa::did');