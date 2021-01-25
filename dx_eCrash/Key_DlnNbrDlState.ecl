IMPORT $;

EXPORT KEY_DLNNBRDLSTATE := INDEX({$.Layouts.DLNNBRDLSTATE_KEYED}, 
                                  {$.Layouts.DLNNBRDLSTATE_PAYLOAD},
                                  $.Names.i_DLN_NBR_DL_STATE_SF
                                  );
