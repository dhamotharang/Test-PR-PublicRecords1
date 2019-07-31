import dx_header, data_services, vault, _control;


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_Header_Address := vault.Doxie.Key_FCRA_Header_Address;
#ELSE
EXPORT Key_FCRA_Header_Address := dx_header.key_header_address(data_services.data_env.iFCRA);
#END;


	