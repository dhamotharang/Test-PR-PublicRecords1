import _control, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false) := INLINE module
	export Name						:= 	'CourtLink';
	export thor_cluster_Files		:= 	'~thor_data400::';
	export thor_cluster_Persists	:= 	thor_cluster_Files;
	export max_record_size			:= 	12000;
	export Groupname				:= 	versioncontrol.groupname();
end;
