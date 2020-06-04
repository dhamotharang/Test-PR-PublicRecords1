import _control, versioncontrol, Data_Services;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'CFPB';
	export thor_cluster_Files			:=if(pUseProd ,VersionControl.foreign_prod + 'thor::', data_services.data_location.prefix('CFPB')+'thor::');
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;