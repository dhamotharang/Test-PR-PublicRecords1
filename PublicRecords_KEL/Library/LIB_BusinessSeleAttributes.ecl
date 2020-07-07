/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_BusinessSeleAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE

	BusinessSeleAttributesResults := PublicRecords_KEL.FnRoxie_GetBusinessSeleIDAttributes(InputData, RepInput, FDCDataset, Options);
	
	EXPORT Results := BusinessSeleAttributesResults;
END;