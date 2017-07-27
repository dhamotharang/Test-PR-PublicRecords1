Import gong, doxie, nid, ut;

hist_in := Gong.File_Surnames(trim(name_last)<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

Export Key_History_CleanName := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := NID.PreferredFirstNew(name_first),
							name_first},
             {hist_out},
		   '~thor_data400::key::gong_history_cleanname_'  + doxie.Version_SuperKey);
