IMPORT $;

EXPORT KEY_MBSINDTYPEEXCLUSION := INDEX({$.Layouts.MBS_INDTYPE_EXCLUSION_KEYED}, 
                                        {$.Layouts.MBS_INDTYPE_EXCLUSION_PAYLOAD},
                                        $.Names.i_MBS_INDTYPE_EXCLUSION_SF
                                        );
