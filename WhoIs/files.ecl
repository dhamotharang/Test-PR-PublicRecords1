﻿EXPORT Files := MODULE

IMPORT WhoIs, Data_Services, PRTE2, ut, STD;

	EXPORT raw_in	:= DATASET('~thor_data400::in::email::WhoIs_Data', WhoIs.Layouts.raw, CSV(HEADING(0), SEPARATOR(','),TERMINATOR('\r\n'), QUOTE('"')));
	
	//Clean invalid characters from input fields
	// PRTE2.CleanFields(raw_in, dsCleanOut);
	
	EXPORT Raw_out	:= raw_in(trim(registrant_email,all) + 
               trim(administrativeContact_email,all) + 
							 trim(billingContact_email,all) + 
							 trim(technicalContact_email,all) + 
							 trim(zoneContact_email,all) <> '');;

	EXPORT Base	:= DATASET('~thor_data400::base::email::WhoIs_Data', WhoIs.Layouts.Base, THOR,OPT);
	
END;
	