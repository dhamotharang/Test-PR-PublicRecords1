import data_services, doxie_build;

EXPORT File_IP_Metadata := MODULE

	EXPORT Raw 				:= dataset('~thor_data400::in::ip_metadata_raw', 			IP_metadata.Layout_IP_Metadata.Raw, csv(heading(1), terminator('\n'), separator(';')));
	EXPORT History 		:= dataset('~thor_data400::in::ip_metadata_history', 	IP_metadata.Layout_IP_Metadata.Raw, flat);	
	EXPORT Base				:= dataset('~thor_data400::base::ip_metadata_main', 	IP_metadata.Layout_IP_Metadata.Base, flat);

END;