import gong, doxie, ut;

hist_in := Gong.File_History_Full_Prepped_for_Keys(name_last<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

Export key_history_wild_name_zip := 
       index(hist_out,
             {name_last,
						  st,
						  name_first,
						  integer4 zip5 := (integer4)z5},
            {hist_out},
		        '~thor_data400::key::gong_history_wild_name_zip_'  + doxie.Version_SuperKey);
