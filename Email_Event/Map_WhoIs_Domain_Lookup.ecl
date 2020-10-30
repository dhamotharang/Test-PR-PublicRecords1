﻿IMPORT email_data, dx_email, WhoIs, ut, STD, MDR;

EXPORT Map_WhoIs_Domain_Lookup(STRING version) := FUNCTION
	
	superfile_name		:= '~thor_data400::in::email_dataV2::WhoIs_domain_lkp';
	subfile_name      := '~thor_data400::in::email_dataV2::WhoIs_domain_lkp::' + version; 

	// Input file WhoIs Delta
	ds_delta_in := WhoIs.files.base(current_rec);
	

	// Transform WhoIs to domain lookup layout
	dx_email.Layouts.i_Domain_lkp Xform_Delta(WhoIs.Layouts.base L) := TRANSFORM
  	tmpdomain_name   := email_data.Fn_Clean_Email_Domain(L.domainname);
		SELF.domain_name := TRIM(ut.fn_KeepPrintableChars(tmpdomain_name),LEFT,RIGHT);
	  SELF.create_date := '';
	  SELF.expire_date := '';
	  SELF.date_first_seen := L.date_first_seen; //date_added
	  SELF.date_last_seen  := L.date_last_seen; //date_added
	  SELF.date_first_verified := thorlib.wuid()[2..9];
	  SELF.date_last_verified  := thorlib.wuid()[2..9];
		email_status := ut.CleanSpacesAndUpper(L.status);
	
    active_pattern	:= '(ADDPERIOD|AUTORENEWPERIOD|OK|PENDINGRENEW|PENDINGTRANSFER|PENDINGUPDATE|REDEMPTIONPERIOD|'+
                       'RENEWPERIOD|SERVERDELETEPROHIBITED|SERVERRENEWPROHIBITED|SERVERTRANSFERPROHIBITED|SERVERUPDATEPROHIBITED|'+
                       'TRANSFERPERIOD|CLIENTDELETEPROHIBITED|CLIENTRENEWPROHIBITED|CLIENTTRANSFERPROHIBITED|CLIENTUPDATEPROHIBITED)';
										
		tmpDomain_status := MAP(email_status = '' => 'UNKNOWN',
		                        REGEXFIND('PENDINGCREATE|PENDINGRESTORE', email_status) => 'UNKNOWN',
		                        REGEXFIND('INACTIVE|SERVERHOLD|CLIENTHOLD|EXPIRED', email_status) => 'INACTIVE',
		                        email_status = 'PENDINGDELETE' => 'INACTIVE',
														REGEXFIND('PENDINGDELETE', email_status) => 'UNKNOWN',
														REGEXFIND(active_pattern, email_status) => 'ACTIVE',
														''); 
	  SELF.domain_status := tmpDomain_status;
		SELF.verifies_account := '';
		SELF.source  := MDR.sourceTools.src_Whois_domains;
	  SELF.process_date  := thorlib.wuid()[2..9];
	  SELF.email_rec_key := 0;
	  SELF := L;
	END;
	
	pWhoIs_out	:= PROJECT(ds_delta_in, Xform_Delta(LEFT));	
	
  // Adding to Superfile
	d_final := OUTPUT(pWhoIs_out,,'~thor_data400::in::email_dataV2::WhoIs_domain_lkp::' + version,__COMPRESSED__,OVERWRITE);

  Add_superfile := SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
															 FileServices.ClearSuperFile(superfile_name);
															 FileServices.AddSuperFile(superfile_name, subfile_name);
															 FileServices.FinishSuperFileTransaction());

  RETURN  SEQUENTIAL(d_final,Add_superfile);

END;
