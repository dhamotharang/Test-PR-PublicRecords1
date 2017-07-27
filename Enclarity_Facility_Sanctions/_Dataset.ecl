IMPORT _control, versioncontrol, data_services;

EXPORT _Dataset(boolean pUseProd = false) := MODULE

	EXPORT Name										:= 'enclarity_sanctions'							;
	EXPORT thor_cluster_Files			:= 	if(pUseProd 
																			,Data_Services.foreign_prod + 'thor_data400::',
																			'~thor_data400::'
																		);
	EXPORT thor_cluster_Persists	:= thor_cluster_Files		;
	EXPORT max_record_size				:= 40000;

	EXPORT Groupname	:= versioncontrol.Groupname();

END;