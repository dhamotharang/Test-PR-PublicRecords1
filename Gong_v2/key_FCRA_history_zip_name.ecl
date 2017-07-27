import gong_v2, doxie;

hist_in := gong_v2.proc_roxie_keybuild_prep(z5<>''); 
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out)

Export key_FCRA_history_zip_name := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
						  integer4 zip5 := (integer4)z5,
              string20 p_name_first := datalib.preferredfirst(name_first),
						  name_last,
						  name_first
					       },
            {hist_out},
		    Gong_v2.thor_cluster+'key::gongv2_history::fcra::qa::zip_name');
