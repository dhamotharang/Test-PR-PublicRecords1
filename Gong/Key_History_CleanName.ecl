
Import Data_Services, gong, doxie, nid, ut, phonesplus_v2;

hist_in_gong := Gong.File_Surnames(trim(name_last)<>'');
hist_in_pplus := project(Phonesplus_v2.File_Surnames(trim(name_last)<>''), recordof(Gong.File_Surnames));
hist_in := hist_in_gong + hist_in_pplus;

gong.mac_hist_full_slim_dep(hist_in, hist_out)

Export Key_History_CleanName := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := NID.PreferredFirstNew(name_first),
							name_first},
             {hist_out},
		   Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_history_cleanname_'  + doxie.Version_SuperKey);
