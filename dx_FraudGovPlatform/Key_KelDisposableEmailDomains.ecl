IMPORT $;

//Used this index method to carry the maxlength.
dsKEL_DISPOSABLEEMAILDOMAINS := DATASET([], $.Layouts.KEL_DISPOSABLEEMAILDOMAINS);
EXPORT Key_KELDISPOSABLEEMAILDOMAINS := INDEX(dsKEL_DISPOSABLEEMAILDOMAINS,
                             {$.Layouts.KEL_DISPOSABLEEMAILDOMAINS_KEYED}, 
                             {$.Layouts.KEL_DISPOSABLEEMAILDOMAINS_PAYLOAD},
                             $.Names.i_KEL_DISPOSABLEEMAILDOMAINS_SF
                             );

