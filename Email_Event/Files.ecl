EXPORT Files := MODULE

IMPORT Email_DataV2, Data_Services, ut, dx_Email;

//BV History file/lookup table	
	EXPORT BV_Email_in			:= DATASET('~thor_data400::in::email_dataV2::bv_email_event', Email_Event.Layouts.BV_Event_in, CSV(HEADING(0), SEPARATOR('|\t|'),TERMINATOR('\r\n'), QUOTE('"')));
	
	EXPORT Email_event_lkp	:= DATASET('~thor_data400::base::email_dataV2::email_event_lkp', dx_Email.Layouts.i_Event_lkp, THOR, OPT);
	
END;