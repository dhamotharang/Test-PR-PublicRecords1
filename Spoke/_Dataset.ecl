import _control, tools;
export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'Spoke'							;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,tools.foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 8192									;

	export Groupname	:= tools.fun_Groupname();

end;