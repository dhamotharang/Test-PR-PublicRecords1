IMPORT data_services;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_header_fcra,
                                     $.names().i_header); 

EXPORT key_header (integer data_category = 0) := 
         INDEX ({$.layout_key_header.s_did}, $.layout_key_header, fname(data_category), OPT); //TODO: OPT?
