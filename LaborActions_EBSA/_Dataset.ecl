import versioncontrol, data_services;

export _Dataset(boolean pUseOtherEnvironment = false) := INLINE module
	export Name										:= 	'laboractions_ebsa';
	export pName										:= 	'LaborActionsEBSA';
	export thor_cluster_Files			:= 	data_services.data_location.prefix ('LaborActionsEBSA') + 'thor_data400::';
	export thor_cluster_Persists	:= 	thor_cluster_Files;
	export max_record_size				:= 	40000;
	export Groupname							:= 	versioncontrol.groupname();
end;