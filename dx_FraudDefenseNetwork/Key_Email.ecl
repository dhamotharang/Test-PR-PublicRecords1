IMPORT $;

//Used this index method to carry the maxlength.
dsEMAIL := DATASET([], $.Layouts.EMAIL);
EXPORT KEY_EMAIL := INDEX(dsEMAIL,
                          {$.Layouts.EMAIL_KEYED}, 
                          {$.Layouts.EMAIL_PAYLOAD},
                          $.Names.i_EMAIL_SF
                         );