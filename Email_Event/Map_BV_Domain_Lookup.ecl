IMPORT email_data, dx_email, ut, STD;

EXPORT Map_BV_Domain_Lookup := FUNCTION

	superfile_name		:= '~thor_data400::in::email_dataV2::BV_domain_lkp';
	subfile_name      := '~thor_data400::in::email_dataV2::BV_domain_lkp_Initial'; 

  // input file Bright Verify
	ds_in       := Email_Event.Files.BV_raw;
	/*
	// input file Bright Verify Delta
	ds_delta_in := Email_Event.Files.BV_Email_delta_in;
	*/
	fmtsin	:= ['%Y-%m-%d'];
	fmtout	:= '%Y%m%d';
	
	// BV layout to domain lookup 
	dx_email.Layouts.i_Domain_lkp Xform(Email_Event.Layouts.BV_raw L) := TRANSFORM
	  SELF.domain_name := email_data.Fn_Clean_Email_Domain(ut.CleanSpacesAndUpper(L.email_address));
	  SELF.create_date := '';
	  SELF.expire_date := '';
	  SELF.date_first_seen := '20190306'; //date_added
	  SELF.date_last_seen  := '20190306'; //date_added
	  SELF.date_first_verified := thorlib.wuid()[2..9];
	  SELF.date_last_verified  := thorlib.wuid()[2..9];
		email_status := ut.CleanSpacesAndUpper(L.email_status);
		sec_status   := ut.CleanSpacesAndUpper(L.secondary_status);
		tmpDomain_status := MAP(sec_status = 'EMAIL_DOMAIN_INVALID' => 'INVALID',
		                        email_status = 'VALID' => 'VALID',
														email_status = 'ACCEPT_ALL' => 'VALID',
                            email_status = 'INVALID' and sec_status = 'EMAIL_ACCOUNT_INVALID' => 'VALID',
														'UNKNOWN');
	  SELF.domain_status := tmpDomain_status;
	  SELF.verifies_account := IF(email_status = 'ACCEPT_ALL', 'FALSE', '');
	  SELF.process_date  := thorlib.wuid()[2..9];
	  SELF.email_rec_key := 0;
	  SELF := L;
	END;
	
	pBV_out	:= PROJECT(ds_in, Xform(LEFT));	
/*
	// BV Delta to domain lookup
	dx_email.Layouts.i_Domain_lkp Xform_Delta(Email_Event.Layouts.BV_Event_Delta_in L) := TRANSFORM
	  SELF.domain_name := email_data.Fn_Clean_Email_Domain(ut.CleanSpacesAndUpper(L.email_address));
	  SELF.create_date := '';
	  SELF.expire_date := '';
		StdDatestamp		 := STD.Date.ConvertDateFormatMultiple(L.date_added,fmtsin,fmtout);
	  SELF.date_first_seen := StdDatestamp; //date_added
	  SELF.date_last_seen  := StdDatestamp; //date_added
	  SELF.date_first_verified := thorlib.wuid()[2..9];
	  SELF.date_last_verified  := thorlib.wuid()[2..9];
		email_status := ut.CleanSpacesAndUpper(L.status);
		sec_status   := ut.CleanSpacesAndUpper(L.error_code);		
		tmpDomain_status := MAP(sec_status  = 'EMAIL_DOMAIN_INVALID' => 'INVALID',
		                        email_status = 'VALID' => 'VALID',
														email_status = 'ACCEPT_ALL' => 'VALID',
                            email_status = 'INVALID' and sec_status = 'EMAIL_ACCOUNT_INVALID' => 'VALID',
														'UNKNOWN');//Look at the BV 
	  SELF.domain_status := tmpDomain_status;
	  SELF.verifies_account := IF(email_status = 'ACCEPT_ALL','FALSE', 'TRUE');
	  SELF.process_date  := thorlib.wuid()[2..9];
	  SELF.email_rec_key := 0;
	  SELF := L;
	END;
	
	pBV_delta_out	:= PROJECT(ds_delta_in, Xform_Delta(LEFT));	
	*/
	// d_BV_out:= pBV_out + pBV_delta_out;
	
	// ds_sorted				:= SORT(pBV_out,domain_name, -date_last_seen);
  // ds_deduped 			:= DEDUP(ds_sorted,domain_name,ALL);  	
		
	
	d_final := OUTPUT(pBV_out,,'~thor_data400::in::email_dataV2::BV_domain_lkp_Initial',__COMPRESSED__,OVERWRITE);

  Add_superfile := SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
                               FileServices.ClearSuperFile(superfile_name);						
															 FileServices.AddSuperFile(superfile_name, subfile_name);
															 FileServices.FinishSuperFileTransaction());
	
	return  sequential(d_final,Add_superfile);
END;