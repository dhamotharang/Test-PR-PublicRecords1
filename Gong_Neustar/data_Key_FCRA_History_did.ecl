IMPORT $, dx_Gong, Data_Services, ut, MDR; 

hist_in := $.File_History_Full_Prepped_for_FCRA_Keys(did<>0);
$.mac_hist_full_slim_fcra(hist_in, hist_out);

//DF-21558 FCRA Consumer Data Field Deprecation - thor_data400::key::gong_history::fcra::qa::did														
ut.MAC_CLEAR_FIELDS(hist_out, hist_out_cleared, $.Constants.fields_to_clear);

EXPORT data_key_fcra_history_did := PROJECT(hist_out_cleared, TRANSFORM(dx_Gong.layouts.i_history_did,
                                                                        SELF.l_did := LEFT.did,
                                                                        SELF.current_flag := LEFT.current_record_flag='Y',
                                                                        SELF.business_flag := LEFT.listing_type_bus='B',
                                                                        SELF := LEFT));