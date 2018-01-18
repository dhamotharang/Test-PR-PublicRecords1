﻿import gong, doxie, data_services; 

hist_in := Gong.File_History_Full_Prepped_for_Keys(hhid<>0);
gong.mac_hist_full_slim_dep(hist_in, hist_out)

export Key_History_HHID := index(hist_out,
                                 {unsigned6 s_hhid := hhid,
						    boolean current_flag := if(current_record_flag='Y',true,false),
						    boolean business_flag := if(listing_type_bus='B',true,false)},
						    {hist_out},
                                  data_services.data_location.prefix() + 'thor_data400::key::gong_history_hhid_'+doxie.Version_SuperKey);