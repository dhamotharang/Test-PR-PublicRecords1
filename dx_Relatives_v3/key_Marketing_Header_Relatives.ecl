IMPORT $;

EXPORT key_Marketing_Header_Relatives (integer data_category = 0) := 
         INDEX ({$.layouts.i_Relatives_v3.did1}, $.layouts.i_Relatives_v3, $.names().i_Marketing_Header_Relatives);
