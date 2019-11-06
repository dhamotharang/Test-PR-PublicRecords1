IMPORT $.^.^.PublicRecords_KEL;

// NOTE: If you change these parameter layouts you MUST redeploy the Library as the interface has changed.
EXPORT LIB_BusinessInputAttributes_Interface(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
            DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options) := INTERFACE
																						
	EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster) Results;
END;