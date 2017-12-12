import tools, data_services;

export _Dataset(

	boolean	pUseProd = false

):=
INLINE module

	export Name										:= 'Spoke'							;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,data_services.foreign_prod + 'thor_data400::'
																			,data_services.data_location.prefix () + 'thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 8192									;

	export Groupname	:= tools.fun_Groupname();

end;
