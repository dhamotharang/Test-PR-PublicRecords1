import _control, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false) := module
	export Name										:= 	'prolic::mari';
	export thor_cluster_Files			:= 	'~thor_data400::';
	export thor_cluster_Persists	:= 	thor_cluster_Files;
	export Groupname							:= 	versioncontrol.groupname();
end;