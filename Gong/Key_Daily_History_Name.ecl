import gong, doxie;

hist_in := gong.file_daily_full(trim(name_last)<>'');
gong.mac_hist_full_slim_dep_dly(hist_in, hist_out)

Export key_daily_history_name := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := datalib.preferredfirst(name_first),
							name_first},
             {hist_out},
		   '~thor_data400::key::gong_daily_name_'  + doxie.Version_SuperKey);