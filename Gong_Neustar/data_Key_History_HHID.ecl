IMPORT $, dx_Gong, Gong; 

hist_in := $.File_History_Full_Prepped_for_Keys(hhid<>0);
Gong.mac_hist_full_slim_dep(hist_in, hist_out)

EXPORT data_key_history_HHID := PROJECT(hist_out, TRANSFORM(dx_Gong.layouts.i_history_hhid,
                                                       SELF.s_hhid := LEFT.hhid,
                                                       SELF.current_flag := LEFT.current_record_flag='Y',
                                                       SELF.business_flag := LEFT.listing_type_bus='B',
                                                       SELF := LEFT));