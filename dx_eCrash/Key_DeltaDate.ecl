IMPORT $;

EXPORT KEY_DELTADATE := INDEX({$.Layouts.DELTADATE_KEYED}, 
                              {$.Layouts.DELTADATE_PAYLOAD},
                              $.Names.i_DELTA_DATE_SF
                              );
