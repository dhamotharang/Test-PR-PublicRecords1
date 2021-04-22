IMPORT $;

EXPORT KEY_MBSFDNMASTERIDEXCLUSION := INDEX({$.Layouts.MBS_FDN_MASTERID_EXCL_KEYED}, 
                                            {$.Layouts.MBS_FDN_MASTERID_EXCL_PAYLOAD},
                                            $.Names.i_MBS_FDN_MASTERID_EXCL_SF
                                            );
