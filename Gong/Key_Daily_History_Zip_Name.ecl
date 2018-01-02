import gong, doxie, data_services;

hist_in := gong.file_daily_full(z5<>'');
gong.mac_hist_full_slim_dep_dly(hist_in, hist_out)

Export key_daily_history_zip_name := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
						  integer4 zip5 := (integer4)z5,
              string20 p_name_first := datalib.preferredfirst(name_first),
						  name_last,
						  name_first
					       },
            {hist_out},
		   data_services.data_location.prefix() + 'thor_data400::key::gong_daily_zip_name_'  + doxie.Version_SuperKey);