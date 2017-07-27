import gong, doxie, nid;

hist_in := Gong.File_History_Full_Prepped_for_Keys(trim(name_last)<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

Export key_history_name := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := NID.PreferredFirstNew(name_first),
							name_first},
             {hist_out},
		   '~thor_data400::key::gong_history_name_'  + doxie.Version_SuperKey);