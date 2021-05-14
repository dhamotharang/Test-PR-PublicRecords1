IMPORT $;

//Used this index method to carry the maxlength.
dsZIP := DATASET([], $.Layouts.ZIP);
EXPORT Key_ZIP := INDEX(dsZIP,
                             {$.Layouts.ZIP_KEYED}, 
                             {$.Layouts.ZIP_PAYLOAD},
                             $.Names.i_ZIP_SF
                             );
