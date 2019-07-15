Import Data_Services, mdr, doxie, ut, Data_Services; 

hist_in := File_History_Full_Prepped_for_FCRA_Keys(did<>0);
mac_hist_full_slim_fcra(hist_in, hist_out);

//DF-21558 FCRA Consumer Data Field Deprecation - thor_data400::key::gong_history::fcra::qa::did														
ut.MAC_CLEAR_FIELDS(hist_out, hist_out_cleared, Gong_Neustar.Constants.fields_to_clear);

export key_fcra_history_did := index(hist_out_cleared,
                                {unsigned6 l_did := did, 
						  boolean current_flag := if(current_record_flag='Y',true,false),
						  boolean business_flag := if(listing_type_bus='B',true,false)},
						  {hist_out_cleared},
					  Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_history::fcra::'+doxie.Version_SuperKey + '::did');