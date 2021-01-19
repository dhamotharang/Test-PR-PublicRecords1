IMPORT $;

EXPORT KEY_AGENCY := INDEX({$.Layouts.AGENCY_KEYED}, 
                           {$.Layouts.AGENCY_PAYLOAD},
                           $.Names.i_AGENCY_SF
                          );
