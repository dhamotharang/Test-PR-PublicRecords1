//######################################################
//## This Key is no longer in FCRA_GongKeys 2/26/2020 ##
//######################################################
Import Data_Services, gong, doxie, NID, _Control;

hist_in := File_History_Full_Prepped_for_FCRA_Keys(z5<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

Export key_FCRA_history_zip_name := 
       index(hist_out(metaphonelib.DMetaPhone1(name_last) <> ''),
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
						  integer4 zip5 := (integer4)z5,
              string20 p_name_first := NID.PreferredFirstNew(name_first),
						  name_last,
						  name_first
					       },
            {hist_out},
			Data_Services.Data_location.Prefix('Gong_History')+'thor_data400::key::gong_history::fcra::qa::zip_name'
			);
