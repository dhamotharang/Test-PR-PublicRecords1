/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_ConsumerInputAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput,
			PublicRecords_KEL.Interface_Options Options) := MODULE

	ConsumerInputAttributesResults := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(PersonInput, Options);
	
	EXPORT Results := ConsumerInputAttributesResults;
END;