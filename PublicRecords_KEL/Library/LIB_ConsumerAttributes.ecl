/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_ConsumerAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE

	ConsumerAttributesResults := PublicRecords_KEL.FnRoxie_GetPersonAttributes(InputData, FDCDataset, Options);
	
	EXPORT Results := ConsumerAttributesResults;
END;