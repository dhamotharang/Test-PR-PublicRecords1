Import Data_Services, doxie,ut, mdr;

email_did		:= 	project(Email_data.File_Email_Base_FCRA(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);
// did_w_fakes	:=  project(Key_Payload(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);   // commented as not being used

did_input		:= 	email_data.Prep_Build.Email_FCRA(email_did);
did_ready		:= 	(/*did_w_fakes +*/ did_input)(email_src NOT IN ['IM','DG']);

//enter did and get the did and the rest of the record back				   
export Key_Did_FCRA := 
index(did_ready
      ,{did}
      ,{did_ready}
			,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_data::fcra::'+doxie.Version_SuperKey+'::did'
	 );