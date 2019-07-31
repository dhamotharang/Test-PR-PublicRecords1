import mdr,header,_control, data_services, vault, dx_header;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_Header := vault.doxie.Key_FCRA_Header;
#ELSE
EXPORT Key_FCRA_Header := dx_header.key_header(data_services.data_env.iFCRA);

#END;

