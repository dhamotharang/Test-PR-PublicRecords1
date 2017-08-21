import _control, versioncontrol,ut;
export _Dataset(

	boolean	pUseOtherEnvironment = false

):=
module

	export Name										:= 'Travelers_Test'								;

	export foreign_environment := if(VersionControl._Flags.IsDataland
																	,ut.foreign_prod
																	,ut.foreign_dataland
																);

	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,'~thor_data400::'
																		);

	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname	:= VersionControl.Groupname();
	
end;