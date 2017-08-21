import _control, versioncontrol,ut;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module

	export foreign_environment := if(VersionControl._Flags.IsDataland
																	,ut.foreign_prod
																	,ut.foreign_dataland
																);
												
	export Name										:= 'corp2'		;
	export NameMapped             := 'corp2::mapped';
	
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname							:= VersionControl.Groupname();

end;