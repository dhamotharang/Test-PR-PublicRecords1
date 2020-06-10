import dx_ip_metadata, data_services;
EXPORT names := MODULE
	export common_ipv6 := data_services.data_location.Prefix('ip_metadata')+'thor::';
    export in_path_ipv6 		:= common_ipv6 + 'in::ip_metadata_ipv6';
	export base_path_ipv6 :=common_ipv6 +'base::ip_metadata_ipv6_main';
	EXPORT key_ipv6_path :=  common_ipv6+ 'key::ip_metadata_ipv6';
END;