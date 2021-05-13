IMPORT $;

//Used this index method to carry the maxlength.
dsKEL_CONFIGRULES := DATASET([], $.Layouts.KEL_CONFIGRULES);
EXPORT Key_KELCONFIGRULES := INDEX(dsKEL_CONFIGRULES,
                             {$.Layouts.KEL_CONFIGRULES_KEYED}, 
                             {$.Layouts.KEL_CONFIGRULES_PAYLOAD},
                             $.Names.i_KEL_CONFIGRULES_SF
                             );
