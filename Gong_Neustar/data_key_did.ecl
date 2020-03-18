IMPORT $, dx_Gong;

EXPORT data_key_did := PROJECT($.File_Gong_Did(did<>0), TRANSFORM(dx_Gong.layouts.i_did,
                                                                  SELF.l_did := LEFT.did,
                                                                  SELF := LEFT)); 
