IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_BusinessSeleAttributes_Library := NOT _Control.LibraryUse.ForceOff_PublicRecords_KEL__LIB_BusinessSeleAttributes;

EXPORT LIB_BusinessSeleAttributes_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_BusinessSeleAttributes_Library)
	BusinessSeleAttributes_Results := LIBRARY('PublicRecords_KEL.Library.LIB_BusinessSeleAttributes', PublicRecords_KEL.Library.LIB_BusinessSeleAttributes_Interface(InputData, RepInput, FDCDataset, Options)).Results;
#else
	BusinessSeleAttributes_Results := PublicRecords_KEL.FnRoxie_GetBusinessSeleIDAttributes(InputData, RepInput, FDCDataset, Options);
#end

	RETURN(BusinessSeleAttributes_Results);
END;