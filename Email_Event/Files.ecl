EXPORT Files := MODULE

IMPORT Email_DataV2, Data_Services, ut, dx_Email;

//BV History file/lookup table	
	EXPORT BV_raw			 := DATASET('~thor_data400::raw::email_dataV2::bv', Email_Event.Layouts.BV_raw, CSV(HEADING(0), SEPARATOR(','),TERMINATOR('\n'), QUOTE('"')));
	
	EXPORT BV_Delta_raw:= DATASET('~thor_data400::raw::email_dataV2::bv_delta', Email_Event.Layouts.BV_Delta_raw, CSV(HEADING(0), SEPARATOR('|\t|'),TERMINATOR('\r\n'), QUOTE('"')));
	
	EXPORT Email_event_lkp	 := DATASET('~thor_data400::base::email_dataV2::email_event_lkp', dx_Email.Layouts.i_Event_lkp, THOR);
	
  EXPORT Email_Domain_in   := DATASET('~thor_data400::in::email_dataV2::email_domain_lkp',dx_email.Layouts.i_Domain_lkp,THOR);	
	
  EXPORT BV_Domain_in      := DATASET('~thor_data400::in::email_dataV2::BV_domain_lkp',dx_email.Layouts.i_Domain_lkp,THOR);	
	
  EXPORT BV_Delta_Domain_in:= DATASET('~thor_data400::in::email_dataV2::BV_delta_domain_lkp',dx_email.Layouts.i_Domain_lkp,THOR);	
		
	EXPORT Domain_lkp	       := DATASET('~thor_data400::base::email_dataV2::Domain_lkp', dx_email.Layouts.i_Domain_lkp, THOR);
	
END;