Import Data_Services, gong, doxie, ut, Data_Services, mdr, vault, _control; 

hist_in := Gong.File_History_Full_Prepped_for_FCRA_Keys(did<>0);
gong.mac_hist_full_slim_fcra(hist_in, hist_out);



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_fcra_history_did := vault.Gong.Key_FCRA_History_did;
#ELSE
export key_fcra_history_did := index(hist_out,
                                {unsigned6 l_did := did, 
						  boolean current_flag := if(current_record_flag='Y',true,false),
						  boolean business_flag := if(listing_type_bus='B',true,false)},
						  {hist_out},
					  Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_history::fcra::'+doxie.Version_SuperKey + '::did');
#END;

