import dx_ip_metadata, data_services;
EXPORT names := MODULE
	export common_ipv6 := data_services.data_location.Prefix('ip_metadata')+'thor::';
	export base_path_ipv6 :=common_ipv6 +'base::ip_metadata_ipv6_main';
	EXPORT Base_ipv6 := dataset(base_path_ipv6, 	dx_ip_metadata.Layout_IP_Metadata.base_ipv6, 			flat);
	EXPORT key_ipv6 :=  common_ipv6+ 'key::ip_metadata_ipv6';
END;