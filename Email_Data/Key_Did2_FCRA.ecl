Import Data_Services, doxie,ut, mdr;

email_did		:= 	project(Email_data.File_Email_Base_FCRA(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' and email_src <> 'IB' ), Layout_Email.Keys);
did_w_fakes	:=  project(Key_Payload(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);
did_ready		:= 	(/*did_w_fakes +*/ email_did)(email_src NOT IN ['IM','IB','DG']);

//enter did and get the did and the rest of the record back				   
export Key_Did2_FCRA := 
index(did_ready
      ,{did}
      ,{did_ready}
			,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_data::fcra::'+doxie.Version_SuperKey+'::did2'
	 );