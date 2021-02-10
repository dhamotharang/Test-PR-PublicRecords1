IMPORT $;

EXPORT KEY_ECRASH3V := INDEX({$.Layouts.ECRASH3V_KEYED}, 
                             {$.Layouts.ECRASH3V_PAYLOAD},
                             $.Names.i_ECRASH3V_SF
                             );
