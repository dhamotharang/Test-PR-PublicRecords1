Import Data_Services, gong, doxie, ut, Data_Services, mdr; 

hist_in := Gong.File_History_Full_Prepped_for_FCRA_Keys(did<>0);
gong.mac_hist_full_slim_fcra(hist_in, hist_out);

export key_fcra_history_did := index(hist_out,
                                {unsigned6 l_did := did, 
						  boolean current_flag := if(current_record_flag='Y',true,false),
						  boolean business_flag := if(listing_type_bus='B',true,false)},
						  {hist_out},
					  Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_history::fcra::'+doxie.Version_SuperKey + '::did');