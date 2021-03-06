import _control, versioncontrol,ut, Data_Services;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module

	export foreign_environment := if(VersionControl._Flags.IsDataland
																	,Data_Services.foreign_prod
																	,Data_Services.foreign_dataland
																);
												
	export Name										:= 'Busreg'		;
	//export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
	//																		,foreign_environment + 'thor_data400::'
	//																		,'~thor_data400::'
	//
	//																		);
	export thor_cluster_Files			:= 	data_services.Data_location.prefix()+'thor_data400::'; 
																		
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname							:= VersionControl.Groupname();

end;