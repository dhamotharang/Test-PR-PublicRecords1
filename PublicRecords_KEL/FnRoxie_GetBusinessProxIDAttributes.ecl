IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetBusinessProxIDAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithProxID := InputData(B_LexIDLoc > 0);
	RecordsWithoutProxID := InputData(B_LexIDLoc <= 0);
	
	LayoutBIIAndPII := RECORD
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII InputData;
		DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput;
	END;
	
	
 BusinessProxAttributesInput := DENORMALIZE(InputData, RepInput, 
		LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,  GROUP,
		TRANSFORM(LayoutBIIAndPII, 
			SELF.RepInput := ROWS(RIGHT),
			SELF.InputData := LEFT));
					
	// BusinessProxIDAttributesRaw := NOCOMBINE(JOIN(BusinessProxAttributesInput, FDCDataset,//think we need FDCDataset(repnumber != 6) - repnumber needed for batch
		// LEFT.InputData.G_ProcBusUID = RIGHT.G_ProcBusUID,
		// TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessProxIDAttributes},
			// SELF.G_ProcBusUID := LEFT.InputData.G_ProcBusUID;
			// NonFCRABusinessProxIDResults := PublicRecords_KEL.KEL_Queries_MAS_Business.Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic(
				// LEFT.InputData.B_LexIDUlt,
				// LEFT.InputData.B_LexIDOrg,
				// LEFT.InputData.B_LexIDLegal,
				// LEFT.InputData.B_LexIDLoc,
				// LEFT.RepInput,
				// DATASET(LEFT.InputData),
				// (INTEGER)LEFT.InputData.B_InpClnArchDt[1..8],
				// Options.KEL_Permissions_Mask, 
				// DATASET(RIGHT)).res0;
			// SELF := NonFCRABusinessProxIDResults[1]), 
		// LEFT OUTER, ATMOST(100), KEEP(1)));
		
		BusinessProxIDAttributesRaw := NOCOMBINE(PROJECT(BusinessProxAttributesInput, TRANSFORM({INTEGER G_ProcBusUID, PublicRecords_KEL.KEL_Queries_MAS_Business.L_Compile.Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic_Res0_Layout},
		SELF.G_ProcBusUID := LEFT.InputData.G_ProcBusUID;
		NonFCRABusinessProxIDResults := PublicRecords_KEL.KEL_Queries_MAS_Business.Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic(
				LEFT.InputData.B_LexIDUlt,
				LEFT.InputData.B_LexIDOrg,
				LEFT.InputData.B_LexIDLegal,
				LEFT.InputData.B_LexIDLoc,
				LEFT.RepInput,
				DATASET(LEFT.InputData),
				(INTEGER)LEFT.InputData.B_InpClnArchDt[1..8],
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
		SELF := NonFCRABusinessProxIDResults[1])));		
	
	BusinessProxIDAttributesClean := KEL.Clean(BusinessProxIDAttributesRaw, TRUE, TRUE, TRUE);
	
	BusinessAttributesWithProxID := JOIN(RecordsWithProxID, BusinessProxIDAttributesClean, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessProxID,
			ResultsFound := RIGHT.B_LexIDLoc > 0 AND RIGHT.B_LexIDLocSeenFlag = '1';
			SELF.B_LexIDLocSeenFlag := IF(ResultsFound, RIGHT.B_LexIDLocSeenFlag, '0');

			SELF.BP_BestName := IF(ResultsFound, RIGHT.BP_BestName, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BP_BestAddrLocID := IF(ResultsFound, RIGHT.BP_BestAddrLocID, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BP_BestAddrSt := IF(ResultsFound, RIGHT.BP_BestAddrSt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrCity := IF(ResultsFound, RIGHT.BP_BestAddrCity, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrCityPost := IF(ResultsFound, RIGHT.BP_BestAddrCityPost, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrState := IF(ResultsFound, RIGHT.BP_BestAddrState, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BP_BestAddrZip := IF(ResultsFound, RIGHT.BP_BestAddrZip, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BP_BestTIN := IF(ResultsFound, RIGHT.BP_BestTIN, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BP_BestPhone := IF(ResultsFound, RIGHT.BP_BestPhone, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF := LEFT,
			SELF := [];
		),LEFT OUTER, KEEP(1));


	// Assign special values to records with no ProxID
	BusinessAttributesWithoutProxID := PROJECT(RecordsWithoutProxID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessProxID,
			// Attributes from NonFCRABusinessProxIDAttributesV1 KEL query
			SELF.B_LexIDLocSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestName := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BP_BestAddrLocID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BP_BestAddrSt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrCity := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrCityPost := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrState := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestAddrZip := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestTIN := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BP_BestPhone := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT));
			
	BusinessProxIDAttributes := SORT(BusinessAttributesWithProxID + BusinessAttributesWithoutProxID, G_ProcBusUID);
	
	RETURN BusinessProxIDAttributes;
END;	

