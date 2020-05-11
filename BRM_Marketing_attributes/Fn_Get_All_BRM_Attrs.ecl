IMPORT PublicRecords_KEL,BRM_Marketing_Attributes;


EXPORT Fn_Get_All_BRM_Attrs(DATASET(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_Input) InputData,
                             PublicRecords_KEL.Interface_Options Options) := 
	FUNCTION
	
  ds_input := 
    PROJECT(
       InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
			SELF.AccountNumber := LEFT.AcctNo;
			SELF := LEFT;
			SELF := []));
				
	// cleanBusiness
	Prep_CleanBusiness := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputBII(ds_input);
	
	// cleanReps and get lexids
	Prep_RepInput := Dataset([],PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII); //We are not passing rep because we do not need any rep information

	// Append BIP IDs
	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( Prep_CleanBusiness, Prep_RepInput, Options );

	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( Prep_RepInput, Options, withBIPIDs );
	
	InputPIIBIIAttributes := BRM_Marketing_Attributes.Fn_GetBRM_InputBIIAttributes(withBIPIDs, Prep_RepInput, Options);

	BusinessSeleIDAttributes :=BRM_Marketing_Attributes.Fn_GetBRM_SeleIDAttributes(withBIPIDs, Prep_RepInput, FDCDataset, Options);

	withBusinessSeleIDAttributes := JOIN(InputPIIBIIAttributes, BusinessSeleIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Layout_master,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, ATMOST(100));	
		
	BusinessProxIDAttributes := BRM_Marketing_Attributes.Fn_GetBRM_ProxIDAttributes(withBIPIDs, Prep_RepInput, FDCDataset, Options);

	withBusinessProxIDAttributes := JOIN(withBusinessSeleIDAttributes, BusinessProxIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Layout_master,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, ATMOST(100));	

	// output(ds_input,named('ds_input'));
	// output(Prep_CleanBusiness,named('Prep_CleanBusiness'));
	// output(withBIPIDs,named('withBIPIDs'));
	// output(InputPIIBIIAttributes,named('InputPIIBIIAttributes'));
	// output(BusinessSeleIDAttributes,named('BusinessSeleIDAttributes'));
	// output(BusinessProxIDAttributes,named('BusinessProxIDAttributes'));
	// output(withBusinessSeleIDAttributes,named('withBusinessSeleIDAttributes'));
	// output(results,named('results'));
	 return withBusinessProxIDAttributes;

END;
