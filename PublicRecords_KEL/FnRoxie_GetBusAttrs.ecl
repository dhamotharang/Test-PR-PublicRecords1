IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetBusAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) InputData,
                PublicRecords_KEL.Interface_Options Options) := FUNCTION
								
  ds_input := 
    PROJECT(
       InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
        SELF.BusInputUIDAppend := COUNTER,
        SELF := LEFT;
				SELF := []));
				
	//Get the 5 Rep information into a dataset with unique RepNumbers			
	echoReps := SORT(PublicRecords_KEL.ECL_Functions.Fn_InputEchoBusReps_Roxie( ds_input ), BusInputUIDAppend);
	
	//Get the business information
	echoBusiness := PublicRecords_KEL.ECL_Functions.Fn_InputEchoBus_Roxie( ds_input );
	
  // cleanReps
  cleanReps := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( echoReps );	

  // cleanBusiness
  cleanBusiness := PublicRecords_KEL.ECL_Functions.Fn_CleanInputBus_Roxie( echoBusiness );	
	
  // Append Rep LexIDs
  withRepLexIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanReps, Options );
	
  //Get Business attributes
	//When we get the cleaned attributes, then BusInputArchiveDateEcho will change to BusInputArchiveDateClean	
	InputPIIBII := KEL.Clean(PublicRecords_KEL.Q_Input_Bus_Attributes_V1(withRepLexIDs, cleanBusiness, 
		(STRING) cleanBusiness[1].BusInputArchiveDateEcho[1..8]).res0, TRUE, TRUE, TRUE);
		
	// Remove the fields like datefirstseen and datelastseen from final attribute output
	InputPIIBIIAttrs := SORT(PROJECT(InputPIIBII, TRANSFORM(PublicRecords_KEL.ECL_Functions.AttrBus_Layout, 
		SELF := LEFT,
		SELF := [])), BusInputUIDAppend);	
		
	RETURN InputPIIBIIAttrs;
END;