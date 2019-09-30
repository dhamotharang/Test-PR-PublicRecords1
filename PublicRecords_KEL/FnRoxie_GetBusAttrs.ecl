IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetBusAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) InputData,
                PublicRecords_KEL.Interface_Options Options) := FUNCTION
								
  ds_input := 
    PROJECT(
       InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
        SELF.G_ProcBusUID := COUNTER,
        SELF := LEFT;
				SELF := []));
				
	//Get the 5 Rep information into a dataset with unique RepNumbers			
	echoReps := SORT(PublicRecords_KEL.ECL_Functions.Fn_InputEchoBusReps_Roxie( ds_input ), G_ProcBusUID);
	
	//Get the business information
	echoBusiness := PublicRecords_KEL.ECL_Functions.Fn_InputEchoBus_Roxie( ds_input );
	
  // cleanReps
  cleanReps := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( echoReps );	

  // cleanBusiness
  cleanBusiness := PublicRecords_KEL.ECL_Functions.Fn_CleanInputBus_Roxie( echoBusiness );	
	
  // Append Rep LexIDs
  withRepLexIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanReps, Options );
	Rep1Input := withRepLexIDs(RepNumber = 1);

	// Append BIP IDs
	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( cleanBusiness, Rep1Input, Options );
	
	// At this time, only need to collect data for rep1 and not other reps. 
	// If/when this changes all records from withRepLexIDs will need to be passed to Fn_MAS_FDC.
	// Just passing in Rep1 Inputs for now to avoid fetching too much data.
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( Rep1Input, Options, withBIPIDs );

	// Get Business attributes
	// When we get the cleaned attributes, then B_InpArchDt will change to B_InpClnArchDt
	InputPIIBIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Bus_Attributes_V1(withRepLexIDs, withBIPIDs, 
		(STRING) withBIPIDs[1].B_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).res0, TRUE, TRUE, TRUE);
		
	BusinessSeleIDAttributes := PublicRecords_KEL.FnRoxie_GetBusinessSeleIDAttributes(withBIPIDs, FDCDataset, Options);
	
	withBusinessSeleIDAttributes := JOIN(InputPIIBIIAttributes, BusinessSeleIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	

	// Get consumer attributes
	Rep1InputPIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Attributes_V1(Rep1Input, Rep1Input[1].P_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).res0, TRUE, TRUE, TRUE);

	Rep1PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(Rep1Input, FDCDataset, Options);

	// Join Consumer Results back in with business results
	withRep1InputPII := JOIN(withBusinessSeleIDAttributes, Rep1InputPIIAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF.G_ProcUID := RIGHT.G_ProcUID, // Set G_ProcUID to Rep1 value so we can use this value for other rep 1 attributes.
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	withRep1PersonAttributes := JOIN(withRep1InputPII, Rep1PersonAttributes, LEFT.G_ProcUID  = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	// If consumer shell attributes are turned off, we can bypass these calculations as a performance enhancement.	
	FinalResult := IF(Options.ExcludeConsumerAttributes, withBusinessSeleIDAttributes, withRep1PersonAttributes);
	
	MasterResults := SORT(FinalResult, G_ProcBusUID);
	
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));

	RETURN MasterResults;
END;
