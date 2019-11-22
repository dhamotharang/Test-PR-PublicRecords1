import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'CFPB';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor::',
																			'~thor50_dev_eclcc::' //this is the one I'm allowed to use
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;