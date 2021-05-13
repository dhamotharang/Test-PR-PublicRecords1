IMPORT $;

//Used this index method to carry the maxlength.
dsUSER := DATASET([], $.Layouts.USER);
EXPORT Key_USER := INDEX(dsUSER,
                             {$.Layouts.USER_KEYED}, 
                             {$.Layouts.USER_PAYLOAD},
                             $.Names.i_USER_SF
                             );
