IMPORT $;

EXPORT KEY_BYMOY := INDEX({$.Layouts.BY_MOY_KEYED}, 
                          {$.Layouts.BY_MOY_PAYLOAD},
                          $.Names.i_ANALYTICS_BY_MOY_SF
                         );
