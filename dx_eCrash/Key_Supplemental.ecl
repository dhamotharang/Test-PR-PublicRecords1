IMPORT $;

EXPORT KEY_SUPPLEMENTAL := INDEX({$.Layouts.SUPPLEMENTAL_KEYED}, 
                                 {$.Layouts.SUPPLEMENTAL_PAYLOAD},
                                 $.Names.i_SUPPLEMENTAL_SF
                                 );
