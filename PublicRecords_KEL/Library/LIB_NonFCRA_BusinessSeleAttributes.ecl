﻿/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_NonFCRA_BusinessSeleAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	
	LayoutBIIAndPII := RECORD
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII InputData;
		DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput;
	END;
	
	LayoutBusinessSeleIDAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(
																	0, // UltID
																	0, // OrgID
																	0, // SeleID
																	DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 
																	DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII), 
																	0, // ArchiveDate
																	PublicRecords_KEL.CFG_Compile.Permit__NONE).res0); //DPM
	
	BusinessSeleAttributesInput := DENORMALIZE(InputData, RepInput, 
		LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,  GROUP,
		TRANSFORM(LayoutBIIAndPII, 
			SELF.RepInput := ROWS(RIGHT),
			SELF.InputData := LEFT));
					
	BusinessSeleAttributesResults := PROJECT(BusinessSeleAttributesInput, TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDAttributes},
		SELF.G_ProcBusUID := LEFT.InputData.G_ProcBusUID;
		NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(
				LEFT.InputData.B_LexIDUlt,
				LEFT.InputData.B_LexIDOrg,
				LEFT.InputData.B_LexIDLegal,
				LEFT.RepInput,
				DATASET(LEFT.InputData),
				(INTEGER)LEFT.InputData.B_InpClnArchDt[1..8],
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
		SELF := NonFCRABusinessSeleIDResults[1]));
	
	EXPORT Results := BusinessSeleAttributesResults;
END;