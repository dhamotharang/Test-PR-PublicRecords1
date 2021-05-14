IMPORT $;

EXPORT KEY_TAGNBR := INDEX({$.Layouts.TAGNBR_KEYED}, 
                           {$.Layouts.TAGNBR_PAYLOAD},
                           $.Names.i_TAG_NBR_SF
                           );
