IMPORT $;

EXPORT KEY_BYHOD := INDEX({$.Layouts.BY_HOD_KEYED}, 
                          {$.Layouts.BY_HOD_PAYLOAD},
                          $.Names.i_ANALYTICS_BY_HOD_SF
                         );
