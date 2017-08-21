import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'BAIR';
	export thor_cluster_Files			:= 	'~thor_data400::';
	export thor_cluster_Persists	:= thor_cluster_Files;
	export max_record_size				:= 1000000000;

	export Groupname	:= versioncontrol.Groupname();

end;