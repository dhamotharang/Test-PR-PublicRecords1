﻿/*--LIBRARY--*/

IMPORT PublicRecords_KEL;

EXPORT LIB_BusinessAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	#OPTION('expandSelectCreateRow', TRUE);
	#OPTION('foldStored', TRUE);

	
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
	
	EXPORT Results := BusinessAttributes_Results;
END;
