IMPORT $;

EXPORT KEY_BYCOLLISIONTYPE := INDEX({$.Layouts.BY_CT_KEYED}, 
                                    {$.Layouts.BY_CT_PAYLOAD},
                                    $.Names.i_ANALYTICS_BY_COLLISION_TYPE_SF
                                   );
