IMPORT $;

//Used this index method to carry the maxlength.
dsMACADDRESS := DATASET([], $.Layouts.MACADDRESS);
EXPORT Key_MACADDRESS := INDEX(dsMACADDRESS,
                             {$.Layouts.MACADDRESS_KEYED}, 
                             {$.Layouts.MACADDRESS_PAYLOAD},
                             $.Names.i_MACADDRESS_SF
                             );
