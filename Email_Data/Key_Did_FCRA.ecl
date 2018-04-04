Import Data_Services, doxie,ut, mdr;

email_did		:= 	project(Email_data.File_Email_Base_FCRA(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);
did_w_fakes	:=  project(Key_Payload(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);
did_ready		:= 	(/*did_w_fakes +*/ email_did)(email_src <> 'IM');

//DF-21686 blank out following field in thor_200::key::email_data::fcra::qa::did
fields_to_clear := 'orig_ip';
ut.MAC_CLEAR_FIELDS(did_ready, did_ready_cleared, fields_to_clear);

//enter did and get the did and the rest of the record back				   
export Key_Did_FCRA := 
index(did_ready_cleared
      ,{did}
      ,{did_ready_cleared}
			,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_data::fcra::'+doxie.Version_SuperKey+'::did'
	 );