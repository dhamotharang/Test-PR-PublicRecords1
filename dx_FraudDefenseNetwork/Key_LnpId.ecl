IMPORT $;

//Used this index method to carry the maxlength.
dsLNPID := DATASET([], $.Layouts.LNPID);
EXPORT KEY_LNPID := INDEX(dsLNPID,
                          {$.Layouts.LNPID_KEYED}, 
                          {$.Layouts.LNPID_PAYLOAD},
                          $.Names.i_LNPID_SF
                          );
