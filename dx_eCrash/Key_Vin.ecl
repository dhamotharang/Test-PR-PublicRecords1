IMPORT $;

EXPORT KEY_VIN := INDEX({$.Layouts.VIN_KEYED}, 
                        {$.Layouts.VIN_PAYLOAD},
                        $.Names.i_VIN_SF
                        );
