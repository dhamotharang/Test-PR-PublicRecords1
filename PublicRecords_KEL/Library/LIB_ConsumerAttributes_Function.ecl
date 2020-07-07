IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_ConsumerAttributes_Library := NOT _Control.LibraryUse.ForceOff_PublicRecords_KEL__LIB_ConsumerAttributes;

EXPORT LIB_ConsumerAttributes_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_ConsumerAttributes_Library)
	ConsumerAttributes_Results := LIBRARY('PublicRecords_KEL.Library.LIB_ConsumerAttributes', PublicRecords_KEL.Library.LIB_ConsumerAttributes_Interface(InputData, FDCDataset, Options)).Results;
#else
	ConsumerAttributes_Results := PublicRecords_KEL.FnRoxie_GetPersonAttributes(InputData, FDCDataset, Options);
#end

	RETURN(ConsumerAttributes_Results);
END;