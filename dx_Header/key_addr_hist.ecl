IMPORT data_services, vault, _control;;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_addr_hist_fcra,
                                     $.names().i_addr_hist); 

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
	export key_addr_hist(boolean isFCRA=false) := vault.Header.key_addr_hist(isFCRA);
#ELSE

EXPORT key_addr_hist (integer data_category = 0) := FUNCTION
  RETURN INDEX ({$.layouts.i_addr_hist.s_did}, {$.layouts.i_addr_hist}, fname(data_category));
END;	

#END;
