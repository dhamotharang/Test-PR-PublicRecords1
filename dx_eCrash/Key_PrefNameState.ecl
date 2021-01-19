IMPORT $;

EXPORT KEY_PREFNAMESTATE := INDEX({$.Layouts.PREFNAME_KEYED}, 
                                  {$.Layouts.PREFNAME_PAYLOAD},
                                  $.Names.i_PREFNAME_STATE_SF
                                  );
