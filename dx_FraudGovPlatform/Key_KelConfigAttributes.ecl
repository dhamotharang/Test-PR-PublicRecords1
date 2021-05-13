IMPORT $;

//Used this index method to carry the maxlength.
dsKEL_CONFIGATTRIBUTES := DATASET([], $.Layouts.KEL_CONFIGATTRIBUTES);
EXPORT Key_KELCONFIGATTRIBUTES := INDEX(dsKEL_CONFIGATTRIBUTES,
                             {$.Layouts.KEL_CONFIGATTRIBUTES_KEYED}, 
                             {$.Layouts.KEL_CONFIGATTRIBUTES_PAYLOAD},
                             $.Names.i_KEL_CONFIGATTRIBUTES_SF
                             );
