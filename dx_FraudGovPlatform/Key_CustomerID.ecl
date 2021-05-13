IMPORT $;

//Used this index method to carry the maxlength.
dsCUSTOMERID := DATASET([], $.Layouts.CUSTOMERID);
EXPORT Key_CUSTOMERID := INDEX(dsCUSTOMERID,
                             {$.Layouts.CUSTOMERID_KEYED}, 
                             {$.Layouts.CUSTOMERID_PAYLOAD},
                             $.Names.i_CUSTOMERID_SF
                             );
