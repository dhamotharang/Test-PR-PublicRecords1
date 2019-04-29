EXPORT Files := MODULE

IMPORT Email_Data, Data_Services, MDR, ut;

	//Base files
	EXPORT Email_Base := DATASET('~thor_data400::base::email_dataV2', Email_DataV2.Layouts.Base_BIP, THOR);
	EXPORT Email_Base_FCRA := DATASET('~thor_data400::base::email_dataV2_fcra', Email_DataV2.Layouts.Base_BIP, THOR);
	
	//Filters for Keys
	EXPORT DID_File	:= Email_Base(did > 0);
	
	EXPORT Email_Address_File	:= DEDUP(SORT(DISTRIBUTE(Email_Base, HASH(did))
																		 ,clean_email,did,email_rec_key, IF(clean_name.lname <> '' AND clean_address.prim_range <> '', 1, IF(clean_name.lname <>  '',  2, 3)), -date_last_seen, LOCAL)
																		 ,clean_email,did,email_rec_key,LOCAL);
																		 
	//Filters for FCRA Keys
	email_did		:= 	Email_Base_FCRA(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I');
	SHARED did_ready		:= 	email_did(email_src NOT IN Email_Data.FCRA_Src_Filter);

	//DF-21686 blank out selected field in thor_200::key::email_data::fcra::qa::did
	ut.MAC_CLEAR_FIELDS(did_ready, did_ready_cleared, Email_Data.Constants().fields_to_clear);
	EXPORT DID_FCRA	:= did_ready_cleared;
	
	filterActive := Email_Base_FCRA(current_rec and append_is_valid_domain_ext and activecode <> 'I');
	filterSource := filterActive(email_src NOT IN Email_Data.FCRA_Src_Filter);
	ut.MAC_CLEAR_FIELDS(filterSource, fields_cleared, Email_Data.Constants().fields_to_clear);
	
	EXPORT Payload_FCRA :=  fields_cleared;
	
END;