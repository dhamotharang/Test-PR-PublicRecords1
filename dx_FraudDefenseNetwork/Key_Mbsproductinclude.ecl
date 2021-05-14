IMPORT $;

EXPORT KEY_MBSPRODUCTINCLUDE := INDEX({$.Layouts.MBS_PRODUCT_INCLUDE_KEYED}, 
                                      {$.Layouts.MBS_PRODUCT_INCLUDE_PAYLOAD},
                                      $.Names.i_MBS_PRODUCT_INCLUDE_SF
                                      );
