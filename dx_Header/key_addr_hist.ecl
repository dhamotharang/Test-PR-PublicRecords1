IMPORT data_services, _control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_addr_hist_fcra,
                                     $.names().i_addr_hist); 

EXPORT key_addr_hist (integer data_category = 0) := 
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_Header.key_addr_hist(data_category)::DEPRECATED('Please MIGRATE usage to dx_Header.Key_Addr_Unique_Expanded');
#ELSE
    INDEX ({$.layouts.i_addr_hist.s_did}, {$.layouts.i_addr_hist}, fname(data_category)):DEPRECATED('Please MIGRATE usage to dx_Header.Key_Addr_Unique_Expanded');
#END;
