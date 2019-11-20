IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_NonFCRA_BusinessSeleAttributes_NoDates_Library := NOT _Control.LibraryUse.ForceOff_PublicRecords_KEL__LIB_NonFCRA_BusinessSeleAttributes_NoDates;

EXPORT LIB_NonFCRA_BusinessSeleAttributes_NoDates_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_NonFCRA_BusinessSeleAttributes_NoDates_Library)
	BusinessSeleAttributes_NoDates_Results := LIBRARY('PublicRecords_KEL.Library.LIB_NonFCRA_BusinessSeleAttributes_NoDates', PublicRecords_KEL.Library.LIB_NonFCRA_BusinessSeleAttributes_NoDates_Interface(InputData, FDCDataset, Options)).Results;
#else
	LayoutBusinessSeleIDNoDatesAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(0,0,0,0).res0);

	BusinessSeleAttributes_NoDates_Results := IF(Options.OutputMasterResults,
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
#end

	RETURN(BusinessSeleAttributes_NoDates_Results);
END;