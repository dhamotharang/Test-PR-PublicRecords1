import data_services, dx_header, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_legacy_ssn := vault.doxie.Key_FCRA_legacy_ssn;
#ELSE
EXPORT Key_FCRA_legacy_ssn := dx_header.key_legacy_ssn(data_services.data_env.iFCRA);
#END;

