IMPORT $;

EXPORT KEY_VINNBR := INDEX({$.Layouts.VINNBR_KEYED}, 
                           {$.Layouts.VINNBR_PAYLOAD},
                           $.Names.i_VINNBR_SF
                           );
