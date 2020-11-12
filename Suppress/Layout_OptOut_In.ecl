EXPORT Layout_OptOut_In :=  RECORD
	STRING30	ENTRY_TYPE;					//OPTOUT – standard Opt Out Request,DELETE – standard Delete Request,Other types may be defined in the future
	UNSIGNED8	LEXID;							//LEXID of consumer opting out
	STRING1		PROF_DATA;					//Include Healthcare professional data (Y/N)
	STRING2		STATE_ACT;					//state abbreviation of the act under which this consumer has opted out “CA” for CCPA
	STRING8		DATE_OF_REQUEST;	//date of request (YYYYMMDD)
	STRING100	VERIFIED_EMAIL;	//DF-28437 - MBS extract adds email address field
END;
