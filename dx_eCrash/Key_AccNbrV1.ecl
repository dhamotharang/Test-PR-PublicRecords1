IMPORT $;

EXPORT KEY_ACCNBRV1 := INDEX({$.Layouts.ACCNBRV1_KEYED}, 
                             {$.Layouts.ACCNBRV1_PAYLOAD},
                             $.Names.i_ACCNBRV1_SF
                            );
