IMPORT Data_Services, gong, doxie, ut;

hist_in := File_History_Full_Prepped_for_Keys(name_last<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

EXPORT key_history_wild_name_zip := 
       index(hist_out,
             {name_last,
						  st,
						  name_first,
						  integer4 zip5 := (integer4)z5},
            {hist_out},
		        Data_Services.Data_location.Prefix('Gong_History')+'thor_data400::key::gong_history_wild_name_zip_'  + doxie.Version_SuperKey);
