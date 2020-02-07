﻿export Layout_CT_Full	:= record

    string8	    Append_PROCESS_DATE;
		string2			CredentialState	;
		string25		CredentialNumber	;
		string40		LastName	;
		string40		FirstName	;
		string35		MiddleInitial	;
		string5			Suffix	;
		string1			Gender	;
		string3			Height	;
		string3			EyeColor	;
		string8			Date_Birth	;
		string35		ResiAddrStreet	;
		string20		ResidencyCity	;
		string2			ResidencyState	;
		string9			ResidencyZip	; 
		string35		MailAddrStreet	;
		string20		MailingCity	;
		string2			MailingState	;
		string9			MailingZip	;		
		string3			CredentialType	;
		string1     Credential_Class;	
		string5			Endorsements	;
		string12		Restrictions	;
		string8			ExpDate	;
		string8			LastIssueRenewalDate	;
		string8			Date_NonCDL	;
		string8			OriginalDate_CDL	;
		string3			StatusNONCDL;
		string3			LicenseStatusCDL	;
		string8			OriginalDate_LP	;
		string8			OriginalDate_ID	;
		string2			CancelState	;
		string8			CancelDate	;
		string8			CDLMediCertIssueDate	;
		string8			CDLMediCertExpDate	;
		string5	    Clean_name_prefix;
		string20	  Clean_name_first;
		string20	  Clean_name_middle;
		string20	  Clean_name_last;
		string5	    Clean_name_suffix;
		string3	    Clean_name_score;
		
end;