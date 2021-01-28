IMPORT $;

EXPORT KEY_DID := INDEX({$.Layouts.DID_KEYED}, 
                        {$.Layouts.DID_PAYLOAD},
                        $.Names.i_DID_SF
                        );
