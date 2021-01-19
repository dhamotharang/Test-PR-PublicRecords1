IMPORT $;

EXPORT KEY_BDID := INDEX({$.Layouts.BDID_KEYED}, 
                         {$.Layouts.BDID_PAYLOAD},
                         $.Names.i_BDID_SF
                        );
