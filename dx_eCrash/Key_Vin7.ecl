IMPORT $;

EXPORT KEY_VIN7 := INDEX({$.Layouts.VIN7_KEYED}, 
                         {$.Layouts.VIN7_PAYLOAD},
                         $.Names.i_VIN7_SF
                         );
