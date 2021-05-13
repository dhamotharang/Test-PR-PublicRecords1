IMPORT $;

//Used this index method to carry the maxlength.
dsKEL_ENTITYPROFILE := DATASET([], $.Layouts.KEL_ENTITYPROFILE);
EXPORT Key_KELENTITYPROFILE := INDEX(dsKEL_ENTITYPROFILE,
                             {$.Layouts.KEL_ENTITYPROFILE_KEYED}, 
                             {$.Layouts.KEL_ENTITYPROFILE_PAYLOAD},
                             $.Names.i_KEL_ENTITYPROFILE_SF
                             );
