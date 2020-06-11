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
				
	// cleanBusiness
	Prep_CleanBusiness := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputBII(ds_input);
	
	// cleanReps and get lexids
	Prep_RepInput := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputRepPII(ds_input, Options);
	Rep1Input := Prep_RepInput(RepNumber = 1);

	// Append BIP IDs
	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( Prep_CleanBusiness, Rep1Input, Options );

	CheckTPMPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TPM_Phones.Business(withBIPIDs, Options);

	CheckTDSPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TDS_Phones(CheckTPMPhone);

	// 'mini' fdc fetching is to gather address hist data from rank key on person then pass this to the rest of the FDC after creating prev/curr/emerging address related attributes 
	OptionsMini := PublicRecords_KEL.Interface_Mini_Options(Options);

	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC( Rep1Input, OptionsMini);		

	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(Rep1Input, FDCDatasetMini, OptionsMini); 

	// At this time, only need to collect data for rep1 and not other reps. 
	// If/when this changes all records from withRepLexIDs will need to be passed to Fn_MAS_FDC.
	// Just passing in Rep1 Inputs for now to avoid fetching too much data.
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributes, Options, CheckTDSPhone );

	// Get Business attributes
	// When we get the cleaned attributes, then B_InpArchDt will change to B_InpClnArchDt
	InputPIIBIIAttributes := PublicRecords_KEL.Library.LIB_BusinessInputAttributes_Function(CheckTDSPhone, Prep_RepInput, Options);

	BusinessSeleIDAttributes := PublicRecords_KEL.Library.LIB_BusinessSeleAttributes_Function(CheckTDSPhone, Prep_RepInput, FDCDataset, Options);
	
	withBusinessSeleIDAttributes := JOIN(InputPIIBIIAttributes, BusinessSeleIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	

	BusinessProxIDAttributes := PublicRecords_KEL.FnRoxie_GetBusinessProxIDAttributes(CheckTDSPhone, Prep_RepInput, FDCDataset, Options);

	withBusinessProxIDAttributes := JOIN(withBusinessSeleIDAttributes, BusinessProxIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	

	// Get consumer attributes
	Rep1InputPIIAttributes := KEL.Clean(PublicRecords_KEL.Library.LIB_ConsumerInputAttributes_Function(Rep1Input, Options), TRUE, TRUE, TRUE);

	Rep1PersonAttributes := PublicRecords_KEL.Library.LIB_ConsumerAttributes_Function(MiniAttributes, FDCDataset, Options);

	// Join Consumer Results back in with business results
	withRep1InputPII := JOIN(withBusinessProxIDAttributes, Rep1InputPIIAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
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
	FinalResult := IF(Options.ExcludeConsumerAttributes, PROJECT(withBusinessProxIDAttributes, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
											SELF := LEFT,
											SELF := [])),
										withRep1PersonAttributes);	
	
	MasterResults := SORT(FinalResult, G_ProcBusUID);
	
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));

	RETURN MasterResults;
END;