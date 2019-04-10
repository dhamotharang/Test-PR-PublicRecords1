EXPORT Files := MODULE

IMPORT DunnData_email, Data_Services, PRTE2, ut, STD;

	EXPORT raw_in	:= DATASET('~thor_data400::in::email::dunndata_email', DunnData_email.Layouts.Input, CSV(HEADING(0), SEPARATOR('|'),TERMINATOR('\r\n'), QUOTE('"')));
	
	//Clean invalid characters from input fields
	PRTE2.CleanFields(raw_in, dsCleanOut);
	
	EXPORT Raw_out	:= dsCleanOut;
	
	EXPORT Base	:= DATASET('~thor_data400::base::email::dunndata_email', DunnData_email.Layouts.Base, THOR,OPT);
	
END;
	