import data_services, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false) := INLINE module
	export Name										:= 	'LaborActions_MSHA';
	export pname                  :=   'LaborActionsMSHA';
	export thor_cluster_Files			:= 	data_services.data_location.prefix () + 'thor_data400::';
	export thor_cluster_Persists	:= 	thor_cluster_Files;
	export max_record_size				:= 	40000;
	export Groupname							:= 	versioncontrol.groupname();
end;
