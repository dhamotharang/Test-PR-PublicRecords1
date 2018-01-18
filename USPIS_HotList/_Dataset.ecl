import _control, versioncontrol,data_services;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
INLINE module

	export IsDataland 					:= VersionControl._Flags.IsDataland;
	
	export foreign_environment := if(VersionControl._Flags.IsDataland
																	,data_services.foreign_prod
																	,data_services.foreign_dataland
																);
												
	export Name										:= 'USPIS_HotList'		;
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,data_services.data_location.prefix() + 'thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 8192									;

	export Groupname							:= VersionControl.Groupname();

end;