/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_NonFCRA_BusinessSeleAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	
	LayoutBusinessSeleIDAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(0,0,0,0,0).res0);
	
	BusinessSeleAttributesResults := PROJECT(InputData, TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDAttributes},
		SELF.G_ProcBusUID := LEFT.G_ProcBusUID;
		NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(
				LEFT.B_LexIDUlt,
				LEFT.B_LexIDOrg,
				LEFT.B_LexIDLegal,
				(INTEGER)LEFT.B_InpClnArchDt[1..8],
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
		SELF := NonFCRABusinessSeleIDResults[1]));
	
	EXPORT Results := BusinessSeleAttributesResults;
END;