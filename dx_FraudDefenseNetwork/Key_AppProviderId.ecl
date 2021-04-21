IMPORT $;

//Used this index method to carry the maxlength.
dsAPPPROVIDERID := DATASET([], $.Layouts.APP_PROVIDERID);
EXPORT KEY_APPPROVIDERID := INDEX(dsAPPPROVIDERID,
                                  {$.Layouts.APP_PROVIDERID_KEYED}, 
                                  {$.Layouts.APP_PROVIDERID_PAYLOAD},
                                  $.Names.i_APP_PROVIDERID_SF
                                  );
