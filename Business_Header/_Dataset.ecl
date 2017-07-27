import _control, tools,ut;

export _Dataset(

	 boolean	pUseOtherEnvironment	= false	//if true on dataland, use prod, if true on prod, use dataland
	,string		pPrefix								= 'thor_data400'

):=
module

	export IsDataland 					:= Tools._Constants.IsDataland;
	
	export foreign_environment := if(IsDataland
																	,ut.foreign_prod
																	,ut.foreign_dataland
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