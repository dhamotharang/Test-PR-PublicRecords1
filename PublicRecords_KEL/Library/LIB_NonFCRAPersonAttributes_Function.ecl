IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_ConsumerAttributes_Library := NOT _Control.LibraryUse.ForceOffOne_PublicRecords_KEL__LIB_ConsumerAttributes;

EXPORT LIB_NonFCRAPersonAttributes_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) MiniAttributeInputRecords,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_ConsumerAttributes_Library)
	FinalPersonAttributes := LIBRARY('PublicRecords_KEL.Library.LIB_NonFCRAPersonAttributes', PublicRecords_KEL.Library.LIB_NonFCRAPersonAttributes_Interface(MiniAttributeInputRecords, FDCDataset, Options)).Results;
#else
//input consumer	
//nonFCRA consumer
//all risktable summary attributes
 

  InputPIIAttributes := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(MiniAttributeInputRecords, Options, FDCDataset);
	
	PersonAttributes :=PublicRecords_KEL.FnRoxie_GetPersonAttributesNonFCRA(MiniAttributeInputRecords, FDCDataset, Options); 

	// PII Corroboration Summary attributes are NonFCRA only
	ALLSummaryAttributesNonFCRA := PublicRecords_KEL.FnRoxie_GetSummaryAttributes(MiniAttributeInputRecords, Options, FDCDataset);
	
	// HighRiskAddressAttributes := PublicRecords_KEL.FnRoxie_GetHighRiskAddress(MiniAttributeInputRecords, Options, FDCDataset);

	withPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));

	FinalPersonAttributes := JOIN(withPersonAttributes, ALLSummaryAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF.G_ProcUID := LEFT.G_procUID, //If right is empty this ensures that G_ProcUID is not blank
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));		

	// withHighRiskAddressAttributes := JOIN(withPersonALLSummaryAttributes, HighRiskAddressAttributes, 
	// LEFT.G_ProcUID = RIGHT.G_ProcUID,
		// TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			// SELF := RIGHT,
			// SELF := LEFT,
			// SELF := []),
		// LEFT OUTER, KEEP(1), ATMOST(100));	


	#end

	RETURN(FinalPersonAttributes);
END;



