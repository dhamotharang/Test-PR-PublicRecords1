IMPORT $;

EXPORT KEY_AGENCYSOURCE := INDEX({$.Layouts.AGENCYSOURCE_KEYED}, 
                                 {$.Layouts.AGENCYSOURCE_PAYLOAD},
                                 $.Names.i_AGENCYSOURCE_SF
                                 );
