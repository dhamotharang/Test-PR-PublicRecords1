IMPORT $;

inFile := $.Layouts.i_Delta_Rid;

EXPORT Key_Foreclosure_Delta_Rid := INDEX(
  {inFile.record_sid},
  {inFile},
  $.names().i_foreclosure_delta_rid
  );
                                          
