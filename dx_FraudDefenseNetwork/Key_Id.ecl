IMPORT $;

//Used this index method to carry the maxlength.
dsID := DATASET([], $.Layouts.ID);
EXPORT KEY_ID := INDEX(dsID,
                       {$.Layouts.ID_KEYED}, 
                       {$.Layouts.ID_PAYLOAD},
                       $.Names.i_ID_SF
                       );
