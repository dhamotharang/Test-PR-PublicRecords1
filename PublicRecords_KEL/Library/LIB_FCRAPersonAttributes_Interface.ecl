import PublicRecords_KEL;


EXPORT LIB_FCRAPersonAttributes_Interface(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) MiniAttributeInputRecords,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := INTERFACE
																						
	EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster) Results;
END;


