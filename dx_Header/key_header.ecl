IMPORT $;

EXPORT key_header (integer data_category = 0) := 
         INDEX ({$.layout_key_header.s_did}, $.layout_key_header, $.names().i_header, OPT); //TODO: OPT?
