//former: Gong_Neustar.Key_History_Did, Gong_Neustar.Key_FCRA_History_Did
IMPORT $, dx_Gong, MDR; 

hist_in := $.File_History_Full_Prepped_for_Keys(did<>0);
mac_hist_full_slim_fcra(hist_in, hist_out);	

EXPORT data_key_history_did := PROJECT(hist_out, TRANSFORM(dx_Gong.layouts.i_history_did,
                                                           SELF.l_did := LEFT.did,
                                                           SELF.current_flag := LEFT.current_record_flag='Y',
                                                           SELF.business_flag := LEFT.listing_type_bus='B',
                                                           SELF := LEFT));