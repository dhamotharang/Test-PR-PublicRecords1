Import Data_Services, doxie,ut, mdr, vault, _control;

email_did		:= 	project(Email_data.File_Email_Base_FCRA(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);
did_w_fakes	:=  project(Key_Payload(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Layout_Email.Keys);
did_ready		:= 	(/*did_w_fakes +*/ email_did)(email_src <> 'IM');

Key_Did_FCRA_original := 
index(did_ready
      ,{did}
      ,{did_ready}
			,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_data::fcra::'+doxie.Version_SuperKey+'::did'
	 );

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Did_FCRA := project(vault.Email_Data.Key_Did_FCRA, transform(recordof(Key_Did_FCRA_original), self := left;) );
#ELSE
//enter did and get the did and the rest of the record back	
export Key_Did_FCRA := Key_Did_FCRA_original;
#END;			   


