IMPORT PublicRecords_KEL, STD;

EXPORT FnRoxie_Prep_InputRepPII(DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) Input,
                PublicRecords_KEL.Interface_Options Options) := FUNCTION
		
	// Get the 5 Rep's information into a dataset with unique RepNumbers	
	echoReps := SORT(PublicRecords_KEL.ECL_Functions.Fn_InputEchoBusReps_Roxie( Input ), G_ProcBusUID);
	
	// cleanReps
	cleanReps := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( echoReps );	
	
	// Append Rep LexIDs
	withRepLexIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanReps, Options );

	//only run if phone is on input, nonFCRA only
	//this key is set up like this because we are not able to return PII from this key, we can only use it for phone verification
	CheckBureauPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_get_bureau_phones(withRepLexIDs);
	
	//only run if phone is on input, FCRA & nonFCRA 
	CheckTPMPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TPM_Phones.Consumer(CheckBureauPhone, Options);
	
	RETURN CheckTPMPhone ;							
END;									