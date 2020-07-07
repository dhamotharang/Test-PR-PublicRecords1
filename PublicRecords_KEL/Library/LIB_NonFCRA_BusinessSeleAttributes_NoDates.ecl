/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_NonFCRA_BusinessSeleAttributes_NoDates(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	
	LayoutBusinessSeleIDNoDatesAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(0,0,0,PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);

	BusinessSeleAttributesResults := IF(Options.OutputMasterResults,
		PROJECT(InputData, TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDNoDatesAttributes},
			SELF.G_ProcBusUID := LEFT.G_ProcBusUID;
			NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(
				LEFT.B_LexIDUlt,
				LEFT.B_LexIDOrg,
				LEFT.B_LexIDLegal,
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
			SELF := NonFCRABusinessSeleIDResults[1])),
		DATASET([],{INTEGER G_ProcBusUID, LayoutBusinessSeleIDNoDatesAttributes}));
	
	EXPORT Results := BusinessSeleAttributesResults;
END;