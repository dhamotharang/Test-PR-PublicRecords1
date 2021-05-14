IMPORT $;

EXPORT KEY_ECRASH1 := INDEX({$.Layouts.ECRASH1_KEYED}, 
                            {$.Layouts.ECRASH1_PAYLOAD},
                            $.Names.i_ECRASH1_SF
                            );
