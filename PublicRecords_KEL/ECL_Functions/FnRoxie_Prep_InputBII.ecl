IMPORT PublicRecords_KEL, STD;

EXPORT FnRoxie_Prep_InputBII(DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) Input) := FUNCTION

	//Get the business information
	echoBusiness := PublicRecords_KEL.ECL_Functions.Fn_InputEchoBus_Roxie( Input );
	
	// cleanBusiness
	cleanBusiness := PublicRecords_KEL.ECL_Functions.Fn_CleanInputBus_Roxie( echoBusiness );	
				
	RETURN cleanBusiness;
END;							
