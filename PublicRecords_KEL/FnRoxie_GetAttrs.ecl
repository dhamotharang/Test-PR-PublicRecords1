IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) InputData,
								PublicRecords_KEL.Interface_Options Options) := FUNCTION
								
	ds_input_slim := 
    PROJECT(InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT ));														
								
	VerifiedInputPIIPre := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputPII(InputData, Options);

	VerifiedInputPII := verifiedInputPIIPre(PullIDFlag = False);
	pullidlexids := verifiedInputPIIPre(PullIDFlag = true);
	
	// 'mini' fdc fetching is to gather address hist data from rank key then pass this to the rest of the FDC after creating prev/curr/emerging address related attributes 
	OptionsMini := PublicRecords_KEL.Interface_Mini_Options(Options);

	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC( VerifiedInputPII, OptionsMini);		

	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(VerifiedInputPII, FDCDatasetMini, OptionsMini, options.BestPIIAppend); 

	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributes, Options , DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) ,FDCDatasetMini);

	InputChooser := if(options.BestPIIAppend, MiniAttributes, VerifiedInputPII);


  // Get Attributes - cleans the attributes after KEL is done 
  InputPIIAttributes := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(InputChooser, Options, FDCDataset);
	
	PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(MiniAttributes(IsInputRec = TRUE), FDCDataset, Options); 

	// PII Corroboration Summary attributes are NonFCRA only
	ALLSummaryAttributesNonFCRA := PublicRecords_KEL.FnRoxie_GetSummaryAttributes(InputChooser, Options, FDCDataset);
	ALLSummaryAttributes := IF(NOT Options.IsFCRA, ALLSummaryAttributesNonFCRA, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutALLSumAttributes));
	
	withPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));

	withPersonALLSummaryAttributes := JOIN(withPersonAttributes, ALLSummaryAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		

	
	FinalResultWithPullID := PublicRecords_KEL.FnRoxie_GetPullIDOverrides(pullidlexids, Options);

	FinalResultWithBuildDates  := PublicRecords_KEL.FnRoxie_GetBuildDates(withPersonALLSummaryAttributes, Options);

	MasterResults := SORT((FinalResultWithPullID+FinalResultWithBuildDates ), G_ProcUID);
						
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));

  RETURN MasterResults;
 END;

 