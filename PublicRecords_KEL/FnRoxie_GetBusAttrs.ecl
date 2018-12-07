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
	
	// Consumer shell is (optionally) run for rep1 inputs. 
	Rep1Input := withRepLexIDs(RepNumber = 1);

	// At this time, only need to collect data for rep1 and not other reps. 
	// If/when this changes all records from withRepLexIDs will need to be passed to Fn_MAS_FDC.
	// Just passing in Rep1 Inputs for now to avoid fetching too much data.
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( Rep1Input, Options, cleanBusiness );

	// Get Business attributes
	// When we get the cleaned attributes, then BusInputArchiveDateEcho will change to BusInputArchiveDateClean
	InputPIIBIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Bus_Attributes_V1(withRepLexIDs, cleanBusiness, 
		(STRING) cleanBusiness[1].BusInputArchiveDateEcho[1..8]).res0, TRUE, TRUE, TRUE);
		
		
	// Get consumer attributes
	Rep1InputPIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Attributes_V1(Rep1Input, Rep1Input[1].InputArchiveDateClean[1..8]).res0, TRUE, TRUE, TRUE);

	Rep1PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(Rep1Input, FDCDataset, Options);

	// Join Consumer Results back in with business results
	withRep1InputPII := JOIN(InputPIIBIIAttributes, Rep1InputPIIAttributes, LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF.InputUIDAppend := RIGHT.InputUIDAppend, // Set InputUIDAppend to Rep1 value so we can use this value for other rep 1 attributes.
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	withRep1PersonAttributes := JOIN(withRep1InputPII, Rep1PersonAttributes, LEFT.InputUIDAppend = RIGHT.InputUIDAppend,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	// If consumer shell attributes are turned off, we can bypass these calculations as a performance enhancement.	
	FinalResult := IF(Options.ExcludeConsumerShell, 
		PROJECT(InputPIIBIIAttributes, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := LEFT,
			SELF := [])),
		withRep1PersonAttributes);
	
	MasterResults := SORT(FinalResult, BusInputUIDAppend);
	
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));
	RETURN MasterResults;
END;
