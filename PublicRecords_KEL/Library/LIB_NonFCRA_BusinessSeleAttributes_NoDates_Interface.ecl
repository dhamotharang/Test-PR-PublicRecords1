IMPORT $.^.^.PublicRecords_KEL;

// NOTE: If you change these parameter layouts you MUST redeploy the Library as the interface has changed.
EXPORT LIB_NonFCRA_BusinessSeleAttributes_NoDates_Interface(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := INTERFACE
	
	SHARED LayoutBusinessSeleIDNoDatesAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(0,0,0,0).res0);
																						
	EXPORT DATASET({INTEGER G_ProcBusUID, LayoutBusinessSeleIDNoDatesAttributes}) Results;
END;