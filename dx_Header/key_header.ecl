IMPORT data_services, _Control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_header_fcra,
                                     $.names().i_header); 

EXPORT key_header (integer data_category = 0) := 
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_header.key_header(data_category);
#ELSE
    INDEX ({$.layout_key_header.s_did}, $.layout_key_header, fname(data_category), OPT); //TODO: OPT?
#END;
