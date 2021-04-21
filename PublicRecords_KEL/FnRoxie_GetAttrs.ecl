﻿IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) InputData,
								PublicRecords_KEL.Interface_Options Options,
								PublicRecords_KEL.Join_Interface_Options JoinFlags
								) := FUNCTION
								
	ds_input_slim := 
    PROJECT(InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT ));														
								
	VerifiedInputPIIPre := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputPII(InputData, Options);

	VerifiedInputPII := verifiedInputPIIPre(PullIDFlag = False);
	pullidlexids := verifiedInputPIIPre(PullIDFlag = true);
	

//the mini FDC is used to gather information for attributes that will be needed for 'extra' searching in the FDC, like prev/curr address and best pii info.
//if you need to add searching into a dataset that exists in the mini fdc you must also add that dataset into the mini fdc - i.e. header phone wild is used to search header so must be in the mini fdc
//any dataset you add to the mini FDC must be re normalized into the FDC or we will lose that data 
//overrides are also in the mini FDC
//options.BestPIIAppend must call mini FDC
	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC_Mini( VerifiedInputPII, Options, JoinFlags);	
	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(VerifiedInputPII, FDCDatasetMini, Options); 

	//doing this call here instead of in FDC so we do not lose our optout flag, also products may want to skip fdc calls later if we get a hit here
	//inside mini attributes we have dummy flags for adl_* append, these are in ECL for now, if they are needed in KEL later, they will have to be set in mini attributes.  they are also mappeded from left in person attributes
	MiniAttributesWOptOuts := IF(options.isFCRA and options.isprescreen, PublicRecords_KEL.ECL_Functions.FnRoxie_get_optouts(MiniAttributes, options),MiniAttributes);//FCRA prescreen optouts 


	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributesWOptOuts, Options , JoinFlags, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) ,FDCDatasetMini);

	MiniAttributeInputRecords := MiniAttributesWOptOuts(IsInputRec = TRUE);

  // Get Attributes - cleans the attributes after KEL is done 
  InputPIIAttributes := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(MiniAttributeInputRecords, Options, FDCDataset);
	
	PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(MiniAttributeInputRecords, FDCDataset, Options); 

	// PII Corroboration Summary attributes are NonFCRA only
	ALLSummaryAttributesNonFCRA := PublicRecords_KEL.FnRoxie_GetSummaryAttributes(MiniAttributeInputRecords, Options, FDCDataset);
	ALLSummaryAttributes := IF(NOT Options.IsFCRA, ALLSummaryAttributesNonFCRA, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutALLSumAttributes));
	
	InferredPerformanceAttributes := IF(Options.IsFCRA, PublicRecords_KEL.FnRoxie_GetInferredPerformanceAttributes(MiniAttributeInputRecords, Options, FDCDataset), DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInferredAttributes));
	
	// HighRiskAddressAttributesNonFCRA := PublicRecords_KEL.FnRoxie_GetHighRiskAddress(MiniAttributeInputRecords, Options, FDCDataset);
	// HighRiskAddressAttributes  := IF(NOT Options.IsFCRA, HighRiskAddressAttributesNonFCRA, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutHighRiskAddressAttributes));
	
	withPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));

	withPersonALLSummaryAttributes := JOIN(withPersonAttributes, ALLSummaryAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF.G_ProcUID := LEFT.G_procUID, //If right is empty this ensures that G_ProcUID is not blank
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));
		
	withInferredPerformanceAttributes := JOIN(withPersonALLSummaryAttributes, InferredPerformanceAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF.G_ProcUID := LEFT.G_procUID,//If right is empty this ensures that G_ProcUID is not blank
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	// withHighRiskAddressAttributes := JOIN(withInferredPerformanceAttributes, HighRiskAddressAttributes, 
	// LEFT.G_ProcUID = RIGHT.G_ProcUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));	
		

	
	FinalResultWithPullID := PublicRecords_KEL.FnRoxie_GetPullIDOverrides(pullidlexids, Options);

	FinalResultWithBuildDates  := PublicRecords_KEL.FnRoxie_GetBuildDates(IF(Options.IsFCRA,withInferredPerformanceAttributes,withPersonALLSummaryAttributes), Options);

	MasterResults := SORT((FinalResultWithPullID+FinalResultWithBuildDates ), G_ProcUID);
						
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));

  RETURN MasterResults;
 END;