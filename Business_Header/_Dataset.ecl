import _control, tools, Data_Services;

export _Dataset(

	 boolean	pUseOtherEnvironment	= false	//if true on dataland, use prod, if true on prod, use dataland
	,string		pPrefix								= 'thor_data400'

):=
INLINE module

	export IsDataland 					:= Tools._Constants.IsDataland;
	
	export foreign_environment := if(IsDataland
																	,Data_Services.foreign_prod
																	,Data_Services.foreign_dataland
																);
												
	export Name										:= 'Business_Headers'		;
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + pPrefix + '::'
																			,'~' + pPrefix + '::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname							:= tools.fun_Groupname();

end;