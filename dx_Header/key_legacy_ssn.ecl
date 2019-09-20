IMPORT data_services, _control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_legacy_ssn_fcra,
                                     $.names().i_legacy_ssn); 

EXPORT key_legacy_ssn (integer data_category = 0) := 
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_header.key_legacy_ssn(data_category);
#ELSE
    INDEX ($.layouts.i_legacy_ssn, fname(data_category), OPT);
#END;
