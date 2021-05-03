IMPORT $;

EXPORT KEY_ECRASH5 := INDEX({$.Layouts.ECRASH5_KEYED}, 
                            {$.Layouts.ECRASH5_PAYLOAD},
                            $.Names.i_ECRASH5_SF
                           );
