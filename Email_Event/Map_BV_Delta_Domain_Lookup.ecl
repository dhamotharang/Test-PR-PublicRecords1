﻿IMPORT email_data, dx_email, ut, STD;

EXPORT Map_BV_Delta_Domain_Lookup(STRING version) := FUNCTION

	superfile_name		:= '~thor_data400::in::email_dataV2::BV_delta_domain_lkp';
	subfile_name      := '~thor_data400::in::email_dataV2::BV_delta_domain_lkp::' + version; 

	// input file Bright Verify Delta
	ds_delta_in := Email_Event.Files.BV_delta_raw;
	
	fmtsin	:= ['%Y-%m-%d'];
	fmtout	:= '%Y%m%d';

	// BV Delta to domain lookup
	dx_email.Layouts.i_Domain_lkp Xform_Delta(Email_Event.Layouts.BV_Delta_raw L) := TRANSFORM
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
														// email_status = 'INVALID' and sec_status = 'DISPOSABLE' => 'VALID',
														// email_status = 'INVALID' and sec_status = 'ROLE_ADDRESS' => 'VALID',
														'UNKNOWN');//Look at the BV 
	  SELF.domain_status := tmpDomain_status;
	  SELF.verifies_account := IF(email_status = 'ACCEPT_ALL','FALSE', '');
	  SELF.process_date  := thorlib.wuid()[2..9];
	  SELF.email_rec_key := 0;
	  SELF := L;
	END;
	
	pBV_delta_out	:= PROJECT(ds_delta_in, Xform_Delta(LEFT));	
	

	d_final := OUTPUT(pBV_delta_out,,'~thor_data400::in::email_dataV2::BV_delta_domain_lkp::' + version,__COMPRESSED__,OVERWRITE);

  Add_superfile := SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
                               FileServices.ClearSuperFile(superfile_name);						
															 FileServices.AddSuperFile(superfile_name, subfile_name);
															 FileServices.FinishSuperFileTransaction());
	
	return  sequential(d_final,Add_superfile);
	// */
	// return pBV_delta_out;
END;