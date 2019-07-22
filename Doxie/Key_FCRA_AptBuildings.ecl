import data_services, vault, _control, dx_header;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_AptBuildings := vault.doxie.Key_FCRA_AptBuildings;
#ELSE
EXPORT Key_FCRA_AptBuildings := dx_header.Key_AptBuildings(data_services.data_env.iFCRA);
#END;


