/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_BusinessInputAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
            DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options) := MODULE

	BusinessInputAttributesResults := PublicRecords_KEL.FnRoxie_GetInputBIIAttributes(BusinessInput, RepInput, Options);
	
	EXPORT Results := BusinessInputAttributesResults;
END;