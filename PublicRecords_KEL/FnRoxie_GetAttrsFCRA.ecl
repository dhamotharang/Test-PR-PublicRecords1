EXPORT FnRoxie_GetAttrsFCRA(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) InputData,
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
	MiniAttributesWOptOuts := IF(options.isprescreen, PublicRecords_KEL.ECL_Functions.FnRoxie_get_optouts(MiniAttributes, options),MiniAttributes);//FCRA prescreen optouts 


	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributesWOptOuts, Options , JoinFlags, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) ,FDCDatasetMini);

	MiniAttributeInputRecords := MiniAttributesWOptOuts(IsInputRec = TRUE);


	PersonAttributes := PublicRecords_KEL.Library.LIB_FCRAPersonAttributes_Function(MiniAttributeInputRecords, FDCDataset, Options);
	//input consumer
	//FCRA consumer
	//inferred	
	
	
	FinalResultWithPullID := PublicRecords_KEL.FnRoxie_GetPullIDOverrides(pullidlexids, Options);

	FinalResultWithBuildDates  := PublicRecords_KEL.FnRoxie_GetBuildDates(PersonAttributes, Options);

	MasterResults := SORT((FinalResultWithPullID+FinalResultWithBuildDates ), G_ProcUID);
						
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));

  RETURN MasterResults;
 END;
