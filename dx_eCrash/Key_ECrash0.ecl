IMPORT $;

EXPORT KEY_ECRASH0 := INDEX({$.Layouts.ECRASH0_KEYED}, 
                            {$.Layouts.ECRASH0_PAYLOAD},
                            $.Names.i_ECRASH0_SF
                            );
                