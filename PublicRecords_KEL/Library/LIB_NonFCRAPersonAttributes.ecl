﻿/*--LIBRARY--*/

IMPORT PublicRecords_KEL;

EXPORT LIB_NonFCRAPersonAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) MiniAttributeInputRecords,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	
	#OPTION('expandSelectCreateRow', TRUE);
	#OPTION('foldStored', TRUE);

	// Get consumer attributes

  InputPIIAttributes := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(MiniAttributeInputRecords, Options, FDCDataset);
	
	PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributesNonFCRA(MiniAttributeInputRecords, FDCDataset, Options); 

	// PII Corroboration Summary attributes are NonFCRA only
	ALLSummaryAttributesNonFCRA := PublicRecords_KEL.FnRoxie_GetSummaryAttributes(MiniAttributeInputRecords, Options, FDCDataset);


	withPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));

	FinalPersonAttributes := JOIN(withPersonAttributes, ALLSummaryAttributesNonFCRA, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF.G_ProcUID := LEFT.G_procUID, //If right is empty this ensures that G_ProcUID is not blank
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));		
	
	EXPORT Results := FinalPersonAttributes;
END;
