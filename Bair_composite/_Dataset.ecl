import _control, versioncontrol,ut;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'bair_composite';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,ut.foreign_bair_prod + 'thor_data400::',
																			'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;