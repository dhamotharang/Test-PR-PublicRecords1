IMPORT PublicRecords_KEL,BRM_Marketing_Attributes,STD;


EXPORT Fn_Get_All_BRM_Attrs(DATASET(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_Input) InputData,
                             PublicRecords_KEL.Interface_Options Options,
                             PublicRecords_KEL.Join_Interface_Options JoinFlags) := FUNCTION
	
  ds_input := 
			PROJECT(InputData,
			TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
			SELF.AccountNumber := LEFT.AcctNo;
			
			//logic for history date
	   SELF.archivedate:=	(STRING)MAP(LEFT.HistoryDate=999999 OR LEFT.HistoryDateYYYYMM=999999 => (INTEGER)STD.Date.Today(),											      
                                   LEFT.HistoryDate > 0                                     => LEFT.HistoryDate,	                       
                                   LEFT.HistoryDateYYYYMM > 0                               => LEFT.HistoryDateYYYYMM,
                                                                                               (INTEGER)STD.Date.Today());
			SELF := LEFT;
			SELF := []));
				
	// cleanBusiness
	Prep_CleanBusiness := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputBII(ds_input);
	
	//This function echos the input account number to p_inpacct which is used by the KEL query to get b_inpacct.
	Prep_RepInput := BRM_Marketing_attributes.Fn_BRM_Prep_InputRepPII(ds_input);

	// Append BIP IDs
	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( Prep_CleanBusiness, Prep_RepInput, Options );

	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC_Mini( Prep_RepInput, Options, JoinFlags, withBIPIDs );
	
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( Prep_RepInput, Options, JoinFlags, withBIPIDs , FDCDatasetMini);
	
	// PIIBII Attributes
	InputPIIBIIAttributes := BRM_Marketing_Attributes.Fn_GetBRM_InputBIIAttributes(withBIPIDs, Prep_RepInput, Options);

 // Business Sele Attributes
	BusinessSeleIDAttributes :=BRM_Marketing_Attributes.Fn_GetBRM_SeleIDAttributes(withBIPIDs, Prep_RepInput, FDCDataset, Options);

	withBusinessSeleIDAttributes := JOIN(InputPIIBIIAttributes, BusinessSeleIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Layout_master,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
	
	//BusinessProx Attributes
	BusinessProxIDAttributes := BRM_Marketing_Attributes.Fn_GetBRM_ProxIDAttributes(withBIPIDs, Prep_RepInput, FDCDataset, Options);

	withBusinessProxIDAttributes := JOIN(withBusinessSeleIDAttributes, BusinessProxIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Layout_master,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	

	// output(InputData,named('InputData'));
	// output(ds_input,named('ds_input'));
	// output(Prep_CleanBusiness,named('Prep_CleanBusiness'));
	// output(withBIPIDs,named('withBIPIDs'));
	// output(InputPIIBIIAttributes,named('InputPIIBIIAttributes'));
	// output(BusinessSeleIDAttributes,named('BusinessSeleIDAttributes'));
	// output(withBusinessSeleIDAttributes,named('withBusinessSeleIDAttributes'));
	// output(BusinessProxIDAttributes,named('BusinessProxIDAttributes'));
	// output(withBusinessProxIDAttributes,named('withBusinessProxIDAttributes'));

	 return withBusinessProxIDAttributes;
END;
