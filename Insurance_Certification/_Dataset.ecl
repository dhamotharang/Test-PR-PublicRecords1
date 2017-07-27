import _control, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false) := module
	export Name										:= 	'Insurance_Certification';
	export thor_cluster_Files			:= 	'~thor_data400::'; /* prod     */
	//export thor_cluster_Files			:= 	'~thor40_241::';   /* dataland */
	export thor_cluster_Persists	:= 	thor_cluster_Files;
	export max_record_size				:= 	40000;
	export Groupname							:= 	versioncontrol.groupname();
end;