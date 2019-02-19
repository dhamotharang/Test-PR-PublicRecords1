IMPORT data_services;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_addr_hist_fcra,
                                     $.names().i_addr_hist); 

EXPORT key_addr_hist (integer data_category = 0) := FUNCTION
  RETURN INDEX ({$.layouts.i_addr_hist.s_did}, {$.layouts.i_addr_hist}, fname(data_category));
END;	

