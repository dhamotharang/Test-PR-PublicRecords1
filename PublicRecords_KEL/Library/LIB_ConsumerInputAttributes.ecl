/*--LIBRARY--*/

IMPORT $.^.^.PublicRecords_KEL;

EXPORT LIB_ConsumerInputAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput,
			PublicRecords_KEL.Interface_Options Options) := MODULE

	ConsumerInputAttributesResults := PublicRecords_KEL.Q_Input_Attributes_V1(PersonInput, PersonInput[1].P_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).res0;
	
	EXPORT Results := ConsumerInputAttributesResults;
END;