IMPORT $.^.^._Control, $.^.^.PublicRecords_KEL;

Use_BusinessInputAttributes_Library := NOT _Control.LibraryUse.ForceOff_PublicRecords_KEL__LIB_BusinessInputAttributes;

EXPORT LIB_BusinessInputAttributes_Function(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
            DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options) := FUNCTION

#if(Use_BusinessInputAttributes_Library)
	BusinessInputAttributes_Results := LIBRARY('PublicRecords_KEL.Library.LIB_BusinessInputAttributes', PublicRecords_KEL.Library.LIB_BusinessInputAttributes_Interface(BusinessInput, RepInput, Options)).Results;
#else
	BusinessInputAttributes_Results := PublicRecords_KEL.FnRoxie_GetInputBIIAttributes(BusinessInput, RepInput, Options);
#end

	RETURN(BusinessInputAttributes_Results);
END;