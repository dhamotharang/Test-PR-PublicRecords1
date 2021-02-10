IMPORT $;
 
EXPORT KEY_ACCNBR := INDEX({$.Layouts.ACCNBR_KEYED}, 
                           {$.Layouts.ACCNBR_PAYLOAD},
                            $.Names.i_ACCNBR_SF
                           );
