import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'CD_Seed'							;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_data::',
																			'~thor_data::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;