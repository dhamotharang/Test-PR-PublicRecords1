IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_BusinessAttributes_Library := NOT _Control.LibraryUse.ForceOff_PublicRecords_KEL__LIB_BusinessAttributes;

EXPORT LIB_BusinessAttributes_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_BusinessAttributes_Library)
	BusinessAttributes_Results := LIBRARY('PublicRecords_KEL.Library.LIB_BusinessAttributes', PublicRecords_KEL.Library.LIB_BusinessAttributes_Interface(InputData, RepInput, FDCDataset, Options)).Results;
#else

//input bii
//sele
//prox

	InputPIIBIIAttributes := PublicRecords_KEL.FnRoxie_GetInputBIIAttributes(InputData, RepInput, Options);

	BusinessSeleIDAttributes := PublicRecords_KEL.FnRoxie_GetBusinessSeleIDAttributes(InputData, RepInput, FDCDataset, Options);

	withBusinessSeleIDAttributes := JOIN(InputPIIBIIAttributes, BusinessSeleIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	

	BusinessProxIDAttributes := PublicRecords_KEL.FnRoxie_GetBusinessProxIDAttributes(InputData, RepInput, FDCDataset, Options);

	BusinessAttributes_Results := JOIN(withBusinessSeleIDAttributes, BusinessProxIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));		
	#end

	RETURN(BusinessAttributes_Results);
END;



