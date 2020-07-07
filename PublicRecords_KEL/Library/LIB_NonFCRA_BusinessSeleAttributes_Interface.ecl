IMPORT $.^.^.PublicRecords_KEL;

// NOTE: If you change these parameter layouts you MUST redeploy the Library as the interface has changed.
EXPORT LIB_NonFCRA_BusinessSeleAttributes_Interface(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := INTERFACE
	
	SHARED LayoutBusinessSeleIDAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(
																	0, // UltID
																	0, // OrgID
																	0, // SeleID
																	DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 
																	DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII), 
																	0, // ArchiveDate
																	PublicRecords_KEL.CFG_Compile.Permit__NONE).res0); //DPM	
																						
	EXPORT DATASET({INTEGER G_ProcBusUID, LayoutBusinessSeleIDAttributes}) Results;
END;