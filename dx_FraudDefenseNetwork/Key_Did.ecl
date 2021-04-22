IMPORT $;

//Used this index method to carry the maxlength.
dsDID := DATASET([], $.Layouts.DID);
EXPORT KEY_DID := INDEX(dsDID,
                       {$.Layouts.DID_KEYED}, 
                       {$.Layouts.DID_PAYLOAD},
                       $.Names.i_DID_SF
                       );