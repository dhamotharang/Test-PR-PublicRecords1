IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetBusAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) InputData,
                PublicRecords_KEL.Interface_Options Options,
                PublicRecords_KEL.Join_Interface_Options JoinFlags) := FUNCTION
								
  ds_input := 
    PROJECT(
       InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
        SELF.G_ProcBusUID := COUNTER,
				SELF.Rep6FirstName := LEFT.CompanyName;
					SELF.Rep6NameSuffix := left.AlternateCompanyName;
					SELF.Rep6StreetAddressLine1 := left.StreetAddressLine1;
					SELF.Rep6StreetAddressLine2 := left.StreetAddressLine2;
					SELF.Rep6City := left.City1;
					SELF.Rep6State := left.State1;
					SELF.Rep6Zip := left.Zip1;
					SELF.Rep6SSN := left.BusinessTIN;
					SELF.Rep6HomePhone := left.BusinessPhone;
					SELF.Rep6EmailAddress := left.BusinessEmailAddress;
        SELF := LEFT;
				SELF := []));
				
	// cleanBusiness
	Prep_CleanBusiness_temp := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputBII(ds_input);
	
// cleanReps and get lexids
	Prep_RepInputPre := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputRepPII(ds_input, Options);


	Prep_RepInput := Prep_RepInputPre(PullIDFlag = False);
	pullidlexids := Prep_RepInputPre(PullIDFlag = true);
	
	FinalResultWithPullID := PublicRecords_KEL.FnRoxie_GetPullIDOverrides(pullidlexids, Options);

	SlimPullID := dedup(sort(FinalResultWithPullID,G_ProcBusUID),G_ProcBusUID);
	
	Prep_CleanBusiness := join(Prep_CleanBusiness_temp,SlimPullID, 
															left.G_ProcBusUID = right.G_ProcBusUID, 
																transform(recordof(left),
																self := left),
																left only);	
	
	Rep1Input := Prep_RepInput(RepNumber = 1);
	Rep6Input := Prep_RepInput(RepNumber = 6);
	// RepsInput := Prep_RepInput(RepNumber = 1 OR RepNumber = 6);
	
	// if you pass only rep6 into the FDC it will break the results from contacts for busienss.  contacts are tied to g_procuid =1 so if that is not there, 
	//then the data has nothing to denorm too and gets dropped on the floor
	RepsInput := project(Prep_RepInput(RepNumber = 1 OR RepNumber = 6), transform(recordof(Prep_RepInput), 
																				self.p_lexid := if(left.RepNumber = 1, 0, left.p_lexid), 
																				self.p_lexidscore := if(left.RepNumber = 1, 0, left.p_lexidscore),
																				self := left));//for now we do not want to search rep1 in business

	// Append BIP IDs
	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( Prep_CleanBusiness, Rep1Input, Options );

	CheckTPMPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TPM_Phones.Business(withBIPIDs, Options);

	CheckTDSPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TDS_Phones(CheckTPMPhone);

//the mini FDC is used to gather information for attributes that will be needed for 'extra' searching in the FDC, like prev/curr address and best pii info.
//if you need to add searching into a dataset that exists in the mini fdc you must also add that dataset into the mini fdc - i.e. header phone wild is used to search header so must be in the mini fdc
//any dataset you add to the mini FDC must be re normalized into the FDC or we will lose that data 
//all 6th rep data is calculated in the mini FDC 
//overrides are also in the mini FDC
	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC_Mini( RepsInput, Options, JoinFlags, CheckTDSPhone);		

	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(RepsInput, FDCDatasetMini, Options); 

	// At this time, only need to collect data for rep1 and not other reps. 
	// If/when this changes all records from withRepLexIDs will need to be passed to Fn_MAS_FDC.
	// Just passing in Rep1 Inputs for now to avoid fetching too much data.
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributes, Options, JoinFlags, CheckTDSPhone, FDCDatasetMini );

	BusinessAttributes := PublicRecords_KEL.Library.LIB_BusinessAttributes_Function(CheckTDSPhone, Prep_RepInput, FDCDataset, Options);
	//input bii
	//sele
	//prox


	// Get consumer attributes
	// After KS-6866, these are not populating correctly in the case the 6th rep LexID matches the rep 1 lexid, likely due to the mini attributes.
	// Since these attributes are being turned off in KS-7114, this is deemed acceptable, but if they are turned back on, we need to revisit this logic.
	//Rep1InputPIIAttributes := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(MiniAttributes(RepNumber = 1), Options, FDCDataset);
	
	// Rep1PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(MiniAttributes(RepNumber = 1), FDCDataset, Options);

	// Rep1ALLSummaryAttributes := PublicRecords_KEL.FnRoxie_GetSummaryAttributes(MiniAttributes(RepNumber = 1), Options, FDCDataset);
	
	//Rep1HighRiskAddressAttributes := PublicRecords_KEL.FnRoxie_GetHighRiskAddress(MiniAttributes(RepNumber = 1), Options, FDCDataset);
	
	// Rep6PersonAttributes :=  PublicRecords_KEL.FnRoxie_Get6thRepAttributes(MiniAttributes(RepNumber = 6), FDCDatasetMini, Options);//all of 6th rep fdc data is in mini fdc

	// Join Consumer Results back in with business results
	// withRep1InputPII := JOIN(BusinessAttributes, Rep1InputPIIAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF.G_ProcUID := RIGHT.G_ProcUID, // Set G_ProcUID to Rep1 value so we can use this value for other rep 1 attributes.
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));	
		
	// withRep1PersonAttributes := JOIN(withRep1InputPII, Rep1PersonAttributes, LEFT.G_ProcUID  = RIGHT.G_ProcUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));		

	// withRep1ALLSummaryAttributes := JOIN(withRep1PersonAttributes, Rep1ALLSummaryAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));
		
	// withRep1HighRiskAddressAttributes := JOIN(withRep1ALLSummaryAttributes, Rep1HighRiskAddressAttributes, 
	// LEFT.G_ProcUID = RIGHT.G_ProcUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));
		
		
		// withRep6PersonAttributes := JOIN(withRep1PersonAttributes, Rep6PersonAttributes, 
		// LEFT.G_ProcUID  = RIGHT.G_ProcUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));	
		
	
	// If consumer shell attributes are turned off, we can bypass these calculations as a performance enhancement.	
	// FinalResult := IF(Options.ExcludeConsumerAttributes, PROJECT(BusinessAttributes, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
										// SELF := LEFT,
										// SELF := [])),	
										// withRep6PersonAttributes);	
										// withRep1ALLSummaryAttributes);	
										
	FinalResult := PROJECT(BusinessAttributes, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
											SELF := LEFT,
											SELF := []));
	
	WithBuildDates := PublicRecords_KEL.FnRoxie_GetBuildDates(FinalResult, Options);


	MasterResults := SORT((SlimPullID+WithBuildDates), G_ProcBusUID);
	
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));



	RETURN MasterResults;
END;