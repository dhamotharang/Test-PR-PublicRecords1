IMPORT $;

EXPORT KEY_GCID_2_MBSFDNMASTERID := INDEX({$.Layouts.MBS_FDN_MASTERID_KEYED}, 
                                          {$.Layouts.MBS_FDN_MASTERID_PAYLOAD},
                                          $.Names.i_MBS_FDN_MASTERID_SF
                                          );
