IMPORT $;

//Used this index method to carry the maxlength.
dsMBSFDNINDTYPE := DATASET([], $.Layouts.MBSFDNINDTYPE);
EXPORT Key_MBSFDNINDTYPE := INDEX(dsMBSFDNINDTYPE,
                             {$.Layouts.MBSFDNINDTYPE_KEYED}, 
                             {$.Layouts.MBSFDNINDTYPE_PAYLOAD},
                             $.Names.i_MBSFDNINDTYPE_SF
                             );
