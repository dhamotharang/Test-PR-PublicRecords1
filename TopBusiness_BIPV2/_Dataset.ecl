import _control, tools,ut;

export _Dataset(

	 boolean	pUseOtherEnvironment  = false	              //if true on dataland, use prod, if true on prod, use dataland
  ,string   pName                 = 'TopBusiness_BIPV2'
):=
module

	export foreign_environment := if(tools._Constants.IsDataland
																	,ut.foreign_prod
																	,ut.foreign_dataland
																);
												
	export Name										:= pName		;
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname							:= tools.fun_Groupname();

end;