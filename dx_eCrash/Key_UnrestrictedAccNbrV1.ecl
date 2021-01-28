IMPORT $;

EXPORT KEY_UNRESTRICTEDACCNBRV1 := INDEX({$.Layouts.UNRESTRICTED_ACCNBRV1_KEYED}, 
                                         {$.Layouts.UNRESTRICTED_ACCNBRV1_PAYLOAD},
                                         $.Names.i_UNRESTRICTED_ACCNBRV1_SF
                                         );
