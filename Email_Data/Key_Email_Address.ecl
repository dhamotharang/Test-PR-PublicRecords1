Import Data_Services, doxie,ut, mdr;
temp_ds := project(File_Email_Base(did > 0 and current_rec and append_is_valid_domain_ext ),Layout_Email.Keys);
payload := project(Key_Payload,Layout_Email.Keys);

emailAddr				:= email_data.Prep_Build.Email_NonFCRA(temp_ds + payload); 
dedp_emailAddr	:= dedup(sort(distribute(emailAddr, hash(did)) ,clean_email,did, if(clean_name.lname <> '' and clean_address.prim_range <> '', 1, if(clean_name.lname <>  '',  2, 3)), -date_last_seen, local),clean_email,did,local);

//enter the first part of emailaddr or enter the full email addr get the rest of the record back				   
export Key_Email_Address := 
index(dedp_emailAddr
      ,{clean_email}
			,{dedp_emailAddr}
			,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_data::'+doxie.Version_SuperKey+'::email_addresses');

