IMPORT $;

EXPORT KEY_ECRASH2V := INDEX({$.Layouts.ECRASH2V_KEYED}, 
                             {$.Layouts.ECRASH2V_PAYLOAD},
                             $.Names.i_ECRASH2V_SF
                             );
              