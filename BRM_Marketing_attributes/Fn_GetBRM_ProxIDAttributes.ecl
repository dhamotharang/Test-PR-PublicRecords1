IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL,BRM_Marketing_attributes;

EXPORT Fn_GetBRM_ProxIDAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	RecordsWithProxID := InputData((INTEGER7)B_LexIDLoc > 0);
	RecordsWithoutProxID := InputData((INTEGER7)B_LexIDLoc <= 0);
	
	LayoutBIIAndPII := RECORD
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII InputData;
		DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput;
	END;
	
	LayoutBusinessProxIDAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic(
																														0, 				
																														0, 				
																														0, 				
																														0, 				
																														DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 
																														DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII), 		
																														0, 
																														PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);

	
 BusinessProxAttributesInput := DENORMALIZE(InputData, RepInput, 
		LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,  GROUP,
		TRANSFORM(LayoutBIIAndPII, 
			SELF.RepInput := ROWS(RIGHT),
			SELF.InputData := LEFT));
					
	BusinessProxIDAttributesRaw := PROJECT(BusinessProxAttributesInput, TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessProxIDAttributes},
		SELF.G_ProcBusUID := LEFT.InputData.G_ProcBusUID;
		NonFCRABusinessProxIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic(
				(INTEGER7)LEFT.InputData.B_LexIDUlt,
				(INTEGER7)LEFT.InputData.B_LexIDOrg,
				(INTEGER7)LEFT.InputData.B_LexIDLegal,
				(INTEGER7)LEFT.InputData.B_LexIDLoc,
				LEFT.RepInput,
				DATASET(LEFT.InputData),
				(INTEGER)LEFT.InputData.B_InpClnArchDt[1..8],
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
		SELF := NonFCRABusinessProxIDResults[1]));	
	
	BusinessProxIDAttributesClean := KEL.Clean(BusinessProxIDAttributesRaw, TRUE, TRUE, TRUE);
	
	BusinessAttributesWithProxID := JOIN(RecordsWithProxID, BusinessProxIDAttributesClean, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.LayoutBusinessProxID,
			ResultsFound := (INTEGER7)RIGHT.B_LexIDLoc > 0 AND RIGHT.B_LexIDLocSeenFlag = '1';
			SELF.BP_BestName := IF(ResultsFound, RIGHT.BP_BestName, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BP_BestAddrSt := IF(ResultsFound, RIGHT.BP_BestAddrSt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrCity := IF(ResultsFound, RIGHT.BP_BestAddrCity, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrState := IF(ResultsFound, RIGHT.BP_BestAddrState, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrZip := IF(ResultsFound, RIGHT.BP_BestAddrZip, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BP_BestTIN := IF(ResultsFound, RIGHT.BP_BestTIN, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BP_BestPhone := IF(ResultsFound, RIGHT.BP_BestPhone, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF := LEFT,
			SELF := [];
		),LEFT OUTER, KEEP(1));

	// Assign special values to records with no ProxID
	BusinessAttributesWithoutProxID := PROJECT(RecordsWithoutProxID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.LayoutBusinessProxID,
			// Attributes from NonFCRABusinessProxIDAttributesV1 KEL query
			SELF.BP_BestName := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrSt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrCity := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrState := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrZip := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestTIN := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestPhone := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT));
			
	BusinessProxIDAttributes := SORT(BusinessAttributesWithProxID + BusinessAttributesWithoutProxID, G_ProcBusUID);
	
	RETURN BusinessProxIDAttributes;
END;	

