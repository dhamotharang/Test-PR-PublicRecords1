IMPORT $;

EXPORT KEY_DLNBR := INDEX({$.Layouts.DLNBR_KEYED}, 
                          {$.Layouts.DLNBR_PAYLOAD},
                          $.Names.i_DL_NBR_SF
                          );
