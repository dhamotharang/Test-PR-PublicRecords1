import _control, versioncontrol,Data_Services;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module

	export IsDataland 					:= VersionControl._Flags.IsDataland;
	
	export foreign_environment := if(VersionControl._Flags.IsDataland
																	,Data_Services.foreign_prod
																	,Data_Services.foreign_dataland
																);
												
	export Name										:= 'Risk_Indicators'		;
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,data_services.data_location.prefix() + 'thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname							:= VersionControl.Groupname();

end;