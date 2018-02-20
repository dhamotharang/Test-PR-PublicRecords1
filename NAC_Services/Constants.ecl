EXPORT Constants := MODULE
	EXPORT MAX_RECORDS_PER_ACCTNO := 30;
	// In Nac1, Both Match & Investigative searches are conducted on programs = S or D only.
	// However, for Match searches, they may get output results with
	//any program in MATCH_ProgramsAllowedReturn below based on the INTRA/INTER state logic.
	// For investigative searches (not supported in batch), they will only get results = S or D.
	// See NAC_V2_Services.Constants for detailed program description
	
	//RR-12051 NAC SNAP only filtering
	EXPORT SET of STRING1 MATCH_ProgramsAllowedReturn := ['S','D'];


	// Debugging - this will display the output statements
	EXPORT Debug := FALSE;
END;