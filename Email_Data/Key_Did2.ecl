// Removed iBehavior data
Import Data_Services, doxie,ut, mdr;

email_did					  := project(Email_data.File_Email_Base(did > 0 and current_rec and append_is_valid_domain_ext), Layout_Email.Keys);
did_w_fakes					:= project(Key_Payload, Layout_Email.Keys);

did_input		:= did_w_fakes + email_did;
did_ready   := did_input(TRIM(email_src) <> 'IB');
//enter did and get the did and the rest of the record back				   
export Key_Did2 := 
index(did_ready
      ,{did}
      ,{did_ready}
			,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_data::'+doxie.Version_SuperKey+'::did2');

