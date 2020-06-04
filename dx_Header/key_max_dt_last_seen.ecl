IMPORT data_services, _control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_max_date_fcra,
                                     $.names().i_max_date); 

EXPORT key_max_dt_last_seen (integer data_category = 0) :=
#IF(_Control.Environment.onVault)
    vault.dx_header.key_max_dt_last_seen(data_category);
#ELSE
    INDEX ($.layouts.i_max_date, $.layouts.i_max_date, fname(data_category));
#END;
