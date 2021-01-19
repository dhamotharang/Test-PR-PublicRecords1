IMPORT $;

EXPORT KEY_DOL := INDEX({$.Layouts.DOL_KEYED}, 
                        {$.Layouts.DOL_PAYLOAD},
                        $.Names.i_DOL_SF
                        );
