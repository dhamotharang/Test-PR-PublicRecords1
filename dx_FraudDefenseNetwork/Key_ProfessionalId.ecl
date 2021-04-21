IMPORT $;

//Used this index method to carry the maxlength.
dsPROFESSIONALID := DATASET([], $.Layouts.PROFESSIONALID);
EXPORT KEY_PROFESSIONALID := INDEX(dsPROFESSIONALID,
                                   {$.Layouts.PROFESSIONALID_KEYED}, 
                                   {$.Layouts.PROFESSIONALID_PAYLOAD},
                                   $.Names.i_PROFESSIONALID_SF
                                   );
