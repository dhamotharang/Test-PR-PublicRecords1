IMPORT $.^.^.PublicRecords_KEL;

// NOTE: If you change these parameter layouts you MUST redeploy the Library as the interface has changed.
EXPORT LIB_ConsumerAttributes_Interface(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := INTERFACE
																						
	EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson) Results;
END;