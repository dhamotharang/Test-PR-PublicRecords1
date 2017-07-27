import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'hms_stl';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + '~thor400_data::',
																			'~thor400_data::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;