IMPORT Email_DataV2, Email_Event, dx_Email, STD, ut;

EXPORT Fn_EmailEventStatus (DATASET(RECORDOF(Email_DataV2.Layouts.temp_Validate)) email_in) := FUNCTION

	event_lkp := Email_Event.Files.Email_event_lkp;
	
	ErrorCodes := ['EMAIL_ADDRESS_INVALID','EMAIL_DOMAIN_INVALID','EMAIL_ACCOUNT_INVALID'];
	
	//Validate email status
	Layouts.temp_Validate ValidStatus(email_in L, event_lkp R) := TRANSFORM
		SELF.InvalidEmail		:= IF(R.error_code <> '' and R.error_code in ErrorCodes,TRUE,FALSE);
		SELF.InvalidDomain	:= IF(R.error_code <> '' and R.error_code = 'EMAIL_DOMAIN_INVALID',TRUE,FALSE);
		SELF.InvalidAccount	:= IF(R.error_code <> '' and R.error_code = 'EMAIL_ACCOUNT_INVALID',TRUE,FALSE);
		SELF.disposable			:= IF(R.disposable = 'TRUE',TRUE,FALSE);
		SELF.role						:= IF(R.role_address = 'TRUE',TRUE,FALSE);
		SELF := L;
		SELF := [];
	END;
	
	jEmailValidInd	:= JOIN(SORT(DISTRIBUTE(email_in,HASH(clean_email)),clean_email, -process_date, LOCAL),
													SORT(DISTRIBUTE(event_lkp,HASH(email_address)),email_address, -date_added,LOCAL),
													TRIM(LEFT.clean_email) = TRIM(RIGHT.email_address),
													ValidStatus(LEFT,RIGHT),LEFT OUTER, LOCAL);
													
	RETURN	jEmailValidInd;
END;
		