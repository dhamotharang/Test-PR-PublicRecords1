IMPORT $;

EXPORT KEY_STANDLOCATION := INDEX({$.Layouts.STANDLOCATION_KEYED}, 
                                  {$.Layouts.STANDLOCATION_PAYLOAD},
                                  $.Names.i_ST_AND_LOCATION_SF
                                  );
