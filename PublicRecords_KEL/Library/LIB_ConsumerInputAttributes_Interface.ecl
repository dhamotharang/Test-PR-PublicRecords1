IMPORT $.^.^.PublicRecords_KEL;

// NOTE: If you change these parameter layouts you MUST redeploy the Library as the interface has changed.
EXPORT LIB_ConsumerInputAttributes_Interface(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput,
			PublicRecords_KEL.Interface_Options Options) := INTERFACE
																						
	EXPORT DATASET(RECORDOF(PublicRecords_KEL.Q_Input_Attributes_V1(DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0)) Results;
END;