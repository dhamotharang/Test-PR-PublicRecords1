IMPORT $;

//Used this index method to carry the maxlength.
dsSERIALNUMBER := DATASET([], $.Layouts.SERIALNUMBER);
EXPORT Key_SERIALNUMBER := INDEX(dsSERIALNUMBER,
                             {$.Layouts.SERIALNUMBER_KEYED}, 
                             {$.Layouts.SERIALNUMBER_PAYLOAD},
                             $.Names.i_SERIALNUMBER_SF
                             );
