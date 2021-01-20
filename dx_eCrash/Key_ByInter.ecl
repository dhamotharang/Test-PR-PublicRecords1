IMPORT $;

EXPORT KEY_BYINTER := INDEX({$.Layouts.BY_INTER_KEYED}, 
                            {$.Layouts.BY_INTER_PAYLOAD},
                            $.Names.i_ANALYTICS_BY_INTER_SF
                            );
