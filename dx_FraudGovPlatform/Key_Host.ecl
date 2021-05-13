IMPORT $;

//Used this index method to carry the maxlength.
dsHOST := DATASET([], $.Layouts.HOST);
EXPORT Key_HOST := INDEX(dsHOST,
                             {$.Layouts.HOST_KEYED}, 
                             {$.Layouts.HOST_PAYLOAD},
                             $.Names.i_HOST_SF
                             );
