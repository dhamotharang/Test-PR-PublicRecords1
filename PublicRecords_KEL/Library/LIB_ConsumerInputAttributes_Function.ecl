IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_ConsumerInputAttributes_Library := NOT _Control.LibraryUse.ForceOff_PublicRecords_KEL__LIB_ConsumerInputAttributes;

EXPORT LIB_ConsumerInputAttributes_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput,
            PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_ConsumerInputAttributes_Library)
	ConsumerInputAttributes_Results := LIBRARY('PublicRecords_KEL.Library.LIB_ConsumerInputAttributes', PublicRecords_KEL.Library.LIB_ConsumerInputAttributes_Interface(PersonInput, Options)).Results;
#else
	ConsumerInputAttributes_Results := PublicRecords_KEL.FnRoxie_GetInputPIIAttributes(PersonInput, Options);
#end

	RETURN(ConsumerInputAttributes_Results);
END;