IMPORT $;

EXPORT KEY_BYDOW := INDEX({$.Layouts.BY_DOW_KEYED}, 
                          {$.Layouts.BY_DOW_PAYLOAD},
                          $.Names.i_ANALYTICS_BY_DOW_SF
                         );
