IMPORT $;

//Used this index method to carry the maxlength.
dsMBS_FDN_MASTERID_INDTYPE_INCL := DATASET([], $.Layouts.MBS_FDN_MASTERID_INDTYPE_INCL);
EXPORT KEY_MBSFDNMASTERIDINDTYPEINCLUSION := INDEX(dsMBS_FDN_MASTERID_INDTYPE_INCL,
                             {$.Layouts.MBS_FDN_MASTERID_INDTYPE_INCL_KEYED}, 
                             {$.Layouts.MBS_FDN_MASTERID_INDTYPE_INCL_PAYLOAD},
                             $.Names.i_MBS_FDN_MASTERID_INDTYPE_INCL_SF
                             );
