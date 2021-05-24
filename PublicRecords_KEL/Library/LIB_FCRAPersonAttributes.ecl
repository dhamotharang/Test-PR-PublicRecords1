﻿/*--LIBRARY--*/

IMPORT PublicRecords_KEL;

EXPORT LIB_FCRAPersonAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) MiniAttributeInputRecords,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	
	#OPTION('expandSelectCreateRow', TRUE);
	#OPTION('foldStored', TRUE);
	#CONSTANT('IsFCRA', TRUE);

  // Get Attributes - cleans the attributes after KEL is done 
  InputPIIAttributes := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(MiniAttributeInputRecords, Options, FDCDataset);
	
	PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributesFCRA(MiniAttributeInputRecords, FDCDataset, Options); 
	
	FinalPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, 
	LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
	
	EXPORT Results := FinalPersonAttributes;
END;
