import data_services, tools;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
INLINE module

	export IsDataland 					:= Tools._Constants.IsDataland;
	
	export foreign_environment := if(IsDataland
																	,data_services.foreign_prod
																	,data_services.foreign_dataland
																);
												
	export Name										:= 'One_Click_Data'		;
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 5024000									;

	export Groupname							:= tools.fun_Groupname('44');

end;