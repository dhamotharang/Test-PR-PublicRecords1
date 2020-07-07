IMPORT PublicRecords_KEL, STD;

EXPORT FnRoxie_Prep_InputPII(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) Input,
                PublicRecords_KEL.Interface_Options Options) := FUNCTION
	
  ds_input_slim := 
    PROJECT(
      Input,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT ));
				
	InputEcho := PublicRecords_KEL.ECL_Functions.Fn_InputEcho_Roxie( ds_input_slim );	

	cleanInput := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( InputEcho );	
	
  // Append LexID
  withLexID := IF(Options.isFCRA, 
		PublicRecords_KEL.ECL_Functions.Neutral_Lexid_Soapcall(cleanInput, Options), //FCRA uses soapcall
		PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanInput, Options ));
		
	//only run if phone is on input, nonFCRA only
	//this key is set up like this because we are not able to return PII from this key, we can only use it for phone verification
	CheckBureauPhone := IF(~Options.isFCRA, PublicRecords_KEL.ECL_Functions.FnRoxie_get_bureau_phones(withLexID), withLexID);
	
	//only run if phone is on input, FCRA & nonFCRA 
	CheckTPMPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TPM_Phones.Consumer(CheckBureauPhone, Options);

 RETURN CheckTPMPhone;


 END;				