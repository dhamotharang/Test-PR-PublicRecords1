IMPORT $;

//Used this index method to carry the maxlength.
dsIPRANGE := DATASET([], $.Layouts.IPRANGE);
EXPORT Key_IPRANGE := INDEX(dsIPRANGE,
                             {$.Layouts.IPRANGE_KEYED}, 
                             {$.Layouts.IPRANGE_PAYLOAD},
                             $.Names.i_IPRANGE_SF
                             );
