IMPORT dx_email, Email_dataV2, ut;

EXPORT Map_Email_Domain_Lookup := FUNCTION

	// super file
	superfile_name		:= '~thor_data400::in::email_dataV2::email_domain_lkp';
	subfile_name      := '~thor_data400::in::email_dataV2::email_domain_lkp_Initial'; 

 	email_in       := Email_dataV2.Files.Email_Base;
	
	//Project to temp layout to apply rules
	xRuleFields	:=	PROJECT(email_in, TRANSFORM(Email_DataV2.Layouts.temp_Validate, SELF := LEFT));
	
	//Set Invalid Email Rules
	setEmailFlags	:= Email_DataV2.Fn_InvalidEmail(xRuleFields);
		
	dx_email.layouts.i_domain_lkp xformToDomain(Email_DataV2.Layouts.temp_Validate L) := TRANSFORM
	  SELF.domain_name := ut.CleanSpacesAndUpper(L.append_domain);
	  SELF.create_date := '';
	  SELF.expire_date := '';
	  SELF.date_first_seen := L.date_first_seen; //date_added
	  SELF.date_last_seen  := L.date_last_seen;  //date_added
	  SELF.date_first_verified := thorlib.wuid()[2..9];
	  SELF.date_last_verified  := thorlib.wuid()[2..9];
		tmpDomain_status := MAP(L.append_is_valid_domain_ext = FALSE => 'INVALID',
		                        L.InValidDomain = TRUE => 'INVALID',
														'UNKNOWN');
	  SELF.domain_status := tmpDomain_status;
	  SELF.verifies_account := '';
		SELF.source  := '';
	  SELF.process_date  := thorlib.wuid()[2..9];
	  SELF.email_rec_key := 0;
	  SELF := L;
	END;
	
	pEmail_out	:= PROJECT(setEmailFlags, xformToDomain(LEFT));	
	
	// Remove duplicate records with same domain_name
	ds_map_sorted				:= SORT(pEmail_out,domain_name, -date_last_seen,local);
  ds_map_deduped 			:= DEDUP(ds_map_sorted,domain_name,ALL);  	
	
	// Adding to Superfile
  d_final := OUTPUT(ds_map_deduped,,'~thor_data400::in::email_dataV2::email_domain_lkp_Initial',__COMPRESSED__,OVERWRITE);

  Add_superfile := SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
															 FileServices.ClearSuperFile(superfile_name);
															 FileServices.AddSuperFile(superfile_name, subfile_name);
															 FileServices.FinishSuperFileTransaction());

  RETURN  SEQUENTIAL(d_final,Add_superfile);

END;