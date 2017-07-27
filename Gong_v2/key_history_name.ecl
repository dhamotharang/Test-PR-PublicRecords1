import gong_v2, doxie;

hist_in := gong_v2.proc_roxie_keybuild_prep(trim(name_last)<>'');
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out)

Export key_history_name := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := datalib.preferredfirst(name_first),
							name_first},
             {hist_out},
		    Gong_v2.thor_cluster+'key::gongv2_history_name_'  + doxie.Version_SuperKey);