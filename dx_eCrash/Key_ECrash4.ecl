IMPORT $;

EXPORT KEY_ECRASH4 := INDEX({$.Layouts.ECRASH4_KEYED}, 
                            {$.Layouts.ECRASH4_PAYLOAD},
                            $.Names.i_ECRASH4_SF
                            );
        