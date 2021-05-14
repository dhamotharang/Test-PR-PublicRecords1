IMPORT $;

//Used this index method to carry the maxlength.
dsBANKNAME := DATASET([], $.Layouts.BANKNAME);
EXPORT Key_BANKNAME := INDEX(dsBANKNAME,
                             {$.Layouts.BANKNAME_KEYED}, 
                             {$.Layouts.BANKNAME_PAYLOAD},
                             $.Names.i_BANKNAME_SF
                             );
