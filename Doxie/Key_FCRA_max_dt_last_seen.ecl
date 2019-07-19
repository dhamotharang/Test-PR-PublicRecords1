import dx_header,data_services, vault, _control;


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_FCRA_max_dt_last_seen := vault.Doxie.Key_FCRA_max_dt_last_seen;
#ELSE
EXPORT key_FCRA_max_dt_last_seen := dx_header.key_max_dt_last_seen(data_services.data_env.iFCRA);
#END;

