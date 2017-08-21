import Data_Services, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'enclarity'							;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,Data_Services.foreign_prod + 'thor_data400::',
																			'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;