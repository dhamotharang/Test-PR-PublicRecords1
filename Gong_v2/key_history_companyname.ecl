import gong, doxie;

hist_in := Gong_v2.proc_roxie_keybuild_prep((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

export key_history_companyname := index(hist_out,
																			  {listed_name}, 
																				{hist_out},
                                        Gong_v2.thor_cluster + 'key::gongv2_history_companyname_'+doxie.Version_SuperKey);
