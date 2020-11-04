﻿﻿IMPORT email_data, dx_email, ut, STD;

EXPORT Map_BV_Domain_Lookup := FUNCTION
	
	fmtsin	:= ['%Y-%m-%d'];
	fmtout	:= '%Y%m%d';
	
	superfile_name		:= '~thor_data400::in::email_dataV2::BV_domain_lkp';
	subfile_name      := '~thor_data400::in::email_dataV2::BV_domain_lkp_Initial'; 

  // Input file Bright Verify History
	ds_in       := Email_Event.Files.BV_raw;

  // Filter Header record
  ValidInputFile	:= ds_in(trim(email_address) != '' and trim(email_status) != 'email_status');
	
	// Transform Bright Verify History records to domain lookup layout
	dx_email.Layouts.i_Domain_lkp Xform(Email_Event.Layouts.BV_raw L) := TRANSFORM
	  trimEmailAddress  := ut.CleanSpacesAndUpper(L.email_address);
  	tmpdomain_name   := email_data.Fn_Clean_Email_Domain(trimEmailAddress);
		SELF.domain_name := TRIM(ut.fn_KeepPrintableChars(tmpdomain_name),LEFT,RIGHT);	  
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
		SELF.source  := MDR.sourceTools.src_BrightVerify_email;
	  SELF.process_date  := thorlib.wuid()[2..9];
	  SELF.email_rec_key := 0;
	  SELF := L;
	END;
	
	pBV_out	:= PROJECT(ValidInputFile, Xform(LEFT));	

  // Adding to Superfile
	d_final := OUTPUT(pBV_out,,'~thor_data400::in::email_dataV2::BV_domain_lkp_Initial',__COMPRESSED__,OVERWRITE);

  Add_superfile := SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
                               FileServices.ClearSuperFile(superfile_name);						
															 FileServices.AddSuperFile(superfile_name, subfile_name);
															 FileServices.FinishSuperFileTransaction());
	
	RETURN  SEQUENTIAL(d_final,Add_superfile);
END;
