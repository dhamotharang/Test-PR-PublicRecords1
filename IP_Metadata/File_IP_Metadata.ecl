import dx_ip_metadata, data_services, doxie_build;

EXPORT File_IP_Metadata := MODULE

	EXPORT Raw 					:= dataset('~thor_data400::in::ip_metadata_raw', 				IP_metadata.Layout_IP_Metadata.Raw, 				csv(heading(1), terminator('\n'), separator(';')));
	EXPORT History 	:= dataset('~thor_data400::in::ip_metadata_history', IP_metadata.Layout_IP_Metadata.History, flat);	
	EXPORT Base					:= dataset('~thor_data400::base::ip_metadata_main', 	IP_metadata.Layout_IP_Metadata.Base, 			flat);
	
	shared common_ipv6 			:= dx_ip_metadata.names.common_ipv6;
	export in_path_ipv6 		:= dx_ip_metadata.names.in_path_ipv6;
	export raw_path_ipv6 		:= in_path_ipv6 + '_raw';
	export history_path_ipv6 	:= in_path_ipv6 + '_history';
	export base_path_ipv6 		:= dx_ip_metadata.names.base_path_ipv6;
	
	EXPORT Raw_ipv6 := dataset(raw_path_ipv6, IP_metadata.Layout_IP_Metadata.Raw_ipv6, csv(heading(1), terminator('\n'), separator(';')));
	EXPORT History_ipv6 := dataset(history_path_ipv6, IP_metadata.Layout_IP_Metadata.History_ipv6, flat);
	EXPORT Base_ipv6						:= dataset(base_path_ipv6, 	IP_metadata.Layout_IP_Metadata.base_ipv6, 			flat);
	EXPORT key_ipv6(string version = '') 	:= if(version = '', dx_ip_metadata.names.key_ipv6_path, dx_ip_metadata.names.common_ipv6+ 'key::'+version+'::ip_metadata_ipv6');
END;
