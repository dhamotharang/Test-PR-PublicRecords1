IMPORT $;

//Used this index method to carry the maxlength.
dsTIN := DATASET([], $.Layouts.TIN);
EXPORT KEY_TIN := INDEX(dsTIN,
                        {$.Layouts.TIN_KEYED}, 
                        {$.Layouts.TIN_PAYLOAD},
                        $.Names.i_TIN_SF
                        );
