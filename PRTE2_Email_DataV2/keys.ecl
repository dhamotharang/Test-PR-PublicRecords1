import doxie,AutoKeyB2;
EXPORT keys := MODULE

EXPORT key_did := INDEX(FILES.did_file, {did, email_rec_key}, 
	 {files.did_file}, 
	Constants.key_prefix + doxie.Version_SuperKey + '::did');
	
	EXPORT key_did_FCRA := INDEX(FILES.did_FCRA, {did, email_rec_key}, 
	 {files.did_FCRA}, 
	Constants.key_FCRA_prefix + doxie.Version_SuperKey + '::did');
	
	export Key_Email_Address := index(files.Email_Address_File_short,{clean_email, email_rec_key},
	       {files.Email_Address_File_short}, 
				 Constants.key_prefix + doxie.Version_SuperKey + '::email_addresses');
			
	EXPORT Key_email_payload := INDEX(Files.Payload,{email_rec_key},
	      {Files.Payload},
		  	 Constants.key_prefix + doxie.Version_SuperKey + '::payload');
				 
	EXPORT Key_email_payload_FCRA := INDEX(Files.PayLoad_FCRA,{email_rec_key},
	      {Files.Payload_FCRA},
		  	 Constants.key_FCRA_prefix + doxie.Version_SuperKey + '::payload');
				 
				
		
	export autokeys(string filedate):= function
		
		AutoKeyB2.MAC_Build (Files.File_AutoKey,clean_name.fname,clean_name.mname,clean_name.lname,
												 best_ssn,
												 best_dob,
												 zero,
												 clean_address.prim_name,
												 clean_address.prim_range,
												 clean_address.st,
												 clean_address.p_city_name,
											   clean_address.zip,
												 clean_address.sec_range,
												 zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,
												 DID,
												 blank,
												 zero,
												 zero,
												 blank,blank,blank,blank,blank,blank,
												 zero,
												 Constants.ak_keyname,
												 Constants.ak_logical(filedate),
												 bld_auto_keys,false,
												 Constants.ak_skipSet,true,Constants.ak_typeStr,
												 true,,,zero); 

	return bld_auto_keys; 				
	end;
	end;
